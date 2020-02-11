Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA46CC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E2720714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 06:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbyDuRd+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgBKGPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 01:15:04 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33309 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbgBKGPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 01:15:04 -0500
Received: by mail-ot1-f65.google.com with SMTP id b18so9021560otp.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 22:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ovFJATVDu6V+ADjunhZvdZKdFIc/4GBOO/Os9uePfYE=;
        b=PbyDuRd+bCjjDsWIYXPfjGpOMhwlwj1boUYk7oUx4sd8wMvaphOrmwfdxQF+t2SrPS
         qZ1WtNsYHmLo0wpgRifBvJ4YNgGVS2WlYzS2dBNY9YfInjY1GoiJQwuakKh6CsbGARaW
         FzyM1oyOo8xjSuNRRJ6QVZXLxIE+dfAXYwatcaN0L5frjxHxlZmPB0tg4OjpvIqFS3WH
         46I5Ynu3GB7c2B1op2PivbxJRXVA2nzfnMBKBLZEKn4agAEKx9NvaQiBqmA5CXUvMYNN
         tewRS4Za5sOIXp9YOWFcIlkM/Yhgjs492lT3pDRPyOVUySM0lQqyNsyPbeiC6M2Bq0ml
         wzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ovFJATVDu6V+ADjunhZvdZKdFIc/4GBOO/Os9uePfYE=;
        b=qs3BvzHWExTexOlRmbDsmoPs/Vaks6WTDITQR+13u+rhtFgcE9oPF/vK7PCxA0nY7I
         b98nhnH/nqlMrI7N9t5xLQM5bgbMXB4JNxLHMCix2kv7g6jwj/7IV3J6kMbIR97X28rV
         ADVLZLR4qBpw4/HjdurabOsz95fIxDaL5xCRfaHhMilA66MUbzUVgpdjT+LRzCTGeK+Z
         REFyBRcHF3xxQC7SI/KRLrf/Tp5/heHGbS/OUzITOvilBm7z2E5opPjz4bn+o1dc+vNB
         ZCA/R7+AljV0NNDrtVyPmxSwwlBKaF2AElzkjt8eAngf86VmsSF/b+r9zeLoZ8eKPJyn
         bxfA==
X-Gm-Message-State: APjAAAUupTHF71ZzwEWuLJbMnLqeN3V+baVVx5oeOroHn8zEaDPnQMHN
        DrF6kSG7oW2D9KNsnQQGu0k=
X-Google-Smtp-Source: APXvYqw6tIh0QT0u93GUbrmFqsmB/GO9LEZw1RYgpBEfmSVnsb6DSCeHR24r8sic5wRHHarUPoTgFQ==
X-Received: by 2002:a05:6830:1042:: with SMTP id b2mr4001160otp.306.1581401703244;
        Mon, 10 Feb 2020 22:15:03 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id v23sm898122otj.61.2020.02.10.22.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 22:15:02 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] drm/i915: Disable -Wtautological-constant-out-of-range-compare
Date:   Mon, 10 Feb 2020 23:13:39 -0700
Message-Id: <20200211061338.23666-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200211050808.29463-1-natechancellor@gmail.com>
References: <20200211050808.29463-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A recent commit in clang added -Wtautological-compare to -Wall, which is
enabled for i915 so we see the following warning:

../drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1485:22: warning:
result of comparison of constant 576460752303423487 with expression of
type 'unsigned int' is always false
[-Wtautological-constant-out-of-range-compare]
        if (unlikely(remain > N_RELOC(ULONG_MAX)))
            ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~

This warning only happens on x86_64 but that check is relevant for
32-bit x86 so we cannot remove it. -Wtautological-compare on a whole has
good warnings but this one is not really relevant for the kernel because
of all of the different configurations that are used to build the
kernel. When -Wtautological-compare is enabled for the kernel, this
option will remain disabled so do that for i915 now.

Link: https://github.com/ClangBuiltLinux/linux/issues/778
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2: https://lore.kernel.org/lkml/20200211050808.29463-1-natechancellor@gmail.com/

* Fix patch application due to basing on a local tree that had
  -Wuninitialized turned on. Can confirm that patch applies on
  latest -next now.

 drivers/gpu/drm/i915/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index b8c5f8934dbd..159355eb43a9 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -22,6 +22,7 @@ subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
 subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
 subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
 subdir-ccflags-y += $(call cc-disable-warning, uninitialized)
+subdir-ccflags-y += $(call cc-disable-warning, tautological-constant-out-of-range-compare)
 subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
 
 # Fine grained warnings disable
-- 
2.25.0

