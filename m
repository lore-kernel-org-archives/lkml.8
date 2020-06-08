Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D37C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF81A2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 14:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2CXriWfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbgFHO5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 10:57:42 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:39612 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgFHO5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pxY+k1EDOGmASjIgfSa3YXyUmL2DqkU4/aox1YMvk6I=; b=2CXriWfrKP1Fl1stlshdbKaz2m
        OfGHmEc7e9keimnc6B1dDuLMA6W2Q3LLtqe0b748WjJw0/OkXJdNpHwFSBUa71VtgqlTzrFh2/AU6
        KcM4j01FXNpS3I0NCGVqADFVUqXE49yVSqMa/bIYOu9G5jtJ3MnjK8wN4LJwtXs/ZvgM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jiJDV-004PYI-4V; Mon, 08 Jun 2020 16:57:37 +0200
Date:   Mon, 8 Jun 2020 16:57:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: ethernet: mvneta: add support for 2.5G DRSGMII mode
Message-ID: <20200608145737.GG1006885@lunn.ch>
References: <20200608074716.9975-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608074716.9975-1-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 09:47:16AM +0200, Sascha Hauer wrote:
> The Marvell MVNETA Ethernet controller supports a 2.5 Gbps SGMII mode
> called DRSGMII.
> 
> This patch adds a corresponding phy-mode string 'drsgmii' and parses it
> from DT. The MVNETA then configures the SERDES protocol value
> accordingly.
> 
> It was successfully tested on a MV78460 connected to a FPGA.

Hi Sascha

Is this really overclocked SGMII, or 2500BaseX? How does it differ
from 2500BaseX, which mvneta already supports?

Also, does comphy need extensions to support this?

      Andrew
