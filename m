Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB98DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4CA0206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WLNGyhE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgESKGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:06:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29553 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728632AbgESKGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589882759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i7Pb0OijTA+irttwxC+dxELBnYCuz9NJOuNYknbTw1Q=;
        b=WLNGyhE59TAn+NOIB3tfIp1NHP6D6qhXpXRogSNh2raDSZe+ImnAtCoZf5Wb0PyScLdoV8
        E5oM/Jfx84pRPBj+O1G6XbsN2uqYMw5Oo+gO3RetgIZlOUcCpgblV3r0uteTyE2HEkb00j
        JwJKnE5t/XfRwUCAYAzFHaNnlc3yRnA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-hjiB7Y2jM-2xfzB52wTqnw-1; Tue, 19 May 2020 06:05:58 -0400
X-MC-Unique: hjiB7Y2jM-2xfzB52wTqnw-1
Received: by mail-ej1-f72.google.com with SMTP id h6so1829159ejb.17
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7Pb0OijTA+irttwxC+dxELBnYCuz9NJOuNYknbTw1Q=;
        b=tppXz77sBxDGi6mC4l00BtvkToru9aEtsLIOb5g1YqQlg0oRWpHu0rG10hrG6SCqHV
         1dyY8W++CGb2xWIjhtEuo6+k+KCbbTsbxGQKOFGuix8ThgV4edU419qmz94EFlNpWRKo
         qZ4a5BlEPszjIudlbzXhFx5bb+XjYjFgtfdKyWOR17VW7XWCWD+U2r7hj+0Pks25gdAY
         eJExOQGIclFXBZqJDqcab/GYqeW7c2dY2EyUKUxm7eRXXsZrO0DhE2ESHGRLgYLggUg9
         JWUD0cM/76U80fR8Q51LaF3Vh09qfWjJfU7U3Ze8bO7QKsBZtFQEtTSzW+BeMzN+WEyB
         vbsw==
X-Gm-Message-State: AOAM531tdO9t+S4UxUncWiFTjYA8VEAJq0FNABGPESYKU71ITG0Wr4VD
        fr4hF+yx5E/Z+osxFMrSruLPUOELGnGW3cF4bPok7z9kdMQiO2IQJzmrDOBbgWMUQx46I8G2+M8
        SkkkbXonHbm7F9yEPYS1aRi8ySFZYBblkpOPWc8Rk
X-Received: by 2002:a17:906:2503:: with SMTP id i3mr17354033ejb.293.1589882756924;
        Tue, 19 May 2020 03:05:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ1McJxtcCmjVmosQ2avZ2PtCSSDCXz2Om0hD2da3gdN7fS7o6Mf8E32HG29p7gwidi7B2T3qwUaeoW85+L6Q=
X-Received: by 2002:a17:906:2503:: with SMTP id i3mr17354012ejb.293.1589882756498;
 Tue, 19 May 2020 03:05:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190524100554.8606-1-maxime.chevallier@bootlin.com>
 <20190524100554.8606-4-maxime.chevallier@bootlin.com> <CAGnkfhzsx_uEPkZQC-_-_NamTigD8J0WgcDioqMLSHVFa3V6GQ@mail.gmail.com>
 <20200423170003.GT25745@shell.armlinux.org.uk> <CAGnkfhwOavaeUjcm4_+TG-xLxQA519o+fR8hxBCCfSy3qpcYhQ@mail.gmail.com>
 <DM5PR18MB1146686527DE66495F75D0DAB0A30@DM5PR18MB1146.namprd18.prod.outlook.com>
 <20200509114518.GB1551@shell.armlinux.org.uk> <CAGnkfhx8fEZCoLPzGxSzQnj1ZWcQtBMn+g_jO1Jxc4zF7pQwjQ@mail.gmail.com>
 <20200509195246.GJ1551@shell.armlinux.org.uk> <20200509202050.GK1551@shell.armlinux.org.uk>
 <20200519095330.GA1551@shell.armlinux.org.uk>
