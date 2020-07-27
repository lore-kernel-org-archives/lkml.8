Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A273C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:12:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E838F20838
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859120;
	bh=ARPaB4wAHglbbqJ4LINQxaTkNFe3SorSemUE1XOUsgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Db9t04FKz/WUgnIyW/uS8v2CvZONOTfz7b3AcejG9mzfOpQyS3J3X/cRoAGWw7VaP
	 m1hWwhPCeZFQNdmDzKD0cttCjwLi6dy3wpvNwjzy2eQvRes069SJjO56HI+L7izoGp
	 d0DicCdJ04MfcRfdO0do3TC1Pf9UTAeg2Pv+sF9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgG0OL6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:11:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730066AbgG0OLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:11:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28975208E4;
        Mon, 27 Jul 2020 14:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859110;
        bh=ARPaB4wAHglbbqJ4LINQxaTkNFe3SorSemUE1XOUsgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dmDvFDV9DSEunlpX9XuogmyTlRqeak5KLKnJ0nRiz+AnhsL3Lrh3P5Zq8qqw0f1Fj
         EuFHt91OU6+ZevsqWze73K6PHJRd4ZDUbSOHYaIc+ISX27dhx7+OmiSkRT1NUdQHwL
         J0hmYrdYxX9gByHBi+eXqeLFg05YsD9UbAcTZ2FI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sergey Organov <sorganov@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/86] net: dp83640: fix SIOCSHWTSTAMP to update the struct with actual configuration
Date:   Mon, 27 Jul 2020 16:04:03 +0200
Message-Id: <20200727134915.910636778@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergey Organov <sorganov@gmail.com>

[ Upstream commit 473309fb8372365ad211f425bca760af800e10a7 ]

>From Documentation/networking/timestamping.txt:

  A driver which supports hardware time stamping shall update the
  struct with the actual, possibly more permissive configuration.

Do update the struct passed when we upscale the requested time
stamping mode.

Fixes: cb646e2b02b2 ("ptp: Added a clock driver for the National Semiconductor PHYTER.")
Signed-off-by: Sergey Organov <sorganov@gmail.com>
Acked-by: Richard Cochran <richardcochran@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/dp83640.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/dp83640.c b/drivers/net/phy/dp83640.c
index 4fed778331573..dd0a658c843d6 100644
--- a/drivers/net/phy/dp83640.c
+++ b/drivers/net/phy/dp83640.c
@@ -1343,6 +1343,7 @@ static int dp83640_hwtstamp(struct phy_device *phydev, struct ifreq *ifr)
 		dp83640->hwts_rx_en = 1;
 		dp83640->layer = PTP_CLASS_L4;
 		dp83640->version = PTP_CLASS_V1;
+		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
@@ -1350,6 +1351,7 @@ static int dp83640_hwtstamp(struct phy_device *phydev, struct ifreq *ifr)
 		dp83640->hwts_rx_en = 1;
 		dp83640->layer = PTP_CLASS_L4;
 		dp83640->version = PTP_CLASS_V2;
+		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
@@ -1357,6 +1359,7 @@ static int dp83640_hwtstamp(struct phy_device *phydev, struct ifreq *ifr)
 		dp83640->hwts_rx_en = 1;
 		dp83640->layer = PTP_CLASS_L2;
 		dp83640->version = PTP_CLASS_V2;
+		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_L2_EVENT;
 		break;
 	case HWTSTAMP_FILTER_PTP_V2_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
@@ -1364,6 +1367,7 @@ static int dp83640_hwtstamp(struct phy_device *phydev, struct ifreq *ifr)
 		dp83640->hwts_rx_en = 1;
 		dp83640->layer = PTP_CLASS_L4 | PTP_CLASS_L2;
 		dp83640->version = PTP_CLASS_V2;
+		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 		break;
 	default:
 		return -ERANGE;
-- 
2.25.1



