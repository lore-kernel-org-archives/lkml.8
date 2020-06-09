Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4062FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194B52078D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 13:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIAk2MfP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgFIN3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgFIN3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 09:29:14 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621BFC05BD1E;
        Tue,  9 Jun 2020 06:29:14 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c17so25015643lji.11;
        Tue, 09 Jun 2020 06:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VyQqkmAqCRmhebVrr7VbOeFm0zvD99iAEoTluAvbJX0=;
        b=CIAk2MfPqSQmdCUuQCgNDKahaE/vsRM0XdOjTzVjv0eIHVz/7YGvl4ZBWOIsbIEiEp
         F0YWveupWoIbRDD0vm0jMMq24Im00dNFHkqoppPcK5wVvLP55rBx+pAdazj/QChMjIHB
         4BlGkOjESv0CkG1jnoLlAvYb19XndAFhH76io3uizAeHQ8VKuAVko6l+32vb/u8+nAT8
         j+JkxEo9B+NspuoZYh/QJ7WFn97Xk4QrZEeVo9strAmn9dMq9X8RweFSjAKVqFeLACGq
         1OAs5nu3f0wr/a/xzgAFp/pjwQvuSgZefIPRMfx5KaiIOi6O9zHLkRPQn9aWqhK6IRRH
         evXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VyQqkmAqCRmhebVrr7VbOeFm0zvD99iAEoTluAvbJX0=;
        b=l4aHrEMUb/wiie0FXGprm9YN0EJtl1cC2TmFV0NwHObwCkilpmdB8aGAagywSiyJVZ
         gzX9ZL71lyBv+lk2h3YBe22mVQQc8jLAEofFz0944s5ERMqIfC/dJLDFCwxWkKQIx0Z4
         W3nVe1jIn8j+fp7bL/M3Oar7TmO8uz/7j9l+u8ek6tXumBddIuDf8uG8O9o1jKKucIAI
         M29nb0p5RIumpwB1uHJ1/RpH7yuwIOw8R9LKL3KHH5QioRBc5HASf5cHR776h5tGa8vw
         VuIY4N7TItaZxd2z1oSxzgguniwBKpeWwTWGuuaFVSpqMhtCwMjx2/sdmITNAQH3oIvl
         rjyA==
X-Gm-Message-State: AOAM531vnawma9G+Hatvfu4vQeYx+7WwjzeZ5gP1/BSB7FK5btq9H/rF
        sJK5pi2UEjWEpSW4dsfmfiA=
X-Google-Smtp-Source: ABdhPJzbKrzIKoajQPdCZLcQ+VPt3ZjJhuXrc0D2alUYPYU30yDhBVt4EOUseD8KsWPRpYm4RdY4+Q==
X-Received: by 2002:a05:651c:54e:: with SMTP id q14mr12329916ljp.279.1591709352921;
        Tue, 09 Jun 2020 06:29:12 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id s8sm5069821lfc.83.2020.06.09.06.29.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:29:12 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/6] drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence
Date:   Tue,  9 Jun 2020 16:28:51 +0300
Message-Id: <20200609132855.20975-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200609132855.20975-1-digetx@gmail.com>
References: <20200609132855.20975-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When graph isn't defined in a device-tree, the of_graph_get_remote_node()
prints a noisy error message, telling that port node is not found. This is
undesirable behaviour in our case because absence of a panel/bridge graph
is a valid case. Let's check presence of the local port in a device-tree
before proceeding with parsing the graph.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/drm_of.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index b50b44e76279..e0652c38f357 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -239,13 +239,24 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 				struct drm_bridge **bridge)
 {
 	int ret = -EPROBE_DEFER;
-	struct device_node *remote;
+	struct device_node *local, *remote;
 
 	if (!panel && !bridge)
 		return -EINVAL;
 	if (panel)
 		*panel = NULL;
 
+	/*
+	 * of_graph_get_remote_node() produces a noisy error message if port
+	 * node isn't found and the absence of the port is a legit case here,
+	 * so at first we silently check presence of the local port.
+	 */
+	local = of_graph_get_local_port(np);
+	if (!local)
+		return -ENODEV;
+
+	of_node_put(local);
+
 	remote = of_graph_get_remote_node(np, port, endpoint);
 	if (!remote)
 		return -ENODEV;
-- 
2.26.0

