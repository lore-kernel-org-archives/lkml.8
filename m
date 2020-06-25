Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9233CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA8E20775
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593095931;
	bh=zxWp8BmWa920a0+o2fBQiG+V+AqjY0vOBj+m52+jqV4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=IUX5S5sHvskbwLPpxhM/7nUt3NMiAmJgsDQMuyxgEX0DjHGxqHfRHpKiOw/Q38swE
	 zHnww9TokOUVwF+2gd5NmZJplgEC6B9+DzVWe/aJBU0ro1Fd17xHDNHzNGY+ST7ouo
	 369swa3pECJp52qJmymJ8mNNPk/cmybiA8GirZoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405429AbgFYOiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:38:50 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:45184 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405411AbgFYOiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:38:50 -0400
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 05PEcQAX008959;
        Thu, 25 Jun 2020 23:38:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 05PEcQAX008959
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1593095907;
        bh=ijPZb1cfulvfr7nl4mn4pmwbl3GKFLftlqTTQQ9OMEc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OznUSqNEqRwb9eSqLiT0Q6D+ovJNlmwc02GFYtezeKuLjq3Zl4BfDOXROeFx9tON1
         iqmr3lKpeEos+rVdZDVXay4TD4UVgiNzFvAUTs1BGs8Rz3IYk46DXgzcqynWLhwOSZ
         OrsNx0HahNWTZTy9eSXlZbad+a/RXhmssSP9eHOlh0+R8A2NVdFwqhXIgjDcquRXd6
         09DKR5pTWf+f3pDkm4PIxV4IlNruY0BhnF3Q+W+R6U7C1dNB3jC7ChnBoV+XlJlxwF
         JJYeXuVH82yC1cfbXnxlJqEOdmSrh6SLm8j+G3jEn0fZl6qc1VO2F2hstm/1U5M4P+
         TIP02jpz6v7ug==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id m25so3668741vsp.8;
        Thu, 25 Jun 2020 07:38:27 -0700 (PDT)
X-Gm-Message-State: AOAM5307P+XvSxbN/q+ZzGCSLLPCo+tIIvB1VgWhqsvu/GVxq5azQBsX
        TnPnx+lPRG7zRasNs/Lw+ztxxEqah60AVWaWlHM=
X-Google-Smtp-Source: ABdhPJyvOYDrxR1TD/0As+dJtiC0TVMxIpD2R/NeE0UMXfGRlubszQEpcdvJygsMSzOaXDMnb7MTpA0vPI/hmyAnMhA=
X-Received: by 2002:a67:2d42:: with SMTP id t63mr26451715vst.181.1593095906216;
 Thu, 25 Jun 2020 07:38:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200623114614.792648-1-yamada.masahiro@socionext.com>
 <20200623114614.792648-4-yamada.masahiro@socionext.com> <20200623122413.GA954398@dell>
 <CAK7LNAR-dm6Zbtt9MsUunn9+qqwTtRCbq4Wzb=8uKLtfaLK6TQ@mail.gmail.com> <20200624181605.GJ954398@dell>
In-Reply-To: <20200624181605.GJ954398@dell>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 25 Jun 2020 23:37:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFUX56t=wn-3qOSYLwESp63gqDWjADEVQ1g1CYrGxA3g@mail.gmail.com>
Message-ID: <CAK7LNATFUX56t=wn-3qOSYLwESp63gqDWjADEVQ1g1CYrGxA3g@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: uniphier: change support card to simple-mfd
 from simple-bus
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 3:16 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 25 Jun 2020, Masahiro Yamada wrote:
>
> > On Tue, Jun 23, 2020 at 9:24 PM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Tue, 23 Jun 2020, Masahiro Yamada wrote:
> > >
> > > > 'make ARCH=arm dtbs_check' emits the following warning:
> > > >
> > > >   support-card@1,1f00000: $nodename:0: 'support-card@1,1f00000' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'
> > > >
> > > > Maybe, simple-mfd could be a better fit for this device.
> > >
> > > The two should be equivalent.
> >
> > Yes, I know.
> > That's why I can change "simple-bus" to "simple-mfd"
> > with no risk.
> >
> > The difference is schema-check.
> >
> > The node name for "simple-bus" is checked by 'make dtbs_check'.
> >
> > See this code:
> > https://github.com/robherring/dt-schema/blob/v2020.05/schemas/simple-bus.yaml#L17
> >
> > Even if I rename the node, it does not accept the
> > unit name '1,1f00000'
> >
> > > What do you mean by "maybe"?  Does this squash the warning?
> >
> > "maybe" means I am not quite sure
> > which compatible is a better fit
> > to describe this device.
> >
> > As mentioned above, simple-bus and simple-mfd
> > are interchangeable from a driver point of view.
> >
> > This add-on board is integrated with various peripherals
> > such as 16550a serial, smsc9115 ether etc.
> > The address-decode is implemented in a CPLD device.
> > It has chip selects and local addresses, which are mapped to
> > the parent.
> >
> > It can be either simple-bus or simple-mfd, I think.
> >
> >
> > dt-schema checks the node name of simple-bus.
> > Currently, there is no check for simple-mfd.
> >
> > So, I think this patch is an easy solution
> > to fix the warning.
>
> Yes, looking at the documentation it seems as though 'simple-mfd'
> would be a better fit.  Is the device a single IP with various
> different functions?


Not an IP.

This is a small board that consists of
a CPLD + ethernet controller + serial controller + LED, etc.


>
> > Rob is in Cc. Please add comments if any.
> >
> > > Isn't the issue caused by the ','?
> >
> > Right.
> >
> > The node name of simple-bus
> > must meet the regular expression:
> > "^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$"
> >
> >
> > Even if I rename the node
> > "support-card@1,1f00000"
> > to "bus@1,1f00000", the warning is still
> > displayed due to ','
> >
> > "1,1f00000" means
> > the address 0x01f00000 of chip select 1.
>
> Is this an officially accepted format?


I am not sure if it is official.

Rob said the data fields should be separated by commas.
https://www.spinics.net/lists/devicetree/msg201565.html




-- 
Best Regards
Masahiro Yamada
