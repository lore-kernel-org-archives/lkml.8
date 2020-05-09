Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96B5C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92ED121775
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CPtZJNRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgEINOq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:14:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37313 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726891AbgEINOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589030084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fXszUZPGL30pBHLQXJciSiK0fXjuwaWRz9TKtjnhSaw=;
        b=CPtZJNRX7ShXyFAVK5/r0kU4xnzKpK5YIvTmqF0lHRiehpN+3/duCyBtChcyUleXAOu0in
        934hj001LVxJYTPXgh+Gy2WagBW+AV2Nxbf3Nbw9dUMgAV3ccg7RdylmGpe85l9BNBmPye
        sAPZdNyLgLdnfe+GOH2/wgNwZqgiETU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-121-BFQKUe0nMrKskE98CWEDmQ-1; Sat, 09 May 2020 09:14:43 -0400
X-MC-Unique: BFQKUe0nMrKskE98CWEDmQ-1
Received: by mail-ed1-f71.google.com with SMTP id b24so1717064edx.22
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 06:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fXszUZPGL30pBHLQXJciSiK0fXjuwaWRz9TKtjnhSaw=;
        b=iujFQS2zfBNgppOc6NUE16gsJK2kYnlD63srnxDWTWeI9TY2j9c3adQyAwmUU9jhSp
         ACPbionEeIRuld19BbtK8syQ4wU7BUvJMi8X+hhtFcJ9F+SyQ70XCjGUh5EAp3hjnS17
         6I1XN4mylqn1uhggpuMk/WSB1FPuRUxYdW9PKdSr2FVAdrpAN+NdarOojjCjakomRs2a
         VS8WrDGOfgU6j6l3Sq3IDIa0FlxdRJKnwVLvsmB+spiT1FAME3pR7DJbQw/zdyU76pkN
         jyI0SZwMLs0EIt86jVDZwJ10na2+FPbNd+1tvuUDsF5Hc5js9dTWEx1elz16jsKM8amm
         fnlg==
X-Gm-Message-State: AGi0Pubuu68FXaTqSWca0VutPiK3dWkxV8negm9bbzvCuXibvP04DNgG
        QX1tx3Eq4rnu+4DqLT+YasEI8qFSuslnZc57OXSrKmi9Gnj5Pu8JeTVomQobaQ+qKjS68qIAynd
        9HlSRV2LUQsdtajUikzwVQ24FNCF594hrwjPhTc1R
X-Received: by 2002:a05:6402:b2a:: with SMTP id bo10mr6360494edb.366.1589030082242;
        Sat, 09 May 2020 06:14:42 -0700 (PDT)
X-Google-Smtp-Source: APiQypJTOew0BzTLx2lykLc6ZnwAhULmTxRo4EBF7kA/EDNp3Rtkx/81lrJt/Ty1aqhmM7gm8iaduhfmnd2Vfy0rnYA=
X-Received: by 2002:a05:6402:b2a:: with SMTP id bo10mr6360472edb.366.1589030081918;
 Sat, 09 May 2020 06:14:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190524100554.8606-1-maxime.chevallier@bootlin.com>
 <20190524100554.8606-4-maxime.chevallier@bootlin.com> <CAGnkfhzsx_uEPkZQC-_-_NamTigD8J0WgcDioqMLSHVFa3V6GQ@mail.gmail.com>
 <20200423170003.GT25745@shell.armlinux.org.uk> <CAGnkfhwOavaeUjcm4_+TG-xLxQA519o+fR8hxBCCfSy3qpcYhQ@mail.gmail.com>
 <DM5PR18MB1146686527DE66495F75D0DAB0A30@DM5PR18MB1146.namprd18.prod.outlook.com>
 <20200509114518.GB1551@shell.armlinux.org.uk>
In-Reply-To: <20200509114518.GB1551@shell.armlinux.org.uk>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sat, 9 May 2020 15:14:05 +0200
Message-ID: <CAGnkfhx8fEZCoLPzGxSzQnj1ZWcQtBMn+g_jO1Jxc4zF7pQwjQ@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH net-next 3/5] net: mvpp2: cls: Use RSS contexts
 to handle RSS tables
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Stefan Chulski <stefanc@marvell.com>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 1:45 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sat, May 09, 2020 at 11:15:58AM +0000, Stefan Chulski wrote:
> >
> >
> > > -----Original Message-----
> > > From: Matteo Croce <mcroce@redhat.com>
> > > Sent: Saturday, May 9, 2020 3:13 AM
> > > To: David S . Miller <davem@davemloft.net>
> > > Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>; netdev
> > > <netdev@vger.kernel.org>; LKML <linux-kernel@vger.kernel.org>; Antoine
> > > Tenart <antoine.tenart@bootlin.com>; Thomas Petazzoni
> > > <thomas.petazzoni@bootlin.com>; gregory.clement@bootlin.com;
> > > miquel.raynal@bootlin.com; Nadav Haklai <nadavh@marvell.com>; Stefan
> > > Chulski <stefanc@marvell.com>; Marcin Wojtas <mw@semihalf.com>; Linux
> > > ARM <linux-arm-kernel@lists.infradead.org>; Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk>
> > > Subject: [EXT] Re: [PATCH net-next 3/5] net: mvpp2: cls: Use RSS contexts to
> > > handle RSS tables
> > >
> > > Hi,
> > >
> > > What do you think about temporarily disabling it like this?
> > >
> > > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > > @@ -5775,7 +5775,8 @@ static int mvpp2_port_probe(struct platform_device
> > > *pdev,
> > >                             NETIF_F_HW_VLAN_CTAG_FILTER;
> > >
> > >         if (mvpp22_rss_is_supported()) {
> > > -               dev->hw_features |= NETIF_F_RXHASH;
> > > +               if (port->phy_interface != PHY_INTERFACE_MODE_SGMII)
> > > +                       dev->hw_features |= NETIF_F_RXHASH;
> > >                 dev->features |= NETIF_F_NTUPLE;
> > >         }
> > >
> > >
> > > David, is this "workaround" too bad to get accepted?
> >
> > Not sure that RSS related to physical interface(SGMII), better just remove NETIF_F_RXHASH as "workaround".
>
> Hmm, I'm not sure this is the right way forward.  This patch has the
> effect of disabling:
>
> d33ec4525007 ("net: mvpp2: add an RSS classification step for each flow")
>
> but the commit you're pointing at which caused the regression is:
>
> 895586d5dc32 ("net: mvpp2: cls: Use RSS contexts to handle RSS tables")
>
>

Hi,

When git bisect pointed to 895586d5dc32 ("net: mvpp2: cls: Use RSS
contexts to handle RSS tables"), which was merged
almost an year after d33ec4525007 ("net: mvpp2: add an RSS
classification step for each flow"), so I assume that between these
two commits either the feature was working or it was disable and we
didn't notice

Without knowing what was happening, which commit should my Fixes tag point to?

Regards,
-- 
Matteo Croce
per aspera ad upstream

