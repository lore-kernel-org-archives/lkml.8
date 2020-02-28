Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31D3C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A234246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 05:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZCnKA+YN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgB1FmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 00:42:18 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34338 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgB1FmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 00:42:17 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S5bbGH179811;
        Fri, 28 Feb 2020 05:42:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : subject : to :
 cc : message-id : date : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=RHqBzSjWYn2Rk3KYgmZDclzprjLz5YbM37KJXpO5Trs=;
 b=ZCnKA+YN14vSW+PRKcYfdi2WyPBgYM3InNRYieTPWiQP9/gn1mFqUsjQi3NiO6PsXcYJ
 WOwui/JrgHBhNa09R7TxTEy+bEYNgszXcx/exoEB/VIKFD0k/wG9gv46ZEA9iZnJpsqq
 tOsGxnAEEc2+O86GMO/ryQT4HxKsT33uUV/YtpJeK+VBv5R/lfDCbS4QmA6754Byjh7l
 XEk1M6S30OiAEEn69ZtoM8vs945uzlXpNnUg/Rws9tgoQnLkqR1kUJRJqLJ56xBvmDvE
 iUwsT+BAKbw389s4AlVw7GCyXC2vqO5gdAiKCBo0/j/6Qt0SdKVT9FLfej1VdeqMX5x2 0g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2ydcsnrdke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 05:42:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01S5aovX074836;
        Fri, 28 Feb 2020 05:42:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2ydcsebf1c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Feb 2020 05:42:05 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01S5g4sp007459;
        Fri, 28 Feb 2020 05:42:04 GMT
Received: from [10.159.136.144] (/10.159.136.144)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 27 Feb 2020 21:42:04 -0800
From:   Joe Jin <joe.jin@oracle.com>
Subject: [PATCH] genirq/debugfs: add new config option for trigger interrupt
 from userspace
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Joe Jin <joe.jin@oracle.com>
Message-ID: <44a7007d-9624-8ac7-e0ab-fab8bdd39848@oracle.com>
Date:   Thu, 27 Feb 2020 21:42:02 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280049
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9544 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1011 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002280049
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 536e2e34bd00 ("genirq/debugfs: Triggering of interrupts from
userspace") is allowed developer inject interrupts via irq debugfs, which
is very useful during development phase, but on a production system, this
is very dangerous, add new config option, developers can enable it as
needed instead of enabling it by default when irq debugfs is enabled.

Signed-off-by: Joe Jin <joe.jin@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 kernel/irq/Kconfig   | 15 +++++++++++++++
 kernel/irq/debugfs.c |  9 +++++++++
 2 files changed, 24 insertions(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index f92d9a687372..00521e896e6c 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -135,6 +135,21 @@ config GENERIC_IRQ_DEBUGFS
 
 	  If you don't know what to do here, say N.
 
+config GENERIC_IRQ_DEBUGFS_INJECT_INT
+	bool "Allow trigger interrupts from userspace"
+	depends on DEBUG_FS && GENERIC_IRQ_DEBUGFS
+	default n
+	---help---
+
+	  Allow developers retrigger a (edge-only) interrupt from userspace.
+	  To use this feature:
+
+	  echo -n trigger > /sys/kernel/debug/irq/irqs/IRQNUM
+
+	  WARNING: This is DANGEROUS, and strictly a debug feature.
+
+	  If you don't know what to do here, say N.
+
 endmenu
 
 config GENERIC_IRQ_MULTI_HANDLER
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index a949bd39e343..56db29bc1acf 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -178,6 +178,7 @@ static int irq_debug_open(struct inode *inode, struct file *file)
 	return single_open(file, irq_debug_show, inode->i_private);
 }
 
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS_INJECT_INT
 static ssize_t irq_debug_write(struct file *file, const char __user *user_buf,
 			       size_t count, loff_t *ppos)
 {
@@ -223,10 +224,13 @@ static ssize_t irq_debug_write(struct file *file, const char __user *user_buf,
 
 	return count;
 }
+#endif
 
 static const struct file_operations dfs_irq_ops = {
 	.open		= irq_debug_open,
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS_INJECT_INT
 	.write		= irq_debug_write,
+#endif
 	.read		= seq_read,
 	.llseek		= seq_lseek,
 	.release	= single_release,
@@ -249,8 +253,13 @@ void irq_add_debugfs_entry(unsigned int irq, struct irq_desc *desc)
 		return;
 
 	sprintf(name, "%d", irq);
+#ifdef CONFIG_GENERIC_IRQ_DEBUGFS_INJECT_INT
 	desc->debugfs_file = debugfs_create_file(name, 0644, irq_dir, desc,
 						 &dfs_irq_ops);
+#else
+	desc->debugfs_file = debugfs_create_file(name, 0444, irq_dir, desc,
+						 &dfs_irq_ops);
+#endif
 }
 
 static int __init irq_debugfs_init(void)
-- 
2.21.1 (Apple Git-122.3)

