Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AE1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:23:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 423D72083E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859820;
	bh=8UMyjt/AzFGIS1GD45TwNQmUI/lsxAFHKcAG7o84BZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eJr0oKuvTC4pv7lRPaqsoTIibFSIgo6wF2p3Pp9dq+pe5stBPIe43R1RdoB5bSW+Y
	 481XrurJ9hHuf/ruLd+v/eFhItFtP6mvPFjGfVj8wy+RWGYUjy4CGbv3FBc8f4pfIF
	 tA/gef/SfpXlVEKI7vLe0Rfub7BZps0BiPH+8Wlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgG0OXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:23:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:52762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732070AbgG0OXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:23:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3166E2083E;
        Mon, 27 Jul 2020 14:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859810;
        bh=8UMyjt/AzFGIS1GD45TwNQmUI/lsxAFHKcAG7o84BZM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xWvsPcEvdoDwJ5GnhwxB1zSZQMrYDwVG2sbAJKmdggbowNhc0pzrRd3jvNy+Q5i6Q
         +VUhcDPFLuh+SLGP9VXtgg+p/3WSQPBm6cJH2ZaTF2KY7VWfUrxShbzsjeFfS+ZcGm
         l66Xy33aujTBk18+7bGV+LWTdQ7fr7yA+dL55+S4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 113/179] regmap: dev_get_regmap_match(): fix string comparison
Date:   Mon, 27 Jul 2020 16:04:48 +0200
Message-Id: <20200727134938.158461781@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

[ Upstream commit e84861fec32dee8a2e62bbaa52cded6b05a2a456 ]

This function is used by dev_get_regmap() to retrieve a regmap for the
specified device. If the device has more than one regmap, the name parameter
can be used to specify one.

The code here uses a pointer comparison to check for equal strings. This
however will probably always fail, as the regmap->name is allocated via
kstrdup_const() from the regmap's config->name.

Fix this by using strcmp() instead.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://lore.kernel.org/r/20200703103315.267996-1-mkl@pengutronix.de
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 320d23de02c29..927ebde1607be 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1363,7 +1363,7 @@ static int dev_get_regmap_match(struct device *dev, void *res, void *data)
 
 	/* If the user didn't specify a name match any */
 	if (data)
-		return (*r)->name == data;
+		return !strcmp((*r)->name, data);
 	else
 		return 1;
 }
-- 
2.25.1



