Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20717C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F4E20801
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 08:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582272039;
	bh=vCOwDC4HiMKfA9asIcQGpE8w0AH9BpB7uecmviq9Qsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DXGH7ZUxRlEnX8jMTsqvT3LYqU/XxDj5nTRG2tznp9hLP5/poLZULOFDPt95QCWI3
	 2gCqwkR8KJCYnBvBkdcnv1bqhSoIUd2B2uRtegEeFZhH3Hb0qIlFOJPeIOV4A/o1x4
	 53UPzM0ncb5BvV3U2xRAhj212uvx2A/cVP7v6+14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgBUIAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 03:00:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:32792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731083AbgBUIAg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 03:00:36 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B6F206ED;
        Fri, 21 Feb 2020 08:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582272035;
        bh=vCOwDC4HiMKfA9asIcQGpE8w0AH9BpB7uecmviq9Qsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oc555iWMlm83sUjlvAONGDMOemnJzzH70SK7UARQPdrVK+i32xZ/W5OQARVQXT0VW
         U7SadToKB2pdrjBw5wvrxKdEhuGb/4z83jL9fYhbsrDbmfz9xCebEfrsLyBieBvEWw
         TikUBnY0pMBQ190M965dCJIzjxBU2FuundeXVISw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 390/399] i40e: Relax i40e_xsk_wakeups return value when PF is busy
Date:   Fri, 21 Feb 2020 08:41:55 +0100
Message-Id: <20200221072437.894914775@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit c77e9f09143822623dd71a0fdc84331129e97c3a ]

Return -EAGAIN instead of -ENETDOWN to provide a slightly milder
information to user space so that an application will know to retry the
syscall when __I40E_CONFIG_BUSY bit is set on pf->state.

Fixes: b3873a5be757 ("net/i40e: Fix concurrency issues between config flow and XSK")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Björn Töpel <bjorn.topel@intel.com>
Link: https://lore.kernel.org/bpf/20200205045834.56795-2-maciej.fijalkowski@intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/i40e/i40e_xsk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_xsk.c b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
index f73cd917c44f7..3156de786d955 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_xsk.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_xsk.c
@@ -791,7 +791,7 @@ int i40e_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 	struct i40e_ring *ring;
 
 	if (test_bit(__I40E_CONFIG_BUSY, pf->state))
-		return -ENETDOWN;
+		return -EAGAIN;
 
 	if (test_bit(__I40E_VSI_DOWN, vsi->state))
 		return -ENETDOWN;
-- 
2.20.1



