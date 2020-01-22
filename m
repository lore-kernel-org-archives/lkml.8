Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808BBC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57DA824672
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 09:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579685683;
	bh=pGGSznadTDpUp/QlK1glxUgOtEg1Tqrc/xNzw4ipz7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LVcxpn7aZwCTJJLnp+qW58CuT9OSyo6fYb96wHyJvAaOyEoD1tnv+ItkChHAdilK7
	 1DqaboQAmvT3gFN0EhkKOAUEaMk/FAu/TicxTJkSXtIuF2Em0ibrLcfj6npKORUS8y
	 1mtS0lhxG8Q9mWXUmoY5DOOu2VFcg5SBO5q+0Ia8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgAVJem (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 04:34:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:49286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730959AbgAVJek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 04:34:40 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B1B2467A;
        Wed, 22 Jan 2020 09:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579685680;
        bh=pGGSznadTDpUp/QlK1glxUgOtEg1Tqrc/xNzw4ipz7c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yOFaJpLhqzb1r53R/rJEqtZoxWPSE+963RoxbD8uY3oouWYQ6hY8j0IlQSiYSRbtC
         jt4cWUyHwt5k+Pt6IoK0McHJpkaukem9xewQ7XIevVo8rFNF+uywl8Y42Pus/Q73L9
         3EjLHUeJB7m0WefFItzENWUblNSGgwwATlQYvPAM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4.9 35/97] tty: serial: imx: use the sg count from dma_map_sg
Date:   Wed, 22 Jan 2020 10:28:39 +0100
Message-Id: <20200122092802.178322001@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092755.678349497@linuxfoundation.org>
References: <20200122092755.678349497@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 596fd8dffb745afcebc0ec6968e17fe29f02044c upstream.

The dmaengine_prep_slave_sg needs to use sg count returned
by dma_map_sg, not use sport->dma_tx_nents, because the return
value of dma_map_sg is not always same with "nents".

Fixes: b4cdc8f61beb ("serial: imx: add DMA support for imx6q")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Link: https://lore.kernel.org/r/1573108875-26530-1-git-send-email-peng.fan@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/imx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -548,7 +548,7 @@ static void imx_dma_tx(struct imx_port *
 		dev_err(dev, "DMA mapping error for TX.\n");
 		return;
 	}
-	desc = dmaengine_prep_slave_sg(chan, sgl, sport->dma_tx_nents,
+	desc = dmaengine_prep_slave_sg(chan, sgl, ret,
 					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 	if (!desc) {
 		dma_unmap_sg(dev, sgl, sport->dma_tx_nents,