In-Reply-To: <20200519095330.GA1551@shell.armlinux.org.uk>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 19 May 2020 12:05:20 +0200
Message-ID: <CAGnkfhzuyxJDo-DXPHPiNtP4RbRpry+3M9eoiTknGR0zvgPuoA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH net-next 3/5] net: mvpp2: cls: Use RSS contexts
 to handle RSS tables
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev <netdev@vger.kernel.org>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        "David S . Miller" <davem@davemloft.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:54 AM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Sat, May 09, 2020 at 09:20:50PM +0100, Russell King - ARM Linux admin wrote:
> > On Sat, May 09, 2020 at 08:52:46PM +0100, Russell King - ARM Linux admin wrote:
> > > It is highly likely that 895586d5dc32 is responsible for this breakage.
> > > I've been investigating this afternoon, and what I've found, comparing
> > > a kernel without 895586d5dc32 and with 895586d5dc32 applied is:
> > >
> > > - The table programmed into the hardware via mvpp22_rss_fill_table()
> > >   appears to be identical with or without the commit.
> > >
> > > - When rxhash is enabled on eth2, mvpp2_rss_port_c2_enable() reports
> > >   that c2.attr[0] and c2.attr[2] are written back containing:
> > >
> > >    - with 895586d5dc32, failing:    00200000 40000000
> > >    - without 895586d5dc32, working: 04000000 40000000
> > >
> > > - When disabling rxhash, c2.attr[0] and c2.attr[2] are written back as:
> > >
> > >    04000000 00000000
> > >
> > > The second value represents the MVPP22_CLS_C2_ATTR2_RSS_EN bit, the
> > > first value is the queue number, which comprises two fields.  The high
> > > 5 bits are 24:29 and the low three are 21:23 inclusive.  This comes
> > > from:
> > >
> > >        c2.attr[0] = MVPP22_CLS_C2_ATTR0_QHIGH(qh) |
> > >                      MVPP22_CLS_C2_ATTR0_QLOW(ql);
> > > #define     MVPP22_CLS_C2_ATTR0_QHIGH(qh)       (((qh) & 0x1f) << 24)
> > > #define     MVPP22_CLS_C2_ATTR0_QLOW(ql)        (((ql) & 0x7) << 21)
> > >
> > > So, the working case gives eth2 a queue id of 4.0, or 32 as per
> > > port->first_rxq, and the non-working case a queue id of 0.1, or 1.
> > >
> > > The allocation of queue IDs seems to be in mvpp2_port_probe():
> > >
> > >         if (priv->hw_version == MVPP21)
> > >                 port->first_rxq = port->id * port->nrxqs;
> > >         else
> > >                 port->first_rxq = port->id * priv->max_port_rxqs;
> > >
> > > Where:
> > >
> > >         if (priv->hw_version == MVPP21)
> > >                 priv->max_port_rxqs = 8;
> > >         else
> > >                 priv->max_port_rxqs = 32;
> > >
> > > Making the port 0 (eth0 / eth1) have port->first_rxq = 0, and port 1
> > > (eth2) be 32.  It seems the idea is that the first 32 queues belong to
> > > port 0, the second 32 queues belong to port 1, etc.
> > >
> > > mvpp2_rss_port_c2_enable() gets the queue number from it's parameter,
> > > 'ctx', which comes from mvpp22_rss_ctx(port, 0).  This returns
> > > port->rss_ctx[0].
> > >
> > > mvpp22_rss_context_create() is responsible for allocating that, which
> > > it does by looking for an unallocated priv->rss_tables[] pointer.  This
> > > table is shared amongst all ports on the CP silicon.
> > >
> > > When we write the tables in mvpp22_rss_fill_table(), the RSS table
> > > entry is defined by:
> > >
> > >             u32 sel = MVPP22_RSS_INDEX_TABLE(rss_ctx) |
> > >                           MVPP22_RSS_INDEX_TABLE_ENTRY(i);
> > >
> > > where rss_ctx is the context ID (queue number) and i is the index in
> > > the table.
> > >
> > > #define     MVPP22_RSS_INDEX_TABLE_ENTRY(idx)   (idx)
> > > #define     MVPP22_RSS_INDEX_TABLE(idx)         ((idx) << 8)
> > > #define     MVPP22_RSS_INDEX_QUEUE(idx)         ((idx) << 16)
> > >
> > > If we look at what is written:
> > >
> > > - The first table to be written has "sel" values of 00000000..0000001f,
> > >   containing values 0..3. This appears to be for eth1.  This is table 0,
> > >   RX queue number 0.
> > > - The second table has "sel" values of 00000100..0000011f, and appears
> > >   to be for eth2.  These contain values 0x20..0x23.  This is table 1,
> > >   RX queue number 0.
> > > - The third table has "sel" values of 00000200..0000021f, and appears
> > >   to be for eth3.  These contain values 0x40..0x43.  This is table 2,
> > >   RX queue number 0.
> > >
> > > Okay, so how do queue numbers translate to the RSS table?  There is
> > > another table - the RXQ2RSS table, indexed by the MVPP22_RSS_INDEX_QUEUE
> > > field of MVPP22_RSS_INDEX and accessed through the MVPP22_RXQ2RSS_TABLE
> > > register.  Before 895586d5dc32, it was:
> > >
> > >        mvpp2_write(priv, MVPP22_RSS_INDEX,
> > >                    MVPP22_RSS_INDEX_QUEUE(port->first_rxq));
> > >        mvpp2_write(priv, MVPP22_RXQ2RSS_TABLE,
> > >                    MVPP22_RSS_TABLE_POINTER(port->id));
> > >
> > > and after:
> > >
> > >        mvpp2_write(priv, MVPP22_RSS_INDEX, MVPP22_RSS_INDEX_QUEUE(ctx));
> > >        mvpp2_write(priv, MVPP22_RXQ2RSS_TABLE, MVPP22_RSS_TABLE_POINTER(ctx));
> > >
> > > So, before the commit, for eth2, that would've contained '32' for the
> > > index and '1' for the table pointer - mapping queue 32 to table 1.
> > > Remember that this is queue-high.queue-low of 4.0.
> > >
> > > After the commit, we appear to map queue 1 to table 1.  That again
> > > looks fine on the face of it.
> > >
> > > Section 9.3.1 of the A8040 manual seems indicate the reason that the
> > > queue number is separated.  queue-low seems to always come from the
> > > classifier, whereas queue-high can be from the ingress physical port
> > > number or the classifier depending on the MVPP2_CLS_SWFWD_PCTRL_REG.
> > >
> > > We set the port bit in MVPP2_CLS_SWFWD_PCTRL_REG, meaning that queue-high
> > > comes from the MVPP2_CLS_SWFWD_P2HQ_REG() register... and this seems to
> > > be where our bug comes from.
> > >
> > > mvpp2_cls_oversize_rxq_set() sets this up as:
> > >
> > >         mvpp2_write(port->priv, MVPP2_CLS_SWFWD_P2HQ_REG(port->id),
> > >                     (port->first_rxq >> MVPP2_CLS_OVERSIZE_RXQ_LOW_BITS));
> > >
> > >         val = mvpp2_read(port->priv, MVPP2_CLS_SWFWD_PCTRL_REG);
> > >         val |= MVPP2_CLS_SWFWD_PCTRL_MASK(port->id);
> > >         mvpp2_write(port->priv, MVPP2_CLS_SWFWD_PCTRL_REG, val);
> > >
> > > so, the queue-high for eth2 is _always_ 4, meaning that only queues
> > > 32 through 39 inclusive are available to eth2.  Yet, we're trying to
> > > tell the classifier to set queue-high, which will be ignored, to zero.
> > >
> > > So we end up directing traffic from eth2 not to queue 1, but to queue
> > > 33, and then we tell it to look up queue 33 in the RSS table.  However,
> > > RSS table has not been programmed for queue 33, and so it ends up
> > > (presumably) dropping the packets.
> > >
> > > It seems that mvpp22_rss_context_create() doesn't take account of the
> > > fact that the upper 5 bits of the queue ID can't actually be changed
> > > due to the settings in mvpp2_cls_oversize_rxq_set(), _or_ it seems
> > > that mvpp2_cls_oversize_rxq_set() has been missed in this commit.
> > > Either way, these two functions mutually disagree with what queue
> > > number should be used.
> > >
> > > So, 895586d5dc32 is indeed the cause of this problem.
> >
> > Looking deeper into what mvpp2_cls_oversize_rxq_set() and the MTU
> > validation is doing, it seems that MVPP2_CLS_SWFWD_P2HQ_REG() is
> > used for at least a couple of things.
> >
> > So, with the classifier having had RSS enabled and directing eth2
> > traffic to queue 1, we can not ignore the fact that we may have
> > packets appearing on queue 32 for this port.
> >
> > One of the things that queue 32 will be used for is if an over-sized
> > packet attempts to egress through eth2 - it seems that the A8040 has
> > the ability to forward frames between its ports.  However, afaik we
> > don't support that feature, and the kernel restricts the packet size,
> > so we should never violate the MTU validator and end up with such a
> > packet.  In any case, _if_ we were to attempt to transmit an oversized
> > packet, we have no support in the kernel to deal with that appearing
> > in the port's receive queue.
> >
> > Maybe it would be safe to clear the MVPP2_CLS_SWFWD_PCTRL_MASK() bit?
> >
> > My testing seems to confirm my findings above - clearing this bit
> > means that if I enable rxhash on eth2, the interface can then pass
> > traffic, as we are now directing traffic to RX queue 1 rather than
> > queue 33.  Traffic still seems to work with rxhash off as well.
> >
> > So, I think it's clear where the problem lies, but not what the correct
> > solution is; someone with more experience of packet classifiers (this
> > one?) needs to look at this - this is my first venture into these
> > things, and certainly the first time I've traced through how this is
> > trying to work (or not)...
>
> This is what I was using here to work around the problem, and what I
> mentioned above.
>
> diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
> index fd221d88811e..0dd3b65822dd 100644
> --- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
> +++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_cls.c
> @@ -1058,7 +1058,7 @@ void mvpp2_cls_oversize_rxq_set(struct mvpp2_port *port)
>                     (port->first_rxq >> MVPP2_CLS_OVERSIZE_RXQ_LOW_BITS));
>
>         val = mvpp2_read(port->priv, MVPP2_CLS_SWFWD_PCTRL_REG);
> -       val |= MVPP2_CLS_SWFWD_PCTRL_MASK(port->id);
> +       val &= ~MVPP2_CLS_SWFWD_PCTRL_MASK(port->id);
>         mvpp2_write(port->priv, MVPP2_CLS_SWFWD_PCTRL_REG, val);
>  }
>
>

Hi,

I will try this change and let you know if it works.

Thanks

-- 
Matteo Croce
per aspera ad upstream

