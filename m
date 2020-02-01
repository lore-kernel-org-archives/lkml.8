Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EFEC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75D3206D3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 08:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580545998;
	bh=E0v/aw/eZV1PxYSxlag63puXSxfO+G3didZzWiq92GY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=qwVTCMy1I8MybwoTKuReRtQIioABzfRnHh4p1b6/xxLVsGJIQzazhWuoHlZsh3DgM
	 b7tyTMj+Bh+MwRisPt0Cxu2DOMoyXH5m9LcBuAmV8Esh17GLtoob6gYVDRzac/LUyw
	 F/52hhG9abnt2KVI+P2CAdDPq10BD4sVFEq55WQI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgBAIcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 03:32:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:40720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbgBAIcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 03:32:47 -0500
Received: from e123331-lin.c.hoisthospitality.com (dc3829c8a.static.telenet.be [195.130.156.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DC00206D3;
        Sat,  1 Feb 2020 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580545967;
        bh=E0v/aw/eZV1PxYSxlag63puXSxfO+G3didZzWiq92GY=;
        h=From:To:Cc:Subject:Date:From;
        b=eaZIyhqjMhiA8cBE4IIK4AtbdMSaPLPZ6W1gfG30bY2TB5nifflhk4LKtxJXws2Of
         C4wgJdmFprVs3B/lMjQEbic56ebcrnI5GM2zs4TBTBPxB8mz6qxq20o09chKJpcw9k
         YPxixdo3C5lOSdC6IvcbwWI05ERcgsLfZg3te224=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Matthew Garrett <mjg59@google.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] x86/ima: use correct identifier for SetupMode variable
Date:   Sat,  1 Feb 2020 09:32:21 +0100
Message-Id: <20200201083221.20193-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IMA arch code attempts to inspect the "SetupMode" EFI variable
by populating a variable called efi_SetupMode_name with the string
"SecureBoot" and passing that to the EFI GetVariable service, which
obviously does not yield the expected result.

Given that the string is only referenced a single time, let's get
rid of the intermediate variable, and pass the correct string as
an immediate argument. While at it, do the same for "SecureBoot".

Fixes: 399574c64eaf ("x86/ima: retry detecting secure boot mode")
Fixes: 980ef4d22a95 ("x86/ima: check EFI SetupMode too")
Cc: Matthew Garrett <mjg59@google.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---

The bug results in get_sb_mode() to always return efi_secureboot_mode_disabled.

I am not too familiar with this code, but it seems get_sb_mode() is only
called when the secure boot state has not been established yet, but I don't
know how likely that is to occur in practice.

 arch/x86/kernel/ima_arch.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
index 4d4f5d9faac3..23054909c8dd 100644
--- a/arch/x86/kernel/ima_arch.c
+++ b/arch/x86/kernel/ima_arch.c
@@ -10,8 +10,6 @@ extern struct boot_params boot_params;
 
 static enum efi_secureboot_mode get_sb_mode(void)
 {
-	efi_char16_t efi_SecureBoot_name[] = L"SecureBoot";
-	efi_char16_t efi_SetupMode_name[] = L"SecureBoot";
 	efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
 	efi_status_t status;
 	unsigned long size;
@@ -25,7 +23,7 @@ static enum efi_secureboot_mode get_sb_mode(void)
 	}
 
 	/* Get variable contents into buffer */
-	status = efi.get_variable(efi_SecureBoot_name, &efi_variable_guid,
+	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
 				  NULL, &size, &secboot);
 	if (status == EFI_NOT_FOUND) {
 		pr_info("ima: secureboot mode disabled\n");
@@ -38,7 +36,7 @@ static enum efi_secureboot_mode get_sb_mode(void)
 	}
 
 	size = sizeof(setupmode);
-	status = efi.get_variable(efi_SetupMode_name, &efi_variable_guid,
+	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
 				  NULL, &size, &setupmode);
 
 	if (status != EFI_SUCCESS)	/* ignore unknown SetupMode */
-- 
2.17.1

