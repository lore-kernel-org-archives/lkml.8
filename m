Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C989C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 453162071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 14:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584024125;
	bh=3V+qE2bmVHwG3+3FnGVMnNeT4gbtWXLMegY28bMW1zg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gJLEFb8EWFzU91m67U8SgdEZge8rQO78T64PrRiOko2DG2h3H4ZB9g5EaurNcWI8J
	 0TwHEg+72Rltnk9eECGMmqyJ+yrzaXPTTgoNBLp9afiAivLxXYlFCAMmZCS22IgXO5
	 RwrytHBJpFehooXanmQ1gTQwBDI5iPWyQpDOLw40=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgCLOmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:42:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbgCLOmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 10:42:02 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E51C2071B;
        Thu, 12 Mar 2020 14:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584024122;
        bh=3V+qE2bmVHwG3+3FnGVMnNeT4gbtWXLMegY28bMW1zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jgC1NrhTkMGsvXTSlMZr4SUqqkR6Z2K7ruSHOPy+HXUOJpWt47qnwyRWvVuPQ8VR8
         voHPgnOT9JH+uq7t4y3CR/eUpupi5T3LtWlyG/N84+ctoA4S61UVedJxYOUQ6Z3ziZ
         Ry/CeiriWisbaO9wvsJoQQug289ZhMjFzdvAnwvk=
Date:   Thu, 12 Mar 2020 22:41:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Han Xu <han.xu@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] arm64: dts: enable fspi in imx8mm dts
Message-ID: <20200312144152.GE1249@dragon>
References: <20200306101957.1229406-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306101957.1229406-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:19:57AM -0600, Adam Ford wrote:
> Pull in upstream patch from NXP repo to:
> enable fspi in imx8mm DT file
> 
> Signed-off-by: Han Xu <han.xu@nxp.com>
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied, thanks.
