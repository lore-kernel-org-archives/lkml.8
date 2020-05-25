Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC95AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7FC62078B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOeyv6u9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390905AbgEYOaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgEYOaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:30:04 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD54EC061A0E;
        Mon, 25 May 2020 07:30:03 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id x1so20648999ejd.8;
        Mon, 25 May 2020 07:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yMh1OLCPJYxMT3dRwDh/Pc1pXHaCVXG/hZf91AhdVB4=;
        b=BOeyv6u90esY242TIOVf8kZuHxZc7IiQ4MFI+Zqvwnzes9+xpAj9hLrHuSa2uyOBDF
         Or68NuUhIgoEg6nrhjh+IEbnG9Whd1p5tJqEWeNdAT0ST3Osy+qsjbWYmUd9upYS+BdI
         2qgI30mwbvOogfXDlMdztExw+nMndzWJd43DYd3kfgXSNP3MnD7GjZ0Xy8FkjRu7QqWk
         VUSXBMCyKF/d2KTbv5eA+/8WowJnlaEfolsh1wtKblHmFhkOjXyGM9Yf7P7h8hbeuACF
         hyKMECLKRaGsrNpU3R2oAklEG3KJhKdUdgKPm1XyKHn81exBNgBWveq1bY0yPJAdBZfJ
         PuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yMh1OLCPJYxMT3dRwDh/Pc1pXHaCVXG/hZf91AhdVB4=;
        b=qxD1Xddd72zLq/ZkJcZ5XRGNGtDfMHflZ96jbipnEr027zHorfkcHjLReZIfGgGdU3
         BmaMwxmVGb0DwiiXeo6sJ6QQAVQyTD8fRwSX1QI/bPhWfaba93GjwN390Cxypsme5bB2
         HqZ+4bJYOzby6snhmfAoqF1+DpeFgjdV3ZnbMc2+Fmh9R26ZaUDevUTNEj4ZtKYoa7M6
         EtOldMPY8wsrwCva114JlxcNR2pkcO1VCkcfH03Hh2cQzxQp2rOpZWUoF0MMkpbRHXa/
         ELNtweGZ9UM9YkSnc2bCgoO3Vm1JThr/ysi+Snogw8mTl40wUSs6kkGxzTAj2ftb47u3
         SU1w==
X-Gm-Message-State: AOAM530CffYyOzHyEYcjAtKg0QQZ9YuY/j898e55VCf9d86mAqGub+R5
        kjMXkyAk5Z3H6Eg/BgG6nZk=
X-Google-Smtp-Source: ABdhPJwpDfwq3VxDQ5PqHUh5/tPRWT5lYSDfIlEbnN3rH0SxoiirUlcrfg9jhMOb+eHRznUbsJQX/A==
X-Received: by 2002:a17:906:c7cc:: with SMTP id dc12mr19635108ejb.263.1590417002325;
        Mon, 25 May 2020 07:30:02 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dfa:6900:4b6:3b49:50f6:6c03])
        by smtp.gmail.com with ESMTPSA id f10sm16642978edt.69.2020.05.25.07.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 07:30:01 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH SECOND RESEND] MAINTAINERS: adjust entries to moving CEC platform drivers
Date:   Mon, 25 May 2020 16:29:46 +0200
Message-Id: <20200525142946.8268-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 4be5e8648b0c ("media: move CEC platform drivers to a separate
directory") moved various files into a new directory structure, but did
not adjust the entries in MAINTAINERS.

Since then, ./scripts/get_maintainer.pl --self-test=patterns complains:

  warning: no file matches F: drivers/media/platform/s5p-cec/
  warning: no file matches F: drivers/media/platform/tegra-cec/
  warning: no file matches F: drivers/media/platform/cec-gpio/
  warning: no file matches F: drivers/media/platform/meson/ao-cec-g12a.c
  warning: no file matches F: drivers/media/platform/meson/ao-cec.c
  warning: no file matches F: drivers/media/platform/seco-cec/seco-cec.c
  warning: no file matches F: drivers/media/platform/seco-cec/seco-cec.h
  warning: no file matches F: drivers/media/platform/sti/cec/

Update the MAINTAINERS entries to the new file locations.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Mauro, please pick this non-urgent minor clean-up patch on top of the
CEC platform driver moves.
 
applies cleanly on next-20200417, next-20200505 and still on next-20200525
for this second resend.

v1 send here:
https://lore.kernel.org/lkml/20200418093630.6149-1-lukas.bulwahn@gmail.com/

v1 first resend here:
https://lore.kernel.org/lkml/20200506050744.4779-1-lukas.bulwahn@gmail.com/

 MAINTAINERS | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7a442b48f24b..bf5cb149101b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2403,7 +2403,7 @@ L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/s5p-cec.txt
-F:	drivers/media/platform/s5p-cec/
+F:	drivers/media/cec/platform/s5p/
 
 ARM/SAMSUNG S5P SERIES JPEG CODEC SUPPORT
 M:	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
@@ -2548,7 +2548,7 @@ L:	linux-tegra@vger.kernel.org
 L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/tegra-cec.txt
-F:	drivers/media/platform/tegra-cec/
+F:	drivers/media/cec/platform/tegra/
 
 ARM/TETON BGA MACHINE SUPPORT
 M:	"Mark F. Brown" <mark.brown314@gmail.com>
@@ -3969,7 +3969,7 @@ S:	Supported
 W:	http://linuxtv.org
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/cec-gpio.txt
-F:	drivers/media/platform/cec-gpio/
+F:	drivers/media/cec/platform/cec-gpio/
 
 CELL BROADBAND ENGINE ARCHITECTURE
 M:	Arnd Bergmann <arnd@arndb.de>
@@ -11146,8 +11146,7 @@ S:	Supported
 W:	http://linux-meson.com/
 T:	git git://linuxtv.org/media_tree.git
 F:	Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml
-F:	drivers/media/platform/meson/ao-cec-g12a.c
-F:	drivers/media/platform/meson/ao-cec.c
+F:	drivers/media/cec/platform/meson/
 
 MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
 M:	Liang Yang <liang.yang@amlogic.com>
@@ -15212,8 +15211,7 @@ F:	drivers/mmc/host/sdricoh_cs.c
 SECO BOARDS CEC DRIVER
 M:	Ettore Chimenti <ek5.chimenti@gmail.com>
 S:	Maintained
-F:	drivers/media/platform/seco-cec/seco-cec.c
-F:	drivers/media/platform/seco-cec/seco-cec.h
+F:	drivers/media/cec/platform/seco/
 
 SECURE COMPUTING
 M:	Kees Cook <keescook@chromium.org>
@@ -16249,7 +16247,7 @@ STI CEC DRIVER
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/stih-cec.txt
-F:	drivers/media/platform/sti/cec/
+F:	drivers/media/cec/platform/sti/
 
 STK1160 USB VIDEO CAPTURE DRIVER
 M:	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
-- 
2.17.1

