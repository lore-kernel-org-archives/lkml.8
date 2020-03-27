Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525CEC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 297322073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 14:22:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="P04eDa8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbgC0OWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 10:22:54 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:34046 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbgC0OWx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 10:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U0es5eCjPHafmknYI44UIritcApZVL6ufHPKfH3LHp8=; b=P04eDa8uV9VPNA/3xDFaHSp7lu
        PTChCW80xpzV6lIYT1iZfFj2B4jFIt5iRbfawNZSgHYK1l2bIRJQgP0ktBL/Tf9so2gmFp6xazFee
        kRIRD6dSvVtcDK6pjzZmXw3K7HrUK3rGXWYJ6FAMgSVulG/K0G5QgFVSrtgfn6r4I32s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jHpsj-0002C9-4p; Fri, 27 Mar 2020 15:22:45 +0100
Date:   Fri, 27 Mar 2020 15:22:45 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florinel Iordache <florinel.iordache@nxp.com>
Cc:     davem@davemloft.net, netdev@vger.kernel.org, f.fainelli@gmail.com,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, kuba@kernel.org,
        corbet@lwn.net, shawnguo@kernel.org, leoyang.li@nxp.com,
        madalin.bucur@oss.nxp.com, ioana.ciornei@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/9] net: phy: add backplane kr driver support
Message-ID: <20200327142245.GF11004@lunn.ch>
References: <1585230682-24417-1-git-send-email-florinel.iordache@nxp.com>
 <1585230682-24417-7-git-send-email-florinel.iordache@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585230682-24417-7-git-send-email-florinel.iordache@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +/* Backplane custom logging */
> +#define BPDEV_LOG(name) \
> +	char log_buffer[LOG_BUFFER_SIZE]; \
> +	va_list args; va_start(args, msg); \
> +	vsnprintf(log_buffer, LOG_BUFFER_SIZE - 1, msg, args); \
> +	if (!bpphy->attached_dev) \
> +		dev_##name(&bpphy->mdio.dev, log_buffer); \
> +	else \
> +		dev_##name(&bpphy->mdio.dev, "%s: %s", \
> +			netdev_name(bpphy->attached_dev), log_buffer); \
> +	va_end(args)

> +void bpdev_err(struct phy_device *bpphy, char *msg, ...)
> +{
> +	BPDEV_LOG(err);
> +}
> +EXPORT_SYMBOL(bpdev_err);
> +
> +void bpdev_warn(struct phy_device *bpphy, char *msg, ...)
> +{
> +	BPDEV_LOG(warn);
> +}
> +EXPORT_SYMBOL(bpdev_warn);
> +
> +void bpdev_info(struct phy_device *bpphy, char *msg, ...)
> +{
> +	BPDEV_LOG(info);
> +}
> +EXPORT_SYMBOL(bpdev_info);
> +
> +void bpdev_dbg(struct phy_device *bpphy, char *msg, ...)
> +{
> +	BPDEV_LOG(dbg);
> +}
> +EXPORT_SYMBOL(bpdev_dbg);

You are currently modelling this as a phydev. So please just use
phydev_err(), phydev_info(), phydev_dbg() etc.

Also, if you look at other PHY code, struct phy_device * is nearly
always called phydev. Please try to be consistent with the existing
code base.

     Andrew
