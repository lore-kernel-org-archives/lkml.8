Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B525C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363D620684
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 23:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579217492;
	bh=iXjNYfPsujbaV8I/FUUKm6HN4IOhTK91Z7tHbR3EyTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=buE37bt9D0pOuiqD686K4dKcmwgDX0unv5GKJWauN6QXuJZkJxW2myj3RK9K8Cml9
	 ONeV08+wgBOC45SwdL8s1cWd9C3/1ejz2fmNDcaSwsg29oPuhqac64L0rJatAKL2se
	 aFvjUI4wGBg7pY69VjDbmUote0Q3yW5gWc3vVQgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403960AbgAPXbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 18:31:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391087AbgAPXbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 18:31:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C88D720661;
        Thu, 16 Jan 2020 23:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579217461;
        bh=iXjNYfPsujbaV8I/FUUKm6HN4IOhTK91Z7tHbR3EyTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wOIiM7t78T9RFPJgr1skg8GZhsFrCEQoOAB4Buqku4IZAZmo0KDF0zoKGD+4XYzMc
         dCKdCXgfqtg7aRJPVulM7lYMqt042Hlo3KSPGp63iclUwFNhlYwsT6/sKyVATUd2IC
         bs4L9TYSzlGbC6EGQ88DlXXkxNbM68rUHfrbOm/0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 4.19 57/84] tty: serial: imx: use the sg count from dma_map_sg
Date:   Fri, 17 Jan 2020 00:18:31 +0100
Message-Id: <20200116231720.490934190@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200116231713.087649517@linuxfoundation.org>
References: <20200116231713.087649517@linuxfoundation.org>
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
@@ -624,7 +624,7 @@ static void imx_uart_dma_tx(struct imx_p
 		dev_err(dev, "DMA mapping error for TX.\n");
 		return;
 	}
-	desc = dmaengine_prep_slave_sg(chan, sgl, sport->dma_tx_nents,
+	desc = dmaengine_prep_slave_sg(chan, sgl, ret,
 					DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
 	if (!desc) {
 		dma_unmap_sg(dev, sgl, sport->dma_tx_nents,


