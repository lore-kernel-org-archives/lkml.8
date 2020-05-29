Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C618CC433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3C39208A7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590738108;
	bh=koCJ6xxQaoMfHLw3BsotM7WFPlv73KnZA5OKxfKiQT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mEYnI+l/9L9GFUxJ+U9LC/bJCqKUtrnZlcl/ej5w6KX7gAu/ncHNUNulGBT2C3Raq
	 2HynJDaGkcEjTHAF1p0TFiSHVFDgwxUq77xup6DXr9pzJ6CLtCBZQvCpCevXSL20lk
	 s/bLmjDWo5M4soFYopa1crDZ05jY6/BKaB9dM/Io=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgE2Hls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:41:48 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44060 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgE2HlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:19 -0400
Received: by mail-pl1-f195.google.com with SMTP id bh7so759210plb.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GvzomajvqaDlmHgD5CFBW/9i29+5hKQDe8Dyx3XaSq4=;
        b=m6qT/y157svFvH84cfTgQ+ib2CEff3V0Rn3p8D/QM+vlXCmqdc3VQjmoR79Ngm4ceW
         FJZ6tpYG1eTW2gAH27irsPol5xfWaoOdziCSfIaqHe7laUFGu5h1tYVJNrJT0ILCxTe8
         WTVvuOYXZdn9RiWJCWIzPZ+E1cDH5MlkUQHIKrh2Wd2wbkBJYl/2xc6iBXDTFvCyMkkq
         DkJAuKWjMN+y9zEDZxZrDKnILlLHaUvnDkGFGUJ5Ic86KZMSW4//NJAxPStq4TUXuFWN
         opXECVMiMd1oAvh0RIMo+Uka6Km1d4pfTuiJr6yD0dRAwVM+LP8f2EMI9KmwG8DavxKN
         IhCg==
X-Gm-Message-State: AOAM531vlttg51soEmRh/YQ3DQX6mi5GVZkgic20Hx9QOapZ89CeIezq
        NzEyTkAfRBBvPOEKeGyXWJk=
X-Google-Smtp-Source: ABdhPJzaH+urrC8l82AOcunlppRYvCYY8eRn8tjh5bOS5g7bJ5viHl156VGCztJ4ox/+xnpOBndUZg==
X-Received: by 2002:a17:902:7001:: with SMTP id y1mr7344091plk.114.1590738078586;
        Fri, 29 May 2020 00:41:18 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id gd1sm7404001pjb.14.2020.05.29.00.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:16 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id BDFF742340; Fri, 29 May 2020 07:41:10 +0000 (UTC)
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
Subject: [PATCH 06/13] ocfs2: use new sysctl subdir helper register_sysctl_subdir()
Date:   Fri, 29 May 2020 07:41:01 +0000
Message-Id: <20200529074108.16928-7-mcgrof@kernel.org>
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

// pycocci sysctl-subdir.cocci fs/ocfs2/stackglue.c

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
 fs/ocfs2/stackglue.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/fs/ocfs2/stackglue.c b/fs/ocfs2/stackglue.c
index a191094694c6..addafced7f59 100644
--- a/fs/ocfs2/stackglue.c
+++ b/fs/ocfs2/stackglue.c
@@ -677,28 +677,8 @@ static struct ctl_table ocfs2_mod_table[] = {
 	},
 	{ }
 };
-
-static struct ctl_table ocfs2_kern_table[] = {
-	{
-		.procname	= "ocfs2",
-		.data		= NULL,
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= ocfs2_mod_table
-	},
-	{ }
-};
-
-static struct ctl_table ocfs2_root_table[] = {
-	{
-		.procname	= "fs",
-		.data		= NULL,
-		.maxlen		= 0,
-		.mode		= 0555,
-		.child		= ocfs2_kern_table
-	},
-	{ }
-};
+	.data		= NULL,
+	.data		= NULL,
 
 static struct ctl_table_header *ocfs2_table_header;
 
@@ -711,7 +691,8 @@ static int __init ocfs2_stack_glue_init(void)
 {
 	strcpy(cluster_stack_name, OCFS2_STACK_PLUGIN_O2CB);
 
-	ocfs2_table_header = register_sysctl_table(ocfs2_root_table);
+	ocfs2_table_header = register_sysctl_subdir("fs", "ocfs2",
+						    ocfs2_mod_table);
 	if (!ocfs2_table_header) {
 		printk(KERN_ERR
 		       "ocfs2 stack glue: unable to register sysctl\n");
-- 
2.26.2

