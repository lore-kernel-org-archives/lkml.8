Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777D3C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A767205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584443404;
	bh=gTXYefyTfOMkjHb22tvfdm2aO0MyNvIxJ3fzHPHZuuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IdHn6DC77fYyBUfyu9qJH/hAWbO5C8xRUMtKcFcF9TKG158M2rv1qcosoD2vYZ6UQ
	 PQ/F4KW2g0f3OOP/du+d6CFc3RFteqqeQiXLaSHKccYcLkxTUd2uo0Vsb0slFBGSNb
	 4RHPdjvBdNkYoQG4krLnETXI4ddNbuaFeTr7TGKA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgCQLKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 07:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:52640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729017AbgCQLJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 07:09:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F19B20714;
        Tue, 17 Mar 2020 11:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584443398;
        bh=gTXYefyTfOMkjHb22tvfdm2aO0MyNvIxJ3fzHPHZuuc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJg4CiOlIsS6rEgIkzl/+I32anpT3Tld3ZWYhLks1FPSjxg9tIzb7704Dyyqy4WwM
         jd0AiEgfjASSwc/PkLfwG5INpLpY1X9YL9ZZCdRC6OIk7ycCMaZq3db8zDBjLESFGB
         taam9Kouvsy3J/Szz+bInVyRRAC8EPemdGrSGI8M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 071/151] net: phy: Avoid multiple suspends
Date:   Tue, 17 Mar 2020 11:54:41 +0100
Message-Id: <20200317103331.534626602@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317103326.593639086@linuxfoundation.org>
References: <20200317103326.593639086@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

commit 503ba7c6961034ff0047707685644cad9287c226 upstream.

It is currently possible for a PHY device to be suspended as part of a
network device driver's suspend call while it is still being attached to
that net_device, either via phy_suspend() or implicitly via phy_stop().

Later on, when the MDIO bus controller get suspended, we would attempt
to suspend again the PHY because it is still attached to a network
device.

This is both a waste of time and creates an opportunity for improper
clock/power management bugs to creep in.

Fixes: 803dd9c77ac3 ("net: phy: avoid suspending twice a PHY")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/phy/phy_device.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -247,7 +247,7 @@ static bool mdio_bus_phy_may_suspend(str
 	 * MDIO bus driver and clock gated at this point.
 	 */
 	if (!netdev)
-		return !phydev->suspended;
+		goto out;
 
 	if (netdev->wol_enabled)
 		return false;
@@ -267,7 +267,8 @@ static bool mdio_bus_phy_may_suspend(str
 	if (device_may_wakeup(&netdev->dev))
 		return false;
 
-	return true;
+out:
+	return !phydev->suspended;
 }
 
 static int mdio_bus_phy_suspend(struct device *dev)


