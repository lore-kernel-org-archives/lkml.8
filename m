Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05209C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3A0124957
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340260;
	bh=ACTRU1UUEm6ye6yZ2p3caxXTQ7iwAUF7bdVTOxW/sA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BUD3qLczUgrQiKyfy+lqhM/MmFKwdc+eEDKFMockw4PsQmqeKnN2RJgSmb4oNUpmn
	 MB3HT0b4uUNCmeSxmhpap6qu2LdlUMsvjNk8D8KOf5dqC9tb3QevWk9Tea4EHRFn7W
	 IJXQ6MDF5jYL0U2VlCa/ZFlMAMFhJjJgRe8o6tgk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730967AbgEANhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:37:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730580AbgEANhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:37:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E11216FD;
        Fri,  1 May 2020 13:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340254;
        bh=ACTRU1UUEm6ye6yZ2p3caxXTQ7iwAUF7bdVTOxW/sA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GiuWPujX62/RvLzhGOnlGol1AVVGgLa7maZHMDrOBWcvI7ny+Ml8QU9xECd0fcd61
         skMPZ+HVM8bs6xKpuWQRt8ItRjglcAGnNANWzWLu3z+CB1aGsXi2pSivuC8zg7js8G
         +tDhcFKGbrzlsqJ6yECJroigt24ANUzGWpDcug74=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 43/46] hwmon: (jc42) Fix name to have no illegal characters
Date:   Fri,  1 May 2020 15:23:08 +0200
Message-Id: <20200501131513.660829988@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131457.023036302@linuxfoundation.org>
References: <20200501131457.023036302@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/hwmon/jc42.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/hwmon/jc42.c
+++ b/drivers/hwmon/jc42.c
@@ -527,7 +527,7 @@ static int jc42_probe(struct i2c_client
 	}
 	data->config = config;
 
-	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
+	hwmon_dev = devm_hwmon_device_register_with_info(dev, "jc42",
 							 data, &jc42_chip_info,
 							 NULL);
 	return PTR_ERR_OR_ZERO(hwmon_dev);


