Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCD8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39BF820CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 22:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="isbpr2Sx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgFQW2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 18:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgFQW16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 18:27:58 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056E0C061755;
        Wed, 17 Jun 2020 15:27:58 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so4868501ljn.4;
        Wed, 17 Jun 2020 15:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D2TQMn0dQ091Nqq+EmKWvf4EfULgSTe0SpqhYi3GcPk=;
        b=isbpr2SxlqW0J3J2CicBxq53fq28gMmg7YC/eQiXUTn9g8m1Gd6Or6C46Ub3yzaEPf
         BcvWGAqobcTCh3f4tPMWdWA5ME0RP5TJ/6+67rSMdNS5OTaIYhuE2RrZ5cFC8havF97R
         duxVfwbCfPK40vjgiyD7IodPZS4NJ0Ngbe4qBkzSovstySRusBj7BsUNLLw4my3yrnSu
         tc1sF0fwqJgDMlfwGql3o0WQmtsDmtjsXFFA2Yk3SzBQDfj21q4KL4adVx+IOSlLguQm
         FBeDVj8+86w0ZVNsJqIaJD7OTEhUItm7Zw3z94Bft5UE1kuH3XHlkDux1vIZr2AQJ3Gh
         Qxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D2TQMn0dQ091Nqq+EmKWvf4EfULgSTe0SpqhYi3GcPk=;
        b=CB3cb5rzH5qSQdd/uX3P2wim/pwUncjDtHGT3rk5XGIjjdGBt7gYmfZXy0c16oI0KB
         PhwBN7J/g/vHaW+RS8ep36Ulxjnt9Cc8AfCyGSuXMHGDwOhxEiETbTZfra+9jNwKiLXX
         z8uJQVgiP/+XE2yQCaAODZ3WsANByKbVWWXeOLPgK2eoBkZm/R+KPwnCa9JJ2ybuZvuj
         DL7UigvTq1xitc09NESHSC0HsKDVwilkJEVi0zudZm4JJPhXYfq211hPwmPDFUjl48uL
         Ag+2L3QtEh58NdIvbcyFkQW7/Y+X/0u/2j5kAEHfz1T4hcxQ08s+/H9+tpxX4naDuZy6
         OPeA==
X-Gm-Message-State: AOAM532YgiWvoIUxd0k+Na0flzhihrQnd4OvqlmyJSIyqPNV6xbwCtKw
        Q7kku26jy+sKAG1eTI8ZQl4=
X-Google-Smtp-Source: ABdhPJxKn69Kc7DDNBEVuTIu09JjZKMVsMFj3derjbFs4KULA24ehv/AJiph5bFIewzvvXMssVFclA==
X-Received: by 2002:a2e:b051:: with SMTP id d17mr674285ljl.254.1592432876539;
        Wed, 17 Jun 2020 15:27:56 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id a1sm210378ljk.133.2020.06.17.15.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 15:27:56 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/7] drm/of: Make drm_of_find_panel_or_bridge() to check graph's presence
Date:   Thu, 18 Jun 2020 01:26:58 +0300
Message-Id: <20200617222703.17080-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617222703.17080-1-digetx@gmail.com>
References: <20200617222703.17080-1-digetx@gmail.com>
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
index b50b44e76279..cbe65efdae39 100644
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
+	if (!of_graph_presents(np))
+		return -ENODEV;
+
 	remote = of_graph_get_remote_node(np, port, endpoint);
 	if (!remote)
 		return -ENODEV;
-- 
2.26.0

