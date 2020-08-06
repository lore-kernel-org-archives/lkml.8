Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 760F4C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E8F2086A
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/EQNUDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbgHFQ64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:58:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgHFQkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:40:42 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D907C0086B9;
        Thu,  6 Aug 2020 08:36:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id c16so30416719ejx.12;
        Thu, 06 Aug 2020 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpnCPJNyGsrLzWm8QOzVbxMg70S0b7SCU0Q8vzGNKK0=;
        b=Z/EQNUDaGYAngW57e5SPhEMMQviexnNEdX1OL8T0J8vvO3HW6AQDQoEtnsgqOdejSG
         j7NeDR63FkI2y+Sg+FZr7fDNzw68hmE1/zlxMxpiX3QWPCNyjoV7VTBhIsB4wh5bQM2D
         1derZihF6/dWXWAcaG0BO1yZbDTL0QBWxO7LBWCr5mp45poeITN69tJKvhXEo60OJYPV
         ihDCDzTECHtfo7SkZxW+uFK/+YG7mWoVZ+k1omKseDF0t3XgJ8bsfmz000dVuXwptjt+
         egVVAZ2W9LcB2Yln2DEJralPQYwHKJ3PdtqE6+eT2W1a8A5XSbLY3346tLlrVWjzRnlo
         Qq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xpnCPJNyGsrLzWm8QOzVbxMg70S0b7SCU0Q8vzGNKK0=;
        b=euAqzzWTnNEQwRAKymBjwwW3fsYAVNaCyX/1Ht/hSDwiefzy74pA6WRwKjrIJ1O8XH
         GjfO7gNbYxPpu1rYLvpnU44j2QGOjz7tXBWL0NMEgFUX5ECk4jUgCfdHO+5qh8k4Jqxk
         rY1G2TNnqtXfH1FE0NOj8owprm04uO0xKUe9hb7ZS0O/q7QhRDqeXHiMcMv34gcBNTcv
         QcxkABWdVFQ1ldXPg7R87ZrIiqE7J0fB1adduM5UKFPf9QV6b1Bk3QGpZaBe6Z6+LTgw
         i4YtZ2mDuC8n48D7W9FY56PiRYlu2eSNKZ7ZHSaiZg271AKiGTmS5C22NR/gtzSp94qo
         h9rw==
X-Gm-Message-State: AOAM531O55K8tOOWaugL3HQ2yzc3cyKNxhPbt0jt1nZzjiyhTJS06iQM
        BZ7YWXzhpUIjvY6RA/6MO3wxxuMB
X-Google-Smtp-Source: ABdhPJyjvQ0o88PzKsmx99c/tjJod1LI1/VwIAe8QTyZaHHrSHXsA/mfPwbax44NxKm9klRmAuMXZQ==
X-Received: by 2002:a17:906:970a:: with SMTP id k10mr4850800ejx.189.1596728216809;
        Thu, 06 Aug 2020 08:36:56 -0700 (PDT)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id g21sm3563561edm.65.2020.08.06.08.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 08:36:54 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] of: platform: Destroy child devices symmetrically
Date:   Thu,  6 Aug 2020 17:36:50 +0200
Message-Id: <20200806153650.3883530-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Iterate over child devices in reverse when unpopulating a platform
device to make this step symmetrical with the population step. This
fixes an issue in the Tegra DRM driver where upon module unload the
DPAUX controller tries to unregister an I2C controller but will end
up waiting indefinitely because one of the SOR devices is keeping a
reference to it. Since the SOR devices are instantiated after the
DPAUX devices, they would only be removed (and hence release their
reference to the I2C controller) after the DPAUX devices have been
removed.

While destroying the child devices in reverse order helps in this
situation, it isn't fully safe to do so either. An even better way
would be for the child devices to be reordered to match the probe
order, which would work irrespective of the instantiation order.

However, reordering by probe order would be fairly complicated and
doesn't fix any known issues, so we'll go with the simpler fix for
now.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/of/platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 071f04da32c8..b557a0fcd4ba 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -590,7 +590,7 @@ EXPORT_SYMBOL_GPL(of_platform_device_destroy);
 void of_platform_depopulate(struct device *parent)
 {
 	if (parent->of_node && of_node_check_flag(parent->of_node, OF_POPULATED_BUS)) {
-		device_for_each_child(parent, NULL, of_platform_device_destroy);
+		device_for_each_child_reverse(parent, NULL, of_platform_device_destroy);
 		of_node_clear_flag(parent->of_node, OF_POPULATED_BUS);
 	}
 }
-- 
2.27.0

