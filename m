Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE734C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9DFF20888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590520328;
	bh=Ioq5oSR0MIiJstNPITP02CH7m7AaNYznuEU4MG1tsrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PyeOHOFTKAs+I+6Smy0X7cBkbB5ecpNkqG76ozlWqZojF1nqy6cTUOorLwZ++m5XD
	 XDiVOBWUIj/K2z/7zzgQsdwZ4KwXkd6fjvdXaT5vBbuZvfSE9V8tvVd5fkjqpKQTOU
	 fEs7CUDSZOXGgOKYCd8XeNU06sXcM8hNlARHyTq0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392063AbgEZTMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:41492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392025AbgEZTL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:11:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B10F20888;
        Tue, 26 May 2020 19:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590520318;
        bh=Ioq5oSR0MIiJstNPITP02CH7m7AaNYznuEU4MG1tsrQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2uSMwtAWhw+yDcNqIJ73cc01kX7qf4iQu8cqt0GH+68F3BvXhCHWJRLAtLTUY7n8V
         /6P2JAI6EoICaTBxUcaw0qrK5mhzOYHeO566F11lHsBbyG+TF3qb/JZYfWd+EuHmqr
         mOVGO9OS92nyFi7Ew0sjdFujrMUHWe+kH5wxAu/Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Richard Clark <richard.xnu.clark@gmail.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.6 033/126] aquantia: Fix the media type of AQC100 ethernet controller in the driver
Date:   Tue, 26 May 2020 20:52:50 +0200
Message-Id: <20200526183940.621026585@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526183937.471379031@linuxfoundation.org>
References: <20200526183937.471379031@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Clark <richard.xnu.clark@gmail.com>

[ Upstream commit 6de556c31061e3b9c36546ffaaac5fdb679a2f14 ]

The Aquantia AQC100 controller enables a SFP+ port, so the driver should
configure the media type as '_TYPE_FIBRE' instead of '_TYPE_TP'.

Signed-off-by: Richard Clark <richard.xnu.clark@gmail.com>
Cc: Igor Russkikh <irusskikh@marvell.com>
Cc: "David S. Miller" <davem@davemloft.net>
Acked-by: Igor Russkikh <irusskikh@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
index 78b6f3248756..e0625c67eed3 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_pci_func.c
@@ -56,7 +56,7 @@ static const struct aq_board_revision_s hw_atl_boards[] = {
 	{ AQ_DEVICE_ID_D108,	AQ_HWREV_2,	&hw_atl_ops_b0, &hw_atl_b0_caps_aqc108, },
 	{ AQ_DEVICE_ID_D109,	AQ_HWREV_2,	&hw_atl_ops_b0, &hw_atl_b0_caps_aqc109, },
 
-	{ AQ_DEVICE_ID_AQC100,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc107, },
+	{ AQ_DEVICE_ID_AQC100,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc100, },
 	{ AQ_DEVICE_ID_AQC107,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc107, },
 	{ AQ_DEVICE_ID_AQC108,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc108, },
 	{ AQ_DEVICE_ID_AQC109,	AQ_HWREV_ANY,	&hw_atl_ops_b1, &hw_atl_b0_caps_aqc109, },
-- 
2.25.1



