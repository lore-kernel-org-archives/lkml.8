Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D2F7C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA2A20CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/CVSkO2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgFQW2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgFQW17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:27:59 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D817C06174E;
        Wed, 17 Jun 2020 15:27:59 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id i27so4808789ljb.12;
        Wed, 17 Jun 2020 15:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/buGMp+Ss9uiUTlhYkjRB/SevbvsV7Suq67TOhl6lM=;
        b=D/CVSkO2CC++b8uBZgrP1E+qFdW4kJcztCNPpHH9x6AGt9kFw3c7ePV/phmO6Ng6ZB
         SOztQqoE/nYP7nhphM/Mt7GHf61uh37odiZzuIGY8uwlBYzqZjlMt5XxrcGjMndKN4rK
         qHPhSrd2y8guyLfFlejAen4aMP75xpwznOcKOZdsEXMK+GtsBkLGCSTKH6Ts+T6xYiKJ
         DFw/cvwh5lsHR7uNk7jt+ZKNjaHwPR6Pp6+mMxeSvFpW2C2IVh8BOX73d7CussyW7Ufk
         krsN2+lCDNs06zdNF5YvW4O53FVoAsjG+PHF/pi33iMXUUh/ys1cHePLnlpjE6vhuEem
         AHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/buGMp+Ss9uiUTlhYkjRB/SevbvsV7Suq67TOhl6lM=;
        b=W07HQDrOyuKeDwFylThKNtsJHU9xQLYG5HrNL/QhxljWhK/YMRxn7OhVp5GsKtA/2A
         KJU3NCdUSrxLuEVgqOnO101wnxedvCL092J8DDf4AEYzp20/Gi3HKoM54PPXre5FJfVQ
         xNG5ddXM5IbUE16s6nZ0/VjGCyOJF3M3WtaEm4wkD0xc4Hut99fPcS+BMLsk2FqAfmT8
         URyFWV/cpJVqZ2KANg5HWNTB1H8UvQOTuxMmaeDwX+3CkENwtG6Sg+NZPzd7ncou8ul0
         DJvpoaJfe2lgg4Gqn+yGlnwt4bkgZ3qhcI5ffoYOLNu/RE/1/8qzuec1zKdnm9SXWMxs
         gGiA==
X-Gm-Message-State: AOAM531NAcTN2e4QzhPMVjT27RlitvooDznGvVxajGNZok81+2E/5+Pn
        ir+vIHdEw8Xm5L6rAdr7T+I=
X-Google-Smtp-Source: ABdhPJz0MyoPM7RAlYae5zeKJonCtS9xXXa02ONOLAjERMK8yve0QEl8ro8GhLlHMxRQ43L058CrCg==
X-Received: by 2002:a2e:8994:: with SMTP id c20mr719571lji.378.1592432877594;
        Wed, 17 Jun 2020 15:27:57 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id a1sm210378ljk.133.2020.06.17.15.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:27:57 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 3/7] drm/tegra: output: Don't leak OF node on error
Date:   Thu, 18 Jun 2020 01:26:59 +0300
Message-Id: <20200617222703.17080-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617222703.17080-1-digetx@gmail.com>
References: <20200617222703.17080-1-digetx@gmail.com>
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
2.26.0

