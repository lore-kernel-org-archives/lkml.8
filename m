Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D3EC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE4C2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 12:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583844748;
	bh=hN6a469Tivn8u3TsieBjrDtp/aqNDl1Fq/Mz22z/h+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OqRjGiewwH61AEo6xj8KW3c945/C1dbCxvTgYCQnEeAa46LeMcRT0IfJWFLaaclI4
	 Oj8bhWj+Ir9XRPP2rAoZaHw+cVSCD1GVIWd3ONztvXMlBJ0zhYFvm32ROnVwkmgUHD
	 XOSKCg+9qhVACCYOJ2CxhOkKbteX4QRAUNS+XhbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgCJMw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 08:52:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:57980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729039AbgCJMwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 08:52:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1B2120674;
        Tue, 10 Mar 2020 12:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583844739;
        bh=hN6a469Tivn8u3TsieBjrDtp/aqNDl1Fq/Mz22z/h+0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oohqfemI2TZmaOCoYBag81LyjdZsb7hNy2whuYN6yM77tO5PUfr4NQvlMPrOhuLHS
         1/Dod4PjA1y2U63OlMz01NsSwc179+HGsnCUBxvF+Gv8Z+A2tVEHqtLLcCulJ3S+em
         kVpgW0eDVKg2tQMtgw/rqCYZQ2iCZroFn7L+51Qg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Fuzzey <martin.fuzzey@flowbird.group>,
        Fabio Estevam <festevam@gmail.com>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.4 100/168] dmaengine: imx-sdma: fix context cache
Date:   Tue, 10 Mar 2020 13:39:06 +0100
Message-Id: <20200310123645.512315344@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310123635.322799692@linuxfoundation.org>
References: <20200310123635.322799692@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Fuzzey <martin.fuzzey@flowbird.group>

commit d288bddd8374e0a043ac9dde64a1ae6a09411d74 upstream.

There is a DMA problem with the serial ports on i.MX6.

When the following sequence is performed:

1) Open a port
2) Write some data
3) Close the port
4) Open a *different* port
5) Write some data
6) Close the port

The second write sends nothing and the second close hangs.
If the first close() is omitted it works.

Adding logs to the the UART driver shows that the DMA is being setup but
the callback is never invoked for the second write.

This used to work in 4.19.

Git bisect leads to:
	ad0d92d: "dmaengine: imx-sdma: refine to load context only once"

This commit adds a "context_loaded" flag used to avoid unnecessary context
setups.
However the flag is only reset in sdma_channel_terminate_work(),
which is only invoked in a worker triggered by sdma_terminate_all() IF
there is an active descriptor.

So, if no active descriptor remains when the channel is terminated, the
flag is not reset and, when the channel is later reused the old context
is used.

Fix the problem by always resetting the flag in sdma_free_chan_resources().

Cc: stable@vger.kernel.org
Signed-off-by: Martin Fuzzey <martin.fuzzey@flowbird.group>
Fixes: ad0d92d7ba6a ("dmaengine: imx-sdma: refine to load context only once")
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Link: https://lore.kernel.org/r/1580305274-27274-1-git-send-email-martin.fuzzey@flowbird.group
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/dma/imx-sdma.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1335,6 +1335,7 @@ static void sdma_free_chan_resources(str
 
 	sdmac->event_id0 = 0;
 	sdmac->event_id1 = 0;
+	sdmac->context_loaded = false;
 
 	sdma_set_channel_priority(sdmac, 0);
 


