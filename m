Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4AFC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CBDD2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tvg5tDe8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726702AbgFMP6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726656AbgFMP6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:43 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA43C08C5C1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:43 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id c194so11733884oig.5
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wuNYClbuUp4QlZxCwBIpHNTAYpuCGzmthQNYBS1kJAQ=;
        b=Tvg5tDe8wP5XZgtrNd3QnxIbR9k3TboPpRrGVGURFSYThLbXXOoTKbPXnuCIOeW/4i
         ulcEzmec2X7ovn8h8XDL8NDic4orhGW7PyhIdwFjifOHykicq559nvzrx7G1gNQGCpD5
         1aSktCiruJurUC5CfkHtUSUkiTfydgtbpCC5aHyUNaLpOfi0mqangH+UHIb6P/kWgnSo
         7hjLVIC4Dd3mrP041HmCCIUjNXJZkZrB7DcCpKRmwgOEZy/KxCtZc6VUf9JpiO/trVDE
         4mU47h3JNfh0kbWki39e0A/fhsnQlC4k8LmfwSnMytFzAcUO43pf3kiMuTkhF2kEWFYU
         sRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wuNYClbuUp4QlZxCwBIpHNTAYpuCGzmthQNYBS1kJAQ=;
        b=G7aV4QknzzLAuqIpmoeGqbU6/sks+5DucpJ99xYEXL5EsFDOx9B/8YLvNfGHrk+m6w
         jhWR/wnWvm4vjrQBr4FgZGoDWdTQTs78JrTWnkvp2DZdKIWlF3qmocuh5NAzVHS4ZdxC
         IEbv8bUW2Xx2hiWEOqILTaBPI/2QwpI6LpW0w23yjAluF6/eZpKjKM+6sRwOIkMiKXRa
         MvoMoXW08BRU1xz39+Lu9aZrLzloEb8fTCSJ9oZkdX1BIImF4wx479pAUeus5tKwhYUl
         r8y6zcyLH219+f7e8v7c82ayKurV9az9qOPRqEhIij2kPVecw9la1q+MuJDklstoZKzR
         YN/g==
X-Gm-Message-State: AOAM5329owgpHZg+jPvL7jKrz2/UezgLK1vJQy4DRnmPeG8bn9wy5XPs
        GGRId5Yodhu1O2Zy1QudZUQ=
X-Google-Smtp-Source: ABdhPJyv6by/ZHx4cvM8EKfYUXSGL0JOEYold7nLzzoeapnEyiM55PyK1/EwMGBujqfdFWXITe7o3A==
X-Received: by 2002:a54:4e81:: with SMTP id c1mr3011315oiy.151.1592063922781;
        Sat, 13 Jun 2020 08:58:42 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:42 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 24/24] kset-example: use pr_debug_n to create example print-classes
Date:   Sat, 13 Jun 2020 09:57:38 -0600
Message-Id: <20200613155738.2249399-25-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a (counter?) use-case for debug-print-classes.  It adds
read,write print-classes, and marks all pr_debugs in *_show and
*_store functions accordingly.

this allows manipulation of those categories as:

   echo "module kset-example mflags 1 +p" > /proc/dynamic_debug/control
   echo "module kset-example mflags 2 +p" > /proc/dynamic_debug/control

But this marking completely duplicates the callsite sets definable by:

   #> cat enable-show-store
   module kset-example function *_show +p
   module kset-example function *_store +p
   #> cat enable-show-store > /proc/dynamic_debug/control

IOW, dont over-use debug-print-class.  Your arbitrary subset of
pr-debug calls can be recreated by an N line script.
---
 samples/kobject/kset-example.c | 33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index 27c9b1beec28..61d016cb6b4d 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -42,6 +42,27 @@ struct foo_attribute {
 };
 #define to_foo_attr(x) container_of(x, struct foo_attribute, attr)
 
+/*
+ * This module also uses pr_debug() to provide debug logging that
+ * makes it easy to see the module operating.  Just invoke as:
+ *	#> dmesg -w &
+ * 	#> modprobe kset-example dyndbg=+pfml
+ *
+ * Further, we *arbitrarily* use pr_debug_n() to create 2 separate
+ * (non-default) print-classes, in the *_show and *_store functions.
+ *
+ * This allows selection by those categories:
+ *	echo "module kset-example mflags 1 +p" > dynamic_debug/control
+ *	echo "module kset-example mflags 2 +p" > dynamic_debug/control
+ * but that is clearer as:
+ *	echo "module kset-example function *_show +p" > dynamic_debug/control
+ *	echo "module kset-example function *_store +p" > dynamic_debug/control
+ *
+ * IOW - mostly you dont need non-default print-classes
+ */
+#define prCATr 1	/* print-class for show (r=read) */
+#define prCATw 2	/* print-class for store (w=write) */
+
 /*
  * The default show function that must be passed to sysfs.  This will be
  * called by sysfs for whenever a show function is called by the user on a
@@ -56,7 +77,7 @@ static ssize_t foo_attr_show(struct kobject *kobj,
 	struct foo_attribute *attribute;
 	struct foo_obj *foo;
 
-	pr_debug("called");
+	pr_debug_n(prCATr, "called");
 	attribute = to_foo_attr(attr);
 	foo = to_foo_obj(kobj);
 
@@ -77,7 +98,7 @@ static ssize_t foo_attr_store(struct kobject *kobj,
 	struct foo_attribute *attribute;
 	struct foo_obj *foo;
 
-	pr_debug("called");
+	pr_debug_n(prCATw, "called");
 	attribute = to_foo_attr(attr);
 	foo = to_foo_obj(kobj);
 
@@ -115,7 +136,7 @@ static void foo_release(struct kobject *kobj)
 static ssize_t foo_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
 			char *buf)
 {
-	pr_debug("called");
+	pr_debug_n(prCATr, "called");
 	return sprintf(buf, "%d\n", foo_obj->foo);
 }
 
@@ -124,7 +145,7 @@ static ssize_t foo_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
 {
 	int ret;
 
-	pr_debug("called");
+	pr_debug_n(prCATw, "called");
 	ret = kstrtoint(buf, 10, &foo_obj->foo);
 	if (ret < 0)
 		return ret;
@@ -145,7 +166,7 @@ static ssize_t b_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
 {
 	int var;
 
-	pr_debug("called");
+	pr_debug_n(prCATr, "called");
 	if (strcmp(attr->attr.name, "baz") == 0)
 		var = foo_obj->baz;
 	else
@@ -158,7 +179,7 @@ static ssize_t b_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
 {
 	int var, ret;
 
-	pr_debug("called");
+	pr_debug_n(prCATw, "called");
 	ret = kstrtoint(buf, 10, &var);
 	if (ret < 0)
 		return ret;
-- 
2.26.2

