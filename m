Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602C3C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38401214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="K5bocECZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387808AbgCDKlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:41:01 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:39354 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgCDKlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:41:00 -0500
Received: by mail-wm1-f53.google.com with SMTP id j1so1324579wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 02:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1JlFcWjm9Vm8w4kQfDp+PBY42FFj0ptnXlZTlbhd8U0=;
        b=K5bocECZ2MoMvdHotvU2FkMzlFRYvnrBwECmMz9wDY0nD1EEclrdprSb786JDFuH3T
         PHbNvBHm2cSf80mp+GyBiuDp+s65ctAK4z7YYLe5VC2WofzM7Bm5AKGQyL7KhLUKwSnD
         R8+eIZ+1Cmau90gQI6k4aoHpxddowX8DWoTrCQ7hDP5AM0cMPoDM8NGpxQ0dJxkc7U84
         hdh6XDpqooNhSf1rcFkWoG6qgTtS8Jzi+/3uTHI8+fz5xVEejSEL9qjl8kDqJFnFocuD
         m/MQt3AEU+o16otTyEzsu3oIUu1DDRBUCEYiLLvhepRbs+Ku+apCI3NLY7t9v2V6pnBb
         g+TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1JlFcWjm9Vm8w4kQfDp+PBY42FFj0ptnXlZTlbhd8U0=;
        b=KNHBgn+5/MN/LVTtYHatG93n9R18TVCD09Vi/0TvXbZrnGvhzkyqXYWbPP515kS6o9
         hpreiQWiYVFrV+/gsKIQJ5n3tq/1nl9IoJbbEE3EFEvM9e7VmatHLpkKMKP9KKvHLD2C
         YKoSOd+V/4COZpCTVRGa/dTsXD22D6bEt5eokQECjgqxefcILGwjd1v3GGZQivF94R4k
         4TrZccnvaRRxhrTui+79deiqJfNwDV4aAX0o033zLYWn3lNAS7ZsRdZKUIi+9LK00Na4
         IQu7dqS6mttjrmFwotxmNjELmdFPnTpoa0lyXphxqOIE4GckSVN/FDQpc7E6p97h0P3m
         od+g==
X-Gm-Message-State: ANhLgQ2FuoHeJzFa+Bex+JGOw1HAJcDzHUqQJCUDe8JaicTMQugXOqxb
        oVW8lPHeguJelyEUfhVBlZyLKw==
X-Google-Smtp-Source: ADFU+vsyB6OlySe3niT1au0qv1Y8sKilTlKJUImHjCFR50hCR/0l9PUEKsvn/ohlmYaTi1umVyOHOQ==
X-Received: by 2002:a1c:4d3:: with SMTP id 202mr3111868wme.172.1583318458189;
        Wed, 04 Mar 2020 02:40:58 -0800 (PST)
Received: from bender.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c14sm24006398wro.36.2020.03.04.02.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 02:40:57 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     p.zabel@pengutronix.de, heiko@sntech.de, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/11] drm/bridge: dw-hdmi: implement bus-format negotiation and YUV420 support
Date:   Wed,  4 Mar 2020 11:40:41 +0100
Message-Id: <20200304104052.17196-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philippe, Heiko, Maxime, Laurent,

A bad negociation was detected on platforms not implementing a bridge on the
encoder side, which has been fixed in this version.

Could you check it doesn't break your platforms using dw-hdmi ? Especially
patches 1-5.

Thanks,
Neil

This patchset is based on Boris's merged "drm: Add support for bus-format negotiation"
patchset to implement full bus-format negotiation for DW-HDMI, including YUV420 support and
10/12/16bit YUV444, YUV422 and RGB. The Color Space Converter support is already implemented.

And the counterpart implementation in the Amlogic Meson VPU dw-hdmi glue :
- basic bus-format negotiation to select YUV444 bus-format as DW-HDMI input
- YUV420 support when HDMI2.0 YUV420 modeset

This is a follow-up from the previous attempts :
- "drm/meson: Add support for HDMI2.0 YUV420 4k60" at [2]
- "drm/meson: Add support for HDMI2.0 4k60" at [3]

Changes since v4 at [7]:
- Cleaned up patch 1
- Added comment on patch 2
- Added commit message on patch 3
- Fixed invalid negociation when encoder is not yet a bridge (seen on allwinner & rockchip platforms) on patch 4
- Fixed invalid defines, handled MEDIA_BUS_FMT_FIXED and cleaned negociation debug on patch 4
- Added tags on patch 5, 6
- Removed meson_venc_hdmi_encoder_get_out_bus_fmts on patch 7
- Add off-list r-b from Jernej

Changes since v3 at [6]:
- Added "Plug atomic state hooks to the default implementation" on drm/bridge: dw-hdmi
- Also added these atomic state hooks in meson-dw-hdmi in patch 7
- Rebased on latest drm-misc-next including patches 1-7 of [1]

Changes since RFC v2 at [5]:
- Added fixes from Jonas, who tested and integrated it for Rockchip SoCs
- Added support for 10/12/16bit tmds clock calculation
- Added support for max_bcp connector property
- Adapted to Boris's v4 patchset
- Fixed typos reported by boris

Changes since RFC v1 at [4]:
- Rewrote negociation using the v2 patchset, including full DW-HDMI fmt negociation

[2] https://patchwork.freedesktop.org/patch/msgid/20190520133753.23871-1-narmstrong@baylibre.com
[3] https://patchwork.freedesktop.org/patch/msgid/1549022873-40549-1-git-send-email-narmstrong@baylibre.com
[4] https://patchwork.freedesktop.org/patch/msgid/20190820084109.24616-1-narmstrong@baylibre.com
[5] https://patchwork.freedesktop.org/patch/msgid/20190827081425.15011-1-narmstrong@baylibre.com
[6] https://patchwork.freedesktop.org/patch/msgid/20191218154637.17509-1-narmstrong@baylibre.com
[7] https://patchwork.freedesktop.org/patch/msgid/20200206191834.6125-1-narmstrong@baylibre.com

Jonas Karlman (2):
  drm/bridge: dw-hdmi: set mtmdsclock for deep color
  drm/bridge: dw-hdmi: add max bpc connector property

Neil Armstrong (9):
  drm/bridge: dw-hdmi: Plug atomic state hooks to the default
    implementation
  drm/bridge: synopsys: dw-hdmi: add bus format negociation
  drm/bridge: synopsys: dw-hdmi: allow ycbcr420 modes for >= 0x200a
  drm/meson: venc: make drm_display_mode const
  drm/meson: meson_dw_hdmi: add bridge and switch to drm_bridge_funcs
  drm/meson: dw-hdmi: stop enforcing input_bus_format
  drm/meson: venc: add support for YUV420 setup
  drm/meson: vclk: add support for YUV420 setup
  drm/meson: Add YUV420 output support

 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 319 +++++++++++++++++++++-
 drivers/gpu/drm/meson/meson_dw_hdmi.c     | 180 +++++++++---
 drivers/gpu/drm/meson/meson_vclk.c        |  93 +++++--
 drivers/gpu/drm/meson/meson_vclk.h        |   7 +-
 drivers/gpu/drm/meson/meson_venc.c        |  10 +-
 drivers/gpu/drm/meson/meson_venc.h        |   4 +-
 drivers/gpu/drm/meson/meson_venc_cvbs.c   |   6 +-
 include/drm/bridge/dw_hdmi.h              |   1 +
 8 files changed, 544 insertions(+), 76 deletions(-)

-- 
2.22.0

