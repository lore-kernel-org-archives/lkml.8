Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145A4C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C92202078E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 18:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599675642;
	bh=JaN9N3pcoNDn3owpWWs48WvhhA1KCzxeHdaE/iRZjgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zRh19YpU5meVAGIewVUJvWJBMhl7DVEVXNyPZvQcg+LmRcNt9g3wK10JOF5XTYheQ
	 DM2fTcnu0m7MXED1iYWLsLBp2+OGcK/3dkhZPwJNeC5w7TRCGxMu09tCy4a19HbpYr
	 1nnJDBZVE3i36LjxduraUhbHrtVD2ecvQLPvu34w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbgIISUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 14:20:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:35776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbgIISUf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:20:35 -0400
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 272A721D7F;
        Wed,  9 Sep 2020 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599675634;
        bh=JaN9N3pcoNDn3owpWWs48WvhhA1KCzxeHdaE/iRZjgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=y9d+1uXio6dNOyfxskd1CxCQ+TgygEg+TrXynmG2dimfIx0KVIbsAGTMnEIV9+RPv
         2dv3e306tPEquqIstAJkY9BiBdbcHvYCSZZ/rZfcdUT/449LRkS5bG0K0C89CGRQjH
         OL8p/S2idASTo/qcXlpkEsmrOwhkLb2HooWYjisA=
Received: by mail-oo1-f42.google.com with SMTP id m25so809195oou.0;
        Wed, 09 Sep 2020 11:20:34 -0700 (PDT)
X-Gm-Message-State: AOAM532cDOpxBx4SSLcnmhtT1LD6iVYgYB6JTc+6Uh6rCK/z1oGlc1fW
        BcEhcWEZQFyzZjqRUtr2pYrHty8NrB/NC7pHeA==
X-Google-Smtp-Source: ABdhPJysndRewOcbs57i2Hp2EeNgVH4uvg8GYdBkIyjcd/OFZOjDgbOLWTn74YaaG5Aa6jTa2G8H3AZa2FPgZTOhE5M=
X-Received: by 2002:a4a:d306:: with SMTP id g6mr1662606oos.25.1599675633402;
 Wed, 09 Sep 2020 11:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
 <20200817030324.5690-3-crystal.guo@mediatek.com> <20200825190219.GA1125997@bogus>
 <1598440183.30048.14.camel@mhfsdcap03> <6c292056-1cb1-bc6c-0422-46e047dcf08f@ti.com>
 <CAL_JsqKuL7XM2CL3z0OQdRua5YJO2ZRdsoE3fdAH948mKGfWnA@mail.gmail.com> <b91c4ddf-8f12-2154-0a41-bf9563b5aefd@ti.com>
In-Reply-To: <b91c4ddf-8f12-2154-0a41-bf9563b5aefd@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Sep 2020 12:20:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJq6gqoXtvG1U7UDsOQpz7oMLMunZHq2njN6nvPr8PZMA@mail.gmail.com>
Message-ID: <CAL_JsqJq6gqoXtvG1U7UDsOQpz7oMLMunZHq2njN6nvPr8PZMA@mail.gmail.com>
Subject: Re: [v4,2/4] dt-binding: reset-controller: ti: add
 'mediatek,infra-reset' to compatible
To:     Suman Anna <s-anna@ti.com>
Cc:     Crystal Guo <crystal.guo@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        =?UTF-8?B?U3RhbmxleSBDaHUgKOacseWOn+mZnik=?= 
        <stanley.chu@mediatek.com>,
        =?UTF-8?B?WWluZ2pvZSBDaGVuICjpmbPoi7HmtLIp?= 
        <Yingjoe.Chen@mediatek.com>,
        =?UTF-8?B?RmFuIENoZW4gKOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        =?UTF-8?B?WW9uZyBMaWFuZyAo5qKB5YuHKQ==?= <Yong.Liang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 9:10 AM Suman Anna <s-anna@ti.com> wrote:
>
> On 9/8/20 1:49 PM, Rob Herring wrote:
> > On Wed, Sep 2, 2020 at 5:26 PM Suman Anna <s-anna@ti.com> wrote:
> >>
> >> Hi Rob,
> >>
> >> On 8/26/20 6:09 AM, Crystal Guo wrote:
> >>> On Wed, 2020-08-26 at 03:02 +0800, Rob Herring wrote:
> >>>> On Mon, Aug 17, 2020 at 11:03:22AM +0800, Crystal Guo wrote:
> >>>>> The TI syscon reset controller provides a common reset management,
> >>>>> and is suitable for MTK SoCs. Add compatible 'mediatek,infra-reset',
> >>>>> which denotes to use ti reset-controller driver directly.
> >>>>>
> >>>>> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> >>>>> ---
> >>>>>  Documentation/devicetree/bindings/reset/ti-syscon-reset.txt | 1 +
> >>>>>  1 file changed, 1 insertion(+)
> >>>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> >>>>> index ab041032339b..5a0e9365b51b 100644
> >>>>> --- a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> >>>>> +++ b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> >>>>> @@ -25,6 +25,7 @@ Required properties:
> >>>>>                         "ti,k2l-pscrst"
> >>>>>                         "ti,k2hk-pscrst"
> >>>>>                         "ti,syscon-reset"
> >>>>> +                       "mediatek,infra-reset", "ti,syscon-reset"
> >>>>
> >>>> You need your own binding doc. If you can use the same driver then fine,
> >>>> but that's a separate issue. There's also reset-simple driver if you
> >>>> have just array of 32-bit registers with a bit per reset.
> >>>>
> >>>> Don't repeat 'ti,reset-bits' either.
> >>>
> >>> Do you mean I should add a Mediatek reset binding doc, although Mediatek
> >>> reuse the TI reset controller directly?
> >>
> >> Hmm, how do you envision not repeating the same bits in a separate binding?
> >
> > I mean 'ti,reset-bits' isn't really something that should have been in
> > DT in the first place, but rather implied by the compatible string.
>
> Ok, should I be deprecating this and move this data to driver then?

No, I'm just asking to not have new users.

> I am assuming that is how you are envisioning the new Mediatek binding to be
> atleast.

Right.

Rob
