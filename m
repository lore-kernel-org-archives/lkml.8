Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46221C47247
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:07:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FBB22083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgEGOHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbgEGOH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:07:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7563EC05BD43;
        Thu,  7 May 2020 07:07:28 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWhBK-00026b-5k; Thu, 07 May 2020 16:07:22 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C78C81C001A;
        Thu,  7 May 2020 16:07:21 +0200 (CEST)
Date:   Thu, 07 May 2020 14:07:21 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove _uv_hub_info_check()
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russ Anderson <rja@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200504171527.2845224-10-hch@lst.de>
References: <20200504171527.2845224-10-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158886044178.8414.125576865550721705.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     fbe1d37866d249b6936cf526592957725a941f95
Gitweb:        https://git.kernel.org/tip/fbe1d37866d249b6936cf526592957725a941f95
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Mon, 04 May 2020 19:15:25 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 15:32:23 +02:00

x86/platform/uv: Remove _uv_hub_info_check()

Neither this functions nor the helpers used to implement it are used
anywhere in the kernel tree.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Not-acked-by:  Dimitri Sivanich <sivanich@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Link: https://lkml.kernel.org/r/20200504171527.2845224-10-hch@lst.de

---
 arch/x86/include/asm/uv/uv_hub.h   | 14 --------------
 arch/x86/kernel/apic/x2apic_uv_x.c |  6 ------
 2 files changed, 20 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv_hub.h b/arch/x86/include/asm/uv/uv_hub.h
index 8a25d95..9eabd7e 100644
--- a/arch/x86/include/asm/uv/uv_hub.h
+++ b/arch/x86/include/asm/uv/uv_hub.h
@@ -219,20 +219,6 @@ static inline struct uv_hub_info_s *uv_cpu_hub_info(int cpu)
 	return (struct uv_hub_info_s *)uv_cpu_info_per(cpu)->p_uv_hub_info;
 }
 
-#define	UV_HUB_INFO_VERSION	0x7150
-extern int uv_hub_info_version(void);
-static inline int uv_hub_info_check(int version)
-{
-	if (uv_hub_info_version() == version)
-		return 0;
-
-	pr_crit("UV: uv_hub_info version(%x) mismatch, expecting(%x)\n",
-		uv_hub_info_version(), version);
-
-	BUG();	/* Catastrophic - cannot continue on unknown UV system */
-}
-#define	_uv_hub_info_check()	uv_hub_info_check(UV_HUB_INFO_VERSION)
-
 /*
  * HUB revision ranges for each UV HUB architecture.
  * This is a software convention - NOT the hardware revision numbers in
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 3830538..8cf0e24 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -415,12 +415,6 @@ static __initdata struct uv_gam_range_s		*_gr_table;
 
 #define	SOCK_EMPTY	((unsigned short)~0)
 
-extern int uv_hub_info_version(void)
-{
-	return UV_HUB_INFO_VERSION;
-}
-EXPORT_SYMBOL(uv_hub_info_version);
-
 /* Default UV memory block size is 2GB */
 static unsigned long mem_block_size __initdata = (2UL << 30);
 
