Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905F7C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6087F20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 19:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GdPcaidi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgDITgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 15:36:05 -0400
Received: from mail.efficios.com ([167.114.26.124]:47244 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbgDITgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 15:36:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 630C3280F68;
        Thu,  9 Apr 2020 15:36:01 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id D0KtDGto7mla; Thu,  9 Apr 2020 15:36:01 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A3EEE280AF8;
        Thu,  9 Apr 2020 15:36:00 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A3EEE280AF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1586460960;
        bh=of9ztiQ/5cHQBKgHs959tFpQDUMQ8xahvSEN+y/duvY=;
        h=From:To:Date:Message-Id;
        b=GdPcaidiMGG3O40pn9ENwf1kfUvQ9wRz6ABEJpEfeAfOGiEece34RYEv49i1BObvj
         EWc4fkwfxdi5aXfF+RY7hHo1lkPXOkPlrD0GiC+PnujjMEL/eAPhVavqAoQsdbRt2v
         dC10ASMqdM7TAGDesR3FiA4qsNOYd6/XFpKf1UKMowQGtD6qK6vQ7FtQI85Lol1CHK
         vk77hoaQD8cPa/D+p+Q/yjGaAjpokqCtYrDbyo0lwX+7tdAqZuuQ2Uk16UhNMylI0a
         mjPIUMaVe5sdZCGaSmklMTzfClc0bN/nxnATtpqBVbu7X9vD7kKNCpERo/Sp2Qt1rx
         /lP2puE2F278A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vTCK6ngF5-Vl; Thu,  9 Apr 2020 15:36:00 -0400 (EDT)
Received: from localhost.localdomain (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 8A3F1281100;
        Thu,  9 Apr 2020 15:35:59 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, akpm@linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>, rostedt@goodmis.org,
        Alexei Starovoitov <ast@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tejun Heo <tj@kernel.org>
Subject: [RFC PATCH 8/9] block: genhd: export-GPL generic disk device type
Date:   Thu,  9 Apr 2020 15:35:42 -0400
Message-Id: <20200409193543.18115-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
References: <20200409193543.18115-1-mathieu.desnoyers@efficios.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Iteration on class devices is exported for use by GPL modules, but
there is no exported function for getting the generic disk device type
which is required to perform iteration on the generic disks.

Export a new getter for disk device type for use by GPL modules. This is
useful for tracing a meaningful list of block devices from tracers
implemented as GPL modules.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 block/genhd.c         | 9 +++++++++
 include/linux/genhd.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/block/genhd.c b/block/genhd.c
index 409c5a92b0b9..e104b696002f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1546,6 +1546,15 @@ static const struct device_type disk_type = {
 	.devnode	= block_devnode,
 };
 
+/*
+ * Return the generic disk device type.
+ */
+const struct device_type *gendisk_device_type(void)
+{
+	return &disk_type;
+}
+EXPORT_SYMBOL_GPL(gendisk_device_type);
+
 #ifdef CONFIG_PROC_FS
 /*
  * aggregate disk stat collector.  Uses the same stats that the sysfs
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 9b3fffdf4011..3307dfae72cb 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -353,6 +353,8 @@ extern void blk_register_region(dev_t devt, unsigned long range,
 			void *data);
 extern void blk_unregister_region(dev_t devt, unsigned long range);
 
+extern const struct device_type *gendisk_device_type(void);
+
 #define alloc_disk_node(minors, node_id)				\
 ({									\
 	static struct lock_class_key __key;				\
-- 
2.17.1

