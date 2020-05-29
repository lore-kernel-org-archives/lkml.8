Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D565FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5A4921534
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590738087;
	bh=cEsY61vu3qsjUilOkw6AJ0nvPj0svQaDD5g+xG+fS88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iM2fhDfZUPU/C9sf6kctRisAgj9FmlOwrs3fjHuqezXctf2XFhNcc9yQKBi0EkSAH
	 VnhEhhauyuc5MQKD34lkBMigkV8nORKW2Ra2+sh00xBamPjH41dYvP32MZSpCYqJer
	 2dotSg0a6VnalUV3RSmCsHjL12kUUZ7ubpzpF77U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgE2Hl1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:41:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36355 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgE2HlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id c75so1024479pga.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2AME75dBsNApuZxoQz+ouSeETod/FSpHW6fOtIBoA8=;
        b=KQvzeNo87F/9LxswTBFmhg8sZUA0V44IcYIPKvnwgXRtOq6oOfqTkOQjfrOffvjPiI
         Kh6p7dOndetM//DsjI2Ow/Osd8Z7UHKoamWyF1hN21GCai+E7d71ZOrmd33QthfirPOt
         mvDYBKohHUCOeZ3LQ/9dZJJPDHcjoh1Tevte5VVmWKysEQxQ9EYWoLTxMU2EK6UXVfoU
         kdBg0rS8qtsuauYKeSlwtLQXKtop4MneSaw/bba6VhoO2eNpnFCdgqviXliQcJmwhXVv
         OGwnn/V0wMG7EiJmGWRgqVnGbHVbFbIMA6Rz9oK4UYvy9BeAGX/gGeic3oKEPmlJmxN2
         jTDw==
X-Gm-Message-State: AOAM530nNWEeHop5Bo4HNrK4uFM//2/7PpaZGb32lzkxEFkNS/g58J56
        yTSCgLvM9ms0eyjmF4BAn64=
X-Google-Smtp-Source: ABdhPJxK/ukzZZOooA7TqKRX6aKFoBfWQ0FrPQYbK4i1DMtq53A2mx5D7MUo+TbjaMx4o+x/3KgfHw==
X-Received: by 2002:a63:711b:: with SMTP id m27mr6911712pgc.324.1590738082579;
        Fri, 29 May 2020 00:41:22 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a7sm6766024pfa.187.2020.05.29.00.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id F2CEA4238B; Fri, 29 May 2020 07:41:10 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, axboe@kernel.dk, clemens@ladisch.de,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie, daniel@ffwll.ch,
        benh@kernel.crashing.org, rdna@fb.com, viro@zeniv.linux.org.uk,
        mark@fasheh.com, jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        vbabka@suse.cz, sfr@canb.auug.org.au, jack@suse.cz,
        amir73il@gmail.com, rafael@kernel.org, tytso@mit.edu
Cc:     julia.lawall@lip6.fr, akpm@linux-foundation.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 11/13] random: simplify sysctl declaration with register_sysctl_subdir()
Date:   Fri, 29 May 2020 07:41:06 +0000
Message-Id: <20200529074108.16928-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200529074108.16928-1-mcgrof@kernel.org>
References: <20200529074108.16928-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoming Ni <nixiaoming@huawei.com>

Move random_table sysctl from kernel/sysctl.c to drivers/char/random.c
and use register_sysctl_subdir() to help remove the clutter out of
kernel/sysctl.c.

Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/char/random.c  | 14 ++++++++++++--
 include/linux/sysctl.h |  1 -
 kernel/sysctl.c        |  5 -----
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index a7cf6aa65908..73fd4b6e9c18 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -2101,8 +2101,7 @@ static int proc_do_entropy(struct ctl_table *table, int write,
 }
 
 static int sysctl_poolsize = INPUT_POOL_WORDS * 32;
-extern struct ctl_table random_table[];
-struct ctl_table random_table[] = {
+static struct ctl_table random_table[] = {
 	{
 		.procname	= "poolsize",
 		.data		= &sysctl_poolsize,
@@ -2164,6 +2163,17 @@ struct ctl_table random_table[] = {
 #endif
 	{ }
 };
+
+/*
+ * rand_initialize() is called before sysctl_init(),
+ * so we cannot call register_sysctl_init() in rand_initialize()
+ */
+static int __init random_sysctls_init(void)
+{
+	register_sysctl_subdir("kernel", "random", random_table);
+	return 0;
+}
+device_initcall(random_sysctls_init);
 #endif 	/* CONFIG_SYSCTL */
 
 struct batched_entropy {
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index e5364b69dd95..33a471b56345 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -216,7 +216,6 @@ extern int unaligned_dump_stack;
 extern int no_unaligned_warning;
 
 extern struct ctl_table sysctl_mount_point[];
-extern struct ctl_table random_table[];
 
 #else /* CONFIG_SYSCTL */
 static inline struct ctl_table_header *register_sysctl_table(struct ctl_table * table)
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5c116904feb7..f9a35325d5d5 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2078,11 +2078,6 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= sysctl_max_threads,
 	},
-	{
-		.procname	= "random",
-		.mode		= 0555,
-		.child		= random_table,
-	},
 	{
 		.procname	= "usermodehelper",
 		.mode		= 0555,
-- 
2.26.2

