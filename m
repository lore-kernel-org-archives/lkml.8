Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B262AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E9092074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 15:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VerhtY5s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgFMP6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 11:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgFMP6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 11:58:41 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996D9C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:40 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id e5so9734579ote.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 08:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sjkczbkul9NKVPRH/wDQS0yGqzaoqVkIPgvS0BYIbb8=;
        b=VerhtY5soLDoYsNEIsDmrkV7PUpF7PNRDJYCcrKpgZmGmJNn/NuT3r9Ei62e1PJ2XD
         yuB1Vb0+pxMxBokqj4uGEhrk2WXiWHbHcI+5I/nUjD2E4AY1WQ14veoYagahcL5p345X
         PiNwdGBf2aVRief1i/MZ+QLtmIgEmeDb6TCRkoMr69DnY05rYD0FCUuipvFEpFWJNVQd
         FJRzRaZGkjNGLXR/HJjC/eiN6E1EFXi8jlO2WDz6cpmLINRPuqNiMR9Mymo2Q725qmEq
         QoVdoja0cVu7ChA9fQZQvGcSCr2PLcGu1wo99zKiQ+KOl6ZKQQbADCjAoDyxGgXxvAuN
         aceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sjkczbkul9NKVPRH/wDQS0yGqzaoqVkIPgvS0BYIbb8=;
        b=Y2OnTQKtaggchZVQzbedSsUi/gSOu5vrneZJaAgnhl7zBWiIvhp4SaRgQUAoFMenoY
         eFpwDb0y7X1gn0fV6PVIjo2sHK0MGWc653CO4PgPVl5yzFXmmj8xc9waFSEpmrwMrVUd
         hLwsdk46khiEwuosoodefRIYo8OO3Ku+qwMwt+uQJV6eSwhNs5iKP4NGBs9ETpOUy4Rr
         /2dH1rZCAw/SHK6acj2Agxv940S/fWHR3EXRd6FJ0E6evHHx2YelvRZdX94RfzJHtBMX
         1o/KRDgX2OxrD4WrXgkGuI6J0x3AyjycdUQC3YjJKON4M8qpwh1TJ1R/LG3rXKv6yrix
         XqZw==
X-Gm-Message-State: AOAM533vAtRnRb8EhRarOJLyzvMXuY9aGjOUVeU9p6vnvNriZ4BFcYcO
        ojGglJ44sigX6m/dHL9JueKpzuIg/os=
X-Google-Smtp-Source: ABdhPJw9tPOyKKOL1afsqf+XghTRulXyfREH5tsV6gB+QVYEtltyJyymXFxzMMYBhZBXICI80tMZTQ==
X-Received: by 2002:a05:6830:1ad7:: with SMTP id r23mr14155703otc.96.1592063920023;
        Sat, 13 Jun 2020 08:58:40 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::aaac])
        by smtp.googlemail.com with ESMTPSA id 53sm2105565otv.22.2020.06.13.08.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 08:58:39 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 23/24] kset-example: add pr_debug()s for easy visibility of its operation
Date:   Sat, 13 Jun 2020 09:57:37 -0600
Message-Id: <20200613155738.2249399-24-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200613155738.2249399-1-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

put pr_debug()s into most functions, to easily see code operate when
module is loaded and used.

  #> dmesg -w &
  #> modprobe kset-example dyndbg=+pfml
  #> cat /sys/kernel/kset-example/*/*
---
 samples/kobject/kset-example.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/samples/kobject/kset-example.c b/samples/kobject/kset-example.c
index c8010f126808..27c9b1beec28 100644
--- a/samples/kobject/kset-example.c
+++ b/samples/kobject/kset-example.c
@@ -56,6 +56,7 @@ static ssize_t foo_attr_show(struct kobject *kobj,
 	struct foo_attribute *attribute;
 	struct foo_obj *foo;
 
+	pr_debug("called");
 	attribute = to_foo_attr(attr);
 	foo = to_foo_obj(kobj);
 
@@ -76,6 +77,7 @@ static ssize_t foo_attr_store(struct kobject *kobj,
 	struct foo_attribute *attribute;
 	struct foo_obj *foo;
 
+	pr_debug("called");
 	attribute = to_foo_attr(attr);
 	foo = to_foo_obj(kobj);
 
@@ -102,6 +104,7 @@ static void foo_release(struct kobject *kobj)
 {
 	struct foo_obj *foo;
 
+	pr_debug("called");
 	foo = to_foo_obj(kobj);
 	kfree(foo);
 }
@@ -112,6 +115,7 @@ static void foo_release(struct kobject *kobj)
 static ssize_t foo_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
 			char *buf)
 {
+	pr_debug("called");
 	return sprintf(buf, "%d\n", foo_obj->foo);
 }
 
@@ -120,6 +124,7 @@ static ssize_t foo_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
 {
 	int ret;
 
+	pr_debug("called");
 	ret = kstrtoint(buf, 10, &foo_obj->foo);
 	if (ret < 0)
 		return ret;
@@ -140,6 +145,7 @@ static ssize_t b_show(struct foo_obj *foo_obj, struct foo_attribute *attr,
 {
 	int var;
 
+	pr_debug("called");
 	if (strcmp(attr->attr.name, "baz") == 0)
 		var = foo_obj->baz;
 	else
@@ -152,6 +158,7 @@ static ssize_t b_store(struct foo_obj *foo_obj, struct foo_attribute *attr,
 {
 	int var, ret;
 
+	pr_debug("called");
 	ret = kstrtoint(buf, 10, &var);
 	if (ret < 0)
 		return ret;
@@ -201,6 +208,7 @@ static struct foo_obj *create_foo_obj(const char *name)
 	struct foo_obj *foo;
 	int retval;
 
+	pr_debug("called");
 	/* allocate the memory for the whole object */
 	foo = kzalloc(sizeof(*foo), GFP_KERNEL);
 	if (!foo)
@@ -235,11 +243,13 @@ static struct foo_obj *create_foo_obj(const char *name)
 
 static void destroy_foo_obj(struct foo_obj *foo)
 {
+	pr_debug("called");
 	kobject_put(&foo->kobj);
 }
 
 static int __init example_init(void)
 {
+	pr_debug("called");
 	/*
 	 * Create a kset with the name of "kset_example",
 	 * located under /sys/kernel/
@@ -276,6 +286,7 @@ static int __init example_init(void)
 
 static void __exit example_exit(void)
 {
+	pr_debug("called");
 	destroy_foo_obj(baz_obj);
 	destroy_foo_obj(bar_obj);
 	destroy_foo_obj(foo_obj);
-- 
2.26.2

