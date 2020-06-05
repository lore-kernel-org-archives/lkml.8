Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8958C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0FFE20663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 14:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jarSB6Qs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbgFEOUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgFEOTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 10:19:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F16FC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 07:19:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id s10so5235333pgm.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 07:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=I/KKVhuE8TSr5CEPiD/eAOjx+oGBg92j9fEZOcTd8zg=;
        b=jarSB6Qs7gLwZLwAII57y/JKWmy3ExqgUg4+qPkwLvqLeaEWf1Kixa0LjlOiCp5DkE
         iCWhitxnz+om4kZ6TOMl20AvHbhxvPjnM3uoi2UXR9fkMS25nSr4jQnu8W7AZGeI6Rdr
         TdVp/eUHb7jMMzX2WNXMl1/zWXVpFdErX2PJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=I/KKVhuE8TSr5CEPiD/eAOjx+oGBg92j9fEZOcTd8zg=;
        b=uRcix9BCvqX0BuRB1A+YGr8+nZ+D4MkDTrRk9dyUR/d4Wjqidk7+kfxL3OjvcYFp+Z
         FIJV/opkToeF9jReoQq+xok7NvuTV9L4xLzTrQndzAqaZ/tQxqCKbZv5wbbds4QJ2Wys
         TULcpBzN9D55iOBYXv+QMlRXDRW1/kq0V6QD8RQ1oRFd4l+AlRbPDU/PHVG4dH8IYJKc
         ts2kMILSzEwImhwTFmSa3XO8lxEHQkn1QTuLoRnRAwcBOo8V+bzqqEcKylAWKHNeTKFD
         uq+gwobyYHqkDNMDMt1bsl1PJwXP0dJRQAljd2fB3iPUpAkeQgK9YCg4wvIJDtD3dHpg
         BVkQ==
X-Gm-Message-State: AOAM531QnZD81K7b1Ahet5VBW07LNvSBlTV/tXqp0mArQGONu+cjNUnS
        /BOPK0w0dahpz78/80ksPsCVkA==
X-Google-Smtp-Source: ABdhPJz7HFAhlb37GBve0BZLBLu80nmLbK9xyenwxebfEX6BJX1qGBnd3RV1CVMHJdneQ+1UKXbDhw==
X-Received: by 2002:a63:f854:: with SMTP id v20mr10018864pgj.0.1591366794973;
        Fri, 05 Jun 2020 07:19:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x11sm7568429pfm.196.2020.06.05.07.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 07:19:54 -0700 (PDT)
Date:   Fri, 5 Jun 2020 07:19:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Joe Perches <joe@perches.com>, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/i915: Fix comments mentioning typo in IS_ENABLED()
Message-ID: <202006050718.9D4FCFC2E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has no code changes, but the typo is clearly getting copy/pasted,
so better to avoid this now and fix the typo. IS_ENABLED() takes full
names, and must have the "CONFIG_" prefix.

Reported-by: Joe Perches <joe@perches.com>
Link: https://lore.kernel.org/lkml/b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/dma-buf/selftests.h                          | 2 +-
 drivers/gpu/drm/i915/selftests/i915_live_selftests.h | 2 +-
 drivers/gpu/drm/i915/selftests/i915_mock_selftests.h | 2 +-
 drivers/gpu/drm/i915/selftests/i915_perf_selftests.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/selftests.h b/drivers/dma-buf/selftests.h
index 55918ef9adab..bc8cea67bf1e 100644
--- a/drivers/dma-buf/selftests.h
+++ b/drivers/dma-buf/selftests.h
@@ -5,7 +5,7 @@
  * a module parameter. It must be unique and legal for a C identifier.
  *
  * The function should be of type int function(void). It may be conditionally
- * compiled using #if IS_ENABLED(DRM_I915_SELFTEST).
+ * compiled using #if IS_ENABLED(CONFIG_DRM_I915_SELFTEST).
  *
  * Tests are executed in order by igt/dmabuf_selftest
  */
diff --git a/drivers/gpu/drm/i915/selftests/i915_live_selftests.h b/drivers/gpu/drm/i915/selftests/i915_live_selftests.h
index 5dd5d81646c4..e42ea9c6703b 100644
--- a/drivers/gpu/drm/i915/selftests/i915_live_selftests.h
+++ b/drivers/gpu/drm/i915/selftests/i915_live_selftests.h
@@ -11,7 +11,7 @@
  * a module parameter. It must be unique and legal for a C identifier.
  *
  * The function should be of type int function(void). It may be conditionally
- * compiled using #if IS_ENABLED(DRM_I915_SELFTEST).
+ * compiled using #if IS_ENABLED(CONFIG_DRM_I915_SELFTEST).
  *
  * Tests are executed in order by igt/drv_selftest
  */
diff --git a/drivers/gpu/drm/i915/selftests/i915_mock_selftests.h b/drivers/gpu/drm/i915/selftests/i915_mock_selftests.h
index 6a2be7d0dd95..4be044198af9 100644
--- a/drivers/gpu/drm/i915/selftests/i915_mock_selftests.h
+++ b/drivers/gpu/drm/i915/selftests/i915_mock_selftests.h
@@ -11,7 +11,7 @@
  * a module parameter. It must be unique and legal for a C identifier.
  *
  * The function should be of type int function(void). It may be conditionally
- * compiled using #if IS_ENABLED(DRM_I915_SELFTEST).
+ * compiled using #if IS_ENABLED(CONFIG_DRM_I915_SELFTEST).
  *
  * Tests are executed in order by igt/drv_selftest
  */
diff --git a/drivers/gpu/drm/i915/selftests/i915_perf_selftests.h b/drivers/gpu/drm/i915/selftests/i915_perf_selftests.h
index d8da142985eb..c2389f8a257d 100644
--- a/drivers/gpu/drm/i915/selftests/i915_perf_selftests.h
+++ b/drivers/gpu/drm/i915/selftests/i915_perf_selftests.h
@@ -11,7 +11,7 @@
  * a module parameter. It must be unique and legal for a C identifier.
  *
  * The function should be of type int function(void). It may be conditionally
- * compiled using #if IS_ENABLED(DRM_I915_SELFTEST).
+ * compiled using #if IS_ENABLED(CONFIG_DRM_I915_SELFTEST).
  *
  * Tests are executed in order by igt/i915_selftest
  */
-- 
2.25.1


-- 
Kees Cook
