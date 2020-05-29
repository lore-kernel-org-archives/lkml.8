Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B163AC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AA320810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590738082;
	bh=NenSwSGDF9QMQgokmPhgskTTc0a8oJ86NEhdFy5VPhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OR4VyUJ2hlxEBDHm+6tYAXn5P2UfutQ6GqDy7HmUArkzriMtq/3UQEAQisguhDC3L
	 TtZiNTN+lpxS0JrI8pdcaplvF8FTdB3yxs0uNpIUmqkpATMYIFilS1RafMBOszN8Hz
	 r2o6tPlwpD0KGEKge5MSQEete2PbuBtg+847mTYk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgE2HlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:41:21 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:54264 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgE2HlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:41:17 -0400
Received: by mail-pj1-f67.google.com with SMTP id ci21so847340pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2jHA8VIMvKgrxc1AW+DPbkuZZuKskUQcNv9lMPkimBs=;
        b=sFiY7a9O23vHdPbjXpqEIsFJlRaUMMDNd1rAjCG/4Kxg2gkI5Xpq/Vc3zkBRPO00Cs
         2FK6/gnCJ6wWY1fs/3agmSm1BUZFLcudHEc7KThpIDjjNhZbuhxx+7ZNKlZ2YBU9Dj1o
         Yln4q+PnOYPN60QxKKW5dxMUj4NXKyAmhK1w282xymrVOY614FETlEWVS7HW1FVpT9k5
         ZC7leHMa+rNrC5j7fqJHeVUCuOVmfHggLhy7i0taXaq82IINNGMTAniHqPKDQS5DPrby
         a0sZYOI0Xv2d9RGUZyMSA4c08MqHMC81x16eFfF4aptfwZzOkCor6tDSo7vUUdZae/TN
         j8DQ==
X-Gm-Message-State: AOAM532QSwnalS4vS6ElS0aOj7WvK7cKrvig6QopIKvbhP40Zb8QuC+p
        fRuHiIdGj2XaQusNlBqnLXw=
X-Google-Smtp-Source: ABdhPJwLKp4Ek16GIR6wfTGzoNi9sGCN2B5VA54FGeDyqorTPtnWjcRjvN0kcQMGbXM4anhxYRPvyw==
X-Received: by 2002:a17:90a:b011:: with SMTP id x17mr8088274pjq.175.1590738075444;
        Fri, 29 May 2020 00:41:15 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id a7sm6765760pfa.187.2020.05.29.00.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:41:12 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 67FA942309; Fri, 29 May 2020 07:41:10 +0000 (UTC)
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
Subject: [PATCH 03/13] hpet: use new sysctl subdir helper register_sysctl_subdir()
Date:   Fri, 29 May 2020 07:40:58 +0000
Message-Id: <20200529074108.16928-4-mcgrof@kernel.org>
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

// pycocci sysctl-subdir.cocci drivers/char/hpet.c

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
 drivers/char/hpet.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index ed3b7dab678d..169c970d5ff8 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -746,26 +746,6 @@ static struct ctl_table hpet_table[] = {
 	{}
 };
 
-static struct ctl_table hpet_root[] = {
-	{
-	 .procname = "hpet",
-	 .maxlen = 0,
-	 .mode = 0555,
-	 .child = hpet_table,
-	 },
-	{}
-};
-
-static struct ctl_table dev_root[] = {
-	{
-	 .procname = "dev",
-	 .maxlen = 0,
-	 .mode = 0555,
-	 .child = hpet_root,
-	 },
-	{}
-};
-
 static struct ctl_table_header *sysctl_header;
 
 /*
@@ -1059,7 +1039,7 @@ static int __init hpet_init(void)
 	if (result < 0)
 		return -ENODEV;
 
-	sysctl_header = register_sysctl_table(dev_root);
+	sysctl_header = register_sysctl_subdir("dev", "hpet", hpet_table);
 
 	result = acpi_bus_register_driver(&hpet_acpi_driver);
 	if (result < 0) {
-- 
2.26.2

