Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D183C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 622C620700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 12:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587731044;
	bh=PtDDryNXCt/9ihdYD2ZXT+uVLrhInNakO1Houm02HMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XIde4fYHuVhJnjad8H5TjXn5cK7YuJXNPk4a5dUwXw8NhptTaNig38grrnLY6ulxe
	 5UKceTCFq+s0rKuhkRPYEj0bndmFwD3wB62uVBEgH1jeMhDReXD7XOWwJL72AQgWkG
	 tfCxJFZhjk8PVPenvn19EkZAIWoJxcaJCynL2zZU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDXMYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:24:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54106 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728190AbgDXMXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 08:23:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E760820706;
        Fri, 24 Apr 2020 12:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587731033;
        bh=PtDDryNXCt/9ihdYD2ZXT+uVLrhInNakO1Houm02HMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ze+jnc3sIU0XgPHPoBdXPizwyYz67A1Fz1jz/d5DGaGqVXD6ZYlytEicbuH93Dvl2
         w8+w5/XgW9ZDVJtBSX3NhJ4qs/+l7HHrqvKD5FBbAIhNhEaMfCVV+P/og2VMGMVjfl
         MPZ4blyeQuy9VA3J2znI9IM9F+nSmV4ALomlb74E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>, linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 26/26] hwmon: (jc42) Fix name to have no illegal characters
Date:   Fri, 24 Apr 2020 08:23:23 -0400
Message-Id: <20200424122323.10194-26-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200424122323.10194-1-sashal@kernel.org>
References: <20200424122323.10194-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sascha Hauer <s.hauer@pengutronix.de>

[ Upstream commit c843b382e61b5f28a3d917712c69a344f632387c ]

The jc42 driver passes I2C client's name as hwmon device name. In case
of device tree probed devices this ends up being part of the compatible
string, "jc-42.4-temp". This name contains hyphens and the hwmon core
doesn't like this:

jc42 2-0018: hwmon: 'jc-42.4-temp' is not a valid name attribute, please fix

This changes the name to "jc42" which doesn't have any illegal
characters.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Link: https://lore.kernel.org/r/20200417092853.31206-1-s.hauer@pengutronix.de
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/jc42.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/jc42.c b/drivers/hwmon/jc42.c
index f2d81b0558e56..e3f1ebee71306 100644
--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -506,7 +506,7 @@ static int jc42_probe(struct i2c_client *client, const struct i2c_device_id *id)
 	}
 	data->config = config;
 
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "jc42",
 							 data, &jc42_chip_info,
 							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);
-- 
2.20.1

