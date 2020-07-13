Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15249C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3BB6206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 01:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594602009;
	bh=SoIcAi39IGfR/s566lC9A0LfjtruZp5fuCbVydLzwik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L8uY8LAle2pyV08R8ilqZ++sdgHs11PnsZMHmqYtvHXek5uoTv/lRDtRjuTwiuCWR
	 I2n9IZnEKapNXvnzeYepeM5c/eHUi4dufXxehCmelWAv3s81ozT1ifS0xS643/rqkA
	 ih5ODlCRQiXmzVuyqsD3brv8uHgI0fsN2cCgiYbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGMA77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 20:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:54454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgGMA76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 20:59:58 -0400
Received: from dragon (unknown [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED63E206B6;
        Mon, 13 Jul 2020 00:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594601997;
        bh=SoIcAi39IGfR/s566lC9A0LfjtruZp5fuCbVydLzwik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djk9YZXLbvKAevrfOPOWYZwqqgnCwWVL1uUGl6ExRQ+ydoRIfY4pauMaN8L6ll5yr
         y7FL8nTJRixIuD/R40jvd9iEhv2tbqHnOk1RxgeLVh9li7CVlioRGB/YiUc7M2nwbk
         LIk21PcZoHkqv5ettMLoIi4yzlWkYOUBJOPv/Xnw=
Date:   Mon, 13 Jul 2020 08:59:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Shengjiu Wang <shengjiu.wang@nxp.com>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [RESEND PATCH] ARM: dts: imx6sx-sdb: Add MQS support
Message-ID: <20200713005936.GP21277@dragon>
References: <1594545402-26815-1-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594545402-26815-1-git-send-email-shengjiu.wang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 05:16:42PM +0800, Shengjiu Wang wrote:
> Add MQS support. As the pin conflict with usdhc2, then need
> to add a separate dts.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Applied, thanks.
