Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D5BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 223A520758
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597921577;
	bh=9eCPgRyI4fqwqAN+e26qemXeYHNGHo2GCFHGntOOVcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s7QXjoiIGy0C2C2bXxxgYQGv0GmoAfUaH1OZ4zUBOJQaZwr05rE/zcibjr77wb8X/
	 M+htzLa+uFwcSiotUCPeRoiK7SLU+gHdl8Ogy8m1zGpUEoeLDAO5Tu8Xn7EygBhB27
	 WiTvwiG160dqIIm1RdqIIzcbrSg85kaOd4QrNy3U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgHTLGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 07:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731030AbgHTKMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:12:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFC702067C;
        Thu, 20 Aug 2020 10:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597918330;
        bh=9eCPgRyI4fqwqAN+e26qemXeYHNGHo2GCFHGntOOVcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2J4fioawtOxB/3UmJe9XJvpBe8U++AAHygaPsmyWLdHP/d+9evJIgyRLX1rf/1ggE
         fgX9tXKezB4mCkLUVo3MuY6gJHO2/9hyTN3HeOPbmbNhQgbRJiIro2FU3phFLvQTaH
         P1RUZprRpnFoSPtA3wNM7WhDafgFEBIT9kW4johg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Florinel Iordache <florinel.iordache@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 132/228] fsl/fman: fix unreachable code
Date:   Thu, 20 Aug 2020 11:21:47 +0200
Message-Id: <20200820091614.183220705@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091607.532711107@linuxfoundation.org>
References: <20200820091607.532711107@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florinel Iordache <florinel.iordache@nxp.com>

[ Upstream commit cc79fd8f557767de90ff199d3b6fb911df43160a ]

The parameter 'priority' is incorrectly forced to zero which ultimately
induces logically dead code in the subsequent lines.

Fixes: 57ba4c9b56d8 ("fsl/fman: Add FMan MAC support")
Signed-off-by: Florinel Iordache <florinel.iordache@nxp.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/fman/fman_memac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index b33650a897f18..1fbeb991bcdf1 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -855,7 +855,6 @@ int memac_set_tx_pause_frames(struct fman_mac *memac, u8 priority,
 
 	tmp = ioread32be(&regs->command_config);
 	tmp &= ~CMD_CFG_PFC_MODE;
-	priority = 0;
 
 	iowrite32be(tmp, &regs->command_config);
 
-- 
2.25.1



