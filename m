Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0219CC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:48:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4AA020723
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 21:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585432134;
	bh=G8OwioppXxivUN+lG+9D9zomyy4zRkwKcraq37im1go=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NsyqBf9taZMVk8d4bvZMzjGNfbK6usAFlDOAofh12JYM4FR0Sc233uw6L2hVUyYqk
	 UA6fhPhZpwvRBTMqR9MbpYDOg0OWIcaQ++avYPWjABjCd29K7uvHr6Bcs+AyDxv3Sq
	 tl0qJxkCy8k3DVEY/3TyX9neh9VM3ss2a6t592oc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgC1Vsx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 17:48:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:58998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbgC1Vsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 17:48:53 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E60420723
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 21:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585432132;
        bh=G8OwioppXxivUN+lG+9D9zomyy4zRkwKcraq37im1go=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cHUPlg9VZTn2bJ3i8ZyCnu962Xsyf8HfiUrJ8sWmLDcvS6Mkvc8/7ZlePscswR5w/
         eMPuQ4q5O3KTBNwy+oQ/j4CLYgvLvchVHCnOIQcYt6PRiI/aLGUUJT1s/zlLfB9mAJ
         tK7v5LANHo4Djl8CRzBycEqGWS/PdVb9dETZQMEk=
Received: by mail-qt1-f173.google.com with SMTP id t9so11879543qto.9
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 14:48:52 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3wFb8Wrf+2Lcwo29WMxQS7OwjA2RyeV+y1diWFaJLyrMsdq9rO
        3HZl+56CX3cr5nR/0Dn+8+1Fxm77bxSvV1GI9w==
X-Google-Smtp-Source: ADFU+vuPFCy1Urrihp7eFA6SCEIvNd1NQ0YUXPZL7dUqBIvYG02ICZLR/KjsqSl0X1vqh04JtYeHrgdNFC79KTMJZB0=
X-Received: by 2002:aed:3461:: with SMTP id w88mr5617911qtd.143.1585432131157;
 Sat, 28 Mar 2020 14:48:51 -0700 (PDT)
MIME-Version: 1.0
References: <A65A26D8-9F66-4D46-B1E1-84ECECF079E3@goldelico.com>
 <20200328182008.5ac2f99e@kemnade.info> <EF62F8D0-A205-4D64-8540-44F843720797@goldelico.com>
In-Reply-To: <EF62F8D0-A205-4D64-8540-44F843720797@goldelico.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sat, 28 Mar 2020 15:48:40 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLv5sS50ocg85+7C6PhK97GAbOE+6tk1gS4wvzQjnfGNA@mail.gmail.com>
Message-ID: <CAL_JsqLv5sS50ocg85+7C6PhK97GAbOE+6tk1gS4wvzQjnfGNA@mail.gmail.com>
Subject: Re: CHKDT error by f95cad74acdb ("dt-bindings: clocks: Convert
 Allwinner legacy clocks to schemas")
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>, Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 12:21 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
>
> > Am 28.03.2020 um 18:20 schrieb Andreas Kemnade <andreas@kemnade.info>:
> >
> > Hi Nikolaus,
> >
> > On Sat, 28 Mar 2020 13:26:24 +0100
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> >
> >> Hi Rob,
> >> I am trying to check my new bindings with v5.6-rc7 but get this before
> >> the process tries mine:
> >>
> >> make dt_binding_check dtbs_check
> >> ...
> >>
> >>  CHKDT   Documentation/devicetree/bindings/bus/renesas,bsc.yaml - due to target missing
> >>  CHKDT   Documentation/devicetree/bindings/bus/simple-pm-bus.yaml - due to target missing
> >>  CHKDT   Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.yaml - due to target missing
> >> /Volumes/CaseSensitive/master/Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.yaml: Additional properties are not allowed ('deprecated' was unexpected)
> >> make[2]: *** [Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.example.dts] Error 1
> >> make[1]: *** [dt_binding_check] Error 2
> >> make: *** [sub-make] Error 2
> >>
> >> What am I doing wrong?
> >> Is there an option to skip such errors and continue?
> >> Is there an option to just test my bindings and yaml file?
> >>
> > maybe your tools are outdated, so rerun
> >
> > pip3 install git+https://github.com/devicetree-org/dt-schema.git@master
>
> Yes, that one solves the problem!
>
> A better error message of CHKDT would have been helpful. Or an auto-update.

If you know of a "python way" to do auto/self updating I'd like to
know. I looked a while back and didn't find anything. I'm working on a
version check so I can enforce/warn on a minimum version which should
help some.

> Now I just get a lot of messages like
>
>   CHKDT   Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml - due to: Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml
> Documentation/devicetree/bindings/arm/sunxi/allwinner,sun4i-a10-mbus.yaml:: $id: relative path/filename doesn't match actual path or filename
>         expected: http://devicetree.org/schemas/arm/sunxi/allwinner,sun4i-a10-mbus.yaml:#
>   CHKDT   Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.yaml - due to target missing
> Documentation/devicetree/bindings/clock/allwinner,sun4i-a10-ahb-clk.yaml:: $id: relative path/filename doesn't match actual path or filename
>         expected: http://devicetree.org/schemas/clock/allwinner,sun4i-a10-ahb-clk.yaml:#

Should be fixed if you are on a current rc.

Rob
