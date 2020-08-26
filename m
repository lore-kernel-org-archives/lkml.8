Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13099C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1A3B20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 17:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4Vi6MHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgHZRBk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgHZRA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 13:00:58 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45699C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:00:57 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id f12so2394786ils.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F84GgHzsN1yeQN6PQRJoTTLm9lE05lKnfqitPnJqWLU=;
        b=e4Vi6MHy6UTLsDMSjkNofHtVcQzUuSjP1UEi4Zl4t/K7FK4wYLGiwebK/NStDprP7I
         odFjBwSqQCKsEVlcnX+yDkG/CENe6HUJJbKAsN/W791aS2qH2UWYswF/4ewLctaolHpV
         CBm8TzzLoKGLF8vkT58wSBPAmXdL2F7T/66f8TVM9Gf3FamqClb7nmLl1NgqcEsVUmHo
         dgabwZx0bB+Gx/t4j2JaxG/c/kX2yzPUPR68YgPP5jd8wvn7WTQR0BV2WhYxSEog3f9l
         QghttGRVagCMEoeemQdkmK0WpfU9s6H6i6hxGmw16LnQM+gcSjIo4/FUoxg6Nb/fe5Ep
         DnAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F84GgHzsN1yeQN6PQRJoTTLm9lE05lKnfqitPnJqWLU=;
        b=HvZuPULAD20RSeRgc0tGu4M0WkjL4ZEoANlS3Z5cy8wpZQt/JmFBYAGjDAhiccmLGo
         PPYwooE3B3+F7vFfTUXBWClPo/NmiMY/q91hMjWU54C3jYDXiT2urvN495A/fowW7rxF
         kAOHERupJOsWCanmB8OU7Bvnn/mGOU+rJPKZMfjSUgpaa0xCEXaAIMrspMTvRytEpA9I
         2kY3cLpGT9nnotfDk3dLBraygaRwDxnsjUKb3ChdZnSXc08hKkZ4xW1XhK1c6zHusL1k
         Xw8w8Cuk7A0vKfvnh/2CzxSNJDSLauY2+wg3wKnKJO/nP0LxtoBNpcxN9QXo7dIxQNBQ
         qLcw==
X-Gm-Message-State: AOAM531m5qPcx4wuNaL1+6WAGQ58IJcMOR21fQtvas5/a8VqPVk2jvpa
        GXjbzNkY6KMqG21+YmG6THnkDZcLr8g6+GTJ
X-Google-Smtp-Source: ABdhPJym6BLUjQHAO+G1iUIi+hQhRvVbz7JUbJGnpDxNbIAXPZhbdIj6klLQKPC0ZPXyAe01GYF/mw==
X-Received: by 2002:a92:bb8d:: with SMTP id x13mr13758338ilk.243.1598461256033;
        Wed, 26 Aug 2020 10:00:56 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8203:5970::c4c])
        by smtp.googlemail.com with ESMTPSA id p78sm1479606iod.0.2020.08.26.10.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 10:00:55 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jbaron@akamai.com
Cc:     Jim Cromie <jim.cromie@gmail.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] i915: add -DDYNAMIC_DEBUG_MODULE to i915/gvt/Makefile
Date:   Wed, 26 Aug 2020 11:00:40 -0600
Message-Id: <20200826170041.2497546-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200826170041.2497546-1-jim.cromie@gmail.com>
References: <20200826170041.2497546-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This addition to cflags enables dyndbg in the gvt component of the
i915 module, on a CONFIG_DYNAMIC_DEBUG_CORE build.

So here are the message classifications that the gvt driver uses.

   cut -d= -f2 | cut -d\  -f2,3 | \
   perl -ne 'chomp $_ && $h{$_}++; END{print "$_\" \tseen $h{$_}\n" for sort keys %h}'

"gvt: cmd:" 	seen 11
"gvt: core:" 	seen 48
"gvt: dpy:" 	seen 4
"gvt: el:" 	seen 21
"gvt: irq:" 	seen 1
"gvt: mm:" 	seen 6
"gvt: mmio:" 	seen 9
"gvt: render:" 	seen 1
"gvt: sched:" 	seen 15

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/i915/gvt/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
index ea8324abc784..2c581e910688 100644
--- a/drivers/gpu/drm/i915/gvt/Makefile
+++ b/drivers/gpu/drm/i915/gvt/Makefile
@@ -5,5 +5,6 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
 	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
 	fb_decoder.o dmabuf.o page_track.o
 
-ccflags-y				+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
-i915-y					+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
+ccflags-y	+= -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
+ccflags-y	+= -DDYNAMIC_DEBUG_MODULE
+i915-y		+= $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
-- 
2.26.2

