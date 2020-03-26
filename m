Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD877C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D94620722
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:29:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728839AbgCZU3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:29:22 -0400
Received: from smtprelay0050.hostedemail.com ([216.40.44.50]:59896 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726363AbgCZU3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:29:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5365518033D30;
        Thu, 26 Mar 2020 20:29:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bells46_513c0c0a8540a
X-Filterd-Recvd-Size: 2293
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 26 Mar 2020 20:29:18 +0000 (UTC)
Message-ID: <bc4056226b76834aa3fc52cce2d96855afa2c440.camel@perches.com>
Subject: Re: [PATCH net-next 7/9] net: phy: enable qoriq backplane support
From:   Joe Perches <joe@perches.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     florinel.iordache@nxp.com, davem@davemloft.net,
        netdev@vger.kernel.org, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, kuba@kernel.org, corbet@lwn.net,
        shawnguo@kernel.org, leoyang.li@nxp.com, madalin.bucur@oss.nxp.com,
        ioana.ciornei@nxp.com, linux-kernel@vger.kernel.org
Date:   Thu, 26 Mar 2020 13:27:26 -0700
In-Reply-To: <20200326201310.GB11004@lunn.ch>
References: <1585230682-24417-1-git-send-email-florinel.iordache@nxp.com>
         <1585230682-24417-8-git-send-email-florinel.iordache@nxp.com>
         <ba3b1a69496eb08cb071dace96fd385ff8f838e7.camel@perches.com>
         <20200326201310.GB11004@lunn.ch>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-26 at 21:13 +0100, Andrew Lunn wrote:
> > > +static int qoriq_backplane_config_init(struct phy_device *bpphy)
> > > +{
> > []
> > > +	for (i = 0; i < bp_phy->num_lanes; i++) {
> > []
> > > +		ret = of_address_to_resource(lane_node, 0, &res);
> > > +		if (ret) {
> > > +			bpdev_err(bpphy,
> > > +				  "could not obtain lane memory map for index=%d, ret = %d\n",
> > > +				  i, ret);
> > > +			return ret;
> > 
> > This could use the new vsprintf %pe extension:
> 
> Hi Joe

Hello Andrew.

> Probably a FAQ. But is there plans to extend vsprintf to take an int
> errno value, rather than having to do this ugly ERR_PTR(ret) every
> time? Format string %de ?

Uwe Kleine-König proposed one a couple times.

https://lkml.org/lkml/2019/8/27/1456

Though I believe one %<type><extra> extension mechanism
in vsprintf is enough.  At least the %p<foo> use is
unlikely to ever have desired but dropped output after
an output of %p.  It seems less true for %[diux].




