Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757FDC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5BA206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="J67inxLI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgBRJiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:38:13 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40015 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgBRJiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:38:12 -0500
Received: by mail-wm1-f67.google.com with SMTP id t14so2064966wmi.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=diNDoQJLLiILeBSp0QO0Lz48zF47Rfh9Ax7IA6XtwgQ=;
        b=J67inxLIMYJUPkxO7T96ySwzQg3VxXmPuDj5Mr3P4vSQ6vBQzVdg1ltFniAtpgq5EC
         RryNiZ4n7lUwbyLLUQEI1lXWR9yObHs+Unc6iMGzzbEifWA4QVwxPXJ1Bs43i3A8/Qdd
         VKck2+h+hCN8tE4912oW8dF6WdikqXnniVbtI2yZeRQn3uCBqj3bbHvRwPtYEGlZW/p2
         vl11Xu1/snsnWHDWlf3d4M2DVXHsILuD92J5yxHUHc/cJz0N0ztEzB3jEEgs5pA23h1O
         I5zy5+GYZcs2vNX2YwCJHmNwZohq38MjX7RAi9bMy1jl2tfiFdlzTH5M8WaIytfRRESU
         5gVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=diNDoQJLLiILeBSp0QO0Lz48zF47Rfh9Ax7IA6XtwgQ=;
        b=B2Ktz0fOKgk3ko8OAefjYKw6ymE4NKyBFVDMCQtnMrYW87L1H0eNXUfg1MP8tFN8Qy
         lVzYiZXT5C5gfygqreUNEjY+VM/3xeSor0mnxozBBjbq9RVR+Q4GoC9139EDN9LehmZm
         H8GF/oprefvLzzIVjY/HNd+sUBMLqKo0BAFbuCsYt4DGSWNw/+TTQgqiAKUb1HTp3sjX
         Ok32eVkosmKdNy4i99iVz2HgeUfD/vgrFhFkXIc/8LvU5m72VYc/T+0BoScUcHm0sVAo
         sSO/Heyqf1DkVQp/azvPXU1KDow5CEj2+jVrbN2yG1tf7s3yyQ2VVupBWMzO7UA7MTuL
         eedA==
X-Gm-Message-State: APjAAAX3jcc9wIi3Qzt4hQIrqosvJQArIy/l8zQDg7gb0pZK6YPotCZV
        aE0CMT2HO8SAvOkDk68HopAYk2Q/mNU=
X-Google-Smtp-Source: APXvYqzeD7oa4mok6DIG3T4dYqFSsOjTCWha3eJlu4pRVvxeD/u5na/yqU1ULsV45Nqx1fBw0lgYKA==
X-Received: by 2002:a1c:5f41:: with SMTP id t62mr2171022wmb.42.1582018690334;
        Tue, 18 Feb 2020 01:38:10 -0800 (PST)
Received: from nbelin-ThinkPad-T470p.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id f127sm2740626wma.4.2020.02.18.01.38.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2020 01:38:09 -0800 (PST)
From:   Nicolas Belin <nbelin@baylibre.com>
To:     linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, pavel@ucw.cz, dmurphy@ti.com
Cc:     Nicolas Belin <nbelin@baylibre.com>
Subject: [PATCH 0/3] leds: add support for apa102c leds
Date:   Tue, 18 Feb 2020 10:37:34 +0100
Message-Id: <1582018657-5720-1-git-send-email-nbelin@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds the driver and its related documentation 
for the APA102C RGB Leds.

Patch 1 adds the APA102C led manufacturer to the vendor-prefixes list.

Patch 2 Documents the APA102C led driver.

Patch 3 contains the actual driver code and modifications in the Kconfig 
and the Makefile.

Nicolas Belin (3):
  dt-bindings: Document shiji vendor-prefix
  dt-bindings: leds: Shiji Lighting APA102C LED driver
  drivers: leds: add support for apa102c leds

 .../devicetree/bindings/leds/leds-apa102c.yaml     |  91 +++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/leds/Kconfig                               |  11 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-apa102c.c                        | 268 +++++++++++++++++++++
 5 files changed, 373 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-apa102c.yaml
 create mode 100644 drivers/leds/leds-apa102c.c

-- 
2.7.4

