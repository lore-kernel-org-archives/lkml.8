Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80224C352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50D2B20661
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 19:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shdUAmJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBJTbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 14:31:34 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45337 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJTbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 14:31:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id 2so4173016pfg.12;
        Mon, 10 Feb 2020 11:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZuPt180kRsjCVRCyZy+KTCJcOp2X4om9PYJBQV60Moc=;
        b=shdUAmJ14w97aqe7DSTm0HIXz2ZpCws3HjMztJNoydnWz7J6zzufdnzB/MDKNYKzjn
         Np254hbT6cgaPBn4FZz9ykTV7VmZOWgGY5G4KUBewPJZ+5RTiSSoLznfegSaBWBMTsAx
         gF4sEnhtnTO9ia+sOMz4eYufu/7D2ttRDIqjD+aWVPaJ6KVgTc7mvboVz3b1+J4ME9Ze
         s7F4c9JQ+vO4yJKRUNQVKNNIZ+unVmhZdODmaUO3wHnE1HKQpyYeaNm/mneuWgm/uK+0
         CIeE+sMw+0gmAefHNgRg+orMZZIiObTfERMqDWa9up90fnYoNWCE6hMpkPx71UwbLhCc
         IC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZuPt180kRsjCVRCyZy+KTCJcOp2X4om9PYJBQV60Moc=;
        b=eEFmPV2XyPzhPq/eRH8+RS0X6n4lFcExLm1m0ugO8e1x+cQMSxPzT/H8DUzmNgAJOB
         eqGNXFG47NwjIjS+pvTiV0CjcWmtYkd+mh3HM1njQTQsYv22jfQRSf13D/IalPakt1Aw
         qDACsbcP05V2TxuZn0ZFTeB/rYBKFhW6Him1b0h8Cnqp1b5F3gVMBMqUqF1DLaOz/hGc
         nN0ULJ5gR1NxZscaUb5B7WwbIK7seOHZm45vtp61mLnISsHQWysaZt5kHbf9822GbVpO
         OneViexVnWHV7fWRKA4uAp2hLzARc0SIQUDsQF5W3ZIV2zEQaf5gzDyTllQU83ofr3Hx
         8FQw==
X-Gm-Message-State: APjAAAXc3SL4fKhNyc7qGEOmmffmKg9be8ARvpjCQtaLpCL+w0MiphYy
        UboqxP/L0eyvflbVtsoj/GM=
X-Google-Smtp-Source: APXvYqxTAam4vg8YO3HTEwUSpm+D/PTtAnCrM86RpDJMKgUVL7IuukH9eQEDieHTCjyqJRoqovvDwQ==
X-Received: by 2002:a63:e14b:: with SMTP id h11mr3059825pgk.297.1581363093006;
        Mon, 10 Feb 2020 11:31:33 -0800 (PST)
Received: from taoren-ubuntu-R90MNF91 ([2620:10d:c090:200::2:87f0])
        by smtp.gmail.com with ESMTPSA id 28sm895963pgl.42.2020.02.10.11.31.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Feb 2020 11:31:32 -0800 (PST)
Date:   Mon, 10 Feb 2020 11:31:29 -0800
From:   Tao Ren <rentao.bupt@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Joel Stanley <joel@jms.id.au>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>
Subject: Re: [PATCH 2/3] usb: gadget: aspeed: add ast2600 vhub support
Message-ID: <20200210193128.GC5346@taoren-ubuntu-R90MNF91>
References: <20200131222157.20849-1-rentao.bupt@gmail.com>
 <20200131222157.20849-3-rentao.bupt@gmail.com>
 <CACPK8XcmUYhnePr1AG2M9P-oGvOM=zCM+r44jWUzPYGxUEGOGw@mail.gmail.com>
 <b7bf421b5fad397a7ef430af6c0c09602dd66c2a.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b7bf421b5fad397a7ef430af6c0c09602dd66c2a.camel@kernel.crashing.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 08:29:22AM +0100, Benjamin Herrenschmidt wrote:
> On Mon, 2020-02-10 at 02:48 +0000, Joel Stanley wrote:
> > On Fri, 31 Jan 2020 at 22:22, <rentao.bupt@gmail.com> wrote:
> > > 
> > > From: Tao Ren <rentao.bupt@gmail.com>
> > > 
> > > Add AST2600 support in aspeed-vhub driver. There are 3 major differences
> > > between AST2500 and AST2600 vhub:
> > >   - AST2600 supports 7 downstream ports while AST2500 supports 5.
> > >   - AST2600 supports 21 generic endpoints while AST2500 supports 15.
> > >   - EP0 data buffer's 8-byte DMA alignment restriction is removed from
> > >     AST2600.
> > > 
> > > Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> > > Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
> 
> Travelling at the moment so my review might be a bit delayed. Also for
> some reason I missed your original submission, sorry about that, please
> poke me next time if I don't reply within a couple of days !

No worries Ben and thanks for the review. I thought people was too busy
during merge window :)

> 
> One thing to look into as well is the 2600 has revived the "device
> controller" which looks like a cut down version of a vhub device, so we
> should break a bit more the linkage between vhub and the underlying
> devices so the latter can be instanciated standalone...
> 
> (Foor for thought, I'm not asking you to do that right now)

Thanks for sharing your thought. I was actually curious why "device
controller" was back. Anyways I feel it might be easier to break the
linkage when we decide to add driver for the "device controller".


Cheers,

Tao
> 
> Cheers,
> Ben.
> 
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > 
> > > ---
> > >  drivers/usb/gadget/udc/aspeed-vhub/Kconfig | 4 ++--
> > >  drivers/usb/gadget/udc/aspeed-vhub/core.c  | 9 +++++++++
> > >  2 files changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> > > index 83ba8a2eb6af..605500b19cf3 100644
> > > --- a/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> > > +++ b/drivers/usb/gadget/udc/aspeed-vhub/Kconfig
> > > @@ -4,5 +4,5 @@ config USB_ASPEED_VHUB
> > >         depends on ARCH_ASPEED || COMPILE_TEST
> > >         depends on USB_LIBCOMPOSITE
> > >         help
> > > -         USB peripheral controller for the Aspeed AST2500 family
> > > -         SoCs supporting the "vHub" functionality and USB2.0
> > > +         USB peripheral controller for the Aspeed AST2400, AST2500 and
> > > +         AST2600 family SoCs supporting the "vHub" functionality and USB2.0
> > > diff --git a/drivers/usb/gadget/udc/aspeed-vhub/core.c b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > > index 94081cc04113..c827bf420278 100644
> > > --- a/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > > +++ b/drivers/usb/gadget/udc/aspeed-vhub/core.c
> > > @@ -42,6 +42,11 @@ static const struct ast_vhub_config ast2400_config = {
> > >         .max_epns = 15,
> > >  };
> > > 
> > > +static const struct ast_vhub_config ast2600_config = {
> > > +       .max_ports = 7,
> > > +       .max_epns = 21,
> > > +};
> > > +
> > >  static const struct of_device_id ast_vhub_dt_ids[] = {
> > >         {
> > >                 .compatible = "aspeed,ast2400-usb-vhub",
> > > @@ -51,6 +56,10 @@ static const struct of_device_id ast_vhub_dt_ids[] = {
> > >                 .compatible = "aspeed,ast2500-usb-vhub",
> > >                 .data = &ast2400_config,
> > >         },
> > > +       {
> > > +               .compatible = "aspeed,ast2600-usb-vhub",
> > > +               .data = &ast2600_config,
> > > +       },
> > >         { }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, ast_vhub_dt_ids);
> > > --
> > > 2.17.1
> > > 
> 
