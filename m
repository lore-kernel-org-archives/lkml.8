Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A9FC38A29
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C789E21D6C
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 17:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q6O2vRM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgDRRHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 13:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgDRRHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 13:07:22 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55883C061A0C;
        Sat, 18 Apr 2020 10:07:22 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j14so4389193lfg.9;
        Sat, 18 Apr 2020 10:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pVig2XpcIi1wUU1dzHSjXjcQnTVD/QNrePxBnDzBNIU=;
        b=q6O2vRM2j90iSyGYSzu+HAnw6lxsn7evud23Uvn5jGlos/gNwnCPxaUWaQ9XGbgx9d
         soLIh7aFCW90WQ/oKVjEBIz3r/kZ/T1HxcvuvLkskSx6o7dw4btmQ1mhpNCWrkWillhB
         Uf8C1qV6EJ/JyYt/7l88m3KYZGvaCFrEA/jAew3FCea43VeOV5FVznOaRo/lQoEOhfx7
         qcjKWVeI7bKI5fbPPSlYjLDhypXBw3qptTPU4AuAB0nhymN2NiS9WlsE7jZqkN6In4uX
         UVohA4jswnEmQhv983uejcydMdMl5vcu7aNsQuLPdjqH0OZttOsQqyXr1LSqbxzxPqGp
         uVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pVig2XpcIi1wUU1dzHSjXjcQnTVD/QNrePxBnDzBNIU=;
        b=kr+ZTOSFC4JnL3uSgcYKnr0X7YQbcIWvfHmL2VA9UAJp1lLzW8POL53Mdy+HbBXzBU
         c/bWASWW5l5Oubz3XVNu263wgJrvIjrDc/p+9GYHfKZWFHQSjNI33B0XcOIsAP0ZeJnv
         +TQkjh4BvW5lU9O9tMwXXhgZiKQnc08vEzezHauTfTXzPkCJpmZkUfXLE76s+/uFdNTl
         b70+j7Ox3RD7lfYIaEAiXZb1y+qjpnAjoXq5CL1NQcysQA6FIvUcrm6yBvaKwvPE7S+6
         aLxeAV+ognPX9C8c2m7Jt3S8J3Md9VhIlXBLemUYOwyFDMPRJY2ZwjoclLzGqt3IXhUj
         2rFQ==
X-Gm-Message-State: AGi0Pubr7Zyued2ybKXEIT5bO+evmkQy72f/r75dVMoBgJoUTRa9nUQ2
        2ezvjlSwd6iwku2Sy9zXfLAFwJSB
X-Google-Smtp-Source: APiQypIhxIyWT/S7Fta9RYW+bfGXh8dePj+daAJW5u9iCbAWiAyKA7IzL+Sv5RBbG8KNBVL8jv4zkg==
X-Received: by 2002:a05:6512:108a:: with SMTP id j10mr5470969lfg.38.1587229640823;
        Sat, 18 Apr 2020 10:07:20 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id e15sm8768909ljb.25.2020.04.18.10.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 10:07:20 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/6] drm/tegra: output: Don't leak OF node on error
Date:   Sat, 18 Apr 2020 20:07:00 +0300
Message-Id: <20200418170703.1583-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200418170703.1583-1-digetx@gmail.com>
References: <20200418170703.1583-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OF node should be put before returning error in tegra_output_probe(),
otherwise node's refcount will be leaked.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
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

