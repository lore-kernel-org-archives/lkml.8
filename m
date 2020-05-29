Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF129C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D21920810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590738080;
	bh=dyGF6h29npr460bw9621YW3h4QOBu87a4FQs4+aENnc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dfdNzfNyj3r0iPtEdbh+3Qp4WbrWXHThVaryh4RzoXmLirvHUQox+6k7YMCw/Atg1
	 kAvBYhwSuSjIQAUArzudprgOywNibyTHZBh8eL0G2GPjwXeFlnZF5r2Oxu0SqfTc4Y
	 yANFDVeFOsiaDxw0vByd0jlooEXsB9gKRDbXNLkk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgE2HlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:41:19 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41112 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgE2HlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:17 -0400
Received: by mail-pg1-f194.google.com with SMTP id r10so1006825pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/vA3i/UOi3UGtI8x+kS8OZpNUo79BRU7m0khtdFXp1w=;
        b=m+d6TetRqS6KurWPG/b9Ik93yroWYanyjvzBc/xJSVGbVibezROaNbQDJ3qnuhIe96
         fa1g1rcoIOLsEOEPCEusuhh5xVdGDiG+JekNqJnoOQBOh949Ji2up6QXI7BbAw9KCjLs
         2MTSS9K3ZvN3fhPZErgVRC/KE7JXT9Z1JN5bDwbF0NxtEVY4TtncBdNeWilHlUI6vO2I
         kq7enhvTkjNp4t+4koHDL6kRtAsSFLmQN5EE1T6EYIkFnupbi4LaPAO/ccosUQqfc2dP
         /elEuneJED5EsujUQY1xXGYL1sa2r+GbstqBz84crMXMXmXBDlbOyaqTk/HJPTZnRlNq
         q5sg==
X-Gm-Message-State: AOAM531bfsOMgnZiTK8KlWT/0rW+vZPoEYoR0Eh7z+/QMpjYceNNbfDD
        rhdTobEbrkFV9YpnL6p6b3k=
X-Google-Smtp-Source: ABdhPJwVflgyvahnPxBVjITKozn64OGLurCkYnovebI0IemGuS43xiHECvCCud24IYthmkf9lnECTw==
X-Received: by 2002:aa7:8658:: with SMTP id a24mr7517245pfo.135.1590738076317;
        Fri, 29 May 2020 00:41:16 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q189sm6758936pfc.112.2020.05.29.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:12 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 916034230A; Fri, 29 May 2020 07:41:10 +0000 (UTC)
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
Subject: [PATCH 04/13] i915: use new sysctl subdir helper register_sysctl_subdir()
Date:   Fri, 29 May 2020 07:40:59 +0000
Message-Id: <20200529074108.16928-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20200529074108.16928-1-mcgrof@kernel.org>
References: <20200529074108.16928-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This simplifies the code considerably. The following coccinelle
SmPL grammar rule was used to transform this code.

// pycocci sysctl-subdir.cocci drivers/gpu/drm/i915/i915_perf.c

@c1@
expression E1;
identifier subdir, sysctls;
@@

static struct ctl_table subdir[] = {
	{
		.procname = E1,
		.maxlen = 0,
		.mode = 0555,
		.child = sysctls,
	},
	{ }
};

@c2@
identifier c1.subdir;

expression E2;
identifier base;
@@

static struct ctl_table base[] = {
	{
		.procname = E2,
		.maxlen = 0,
		.mode = 0555,
		.child = subdir,
	},
	{ }
};

@c3@
identifier c2.base;
identifier header;
@@

header = register_sysctl_table(base);

@r1 depends on c1 && c2 && c3@
expression c1.E1;
identifier c1.subdir, c1.sysctls;
@@

-static struct ctl_table subdir[] = {
-	{
-		.procname = E1,
-		.maxlen = 0,
-		.mode = 0555,
-		.child = sysctls,
-	},
-	{ }
-};

@r2 depends on c1 && c2 && c3@
identifier c1.subdir;

expression c2.E2;
identifier c2.base;
@@
-static struct ctl_table base[] = {
-	{
-		.procname = E2,
-		.maxlen = 0,
-		.mode = 0555,
-		.child = subdir,
-	},
-	{ }
-};

@r3 depends on c1 && c2 && c3@
expression c1.E1;
identifier c1.sysctls;
expression c2.E2;
identifier c2.base;
identifier c3.header;
@@

header =
-register_sysctl_table(base);
+register_sysctl_subdir(E2, E1, sysctls);

Generated-by: Coccinelle SmPL
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/gpu/drm/i915/i915_perf.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_perf.c b/drivers/gpu/drm/i915/i915_perf.c
index 665bb076e84d..52509b573794 100644
--- a/drivers/gpu/drm/i915/i915_perf.c
+++ b/drivers/gpu/drm/i915/i915_perf.c
@@ -4203,26 +4203,6 @@ static struct ctl_table oa_table[] = {
 	{}
 };
 
-static struct ctl_table i915_root[] = {
-	{
-	 .procname = "i915",
-	 .maxlen = 0,
-	 .mode = 0555,
-	 .child = oa_table,
-	 },
-	{}
-};
-
-static struct ctl_table dev_root[] = {
-	{
-	 .procname = "dev",
-	 .maxlen = 0,
-	 .mode = 0555,
-	 .child = i915_root,
-	 },
-	{}
-};
-
 /**
  * i915_perf_init - initialize i915-perf state on module bind
  * @i915: i915 device instance
@@ -4383,7 +4363,7 @@ static int destroy_config(int id, void *p, void *data)
 
 void i915_perf_sysctl_register(void)
 {
-	sysctl_header = register_sysctl_table(dev_root);
+	sysctl_header = register_sysctl_subdir("dev", "i915", oa_table);
 }
 
 void i915_perf_sysctl_unregister(void)
-- 
2.26.2

