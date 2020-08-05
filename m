Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0DAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 14:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACE521D95
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 14:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgHEO2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 10:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgHEMfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 08:35:39 -0400
X-Greylist: delayed 3285 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 Aug 2020 04:39:24 PDT
Received: from smtp.tuxdriver.com (tunnel92311-pt.tunnel.tserv13.ash1.ipv6.he.net [IPv6:2001:470:7:9c9::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E36FDC034603;
        Wed,  5 Aug 2020 04:39:20 -0700 (PDT)
Received: from [2605:a601:a627:ca00:664d:4b4b:674f:5257] (helo=localhost)
        by smtp.tuxdriver.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.63)
        (envelope-from <nhorman@tuxdriver.com>)
        id 1k3Gu7-0002qe-90; Wed, 05 Aug 2020 06:44:16 -0400
Date:   Wed, 5 Aug 2020 06:44:09 -0400
From:   Neil Horman <nhorman@localhost.localdomain>
To:     David Miller <davem@davemloft.net>
Cc:     izabela.bakollari@gmail.com, nhorman@tuxdriver.com,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCHv2 net-next] dropwatch: Support monitoring of dropped
 frames
Message-ID: <20200805104409.GA118086@localhost.localdomain>
References: <20200707171515.110818-1-izabela.bakollari@gmail.com>
 <20200804160908.46193-1-izabela.bakollari@gmail.com>
 <20200804.161414.149428114422381017.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804.161414.149428114422381017.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 04:14:14PM -0700, David Miller wrote:
> From: izabela.bakollari@gmail.com
> Date: Tue,  4 Aug 2020 18:09:08 +0200
> 
> > @@ -1315,6 +1334,53 @@ static int net_dm_cmd_trace(struct sk_buff *skb,
> >  	return -EOPNOTSUPP;
> >  }
> >  
> > +static int net_dm_interface_start(struct net *net, const char *ifname)
> > +{
> > +	struct net_device *nd = dev_get_by_name(net, ifname);
> > +
> > +	if (nd)
> > +		interface = nd;
> > +	else
> > +		return -ENODEV;
> > +
> > +	return 0;
> > +}
> > +
> > +static int net_dm_interface_stop(struct net *net, const char *ifname)
> > +{
> > +	dev_put(interface);
> > +	interface = NULL;
> > +
> > +	return 0;
> > +}
> 
> Where is the netdev notifier that will drop this reference if the network
> device is unregistered?
> 
See the changes to dropmon_net_event in the patch.  Its there under the case for
NETDEV_UNREGISTER

Neil
