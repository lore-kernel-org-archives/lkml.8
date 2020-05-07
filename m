Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98EC9C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DFF20936
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEGOHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727032AbgEGOH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:07:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8031C05BD43;
        Thu,  7 May 2020 07:07:27 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWhBM-00029T-Fz; Thu, 07 May 2020 16:07:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1C5511C001A;
        Thu,  7 May 2020 16:07:24 +0200 (CEST)
Date:   Thu, 07 May 2020 14:07:24 -0000
From:   "tip-bot2 for Christoph Hellwig" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Remove the
 uv_partition_coherence_id() macro
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russ Anderson <rja@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200504171527.2845224-3-hch@lst.de>
References: <20200504171527.2845224-3-hch@lst.de>
MIME-Version: 1.0
Message-ID: <158886044406.8414.6326875486008539337.tip-bot2@tip-bot2>
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

Commit-ID:     32988cfd579f7912aeb9a66bf44ca4ce0fa860f1
Gitweb:        https://git.kernel.org/tip/32988cfd579f7912aeb9a66bf44ca4ce0fa860f1
Author:        Christoph Hellwig <hch@lst.de>
AuthorDate:    Mon, 04 May 2020 19:15:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 07 May 2020 15:32:19 +02:00

x86/platform/uv: Remove the uv_partition_coherence_id() macro

uv_partition_coherence_id() is only used once.  Just open code it in the
only user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Not-acked-by:  Dimitri Sivanich <sivanich@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Link: https://lkml.kernel.org/r/20200504171527.2845224-3-hch@lst.de
---
 arch/x86/include/asm/uv/bios.h  | 1 -
 arch/x86/platform/uv/uv_sysfs.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index fc85daf..2fcc3ac 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -140,7 +140,6 @@ extern long sn_partition_id;
 extern long sn_coherency_id;
 extern long sn_region_size;
 extern long system_serial_number;
-#define uv_partition_coherence_id()	(sn_coherency_id)
 
 extern struct kobject *sgi_uv_kobj;	/* /sys/firmware/sgi_uv */
 
diff --git a/arch/x86/platform/uv/uv_sysfs.c b/arch/x86/platform/uv/uv_sysfs.c
index 6221473..266773e 100644
--- a/arch/x86/platform/uv/uv_sysfs.c
+++ b/arch/x86/platform/uv/uv_sysfs.c
@@ -21,7 +21,7 @@ static ssize_t partition_id_show(struct kobject *kobj,
 static ssize_t coherence_id_show(struct kobject *kobj,
 			struct kobj_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%ld\n", uv_partition_coherence_id());
+	return snprintf(buf, PAGE_SIZE, "%ld\n", sn_coherency_id);
 }
 
 static struct kobj_attribute partition_id_attr =
