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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A92C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF7A2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q19RtMc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBKFIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 00:08:37 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41676 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgBKFIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:08:36 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so8861758otc.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 21:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzVeAyFZDO+woAn09FRMNrkoa0zSne0dLCKhCXRtKF4=;
        b=q19RtMc0tzaSrg/nVN9T+kDTIgE8GoGHNomGjMNGenUlgmowB17Sqh3zey54f8gwwm
         BR4NEdvdNkRA2Bt8im+h0tZV4M0sHqG14O8zHW8GXGcY92EGJPUwcoRKNQT+o8GOviIq
         vSQXanqPppwaTlPZXXu5SEGn0NtNXBd8lw6KA9PnfTiDeQbt/jgLtEfkoQJjF8NWBhUi
         qhW6ZBmXY3R4d2N2H+odyUXA49/16Rp7mZZVYqyMLKBYZaORunQcif9aVgEHiihUbOYV
         co150RBv41MIHzSY/ynkVRopA+Dxyr5mWI/fMf+GbykRcpD+ZWO2oE5EIWQKAq927rNS
         fWiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PzVeAyFZDO+woAn09FRMNrkoa0zSne0dLCKhCXRtKF4=;
        b=SPxA03KODFolMokkPTcY6VNCJP8guVcfj/6Zajc1c24HLgscyDJb5nN0l/60rECrOZ
         pCA/P7G0T6R7hkdwoUYSqtrdzUamqMJxblln52gtHrDtObipjmBzp6OmZ4X/tlgmHJhu
         VLVH5+Gft5G1NpdkGhmK7iXdWeZeCpYW3IEZx2++dLqRax0V32Ss2qqALeeMb9jiDvWm
         21f2mz+dgEuOITfm/vaVupUWs4JQVilpylJYqss2caGZbTAVdWOBd6cJo219Wb0xbSBZ
         TzT28dEaWrnvSTvBYHxWGYKQPegHZcpRflSrlVKW0Q1cq7Q5XKgO8tCq/izMxL+MxmjK
         1MDg==
X-Gm-Message-State: APjAAAUL/iWhlGdpEsvnrDW3BGHsXm3Q7eSs3FwwSXesKYYxm6Oloab1
        09N5hL5EGBaQUJ5z5RKTMxp5TdSn
X-Google-Smtp-Source: APXvYqxlNclpViNWlqwt0+vIhDKhok/SwQafMKa1noHdmqFLH9wDIUn22rZ/pJ6WKGHUhsnqLaXwGg==
X-Received: by 2002:a05:6830:1e37:: with SMTP id t23mr3936686otr.16.1581397714034;
        Mon, 10 Feb 2020 21:08:34 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id d11sm862015otl.31.2020.02.10.21.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 21:08:33 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/i915: Disable -Wtautological-constant-out-of-range-compare
Date:   Mon, 10 Feb 2020 22:08:08 -0700
Message-Id: <20200211050808.29463-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
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
 drivers/gpu/drm/i915/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/Makefile b/drivers/gpu/drm/i915/Makefile
index 38df01c23176..55dbcca179c7 100644
--- a/drivers/gpu/drm/i915/Makefile
+++ b/drivers/gpu/drm/i915/Makefile
@@ -21,6 +21,7 @@ subdir-ccflags-y += $(call cc-disable-warning, unused-but-set-variable)
 subdir-ccflags-y += $(call cc-disable-warning, sign-compare)
 subdir-ccflags-y += $(call cc-disable-warning, sometimes-uninitialized)
 subdir-ccflags-y += $(call cc-disable-warning, initializer-overrides)
+subdir-ccflags-y += $(call cc-disable-warning, tautological-constant-out-of-range-compare)
 subdir-ccflags-$(CONFIG_DRM_I915_WERROR) += -Werror
 
 # Fine grained warnings disable
-- 
2.25.0

