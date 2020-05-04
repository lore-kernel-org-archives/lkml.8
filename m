Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEFBC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4238F20757
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:24:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEDIYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725941AbgEDIYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:24:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8564C061A0E;
        Mon,  4 May 2020 01:24:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jVWOq-0000Gm-10; Mon, 04 May 2020 10:24:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9D0521C0084;
        Mon,  4 May 2020 10:24:27 +0200 (CEST)
Date:   Mon, 04 May 2020 08:24:27 -0000
From:   "tip-bot2 for He Zhe" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mcelog: Add compat_ioctl for 32-bit mcelog support
Cc:     He Zhe <zhe.he@windriver.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1583303947-49858-1-git-send-email-zhe.he@windriver.com>
References: <1583303947-49858-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Message-ID: <158858066755.8414.12588445728524266047.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     3b4ff4eb904fef04c36b39052ca8eb31fa41fad0
Gitweb:        https://git.kernel.org/tip/3b4ff4eb904fef04c36b39052ca8eb31fa41fad0
Author:        He Zhe <zhe.he@windriver.com>
AuthorDate:    Wed, 04 Mar 2020 14:39:07 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 04 May 2020 10:07:04 +02:00

x86/mcelog: Add compat_ioctl for 32-bit mcelog support

A 32-bit version of mcelog issuing ioctls on /dev/mcelog causes errors
like the following:

  MCE_GET_RECORD_LEN: Inappropriate ioctl for device

This is due to a missing compat_ioctl callback.

Assign to it compat_ptr_ioctl() as a generic implementation of the
.compat_ioctl file operation to ioctl functions that either ignore the
argument or pass a pointer to a compatible data type.

 [ bp: Massage commit message. ]

Signed-off-by: He Zhe <zhe.he@windriver.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1583303947-49858-1-git-send-email-zhe.he@windriver.com
---
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/cpu/mce/dev-mcelog.c b/arch/x86/kernel/cpu/mce/dev-mcelog.c
index c033e7e..a4fd528 100644
--- a/arch/x86/kernel/cpu/mce/dev-mcelog.c
+++ b/arch/x86/kernel/cpu/mce/dev-mcelog.c
@@ -329,6 +329,7 @@ static const struct file_operations mce_chrdev_ops = {
 	.write			= mce_chrdev_write,
 	.poll			= mce_chrdev_poll,
 	.unlocked_ioctl		= mce_chrdev_ioctl,
+	.compat_ioctl		= compat_ptr_ioctl,
 	.llseek			= no_llseek,
 };
 
