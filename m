Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750DFC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D522076C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 12:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbgDUM6d convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 08:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728802AbgDUM6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 08:58:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A398C061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 05:58:33 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jQsTt-00059t-Oe; Tue, 21 Apr 2020 14:58:29 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jQsTs-0007Sp-Pl; Tue, 21 Apr 2020 14:58:28 +0200
Date:   Tue, 21 Apr 2020 14:58:28 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     mkl@pengutronix.de, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>, kernel@pengutronix.de,
        netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        David Jander <david@protonic.nl>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: dsa: sja1105: regression after patch: "net: dsa: configure the
 MTU for switch ports"
Message-ID: <20200421125828.jb44qzfzgd7sh436@pengutronix.de>
References: <20200421113324.vxh2lyasylf5kgkz@pengutronix.de>
 <CA+h21ho2YnUfzMja1Y7=B7Yrqk=WD6jm-OoKKzX4uS3WJiU5aw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CA+h21ho2YnUfzMja1Y7=B7Yrqk=WD6jm-OoKKzX4uS3WJiU5aw@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:54:18 up 158 days,  4:12, 168 users,  load average: 0.09, 0.08,
 0.03
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 02:56:37PM +0300, Vladimir Oltean wrote:
> Hi Oleksij,
> 
> On Tue, 21 Apr 2020 at 14:33, Oleksij Rempel <o.rempel@pengutronix.de> wrote:
> >
> > Hi Vladimir,
> >
> > I have a regression after this patch:
> > |commit bfcb813203e619a8960a819bf533ad2a108d8105
> > |Author:     Vladimir Oltean <vladimir.oltean@nxp.com>
> > |
> > |  net: dsa: configure the MTU for switch ports
> >
> > with following log:
> > [    3.044065] sja1105 spi1.0: Probed switch chip: SJA1105Q
> > [    3.071385] sja1105 spi1.0: Enabled switch tagging
> > [    3.076484] sja1105 spi1.0: error -34 setting MTU on port 0
> > [    3.082795] sja1105: probe of spi1.0 failed with error -34
> >
> > this is devicetree snippet for the port 0:
> >         port@0 {
> >                 reg = <0>;
> >                 label = "usb";
> >                 phy-handle = <&usbeth_phy>;
> >                 phy-mode = "rmii";
> >         };
> >
> >
> > Is it know issue?
> >
 
> The code which is causing problems seems to be this one:
> 
>     mtu_limit = min_t(int, master->max_mtu, dev->max_mtu);
>     old_master_mtu = master->mtu;
>     new_master_mtu = largest_mtu + cpu_dp->tag_ops->overhead;
>     if (new_master_mtu > mtu_limit)
>         return -ERANGE;
> 
> called from
> 
>     rtnl_lock();
>     ret = dsa_slave_change_mtu(slave_dev, ETH_DATA_LEN);
>     rtnl_unlock();
>     if (ret && ret != -EOPNOTSUPP) {
>         dev_err(ds->dev, "error %d setting MTU on port %d\n",
>             ret, port->index);
>         goto out_free;
>     }
> 
> Before this patch, it was silently failing, now it's preventing the
> probing of the ports which I might agree with you is not better.
> Andrew warned about this, and I guess that during probe, we should
> warn but ignore any nonzero return code, not just EOPNOTSUPP. I'll
> send a patch out shortly to correct this.
> 
> Out of curiosity, what DSA master port do you have? Does it not
> support an MTU of 1504 bytes? Does MTU-sized traffic pass correctly
> through your interface? (you can test with iperf3)

It is FEC@iMX6QP attached to the port 4 of the sja1105 switch.
I'll try to make some tests tomorrow.

Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
