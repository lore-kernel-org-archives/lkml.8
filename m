Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C53C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0234246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pHKS2LPs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgB0Pvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:51:32 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:37094 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729110AbgB0Pvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=PJMxTNoqIVqJE/l6fDq02lnZnaiad/GE41foM1ix9NU=; b=pHKS2LPsI94CzZGylwQdDUsG3U
        kRi2/Drb3SGtFq5ucegzT20FXjFhIQMD3dYZuJ6iV+2UShi6dE0PK4nJvCG/W4z+tJ81Um8wjsHCY
        g5UYo6MDNP5XSv3LUryv6BsD4zp0APXoV9nSqPEcg6Ud75NBGyaLTLAv8IhHqxrbRVHE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1j7LRg-0005vX-JR; Thu, 27 Feb 2020 16:51:28 +0100
Date:   Thu, 27 Feb 2020 16:51:28 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        foss@0leil.net
Subject: Re: [PATCH net-next 3/3] net: phy: mscc: implement RGMII skew delay
 configuration
Message-ID: <20200227155128.GB5245@lunn.ch>
References: <20200227152859.1687119-1-antoine.tenart@bootlin.com>
 <20200227152859.1687119-4-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227152859.1687119-4-antoine.tenart@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 04:28:59PM +0100, Antoine Tenart wrote:
> This patch adds support for configuring the RGMII skews in Rx and Tx
> thanks to properties defined in the device tree.

Hi Antoine

What you are not handling here in this patchset is the four RGMII
modes, and what they mean in terms of delay:

        PHY_INTERFACE_MODE_RGMII,
        PHY_INTERFACE_MODE_RGMII_ID,
        PHY_INTERFACE_MODE_RGMII_RXID,
        PHY_INTERFACE_MODE_RGMII_TXID,

The PHY driver should be adding delays based on these
values. Generally, that is enough to make the link work. You only need
additional skew in DT when you need finer grain control than what
these provide.

      Andrew
