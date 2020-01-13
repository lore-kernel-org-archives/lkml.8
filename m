Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD302C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADE9214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgAMPMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:12:34 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:40047 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgAMPMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:12:34 -0500
X-Originating-IP: 90.76.211.102
Received: from localhost (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: antoine.tenart@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C550C1BF213;
        Mon, 13 Jan 2020 15:12:31 +0000 (UTC)
Date:   Mon, 13 Jan 2020 16:12:31 +0100
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>, davem@davemloft.net,
        sd@queasysnail.net, andrew@lunn.ch, f.fainelli@gmail.com,
        hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        alexandre.belloni@bootlin.com, allan.nielsen@microchip.com,
        camelia.groza@nxp.com, Simon.Edelhaus@aquantia.com,
        Igor.Russkikh@aquantia.com, jakub.kicinski@netronome.com
Subject: Re: [PATCH net-next v5 02/15] net: macsec: introduce the
 macsec_context structure
Message-ID: <20200113151231.GD3078@kwain>
References: <20200110162010.338611-1-antoine.tenart@bootlin.com>
 <20200110162010.338611-3-antoine.tenart@bootlin.com>
 <20200113143956.GB2131@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113143956.GB2131@nanopsycho>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 03:39:56PM +0100, Jiri Pirko wrote:
> Fri, Jan 10, 2020 at 05:19:57PM CET, antoine.tenart@bootlin.com wrote:
> 
> >diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
> >index 1d69f637c5d6..024af2d1d0af 100644
> >--- a/include/uapi/linux/if_link.h
> >+++ b/include/uapi/linux/if_link.h
> >@@ -486,6 +486,13 @@ enum macsec_validation_type {
> > 	MACSEC_VALIDATE_MAX = __MACSEC_VALIDATE_END - 1,
> > };
> > 
> >+enum macsec_offload {
> >+	MACSEC_OFFLOAD_OFF = 0,
> >+	MACSEC_OFFLOAD_PHY = 1,
> 
> No need to assign 0, 1 here. That is given.

Right, however MACSEC_VALIDATE_ uses the same notation. I think it's
nice to be consistent, but of course of patch can be sent to convert
both of those enums.

> >+	__MACSEC_OFFLOAD_END,
> >+	MACSEC_OFFLOAD_MAX = __MACSEC_OFFLOAD_END - 1,
> >+};
> >+
> > /* IPVLAN section */
> > enum {
> > 	IFLA_IPVLAN_UNSPEC,
> >diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
> >index 8aec8769d944..42efdb84d189 100644
> >--- a/tools/include/uapi/linux/if_link.h
> >+++ b/tools/include/uapi/linux/if_link.h
> 
> Why you are adding to this header?

Because the two headers are synced.

Thanks,
Antoine

-- 
Antoine Ténart, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
