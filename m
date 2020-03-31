Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7385CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E9AD20658
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585646415;
	bh=PVwq12ikNVjYzL7dLyszQb2N26rWLUYHtiw4e8tlS6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GO/ESTL5bXVR70Xyvoro5RlSD1ByubQcGxYtqgzCj0Iq/LcozfCsav4nlRAHYet/Q
	 Y6pNhDDqXYmPXe3+K0+UX+Z9SAjKH2J7jO8NSEBD3q7Z5m38Szr6oUCiBTAP75pUe4
	 lNHzgeKWNss4bGlddSmD1GUoHzjfQOV+yuaTyybg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbgCaJUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:35626 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731881AbgCaJPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:15:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E8CA20675;
        Tue, 31 Mar 2020 09:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585646123;
        bh=PVwq12ikNVjYzL7dLyszQb2N26rWLUYHtiw4e8tlS6c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o8Q3OArrffZllIvUD5o1dVpOn5EK/rD2QRrjwTWTdXPCnZKngzXNRvTaWI+i16ghZ
         pjPUDtNPP2ZasIdmEUr+mBLV0M8D8DRpzfu3Aaxs8MsFiqz8uBIL+4HY8dY5KxJocQ
         mobAzy1yqfe5ZAZyV74hUcZVd2m9vctu5hfKx27o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PATCH 5.4 090/155] x86/ioremap: Fix CONFIG_EFI=n build
Date:   Tue, 31 Mar 2020 10:58:50 +0200
Message-Id: <20200331085428.515591878@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085418.274292403@linuxfoundation.org>
References: <20200331085418.274292403@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

commit 870b4333a62e45b0b2000d14b301b7b8b8cad9da upstream.

In order to use efi_mem_type(), one needs CONFIG_EFI enabled. Otherwise
that function is undefined. Use IS_ENABLED() to check and avoid the
ifdeffery as the compiler optimizes away the following unreachable code
then.

Fixes: 985e537a4082 ("x86/ioremap: Map EFI runtime services data as encrypted for SEV")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: <stable@vger.kernel.org>
Link: https://lkml.kernel.org/r/7561e981-0d9b-d62c-0ef2-ce6007aff1ab@infradead.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/ioremap.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -115,6 +115,9 @@ static void __ioremap_check_other(resour
 	if (!sev_active())
 		return;
 
+	if (!IS_ENABLED(CONFIG_EFI))
+		return;
+
 	if (efi_mem_type(addr) == EFI_RUNTIME_SERVICES_DATA)
 		desc->flags |= IORES_MAP_ENCRYPTED;
 }


