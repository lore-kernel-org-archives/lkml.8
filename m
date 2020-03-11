Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D205DC18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69A421D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="b4DElPDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgCKMvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:51:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40628 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729232AbgCKMvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:51:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id e26so1972025wme.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 05:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=6mmjs1zoy21HGdXRuhBisBs86sD1UMcUpSzszzdWpvA=;
        b=b4DElPDmtlbb1xvN5jVD3o8QZeGR+7PKcSdOSRtSbXEFwkPrylJcMqnZvKNSJRh14V
         6aqZwiXB5y2Av1kqYMGRFyyVSV3hRn51Jy2RF+Aq6a2j0g1Mf/fUv7KjHILYBHyInEdv
         c5nB8+tBPOpMZgR4su7kn0zyVCJ/DZr2rT7LmbjigMSE74S+SNtoV6NIRDD1zpCuGcMV
         TIP2Ui1s9OocJKnffxQPNBM+2cwn0nrQMe0Q11kYSdT43tjYvZJOEoOo+Fv0mlbQL4d3
         aRgfdZLWl/+ZZvGmp+v4pwZpEdLZsof/+5jRrn7XJP6H0cnzRseS16efUHf3bVll7sxL
         APOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6mmjs1zoy21HGdXRuhBisBs86sD1UMcUpSzszzdWpvA=;
        b=fzvFAQ31BetQSO0iaXzH1Xbiedi5M9mz8NbFakz99MNSa6Fh8cOcDFGXbheU7kH5JP
         1UNmmflFCNwNgHiFGExYoN8AHZOM+vYqLSuGiwXPaArFOoX5nDQ9AuyPLEeg0vgBW4oA
         NF7VowGPdikrgV2ZLTzkUxFH30RmzzMMXDs6EUr6f+Ukch8SrKBA3utlzIdzebb+6J9x
         8TqjpxnaLIHzJ/oAEYWAx5KToSTXgGNZGknFLGyo9GnX9U9hpGn+4teVvw2sdkBhORvq
         rcNGxzf0mVESsyJJtMaEshjYuoW+mYM/pleEi69ot1MnadWgKbBNX+FY6o/HJZddVhhm
         YvoQ==
X-Gm-Message-State: ANhLgQ0Lzh8KWxL0gFHX9LsT/FtSZL7TpNszk6wcdsffwXFX/AB2Bhc6
        JElgqoGgmYtz2a6IxS1eRR2TEw==
X-Google-Smtp-Source: ADFU+vvH+0ONZuHFXRlr54VYaPW++G9wGrbF1sWPr8MKp+jdH72w07T55RveDBX31y81xSMCnFPsBA==
X-Received: by 2002:a7b:c0c7:: with SMTP id s7mr3536712wmh.187.1583931102518;
        Wed, 11 Mar 2020 05:51:42 -0700 (PDT)
Received: from robin.baylibre.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id o3sm8843538wme.36.2020.03.11.05.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 05:51:41 -0700 (PDT)
From:   Phong LE <ple@baylibre.com>
To:     narmstrong@baylibre.com, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, mark.rutland@arm.com, a.hajda@samsung.com
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@siol.net, sam@ravnborg.org, mripard@kernel.org,
        heiko.stuebner@theobroma-systems.com, linus.walleij@linaro.org,
        stephan@gerhold.net, icenowy@aosc.io, broonie@kernel.org,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        andriy.shevchenko@linux.intel.com, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Add it66121 driver
Date:   Wed, 11 Mar 2020 13:51:31 +0100
Message-Id: <20200311125135.30832-1-ple@baylibre.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IT66121 is a high-performance and low-power single channel HDMI
transmitter, fully compliant with HDMI 1.3a, HDCP 1.2 and backward
compatible to DVI 1.0 specifications.
It supports pixel rates from 25MHz to 165MHz.

This series contains document bindings, add vendor prefix, Kconfig to
enable or not.
For now, the driver handles only RGB without color conversion.
Audio, CEC and HDCP are not implemented yet.

Phong LE (4):
  dt-bindings: add ITE vendor
  dt-bindings: display: bridge: add it66121 bindings
  drm: bridge: add it66121 driver
  MAINTAINERS: add it66121 HDMI bridge driver entry

 .../bindings/display/bridge/ite,it66121.yaml  |  98 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/gpu/drm/bridge/Kconfig                |   8 +
 drivers/gpu/drm/bridge/Makefile               |   1 +
 drivers/gpu/drm/bridge/ite-it66121.c          | 997 ++++++++++++++++++
 6 files changed, 1114 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/ite,it66121.yaml
 create mode 100644 drivers/gpu/drm/bridge/ite-it66121.c

-- 
2.17.1

