Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48736C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DA10208B3
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ajKzcojM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbgIDL3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730095AbgIDL2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:28:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF91BC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 04:28:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so6392556wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 04:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6cY1z3DbL2LugEWNVnuvjy5yqeAv9ZfGr4EBGIpkmqo=;
        b=ajKzcojM8mferUuFdzTt0fLsJDLON130FJP/bd4VnW2Ok2hQRuWkB4XdZMxlsiD/V2
         fyvxhgSeQVs9HzYW2rZdYzHlSNcIZA2mVl7h86bxzrZ9UkSE38UfnLeKpiOnZrUUODmv
         sTCM4zc/BrYuEblkYoXmUaTHevCW0VO2ltyOVCQ3N6JBJeqaI14KqdTQN/a26umPaJkp
         bGtmJ04mh5bzfmQjM1wu3zhrUSO0avSQ9mgswJH3+F9pgcFyuJN4yi5Gaopco2QyIyY+
         i1jSLenBjXJwlP2M44osCzccdBa7PO0PMzcyCZ+LiFtj7U6o8c7YaO5ORq/rWjgKZbqR
         rwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6cY1z3DbL2LugEWNVnuvjy5yqeAv9ZfGr4EBGIpkmqo=;
        b=oLGmjRaWgCeSXXNh9EpXYjZWQUJ385K0hKajTHIlz9AtUTjZf+AI2AtbK5fXi+qNLc
         8ZPj8mvJV55mk6JZoPfsetVuzy4Grss5OldkgI4eXVjiFyLaDj9cXxSkX62pvg2kgrLl
         R81HgeOhCB0s4u4LeMqeHWS4V0WosYNOjdxuyPfUXpwhQRVc5Gl9f5ydv5YcpjhbH/hH
         4Y2xjud5yyk7vDi/sfM6GlirlOJ6xHzvyfmpfzkRfhY7ibibf/ypFyHL0h8bpyGF/bik
         nR3gbjGijohHrAYL6KKHD+tiUmPxhZlyPgDopaHfOJTbOqcxU9mMb9ZingtrK7wBPuPX
         lj1Q==
X-Gm-Message-State: AOAM5335bEWL73lGC0SoouNVHH5Cc78oP/xUHX4mXwTsrbEmjB0reiS5
        wQwgBJ0EYSCElXXa+o7VHlPnTQ==
X-Google-Smtp-Source: ABdhPJxgvriBnJSF1av8/To9z7heHY3u/v/teFPCQomEP3bVm/HZbh+jGTincEsdQ2OHKEsxEt9axQ==
X-Received: by 2002:adf:ce85:: with SMTP id r5mr7394974wrn.205.1599218888480;
        Fri, 04 Sep 2020 04:28:08 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id c18sm12226868wrx.63.2020.09.04.04.28.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2020 04:28:07 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] MAINTAINERS: media: cec: fix files location
Date:   Fri,  4 Sep 2020 11:27:54 +0000
Message-Id: <1599218874-800-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Files have moved, fixes their path.

Fixes: 4be5e8648b0c ("media: move CEC platform drivers to a separate directory")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 MAINTAINERS | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1123f26e2891..3b2202b8dec5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2453,7 +2453,7 @@ L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/s5p-cec.txt
-F:	drivers/media/platform/s5p-cec/
+F:	drivers/media/cec/platform/s5p/
 
 ARM/SAMSUNG S5P SERIES JPEG CODEC SUPPORT
 M:	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
@@ -2598,7 +2598,7 @@ L:	linux-tegra@vger.kernel.org
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/tegra-cec.txt
-F:	drivers/media/platform/tegra-cec/
+F:	drivers/media/cec/platform/tegra/
 
 ARM/TETON BGA MACHINE SUPPORT
 M:	"Mark F. Brown" <mark.brown314@gmail.com>
@@ -4042,7 +4042,7 @@ S:	Supported
 W:	http://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/cec-gpio.txt
-F:	drivers/media/platform/cec-gpio/
+F:	drivers/media/cec/platform/cec-gpio/
 
 CELL BROADBAND ENGINE ARCHITECTURE
 M:	Arnd Bergmann <arnd@arndb.de>
@@ -11364,8 +11364,8 @@ S:	Supported
 W:	http://linux-meson.com/
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml
-F:	drivers/media/platform/meson/ao-cec-g12a.c
-F:	drivers/media/platform/meson/ao-cec.c
+F:	drivers/media/cec/platform/meson/ao-cec-g12a.c
+F:	drivers/media/cec/platform/meson/ao-cec.c
 
 MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
 M:	Liang Yang <liang.yang@amlogic.com>
@@ -15574,8 +15574,8 @@ F:	drivers/mmc/host/sdricoh_cs.c
 SECO BOARDS CEC DRIVER
 M:	Ettore Chimenti <ek5.chimenti@gmail.com>
 S:	Maintained
-F:	drivers/media/platform/seco-cec/seco-cec.c
-F:	drivers/media/platform/seco-cec/seco-cec.h
+F:	drivers/media/cec/platform/seco/seco-cec.c
+F:	drivers/media/cec/platform/seco/seco-cec.h
 
 SECURE COMPUTING
 M:	Kees Cook <keescook@chromium.org>
@@ -16608,7 +16608,7 @@ STI CEC DRIVER
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/stih-cec.txt
-F:	drivers/media/platform/sti/cec/
+F:	drivers/media/cec/platform/sti/
 
 STK1160 USB VIDEO CAPTURE DRIVER
 M:	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
-- 
2.26.2

