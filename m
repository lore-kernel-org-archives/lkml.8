Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94175C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7242120B80
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="giq6ndmK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbgFPMhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPMg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:36:57 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57894C08C5C3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:36:56 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id q5so15392386qvp.23
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=0vKWPfQjP4gTkC13b5eOTjKj/nU6f1wDicpnc57zvTg=;
        b=giq6ndmKyvmreXndGDx+A2QGDTeljow3FJH6XZDLqx3AigSslpeOqno4UAORJukH5L
         0kBOw3ib2K5RDsAUhfRC2oTZOGf5mpMYGkzpqTGu56i35awnSqZGjAXWWzp+VYeaSQju
         jgDqaPcmX/rZxpWATLa0XLUHbnpgDmhy1iGo/Tw86Y0GvLthN4PAbNFShEj1odt1um4v
         ta278Vco+vKSx4ZpIT7PyjaV7KKxWyD8wmA8PPPBWI1p8Z7hjPutgaaA4xRompBfeBAe
         npt4MNeJ1bRmpjjz1nszZ2uICuUqlUZkPwkH+ldPD/NXsy8Cwq5IwKGM/JhTgXWXwoF1
         ULMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0vKWPfQjP4gTkC13b5eOTjKj/nU6f1wDicpnc57zvTg=;
        b=gh82NWpmUxhG9ak5ujmpWXojrZgP3nPtrHgZkSMlh6hgcGNnH4MQuBOk5wrIlMZxjI
         +aQ/0XbChWjOB7ls1KLI+ZTTorv3LuC1/GRBx/JicevAl6P6R0g8BhmKo+Y4KRmENusb
         9d8his1Gu1z3W2r6yFq8EqF+PzJP0XvIL9LuYIPnKghWZx8P1Jl0jrc3Hwv8B6pD1m/A
         39W57j7BQHOLdutp+XBypgN2QxhyjeLA/EoEqoo1fjiDX2eiGNf3LS/y9e1R4yj2GCGr
         itHsjctw3rYn+I1yetNuAliaQnI9DMAnnyKMcZ8IfIttHTAhPDLyQtbFbrpmBMS3IMQa
         wXVg==
X-Gm-Message-State: AOAM530D2mnNgV7htbsAyCVzlcjMAb2pVoObMkG+pJcrWrjKTACAJDco
        HHGiGd+C5HI55x0AIMm6qvma+fK9Qw==
X-Google-Smtp-Source: ABdhPJy0yekPNxt9LDvA9hlwBaU7YG/RbJ0qT05IBYYqG1E0bWN6/cQTLU+dOCBzQHvsQGuEErD2Pk0n7A==
X-Received: by 2002:ad4:472f:: with SMTP id l15mr2030266qvz.52.1592311015499;
 Tue, 16 Jun 2020 05:36:55 -0700 (PDT)
Date:   Tue, 16 Jun 2020 14:36:22 +0200
In-Reply-To: <20200616123625.188905-1-elver@google.com>
Message-Id: <20200616123625.188905-2-elver@google.com>
Mime-Version: 1.0
References: <20200616123625.188905-1-elver@google.com>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
Subject: [PATCH 1/4] kcsan: Silence -Wmissing-prototypes warning with W=1
From:   Marco Elver <elver@google.com>
To:     elver@google.com, paulmck@kernel.org
Cc:     dvyukov@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions here should not be forward declared for explicit use
elsewhere in the kernel, as they should only be emitted by the compiler
due to sanitizer instrumentation.  Add forward declarations a line above
their definition to shut up warnings in W=1 builds.

Link: https://lkml.kernel.org/r/202006060103.jSCpnV1g%lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 15f67949d11e..1866bafda4fd 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -754,6 +754,7 @@ EXPORT_SYMBOL(__kcsan_check_access);
  */
 
 #define DEFINE_TSAN_READ_WRITE(size)                                           \
+	void __tsan_read##size(void *ptr);                                     \
 	void __tsan_read##size(void *ptr)                                      \
 	{                                                                      \
 		check_access(ptr, size, 0);                                    \
@@ -762,6 +763,7 @@ EXPORT_SYMBOL(__kcsan_check_access);
 	void __tsan_unaligned_read##size(void *ptr)                            \
 		__alias(__tsan_read##size);                                    \
 	EXPORT_SYMBOL(__tsan_unaligned_read##size);                            \
+	void __tsan_write##size(void *ptr);                                    \
 	void __tsan_write##size(void *ptr)                                     \
 	{                                                                      \
 		check_access(ptr, size, KCSAN_ACCESS_WRITE);                   \
@@ -777,12 +779,14 @@ DEFINE_TSAN_READ_WRITE(4);
 DEFINE_TSAN_READ_WRITE(8);
 DEFINE_TSAN_READ_WRITE(16);
 
+void __tsan_read_range(void *ptr, size_t size);
 void __tsan_read_range(void *ptr, size_t size)
 {
 	check_access(ptr, size, 0);
 }
 EXPORT_SYMBOL(__tsan_read_range);
 
+void __tsan_write_range(void *ptr, size_t size);
 void __tsan_write_range(void *ptr, size_t size)
 {
 	check_access(ptr, size, KCSAN_ACCESS_WRITE);
@@ -799,6 +803,7 @@ EXPORT_SYMBOL(__tsan_write_range);
  * the size-check of compiletime_assert_rwonce_type().
  */
 #define DEFINE_TSAN_VOLATILE_READ_WRITE(size)                                  \
+	void __tsan_volatile_read##size(void *ptr);                            \
 	void __tsan_volatile_read##size(void *ptr)                             \
 	{                                                                      \
 		const bool is_atomic = size <= sizeof(long long) &&            \
@@ -811,6 +816,7 @@ EXPORT_SYMBOL(__tsan_write_range);
 	void __tsan_unaligned_volatile_read##size(void *ptr)                   \
 		__alias(__tsan_volatile_read##size);                           \
 	EXPORT_SYMBOL(__tsan_unaligned_volatile_read##size);                   \
+	void __tsan_volatile_write##size(void *ptr);                           \
 	void __tsan_volatile_write##size(void *ptr)                            \
 	{                                                                      \
 		const bool is_atomic = size <= sizeof(long long) &&            \
@@ -836,14 +842,17 @@ DEFINE_TSAN_VOLATILE_READ_WRITE(16);
  * The below are not required by KCSAN, but can still be emitted by the
  * compiler.
  */
+void __tsan_func_entry(void *call_pc);
 void __tsan_func_entry(void *call_pc)
 {
 }
 EXPORT_SYMBOL(__tsan_func_entry);
+void __tsan_func_exit(void);
 void __tsan_func_exit(void)
 {
 }
 EXPORT_SYMBOL(__tsan_func_exit);
+void __tsan_init(void);
 void __tsan_init(void)
 {
 }
-- 
2.27.0.290.gba653c62da-goog

