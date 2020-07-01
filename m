Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B98C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A49A2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 02:17:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwBpvJCt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgGACR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 22:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbgGACQf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 22:16:35 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E52D8C03E979;
        Tue, 30 Jun 2020 19:16:34 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y18so12641545lfh.11;
        Tue, 30 Jun 2020 19:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vapTfDZ2f1tAvfpKmc+ZWDOZuBAyLK5G5gnKE1dsXng=;
        b=XwBpvJCtsnnsnuaueMAfzetWsRY7ZOzou4jP71fGDWF3pG796loCN0qXhchF2sgu84
         edWAmjAvruo+Bs0X8kE5aDgm7DD2IzGRyhEn66nySzPGXYTgAu331v/qx8sx0mv03iFV
         sdQtshunNKY9AYMqCIZrfxtMv+N1zXb29khQh5iJo8DEf9ZfEXqMjTGqawmDqwh+JB1E
         ZKz84KGiwitlYGRQ7OyP1Knp+MMRs3jKRCPiE1dQWOINtvy4os+twMHyAfg8OAohSJwI
         pLnP0JvMUjxvtYIiAyMeHVqofEI6cEwhkPc6anWD8ODFk5KdlbA1C9pI88zjI3teKNpK
         RIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vapTfDZ2f1tAvfpKmc+ZWDOZuBAyLK5G5gnKE1dsXng=;
        b=QNmvRF1pPuz9e4z7+FJmSFbvuLH9jcd80B5XSIcAy4QaqlDI+LWsW2fl5nVjmsBo7s
         p4EbE9dtFVOiwE7pr5b7vBIx5OaXOuFPpKPYjQ5XU2rOrtxkCKr7cF3scIiKC4prtlmT
         IiDDqvY5S2tUbvtjEyyTjJ5JFYrbxxjYRFmVkQhEWRPoshs/45HL/4jDcsCFof/aGaG+
         Eo8XD93jMUJR+BHqZ2TwXkkWugwYjjwZ/41fRjlY0y4GO7DnRkTSKb+ASUyT6Vqs3kwH
         Y6lkQnyDBjyTae01Y8nPDQTwzs69sfftUheCEd6cX57kjSKN9vNtef/QdsQXKQqQn11e
         V2Ng==
X-Gm-Message-State: AOAM532Dks+CHI172ET5wMeMeyYsgXM6sHkb00lbFaI81devO8/LgP6/
        C4yBjx/0jNv59gS/SVVBMjQ=
X-Google-Smtp-Source: ABdhPJxhbSKKq0FhmJrE9dy8QVFhZlrI2NTNt76+0Z8xz5UeHKJ8xcWUitnVVvXISrjygrzzMjHiVQ==
X-Received: by 2002:a19:f20a:: with SMTP id q10mr13842463lfh.89.1593569793367;
        Tue, 30 Jun 2020 19:16:33 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id i2sm1296892lji.59.2020.06.30.19.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 19:16:32 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 2/2] drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence
Date:   Wed,  1 Jul 2020 05:16:17 +0300
Message-Id: <20200701021617.12030-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200701021617.12030-1-digetx@gmail.com>
References: <20200701021617.12030-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When graph isn't defined in a device-tree, the of_graph_get_remote_node()
prints a noisy error message, telling that port node is not found. This is
undesirable behaviour in our case because absence of a panel/bridge graph
is a valid case. Let's check the graph's presence in a device-tree before
proceeding with parsing of the graph.

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/drm_of.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
index b50b44e76279..fdb05fbf72a0 100644
--- a/drivers/gpu/drm/drm_of.c
+++ b/drivers/gpu/drm/drm_of.c
@@ -246,6 +246,15 @@ int drm_of_find_panel_or_bridge(const struct device_node *np,
 	if (panel)
 		*panel = NULL;
 
+	/*
+	 * of_graph_get_remote_node() produces a noisy error message if port
+	 * node isn't found and the absence of the port is a legit case here,
+	 * so at first we silently check whether graph presents in the
+	 * device-tree node.
+	 */
+	if (!of_graph_is_present(np))
+		return -ENODEV;
+
 	remote = of_graph_get_remote_node(np, port, endpoint);
 	if (!remote)
 		return -ENODEV;
-- 
2.26.0

