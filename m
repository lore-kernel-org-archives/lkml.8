Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5709AC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3530920716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgC1LAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:00:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55563 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgC1LAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:00:06 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jI9C8-0003fP-M2; Sat, 28 Mar 2020 12:00:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C2E4B1C0483;
        Sat, 28 Mar 2020 12:00:01 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:00:01 -0000
From:   "tip-bot2 for Al Viro" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86 kvm page table walks: switch to explicit __get_user()
Cc:     Al Viro <viro@zeniv.linux.org.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158539320147.28353.8883550146531337005.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     a4814443993c7c8686036bb8ca0df6abc499d63f
Gitweb:        https://git.kernel.org/tip/a4814443993c7c8686036bb8ca0df6abc499d63f
Author:        Al Viro <viro@zeniv.linux.org.uk>
AuthorDate:    Sat, 15 Feb 2020 11:29:04 -05:00
Committer:     Al Viro <viro@zeniv.linux.org.uk>
CommitterDate: Sat, 15 Feb 2020 17:26:26 -05:00

x86 kvm page table walks: switch to explicit __get_user()

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 4e1ef04..5bea4cf 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -400,7 +400,7 @@ retry_walk:
 			goto error;
 
 		ptep_user = (pt_element_t __user *)((void *)host_addr + offset);
-		if (unlikely(__copy_from_user(&pte, ptep_user, sizeof(pte))))
+		if (unlikely(__get_user(pte, ptep_user)))
 			goto error;
 		walker->ptep_user[walker->level - 1] = ptep_user;
 
