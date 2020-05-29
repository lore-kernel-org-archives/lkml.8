Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB00C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786D420810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590738092;
	bh=G6xSX+Pm85bRUzgi68fia9m103Lrfy+3Zj4Ymq5OffU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mSGw7Dz1Ijq5J/0XKxwx9DVsS+J3WzRYRqrEoM+QoWxyIHfmx50nVO8oCFPo4amHs
	 xy0V9etUutfOkhx5MErT6L0rX/IVyicPOdEFsEJAM7D0mrROP6vGGUd+RI5/QGlffW
	 XpcY3bAP7L6zjSrCef1gfd6OYepUpGYCr4OLbkoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgE2Hlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:41:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33082 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgE2Hl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:28 -0400
Received: by mail-pl1-f194.google.com with SMTP id t7so776943plr.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1PG5LVb0n4wOO6VZREoyBILeBAzco+IYNIeDXsX/FzY=;
        b=R2e9F5rxEHDkQcp9lRtm6/0ZWEpmBXeCLjTSYq2fyAeuTxqS5XjGgo3VGGtxNcQLHZ
         Q2AczsBC3RYYfVZaEcrISI5KyDopiTbTjQ3YQbIw2hGclJhdLTvAu/+ZEZbtdYrtG336
         vH9EKW/Kb0M/4Ypa/13XU7J25ewYRZuXzZnM/zG8b7owM/8+3ULJH98YbXqZCrhM0kKu
         lAbBFeFJNJ6kCKH8KjEC43K4/XLPSfKGF01F96hk8+AJRG/k3V9izs5j5akzQUKY9Nm+
         9zSURA+1c0M7IO3KAz4uN3l7QBo1aSavAndbQO8Ihindi1rXbskC3VjpmtzGSzoE3sY8
         O3/g==
X-Gm-Message-State: AOAM533M1JmqsAM/Oiixi4dnUTM/7ut1AR6q1lWDLti2pa+oPLppLHmp
        UktjbJ99a3JsROeAo063iGM=
X-Google-Smtp-Source: ABdhPJxM98lxrupu0HzIVHkaILQ2GJoC5HA3ATmBk5nOeI56XgjTlxA112dIBe6io3Hl67zR6z+BjQ==
X-Received: by 2002:a17:90a:db0c:: with SMTP id g12mr7872171pjv.5.1590738086768;
        Fri, 29 May 2020 00:41:26 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q21sm919935pfn.209.2020.05.29.00.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:25 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 13BC8423BF; Fri, 29 May 2020 07:41:11 +0000 (UTC)
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
Subject: [PATCH 13/13] fs: move binfmt_misc sysctl to its own file
Date:   Fri, 29 May 2020 07:41:08 +0000
Message-Id: <20200529074108.16928-14-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200529074108.16928-1-mcgrof@kernel.org>
References: <20200529074108.16928-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the binfmt_misc sysctl to its own file to help remove
clutter from kernel/sysctl.c.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/binfmt_misc.c | 1 +
 kernel/sysctl.c  | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index f69a043f562b..656b3f5f3bbf 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -821,6 +821,7 @@ static int __init init_misc_binfmt(void)
 	int err = register_filesystem(&bm_fs_type);
 	if (!err)
 		insert_binfmt(&misc_format);
+	register_sysctl_empty_subdir("fs", "binfmt_misc");
 	return err;
 }
 
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 460532cd5ac8..7714e7b476c2 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -3042,13 +3042,6 @@ static struct ctl_table fs_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_TWO,
 	},
-#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
-	{
-		.procname	= "binfmt_misc",
-		.mode		= 0555,
-		.child		= sysctl_mount_point,
-	},
-#endif
 	{
 		.procname	= "pipe-max-size",
 		.data		= &pipe_max_size,
-- 
2.26.2

