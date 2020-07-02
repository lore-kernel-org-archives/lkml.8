Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBF5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A61820781
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ZP48jJgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgGBCyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgGBCyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:54:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5484C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 19:54:44 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q17so11862398pfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D4Q7wlnC9uinQAfoiYOmKAt3GyYnF0nwS1m28sSQDUo=;
        b=ZP48jJgvWkI9Wmfys6LSUGRJKCAuUvIJ1CenCS7q4/qaZMUpIwAmGMeKJPT2wS0Wmy
         yQ4JtPRu7jJcldH2+IBxwZ7U8Dmekr3AiJj8akIHRdks0YXPwYaZJa5DOKZilVmzJlCP
         F/rL62iMEdh++SSXvJq21IJPk/pF89qIJJacE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D4Q7wlnC9uinQAfoiYOmKAt3GyYnF0nwS1m28sSQDUo=;
        b=HOah8E/vtzG8PMZgwkDZfNIwsZzo97F6poyKs7zXVRlps3fHypEDsbMCBPQaCbTAo+
         uqL5juvxBDGMpFvkbVhG+BPvfH48KXo9UN8SxLk1S+BQwFTCmqkhIW+XXjGkZMf5Ft6n
         LNzRmugN3wiaRAh/Uz+SmMKMLKAj/54ifOlf1CTUX57hpvgFYPfMEPnZdspE9HDcGsyD
         HE7mIyhwpKZivj7Y5MoGkzEa6la0r4fSVy3I9DQzctH6yHfATrQRdiflwjUG3NqzYZOg
         aSfM2YeLZqh6GvPZQUqt6QCvpnIeQsr8/e+Yrtop9fczGw5aIONTTDyCYRQtCnimcsxp
         s2Zw==
X-Gm-Message-State: AOAM531eZ3tnyfDhTG0xKJ8ldyBGvPCmeNBLaxHVbRyhqdh+aFhsOV6q
        f3V/B0nOjm4X+vUp4gFtxZ7b9conSCo=
X-Google-Smtp-Source: ABdhPJyDd94QLnAKxB+F6OzOYld27r7l1OjUzszJAvVmLhfM9lYgzLjnElqe0vUfemvYhf3Y3Zpv8g==
X-Received: by 2002:a63:20d:: with SMTP id 13mr22820110pgc.166.1593658484159;
        Wed, 01 Jul 2020 19:54:44 -0700 (PDT)
Received: from localhost (2001-44b8-1113-6700-3c80-6152-10ca-83bc.static.ipv6.internode.on.net. [2001:44b8:1113:6700:3c80:6152:10ca:83bc])
        by smtp.gmail.com with ESMTPSA id h6sm7031275pfo.123.2020.07.01.19.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 19:54:43 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v8 2/4] kasan: Document support on 32-bit powerpc
Date:   Thu,  2 Jul 2020 12:54:30 +1000
Message-Id: <20200702025432.16912-3-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702025432.16912-1-dja@axtens.net>
References: <20200702025432.16912-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN is supported on 32-bit powerpc and the docs should reflect this.

Document s390 support while we're at it.

Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 Documentation/dev-tools/kasan.rst |  7 +++++--
 Documentation/powerpc/kasan.txt   | 12 ++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/powerpc/kasan.txt

diff --git a/Documentation/dev-tools/kasan.rst b/Documentation/dev-tools/kasan.rst
index c652d740735d..554cbee1d240 100644
--- a/Documentation/dev-tools/kasan.rst
+++ b/Documentation/dev-tools/kasan.rst
@@ -22,7 +22,8 @@ global variables yet.
 Tag-based KASAN is only supported in Clang and requires version 7.0.0 or later.
 
 Currently generic KASAN is supported for the x86_64, arm64, xtensa, s390 and
-riscv architectures, and tag-based KASAN is supported only for arm64.
+riscv architectures. It is also supported on 32-bit powerpc kernels. Tag-based
+KASAN is supported only on arm64.
 
 Usage
 -----
@@ -255,7 +256,9 @@ CONFIG_KASAN_VMALLOC
 ~~~~~~~~~~~~~~~~~~~~
 
 With ``CONFIG_KASAN_VMALLOC``, KASAN can cover vmalloc space at the
-cost of greater memory usage. Currently this is only supported on x86.
+cost of greater memory usage. Currently this supported on x86, s390
+and 32-bit powerpc. It is optional, except on 32-bit powerpc kernels
+with module support, where it is required.
 
 This works by hooking into vmalloc and vmap, and dynamically
 allocating real shadow memory to back the mappings.
diff --git a/Documentation/powerpc/kasan.txt b/Documentation/powerpc/kasan.txt
new file mode 100644
index 000000000000..26bb0e8bb18c
--- /dev/null
+++ b/Documentation/powerpc/kasan.txt
@@ -0,0 +1,12 @@
+KASAN is supported on powerpc on 32-bit only.
+
+32 bit support
+==============
+
+KASAN is supported on both hash and nohash MMUs on 32-bit.
+
+The shadow area sits at the top of the kernel virtual memory space above the
+fixmap area and occupies one eighth of the total kernel virtual memory space.
+
+Instrumentation of the vmalloc area is optional, unless built with modules,
+in which case it is required.
-- 
2.25.1

