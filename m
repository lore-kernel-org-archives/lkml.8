Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B45C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 06:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED46A2146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 06:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387483AbgCDGj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 01:39:57 -0500
Received: from mail.windriver.com ([147.11.1.11]:62016 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgCDGj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 01:39:57 -0500
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 0246dNZx025717
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Mar 2020 22:39:23 -0800 (PST)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Tue, 3 Mar 2020 22:39:10 -0800
From:   <zhe.he@windriver.com>
To:     <tony.luck@intel.com>, <bp@alien8.de>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <hpa@zytor.com>, <x86@kernel.org>,
        <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] x86/mce: Add compat_ioctl assignment to make it compatible with 32-bit system
Date:   Wed, 4 Mar 2020 14:39:07 +0800
Message-ID: <1583303947-49858-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

32-bit user-space program would get errors like the following from ioctl
syscall due to missing compat_ioctl.
MCE_GET_RECORD_LEN: Inappropriate ioctl for device

compat_ptr_ioctl is provided as a generic implementation of .compat_ioctl
file operation to ioctl functions that either ignore the argument or pass
a pointer to a compatible data type.

Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index 7c8958d..6c9b91b7 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -328,6 +328,7 @@ static const struct file_operations mce_chrdev_ops = {
 	.write			= mce_chrdev_write,
 	.poll			= mce_chrdev_poll,
 	.unlocked_ioctl		= mce_chrdev_ioctl,
+	.compat_ioctl		= compat_ptr_ioctl,
 	.llseek			= no_llseek,
 };
 
-- 
2.7.4

