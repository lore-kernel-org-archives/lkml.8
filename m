Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAD9C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8658820776
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 17:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jX7MFaOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgFNRXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 13:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgFNRXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 13:23:24 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3A7C03E96F;
        Sun, 14 Jun 2020 10:23:23 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n24so16355895lji.10;
        Sun, 14 Jun 2020 10:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/buGMp+Ss9uiUTlhYkjRB/SevbvsV7Suq67TOhl6lM=;
        b=jX7MFaOw3cExCgSaekXMQiFMv/ykxYaiV4t1aMfdM6ABkfwSen/ZrGgy+12hgi+r7Q
         q+72FwMZe4K1nHuX9cdGrxxAOywfo8z7x4qIC1IpLu8fm4i/7d98M309qR5nj2AD+5FY
         OJNX+EyWKohGRt8WNLBY+ePLkjZD6EGLjYoMwqm24LfowY2b8D5cJIpl7ubwIlhBuL5H
         unENs4NsWiU+Sz7EO0Kn+F6lk94UD7aK7VHGbD8SPepdrJGm16z2biCZYTFZNLASoiAc
         iP4BWAQujyinZ7D6PEBtv6fUC2PuWmSFqcLCTD6vP2aUXv4CUIw2fy+mDQgW5HWzbLHK
         yP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/buGMp+Ss9uiUTlhYkjRB/SevbvsV7Suq67TOhl6lM=;
        b=K5gcb8KM+ywgVjkULnXwfObO1xhCdYw575Sjhva77gh1qWNsjmrsbS84NZhD2cvt8J
         ENk1VcOKno3r4hRHtMFFwSxcdpfYNb08Nz5JHxbd/xWIeBioNWO08kQM+GUMSKcoyukg
         /5W84LnDCpsfgeopstmzXPCEV62U04D93CslxewcH+Cl1OCdd04Ebj6Qd53G3sM6WVnw
         UiLGxw+iTwzNL6o2w+mNnnSRD29sIeZpHNeGbffBywjl8bsxtNbT/s/58nEunWqtAYMT
         wHfSFEbF1rIupwH/mvHofdjzq4q2LOz3TeDV8Daa031G17/OoeEPbU2dueMTKHNkl9G1
         A44w==
X-Gm-Message-State: AOAM532Fn+RJ4bcEWQBqba/mqfKWElM+Gg/YXqMQltPW69Zben209xRs
        vH8SFl+JeW6n/33ZShWRwjc=
X-Google-Smtp-Source: ABdhPJwSMAH7jtbReoRcuYHV06Fh8WgMrqBhXiLq3LLTXowtYAwZwDpcHXi+//vFWQlT9aXjggdY3Q==
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr11925153ljl.16.1592155401538;
        Sun, 14 Jun 2020 10:23:21 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id m14sm55144lfp.18.2020.06.14.10.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 10:23:21 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 3/6] drm/tegra: output: Don't leak OF node on error
Date:   Sun, 14 Jun 2020 20:22:31 +0300
Message-Id: <20200614172234.8856-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200614172234.8856-1-digetx@gmail.com>
References: <20200614172234.8856-1-digetx@gmail.com>
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

