Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F87CC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511272067C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730343AbgB0Sxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:53:42 -0500
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:47727 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgB0Sxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:53:42 -0500
X-Originating-IP: 90.76.143.236
Received: from localhost (lfbn-tou-1-1075-236.w90-76.abo.wanadoo.fr [90.76.143.236])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id D443EFF804;
        Thu, 27 Feb 2020 18:53:39 +0000 (UTC)
Date:   Thu, 27 Feb 2020 19:53:39 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Quentin Schulz <foss@0leil.net>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        davem@davemloft.net, f.fainelli@gmail.com, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: phy: mscc: implement RGMII skew delay
 configuration
Message-ID: <20200227185339.GD1686232@kwain>
References: <20200227152859.1687119-1-antoine.tenart@bootlin.com>
 <20200227152859.1687119-4-antoine.tenart@bootlin.com>
 <1f267571ddd9d1caf3e95afe31e47e30@0leil.net>
 <20200227162506.GD5245@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200227162506.GD5245@lunn.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 05:25:06PM +0100, Andrew Lunn wrote:
> > Also, do we actually need to write that register only when skews are defined
> > in the DT? Can't we just write to it anyway (I guess the fact that 0_2 skew
> > is actually 0 in value should put me on the right path but I prefer to ask).
> 
> Ideally, you don't want to rely on the boot loader doing some
> magic. So i would prefer the skew is set to 0 if the properties are
> not present.

Will do.

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
