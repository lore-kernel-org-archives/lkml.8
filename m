Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F17C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B15206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581702508;
	bh=k1sVeab+9d4zC3g2vP/8WxrH+7ZK4bXHgO/WnXajlcc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AiNkeMFfUFtwlOKWcDyGd9lYIkk48AjLxlUCqNxl7MAELQ3W+tdwmFeYjds78tx5f
	 bHO4tJVLLNPyxmQjUM77ENTIp/FrRplsKpxfI9k507aYQuktm2COfEDnuARkVPCTZK
	 SibG8Ot6VX0PwiTnQy/kUeHizR6D49rDWUKt4OmI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388647AbgBNP7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:59:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388953AbgBNP7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:59:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C99A24688;
        Fri, 14 Feb 2020 15:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695975;
        bh=k1sVeab+9d4zC3g2vP/8WxrH+7ZK4bXHgO/WnXajlcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ogECddBm/4fFmzr+L+3bUSr7wuvziLWXZXZpveO+V4i3ZRPdivSVfdsAWwsg5oGxO
         JDHXb5cb6tZm+df1cgp4bk1CDxv6o9uZ+bl+FF+Z9uFhuQmbwkvDCkVKTMoJq9lb7L
         jtvDtKHkEEL0i42jR+H6wEjnkw5mLGRYsu1GlW/0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Raul E Rangel <rrangel@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 501/542] i2c: cros-ec-tunnel: Fix ACPI identifier
Date:   Fri, 14 Feb 2020 10:48:13 -0500
Message-Id: <20200214154854.6746-501-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Raul E Rangel <rrangel@chromium.org>

[ Upstream commit b49f8e0e7bd17b968129790e40f9e2566f4f95ec ]

The initial patch was using the incorrect identifier.

Fixes: 9af1563a5486 ("i2c: cros-ec-tunnel: Make the device acpi compatible")
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-cros-ec-tunnel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cros-ec-tunnel.c b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
index 8a2db3ac3b3c7..790ea3fda693b 100644
--- a/drivers/i2c/busses/i2c-cros-ec-tunnel.c
+++ b/drivers/i2c/busses/i2c-cros-ec-tunnel.c
@@ -299,7 +299,7 @@ static const struct of_device_id cros_ec_i2c_of_match[] = {
 MODULE_DEVICE_TABLE(of, cros_ec_i2c_of_match);
 
 static const struct acpi_device_id cros_ec_i2c_tunnel_acpi_id[] = {
-	{ "GOOG001A", 0 },
+	{ "GOOG0012", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, cros_ec_i2c_tunnel_acpi_id);
-- 
2.20.1

