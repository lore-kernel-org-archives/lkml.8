Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DD9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCADC2074D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 02:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="ns2HOH+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgFNCkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 22:40:09 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:35288 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFNCkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 22:40:08 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49kzG01B1hz9vYTm
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 02:40:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lJZTe4lwBqvm for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 21:40:08 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49kzFz6Zggz9vYTj
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:40:07 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49kzFz6Zggz9vYTj
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49kzFz6Zggz9vYTj
Received: by mail-il1-f200.google.com with SMTP id l11so9508484ils.11
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 19:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjw2EDUNWQmlGguDj5XMiD/z/+98wuHl/U5yK7YcmK8=;
        b=ns2HOH+9IxAgXPEwDFxUkuvCgvyKbVXx7DkZfncXFoBThyQnWFmpyp7tbMmE2iCgl3
         S8oBix/jeQEYV76MhfEOxw8aDjKpcQVZns4CH4CJG+wGRn1agUmbDRQSXkSBoanvB3Uu
         ZNI13YKN2eqm+598/batBVlAu1fWzLevA6ZitBI7dygE4QWFsHoep7G62Am6OiqYAKRf
         M1LjrdBSv7cYkk+/1CruR6B5i2dAqUIgDtWGBH/L/PtG7L8D3j8WH22EB32u00mNdfnv
         Ykyo0/1PgeM0OC1stJsny8PhrYzxaiZT/v5SMml1qqLOEZYdJe4ofRraXBsAPbpS7Wus
         nJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cjw2EDUNWQmlGguDj5XMiD/z/+98wuHl/U5yK7YcmK8=;
        b=ATJP7M+OxBPV016dYC6sNAv1O57fjxqkVnRyTTeCy/4Htn1bMUtolZYr3RaVK8L8vO
         /tmIOATIJleDgM/i28tkRy8/rPCC41QPLUzZ7S6ZlxQC2hyxWxPsfYHUZHdLXu69M4Cg
         b0NsKZ1hcJZNyD8DxFY+KMgZiCf9LfjbcabRSkMJ/b70Xr2BgwgC0vksQagENybGgUJE
         bCaygHe91iPQYeN0Alp+HQHKvsHXkkp6oJVZLSCDVw4oFw8X5vzvlaX5LEQaDweao3Gs
         F8NJ2sARQq/2Y6IdCZqH/RrngizeC+uzBzD+C9UCk3hKwyFzHb7vU+o1ztzJxcybNSlK
         MUOg==
X-Gm-Message-State: AOAM532t8hQeY8TCqXXXgb9CRkvePia2AKYYJ3ZrmWOAG7ZquJVY6eGl
        3awsPLjFk2yqOEtSYs+IZ9UH6frP5lKrVUjrng38q+//mZEX839Kd9olkCJ4BDX0HwCSqzHDtum
        /bjJrDkh9T6wz9W0dhB9py5IUibOD
X-Received: by 2002:a92:4852:: with SMTP id v79mr19760138ila.172.1592102407585;
        Sat, 13 Jun 2020 19:40:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLYZiX+rxdPmvbSe+AhVS/yXl4ftp+Ygbnt1X+F2sUaj6fwZpleI680VBHOfDvc36fjxCtPg==
X-Received: by 2002:a92:4852:: with SMTP id v79mr19760129ila.172.1592102407398;
        Sat, 13 Jun 2020 19:40:07 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
        by smtp.gmail.com with ESMTPSA id c85sm5869099ilg.41.2020.06.13.19.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 19:40:07 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: fix reference count leaks due to pm_runtime_get_sync()
Date:   Sat, 13 Jun 2020 21:40:05 -0500
Message-Id: <20200614024005.125578-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
reference count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/gpu/drm/bridge/cdns-dsi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cdns-dsi.c
index 69c3892caee5..583cb8547106 100644
--- a/drivers/gpu/drm/bridge/cdns-dsi.c
+++ b/drivers/gpu/drm/bridge/cdns-dsi.c
@@ -788,8 +788,10 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	u32 tmp, reg_wakeup, div;
 	int nlanes;
 
-	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
+	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0)) {
+		pm_runtime_put(dsi->base.dev);
 		return;
+	}
 
 	mode = &bridge->encoder->crtc->state->adjusted_mode;
 	nlanes = output->dev->lanes;
@@ -1028,8 +1030,10 @@ static ssize_t cdns_dsi_transfer(struct mipi_dsi_host *host,
 	int ret, i, tx_len, rx_len;
 
 	ret = pm_runtime_get_sync(host->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put(host->dev);
 		return ret;
+	}
 
 	cdns_dsi_init_link(dsi);
 
-- 
2.25.1

