Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F766C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 698C820771
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZxgkoOUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727259AbgCRLi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:38:29 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42892 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727112AbgCRLi3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=KeX7i7jjwGyFs685ZA1LZLsXq6Fd8T1pDtpjn4jVKw8=; b=ZxgkoOUgTaYm/6nU/4W74ecjY1
        M3v3Zo9C3eXMkasX1L1fXpg2YPuc9bEdn03t5zOwnHWmBK3/lO7iGwQwNBJsK6xcmFEfWmLrirw89
        Y9DzC7CVLYc8ae0soeUlzGXdU1/iADHpf1Q1TozWljsEuxel4MW1m6qwepeWqd5XOCdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jEX1g-00075r-7y; Wed, 18 Mar 2020 12:38:20 +0100
Date:   Wed, 18 Mar 2020 12:38:20 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Fuzzey, Martin" <martin.fuzzey@flowbird.group>
Cc:     Fugang Duan <fugang.duan@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] dt-bindings: fec: document the new fsl,stop-mode
 property
Message-ID: <20200318113820.GA27205@lunn.ch>
References: <1584463806-15788-1-git-send-email-martin.fuzzey@flowbird.group>
 <1584463806-15788-4-git-send-email-martin.fuzzey@flowbird.group>
 <20200318091734.GA23244@lunn.ch>
 <CANh8QzzA34th-h8ULM=LNvOvRw9P9=vekOBGvdYjv6TEBNDMig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANh8QzzA34th-h8ULM=LNvOvRw9P9=vekOBGvdYjv6TEBNDMig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:28:48AM +0100, Fuzzey, Martin wrote:
> Hi Andrew,
> 
> On Wed, 18 Mar 2020 at 10:17, Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > You should not be putting registers and values into device tree.
> >
> > The regmap is fine. But could you add the register and the bit to
> > fec_devtype[IMX6SX_FEC], fec_devtype[IMX6UL_FEC], etc.
> >
> 
> If that's the consensus I can do it that way.
> 
> But I should point out that there is already a precedent in mainline for this:
> 
> Documentation/devicetree/bindings/net/can/fsl-flexcan.txt

Hi Martin

And there are probably hundreds of emails saying don't do this.

	Andrew
