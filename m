Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE654C52D20
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:15:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 930A124690
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582812908;
	bh=hTb/1GuHF2M2JOtCgLljW2B8Dk7zHQrkGnfDwohYq90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=f4yAsJjm4hef49NoF1IQWHQ65/OZQhrzLrbjfGOZ+boKk6nvbaoROofx22kdnH/Ig
	 fGeafpf7NiOVlLffJHncS8DOtvruanCg4S8vuz2ARO8/15VYxZ69rOMGliK52UyNpl
	 M0rKQx8VPz7kSqST4XDnFByOHJjNEAZABKzxmRko=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389232AbgB0OPH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:15:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:54550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388801AbgB0OPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:15:04 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E46324691;
        Thu, 27 Feb 2020 14:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812904;
        bh=hTb/1GuHF2M2JOtCgLljW2B8Dk7zHQrkGnfDwohYq90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJ4+wj4GMdaq1/jQ5pAnrxV4Pw0UCHi8Zxu/vv3rcsrm4Vitl29X/l3l+Sre/0BpJ
         IiipQruDhR4kcBsDt4UD60nzhFO0qCz6VW0hKf1hSp8n8IKklwOLUCBAo76VQHwzkv
         lQ8i8ZIWuEI/kgf9Ls3JopgWTLTw3uL3suGPPFGc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 5.5 059/150] x86/ima: use correct identifier for SetupMode variable
Date:   Thu, 27 Feb 2020 14:36:36 +0100
Message-Id: <20200227132241.780810136@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132232.815448360@linuxfoundation.org>
References: <20200227132232.815448360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

commit ff5ac61ee83c13f516544d29847d28be093a40ee upstream.

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
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org # v5.3
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kernel/ima_arch.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

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
@@ -25,7 +23,7 @@ static enum efi_secureboot_mode get_sb_m
 	}
 
 	/* Get variable contents into buffer */
-	status = efi.get_variable(efi_SecureBoot_name, &efi_variable_guid,
+	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
 				  NULL, &size, &secboot);
 	if (status == EFI_NOT_FOUND) {
 		pr_info("ima: secureboot mode disabled\n");
@@ -38,7 +36,7 @@ static enum efi_secureboot_mode get_sb_m
 	}
 
 	size = sizeof(setupmode);
-	status = efi.get_variable(efi_SetupMode_name, &efi_variable_guid,
+	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
 				  NULL, &size, &setupmode);
 
 	if (status != EFI_SUCCESS)	/* ignore unknown SetupMode */


