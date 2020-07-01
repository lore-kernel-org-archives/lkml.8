Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CFBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5ED4D20773
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 07:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2+CyBm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgGAHnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728322AbgGAHnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 03:43:05 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58608C061755;
        Wed,  1 Jul 2020 00:43:04 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id t25so21186773lji.12;
        Wed, 01 Jul 2020 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vapTfDZ2f1tAvfpKmc+ZWDOZuBAyLK5G5gnKE1dsXng=;
        b=p2+CyBm3hryTHrZxURLXskWjQ/8tBPFEijkMuW7RW0ZeOWlUihpvWBa1f0/goGST4d
         /eeRaDMtMkY6I2Yx+CUMG1HaF9YPolELljK8KUxLZqnvpGxescuIgYoYrMsBENXKMnoN
         +DttfWVwAzh/o1j2XVIRrM8DxvRCnZAuO9a092SPAT4IztiLlF13xo+iHk1prupsrHi+
         I2YLTgUM4mUfmsN+P66YuZb6qJc/dN7fZvl0DbCHQHJEq1RujEWdiZ+xRmn1/nbTGcco
         8vdwMsb3m4SHR2tOaLylWAj9buhyOyS/jhoe7ZTXGZfFZ38GdmLpeWaZ4uiKw7RsqeyU
         BeMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vapTfDZ2f1tAvfpKmc+ZWDOZuBAyLK5G5gnKE1dsXng=;
        b=M1RgUuc1/xPaGXm6eVEsRa2BrYe/VmDjyew0U+uExWVyutbW7UerQ+OFx51CT5ztIw
         FYmRIFcCgZxFcJygnIUEbjDfLPdWwR1e1+LHipLhTKmeQE9sBNXw4SVglH75333BWSkJ
         ak/Ot+ToYVLBJFRDZYKBy5f/9wYa78M2yUqOTmSIKmgWmK89trAnEOQ1+sEMqkmYvjtE
         H2KAc75qf95M87o25NhQ3yPIVtgWcMjxIttXFOfwnkSMOaIaXga08ppdyOcZYZOBD/KJ
         z5+N++Pfb0PJyJnEB2ACelbYQ3tLafFzZ/fiqV/gYsGi53VmJygrG6mV2IbARMKvIhcR
         8S7w==
X-Gm-Message-State: AOAM530Qcy9H/ZhLjfDbfRIjzZOWJ2obf7FsFnxyMYnYw11WthmLBND1
        ZJzVn5tQ2xrL4/LfMOrYBsg=
X-Google-Smtp-Source: ABdhPJzQnoAy8VMG2guQ6rxw3JWQlodP3SToyfFNxeaRO3AZp9mee0BT7uQeSlEZTyyS++KM44v1lA==
X-Received: by 2002:a05:651c:1057:: with SMTP id x23mr11651351ljm.116.1593589382903;
        Wed, 01 Jul 2020 00:43:02 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e10sm1520881ljb.118.2020.07.01.00.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 00:43:02 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 2/2] drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence
Date:   Wed,  1 Jul 2020 10:42:32 +0300
Message-Id: <20200701074232.13632-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200701074232.13632-1-digetx@gmail.com>
References: <20200701074232.13632-1-digetx@gmail.com>
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

