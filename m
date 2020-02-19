Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD803C34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9539424654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:26:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="bQCfHoSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgBSP0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:26:24 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53892 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbgBSP0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:26:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=cYDobEu6rKQswzuKoGHjv5OS328UTQI3LLUGuR+DB4M=; b=bQCfHoSfaVstAxfgjAottRCrX0
        FRjenW1dHoU1vnePbgNfmtIIwyiVb+4IYOwYXrPYIv8XtWDWltthYjdcf7slZG5Si/cU1ij8w1r1N
        OnpWzaO2+P3qiGIoOq++8lonSiL7BH+lxCEn1IuIjYaqMTs/d2LqVUmy0TEBVGJ9A0eA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1j4REs-00010w-My; Wed, 19 Feb 2020 16:26:14 +0100
Date:   Wed, 19 Feb 2020 16:26:14 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next/devicetree 2/5] net: dsa: felix: Use
 PHY_INTERFACE_MODE_INTERNAL instead of GMII
Message-ID: <20200219152614.GB3281@lunn.ch>
References: <20200219151259.14273-1-olteanv@gmail.com>
 <20200219151259.14273-3-olteanv@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219151259.14273-3-olteanv@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 05:12:56PM +0200, Vladimir Oltean wrote:
> From: Vladimir Oltean <vladimir.oltean@nxp.com>
> 
> phy-mode = "gmii" is confusing because it may mean that the port
> supports the 8-bit-wide parallel data interface pinout, which it
> doesn't.
> 
> It may also be confusing because one of the "gmii" internal ports is
> actually overclocked to run at 2.5Gbps (even though, yes, as far as the
> switch MAC is concerned, it still thinks it's gigabit).
> 
> So use the phy-mode = "internal" property to describe the internal ports
> inside the NXP LS1028A chip (the ones facing the ENETC). The change
> should be fine, because the device tree bindings document is yet to be
> introduced, and there are no stable DT blobs in use.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
