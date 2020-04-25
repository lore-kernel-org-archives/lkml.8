Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BC5C55186
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C7F20704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 10:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="csoyJfuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgDYK26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 06:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726050AbgDYK25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 06:28:57 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025E7C09B04A;
        Sat, 25 Apr 2020 03:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Pp1luny5nhZVX/a/szwM3I/s1d+y287YsSRFfWcwXHk=; b=csoyJfuqvyh99AsTN/1EwaJhH
        Ip+4lR35nPAGIROfCklCQhE4hdORYTHa4SThXvp90RWaQ+wRng9/DKbJOui2HFpAAtkRnMzQTxUJ1
        fwoLQbQr82qiWsE5pxJoQIRKbS7fM85n6+wk/semvn/RoYI1Bgv720JbJu+OWlOcPbV/GoaM1W5H+
        j/kmmXzTluqHMXX3c6Hb1tTfDzrWnBr2CJdfFinZdftfNihNmrad+sFEQ/EqdcJIvZ/5EBms+3zZR
        9NIDywP7sxUzrrQg8uSzfCTT+eZ36ldd9QQ3GgjbL3wojXcV3FwYGrjBpvx4vmTOHTEI3MKUAdLjs
        mdDDL5mfA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:43514)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jSI3G-00023N-Cq; Sat, 25 Apr 2020 11:28:50 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jSI3F-0004X1-B6; Sat, 25 Apr 2020 11:28:49 +0100
Date:   Sat, 25 Apr 2020 11:28:49 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Florinel Iordache <florinel.iordache@nxp.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, kuba@kernel.org,
        corbet@lwn.net, shawnguo@kernel.org, leoyang.li@nxp.com,
        madalin.bucur@oss.nxp.com, ioana.ciornei@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/9] doc: net: add backplane documentation
Message-ID: <20200425102849.GX25745@shell.armlinux.org.uk>
References: <1587732391-3374-1-git-send-email-florinel.iordache@nxp.com>
 <1587732391-3374-2-git-send-email-florinel.iordache@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587732391-3374-2-git-send-email-florinel.iordache@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 03:46:23PM +0300, Florinel Iordache wrote:
> +Supported platforms
> +===================
> +
> +Ethernet Backplane is enabled on the following platforms:
> +
> +LS1046A
> +LS1088A
> +LS2088A
> +LX2160A
> \ No newline at end of file

Please fix.

> diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
> index 2561060..1f1ebf2 100644
> --- a/Documentation/networking/phy.rst
> +++ b/Documentation/networking/phy.rst
> @@ -279,13 +279,22 @@ Some of the interface modes are described below:
>      XFI and SFI are not PHY interface types in their own right.
>  
>  ``PHY_INTERFACE_MODE_10GKR``
> -    This is the IEEE 802.3 Clause 49 defined 10GBASE-R with Clause 73
> -    autonegotiation. Please refer to the IEEE standard for further
> -    information.
> +    This is 10G Ethernet Backplane over single lane specified in
> +    IEEE802.3ap-2007 Amendment 4: Ethernet Operation over Electrical
> +    Backplanes which includes the new Clause 69 through Clause 74
> +    including autonegotiation. 10GKR uses the same physical layer
> +    encoding as 10GBASE-R defined in IEEE802.3 Clause 49. Please refer
> +    to the IEEE standard for further information.
>  
>      Note: due to legacy usage, some 10GBASE-R usage incorrectly makes
>      use of this definition.
>  
> +``PHY_INTERFACE_MODE_40GKR4``
> +    This is 40G Ethernet Backplane over 4-lanes using the same main
> +    standard used for Ethernet Operation over Electrical Backplanes
> +    and additional specifications that define support for Ethernet
> +    Backplane over 4-lanes specified in IEEE802.3ba-2010.
> +
>  Pause frames / flow control
>  ===========================
>  

This ought to be in patch 3.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
