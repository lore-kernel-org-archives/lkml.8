Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73359C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 491B321655
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 12:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IENZUijm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgEIMRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 08:17:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35376 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728392AbgEIMRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 08:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589026620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H76Mksznw95btvUBSKx6gefc+t9SRkpD4GR2A1wMEWw=;
        b=IENZUijmoG3eopQ3p6xt24H7EezbJ+57h+6P+Qpl3TwQ+HCqziTsZIdGHCsqJQ5B+KxfsH
        0MdVjyHn2uhdns1/ei7SamlLH64QdOTdZyxym9JGVHLoNmTAVu2y8WyeRW7olkvnPMnxdl
        pVaMgDetv1ueRDLd58TM8cnKWvZ8q2o=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-NBq6ZrjiN12jZy9RB8Y6qQ-1; Sat, 09 May 2020 08:16:57 -0400
X-MC-Unique: NBq6ZrjiN12jZy9RB8Y6qQ-1
Received: by mail-ej1-f71.google.com with SMTP id cb22so1874366ejb.12
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 05:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H76Mksznw95btvUBSKx6gefc+t9SRkpD4GR2A1wMEWw=;
        b=SJ+/24rGYT8oXWYlVLH5DfnBBQ/1urJVOL1hf1w6KccGQtfZVhhWnHbiCf9FSmq16c
         HRzTo//1g3dvs1jozfd/1yk5uNYgTCmunWTTwkM9hE8f8be+NLMt7x4B0EJEka3OUfV4
         AmrjjOC+yTnNc1PPpehaBbq+XUJjGHp3cyPAvtkUfXctGccPd6os0GJtlmAtSK3N7bgp
         MGz2m/Nkv28jMp41ipiGf6GHzkP0t9b6RZCB09rfwWHgoQlIEmHQCsrjt5zQxcWXvIOn
         T5OrxTzwqrSC0BTNjWnJadB/abNxUz3WrUA4zejCqnvhlfYF0fgLFmnOZa0XJxMQ2ed5
         rSlg==
X-Gm-Message-State: AGi0PuZH0iketywvFi1aUtNpaiYTIwQ04TfJmYZsffOPlBxCu8QRiI1s
        VCuus3RI1RyUiqNZgzgFgDGbavFtLfeIGRrNN19+PwpL47sR/Xgq9uvXEsnXtmQdj/GHePvRwFB
        2V0oOVsvCn2wDKCaWSPvJG4b/b1aP6cYibWJPZTck
X-Received: by 2002:a17:906:3584:: with SMTP id o4mr5983542ejb.70.1589026616219;
        Sat, 09 May 2020 05:16:56 -0700 (PDT)
X-Google-Smtp-Source: APiQypI1UXFBpEK1GTG9DqxWl2WPCdbZuNHFa+X/9FasNbc4VjLFflOlGIHoBd2LBjBaMDinS7oLti41vflUZ4eTHZc=
X-Received: by 2002:a17:906:3584:: with SMTP id o4mr5983519ejb.70.1589026615896;
 Sat, 09 May 2020 05:16:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190524100554.8606-1-maxime.chevallier@bootlin.com>
 <20190524100554.8606-4-maxime.chevallier@bootlin.com> <CAGnkfhzsx_uEPkZQC-_-_NamTigD8J0WgcDioqMLSHVFa3V6GQ@mail.gmail.com>
 <20200423170003.GT25745@shell.armlinux.org.uk> <CAGnkfhwOavaeUjcm4_+TG-xLxQA519o+fR8hxBCCfSy3qpcYhQ@mail.gmail.com>
 <DM5PR18MB1146686527DE66495F75D0DAB0A30@DM5PR18MB1146.namprd18.prod.outlook.com>
In-Reply-To: <DM5PR18MB1146686527DE66495F75D0DAB0A30@DM5PR18MB1146.namprd18.prod.outlook.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Sat, 9 May 2020 14:16:19 +0200
Message-ID: <CAGnkfhwV4YyR9f1KC8VFx4FPRYkAoXXUURa715wb3+=23=rr6Q@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH net-next 3/5] net: mvpp2: cls: Use RSS contexts
 to handle RSS tables
To:     Stefan Chulski <stefanc@marvell.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 1:16 PM Stefan Chulski <stefanc@marvell.com> wrote:
> > Hi,
> >
> > What do you think about temporarily disabling it like this?
> >
> > --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
> > @@ -5775,7 +5775,8 @@ static int mvpp2_port_probe(struct platform_device
> > *pdev,
> >                             NETIF_F_HW_VLAN_CTAG_FILTER;
> >
> >         if (mvpp22_rss_is_supported()) {
> > -               dev->hw_features |= NETIF_F_RXHASH;
> > +               if (port->phy_interface != PHY_INTERFACE_MODE_SGMII)
> > +                       dev->hw_features |= NETIF_F_RXHASH;
> >                 dev->features |= NETIF_F_NTUPLE;
> >         }
> >
> >
> > David, is this "workaround" too bad to get accepted?
>
> Not sure that RSS related to physical interface(SGMII), better just remove NETIF_F_RXHASH as "workaround".
>
> Stefan.

Hi,

The point is that RXHASH works fine on all interfaces, but on the
gigabit one (eth2 usually).
And on the 10 gbit interface is very very effective, the throughput
goes 4x when enabled, so it would be a big drawback to disable it on
all interfaces.

Honestly I don't have any 2.5 gbit hardware to test it on eth3, so I
don't know if rxhash actually only works on the first interface of a
unit (so eth0 and eth1),
or if it just doesn't work on the gigabit one.

If someone could test it on the 2.5 gbit port, this will be helpful.

Regards,
-- 
Matteo Croce
per aspera ad upstream

