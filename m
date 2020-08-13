Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5860C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8276620771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4El73tu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgHMWHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMWHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 18:07:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22348C061757;
        Thu, 13 Aug 2020 15:07:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id m22so7862823ljj.5;
        Thu, 13 Aug 2020 15:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UhpftvxhrGW/I5vMTkvaan80pR3Bf4Ukt8/Qr1N367o=;
        b=U4El73tuzw8u2iTw2U3rFgaS36+EbTzTxzil61hPtSoIHRP/nGy/sYT4669apwUZ56
         1fLO1E+40xwQUYiilDfsE+6LFATlD28+Pv5r7petk4yla8wj1M+zx2l4gxnC07Melcb2
         xY2TjnzvlzzHuNT8+t97d/f+tE9aXsW4vuM8jisUNzcp2cfeq4PFosOS7g9OUeSF78hp
         b3trwaz9jl/zDRDaGRfliXTUFTjDhrnkUttmhFc9AOxVP1Utl/wfPrAgZY64xyKorDe1
         EZ1U+ti6KcGW072dmi+99zAiCq9MlJw7FEtE3P2B21pJGsUF26w3JwVu4DbXoO6lJ9U2
         OloA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UhpftvxhrGW/I5vMTkvaan80pR3Bf4Ukt8/Qr1N367o=;
        b=HLLJsdahTyTtspi9cE0WiUXJMR8atETkkCuLxB4va3nXmvcE7qXZmNVwII/SHgnczw
         2TIGdw9OL39IXnHw6LMuzj9hDnlCO/CJg0f/rAHSqkrLlGZH6tCKv96U4ddqy51Ptb5c
         Se5QlR1CmZYs9ZOyLCbR4tU2nWFadwJebbcYDDW+qg9iyeNZZAyQ+d1vV9Dek4HJtqk3
         qtWlc9NoQerACxlBNAO35GRDu4enP+rjHIYn6b3HYjvymSldD732KOXPrDhV30uYmSiB
         jG+d76q/8j5CMISTMuz6Ulnlo21wUXe+8X+1VciL2fQKc9A6nBNTBqzWBv1W0x7uarHj
         Da/Q==
X-Gm-Message-State: AOAM530xI6fN/nSUI00bnUSupFImOiN4lxoMb8RFe3z2GHAKa+aUkdSU
        u2Av5wLc7eZDHV4lTSSqa00=
X-Google-Smtp-Source: ABdhPJxdE8SJN6Fl3O8SlSPSFn7L3H7MJoggtpc0XWT3dFeJWVU0/K7OehXS6p0pQlnWdtOB/5iZUQ==
X-Received: by 2002:a2e:b61c:: with SMTP id r28mr2741025ljn.23.1597356425541;
        Thu, 13 Aug 2020 15:07:05 -0700 (PDT)
Received: from localhost.localdomain (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.gmail.com with ESMTPSA id z20sm1354452ljk.97.2020.08.13.15.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 15:07:04 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v10 1/4] drm/tegra: output: Don't leak OF node on error
Date:   Fri, 14 Aug 2020 01:06:53 +0300
Message-Id: <20200813220656.30838-2-digetx@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200813220656.30838-1-digetx@gmail.com>
References: <20200813220656.30838-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF node should be put before returning error in tegra_output_probe(),
otherwise node's refcount will be leaked.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/tegra/output.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/tegra/output.c b/drivers/gpu/drm/tegra/output.c
index e36e5e7c2f69..a6a711d54e88 100644
--- a/drivers/gpu/drm/tegra/output.c
+++ b/drivers/gpu/drm/tegra/output.c
@@ -102,10 +102,10 @@ int tegra_output_probe(struct tegra_output *output)
 	panel = of_parse_phandle(output->of_node, "nvidia,panel", 0);
 	if (panel) {
 		output->panel = of_drm_find_panel(panel);
+		of_node_put(panel);
+
 		if (IS_ERR(output->panel))
 			return PTR_ERR(output->panel);
-
-		of_node_put(panel);
 	}
 
 	output->edid = of_get_property(output->of_node, "nvidia,edid", &size);
@@ -113,13 +113,12 @@ int tegra_output_probe(struct tegra_output *output)
 	ddc = of_parse_phandle(output->of_node, "nvidia,ddc-i2c-bus", 0);
 	if (ddc) {
 		output->ddc = of_find_i2c_adapter_by_node(ddc);
+		of_node_put(ddc);
+
 		if (!output->ddc) {
 			err = -EPROBE_DEFER;
-			of_node_put(ddc);
 			return err;
 		}
-
-		of_node_put(ddc);
 	}
 
 	output->hpd_gpio = devm_gpiod_get_from_of_node(output->dev,
-- 
2.27.0

