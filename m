Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4FA7C54E8E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF011206D3
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 15:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GzrS3eiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgELPd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgELPd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 11:33:27 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA01C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:33:26 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id j6so13446040qvn.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 08:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O4K/En/qONOrXfLbIOD+SAfMhnyVUMpgoQRYv855ayg=;
        b=GzrS3eiCs4SWgs4rXVtiEMJ5SY1GXLMgdf+qBsR1IoUXVpZsXVpKigGa12lkVWAeES
         nbe2Elcxtg2LuveNS2Px9o/JYn84n+Q0tZZj4UqAecRv3vcGjequfkIUje6fFsU0MZaa
         6+NOS04ajywceQ72ucEPik8OzGjPWQgFIJYor7hHEzjo/OYF0zvatTXTJ0c5cuoWNBbZ
         Li2KKhjp/RYNgmDybwQjFf4dmzhNU03lnqxMqoAkU22lOK+r/Q/cLmi76LaGFv6kgTJ9
         w3zFOKZsF4kdH0OFyPD2Lxf1app6kZmNFZgRImcHZVIDluWoSH5thOwa19pPv0UCcofu
         DhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O4K/En/qONOrXfLbIOD+SAfMhnyVUMpgoQRYv855ayg=;
        b=dVb5rxDa5jb9IY1c2dUpNZEUk/CtQZQ2N6MqU657jRfjgn2pGknBqWDu1IK04v0SZy
         QG8GpCAqKA95QEGB1lNxxt5Vof2Oo5tiCU2HjstR1M7eVIoZCLoLXTEGeNOHK/PpGNlE
         m9RqltDGCAPBfQvujgO36G02hCwy89ffyrbpAYzbYmYuw9eqRCEzFmjfqVa0RIDug6pW
         wum39EAdvxr27KDN8BNUanDPTAOcq7A3s6d3Ltl1oymt/2v3+tvztDvb5lbnx1SDorcq
         u2SIRmblNYIAjID5J/3H/4QHTHPKNL64sqyFqrE+WMYl0iwwYKxU7ZCohTqsiJ1tLm8C
         5IlA==
X-Gm-Message-State: AGi0Pua7jhydUpWIKyikBWKbiz71Pn/Pcxs9Bn7LEnYvEo2dg6bnmTY6
        nO6APoyrgDkmBCW+1bB/qn1PeUHlrshClXXX
X-Google-Smtp-Source: APiQypKfnEEfyHaQw/SU5Vb20eSqgtjr049W054488qV7bm/XNr+knjg4rY6hU/wZl2lbj72dlKv7q3OsyQPU6cX
X-Received: by 2002:a0c:9ad5:: with SMTP id k21mr14928022qvf.2.1589297605130;
 Tue, 12 May 2020 08:33:25 -0700 (PDT)
Date:   Tue, 12 May 2020 17:33:19 +0200
Message-Id: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
Subject: [PATCH 1/3] kasan: consistently disable debugging features
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leonro@mellanox.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN is incompatible with some kernel debugging/tracing features.
There's been multiple patches that disable those feature for some of
KASAN files one by one. Instead of prolonging that, disable these
features for all KASAN files at once.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/Makefile | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/kasan/Makefile b/mm/kasan/Makefile
index 08b43de2383b..434d503a6525 100644
--- a/mm/kasan/Makefile
+++ b/mm/kasan/Makefile
@@ -1,23 +1,28 @@
 # SPDX-License-Identifier: GPL-2.0
 KASAN_SANITIZE := n
-UBSAN_SANITIZE_common.o := n
-UBSAN_SANITIZE_generic.o := n
-UBSAN_SANITIZE_generic_report.o := n
-UBSAN_SANITIZE_tags.o := n
+UBSAN_SANITIZE := n
 KCOV_INSTRUMENT := n
 
+# Disable ftrace to avoid recursion.
 CFLAGS_REMOVE_common.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_generic.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_generic_report.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_quarantine.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_report.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_tags.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_tags_report.o = $(CC_FLAGS_FTRACE)
 
 # Function splitter causes unnecessary splits in __asan_load1/__asan_store1
 # see: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=63533
-
 CFLAGS_common.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_generic.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_generic_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_init.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_quarantine.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 CFLAGS_tags.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
+CFLAGS_tags_report.o := $(call cc-option, -fno-conserve-stack -fno-stack-protector)
 
 obj-$(CONFIG_KASAN) := common.o init.o report.o
 obj-$(CONFIG_KASAN_GENERIC) += generic.o generic_report.o quarantine.o
-- 
2.26.2.645.ge9eca65c58-goog

