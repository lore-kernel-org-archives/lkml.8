Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B92C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67D1D21927
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 19:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="jIEgyffu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgBFTSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 14:18:46 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36290 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgBFTSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 14:18:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so8601112wru.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 11:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0g5Mh0a78aE+slLRezbmkDONRPTkqMWKBMePAh+3KlQ=;
        b=jIEgyffuVibQCcxof6bK7UZux67UyEapZihOaFD5RcCLtYAM415gbl+b2IgTkEJEvq
         /CHcnb8leeCz/qGnFD7VawZJ35dzdM15lB3ifg2Tq/NqTXsgfyX2fsj9t5C494aNJhYE
         pe6Hs0gknoOBaQWpSi95SPt8YSRGCteP5kQFil5/rm3CVo1DpH/nziVTbk33LzlpZIt9
         td0yuhnM20waWn/D+BS0sFJMnMPglTEcmh25grwiBCULI8TECk/l0vnsN1E/JOuOF+TO
         8yXFgbNApsOqeamcvi+UI4Y279iHxaQPPiPYKPEYoQVnuv7nT0esLBfMGnmCrYSoaisB
         DjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0g5Mh0a78aE+slLRezbmkDONRPTkqMWKBMePAh+3KlQ=;
        b=IANJrAwFxtpgzhoquWZCIcKhQx792r4ON2U/T9W2CW039Q+UPVCzxvbLFx8tzCsIrq
         /UK9I22mMhF9NqYH3W/ACgwj1nDSeloZ6DTxh/bkjJiHvrGXzxc1flB+7ry1Q4klhINx
         6F1c94yO6qgE49yvGbZCbQDky4/j49lbiN7cWbSUgjAVSYMOQ4EuyweKqIW3F+EmL+6w
         OSH+ZBYoKIPa8aUhthOX65JYmKGqH8vnRo3LXvm62STVaOWyCWMpjX2escWJsILbXlb1
         7rRCaq1fLF0wnKGkZOawm5Q1eTId6X1+JasCao2WDtMynAFdtv8amLNyoXdnNtfT6xZi
         lYMw==
X-Gm-Message-State: APjAAAV0CewmvNCT9DDRtFIRsIgl5sViSPGMNjhaQhkTX/luEzB83kyN
        EUa4s+fAtN2fQkQA8w4nS22KwQ==
X-Google-Smtp-Source: APXvYqy1Eu383ojtVuMTe4GlaMccR2VzKV14GruGHGYGabKmoxhKDRG84mifGs+gI/xchtHoZecR9A==
X-Received: by 2002:adf:9b87:: with SMTP id d7mr5552131wrc.64.1581016721267;
        Thu, 06 Feb 2020 11:18:41 -0800 (PST)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:7d33:17f7:8097:ecc7])
        by smtp.gmail.com with ESMTPSA id m3sm272662wrs.53.2020.02.06.11.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 11:18:40 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net,
        boris.brezillon@collabora.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/11] drm/bridge: dw-hdmi: Plug atomic state hooks to the default implementation
Date:   Thu,  6 Feb 2020 20:18:26 +0100
Message-Id: <20200206191834.6125-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200206191834.6125-1-narmstrong@baylibre.com>
References: <20200206191834.6125-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 051001f77dd4..fec4a4bcd1fe 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2494,6 +2494,9 @@ static void dw_hdmi_bridge_enable(struct drm_bridge *bridge)
 }
 
 static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
 	.attach = dw_hdmi_bridge_attach,
 	.detach = dw_hdmi_bridge_detach,
 	.enable = dw_hdmi_bridge_enable,
-- 
2.22.0

