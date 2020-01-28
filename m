Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9C8C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 977A224683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580235706;
	bh=p//mWvbjUQWMz/yXfxYT49hHopuwkXyy57UEPZOG144=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tC7ldwbyEboofk+RoM8UfzfPPWWoRAIehIX2ht+ruWxAXT7PT3j1qSHMrNL+wj0eC
	 qzald3wz1NuOAnxGqHvIdBRVMe95DcV5DfJraxQTO8kaRhlpZiiuh/zlhi841msy3z
	 Ld790fmXkR3nPvw/Iw8aZ4Vhaz0zo47VNHbr0+Uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgA1SVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:21:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1SVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:21:45 -0500
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EC5722522;
        Tue, 28 Jan 2020 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580235704;
        bh=p//mWvbjUQWMz/yXfxYT49hHopuwkXyy57UEPZOG144=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=F8N1ih0hsfMcT1itiIdThXCa1Rq600KUposZhsvsGGkRADH9Mr14RKjkBrKdxIPgh
         fLmQ2TFqTR5yrhTE3eEgn4+PREBXj2RSmhEGntwIx9eFu69dR+2SD5S/LM9ocWvE1N
         hX6FsM0O94jMxtz1vwT+dPy2CvyKtPr8D04rrEX8=
Received: by mail-qv1-f48.google.com with SMTP id dp13so6719082qvb.7;
        Tue, 28 Jan 2020 10:21:44 -0800 (PST)
X-Gm-Message-State: APjAAAUlhZojxlFoSgznpM6lUB5EihDoCRFYJwPQp0TVGByf0qf/B5PI
        jyiOdNUtHE8zh5/YVK3EaHq+zvgvM/bmqGGAVg==
X-Google-Smtp-Source: APXvYqwPpTr1MCUPd3qOHeLBf2H6pq4i35Dq4QnQtMfEtE0xTbpsF1vW77fxpZogY+7MgKbUv34lw2kPVCNgBOs8lJw=
X-Received: by 2002:ad4:4511:: with SMTP id k17mr22463825qvu.135.1580235703715;
 Tue, 28 Jan 2020 10:21:43 -0800 (PST)
MIME-Version: 1.0
References: <20200124152504.23411-1-mans@mansr.com> <20200127153506.GA4589@bogus>
 <yw1xy2tsvnww.fsf@mansr.com> <20200128134745.GA3048749@kroah.com>
 <yw1xpnf3vchs.fsf@mansr.com> <20200128152818.GB3437093@kroah.com> <20200128165243.GC3666045@kroah.com>
In-Reply-To: <20200128165243.GC3666045@kroah.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Jan 2020 12:21:32 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK1fMCrbbMdRPqVjtS0D6p4AhqjcOGoivGbT2aKN7UJWw@mail.gmail.com>
Message-ID: <CAL_JsqK1fMCrbbMdRPqVjtS0D6p4AhqjcOGoivGbT2aKN7UJWw@mail.gmail.com>
Subject: Re: [RESEND][PATCH 1/2] dt-bindings: usb: add non-removable-ports hub property
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

n Tue, Jan 28, 2020 at 10:52 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 28, 2020 at 04:28:18PM +0100, Greg Kroah-Hartman wrote:
> > On Tue, Jan 28, 2020 at 03:15:11PM +0000, M=C3=A5ns Rullg=C3=A5rd wrote=
:
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > >
> > > > On Mon, Jan 27, 2020 at 04:56:15PM +0000, M=C3=A5ns Rullg=C3=A5rd w=
rote:
> > > >> Rob Herring <robh@kernel.org> writes:
> > > >>
> > > >> > On Fri, Jan 24, 2020 at 03:25:03PM +0000, Mans Rullgard wrote:
> > > >> >> Add a non-removable-ports property that lists the hardwired dow=
nstream
> > > >> >> ports of a hub.  Although hubs can provide this information, th=
ey are
> > > >> >> not always configured correctly.  An alternate means of indicat=
ing this
> > > >> >> for built-in USB devices is thus useful.
> > > >> >>
> > > >> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> > > >> >
> > > >> > I reviewed this already, but since you didn't add my reviewed-by=
, I'm
> > > >> > looking at it again and having 2nd thoughts.
> > > >> >
> > > >> >> ---
> > > >> >>  Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
> > > >> >>  1 file changed, 4 insertions(+)
> > > >> >>
> > > >> >> diff --git a/Documentation/devicetree/bindings/usb/usb-device.t=
xt b/Documentation/devicetree/bindings/usb/usb-device.txt
> > > >> >> index 036be172b1ae..92d863cc96b6 100644
> > > >> >> --- a/Documentation/devicetree/bindings/usb/usb-device.txt
> > > >> >> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> > > >> >> @@ -66,6 +66,10 @@ Required properties for host-controller node=
s with device nodes:
> > > >> >>  - #size-cells: shall be 0
> > > >> >>
> > > >> >>
> > > >> >> +Optional properties for hub and host-controller nodes:
> > > >> >> +- non-removable-ports: list of hardwired downstream ports
> > > >> >
> > > >> > If you have a hardwired device and need to know that, doesn't th=
at imply
> > > >> > there's some other stuff you need to describe beyond what a stan=
dard USB
> > > >> > device has. Such as a power supply that's not Vbus from the hub.
> > > >>
> > > >> I suppose there could be, but there isn't in my actual situation.
> > > >>
> > > >> > At a minimum, I think this should be a per port property.
> > > >>
> > > >> That's what I suggested first.  Greg told me to do it like this in=
stead.
> > > >
> > > > I said that?  I do not remember discussing this at all, when did th=
at
> > > > happen?
> > >
> > > https://lore.kernel.org/lkml/20190228155241.GC12050@kroah.com/
> >
> > Almost a full year ago!  Hah, I can't remember what I wrote last week.
>
> Ah, ok, all I said was "do what ACPI does here", as that's a model of
> what has already been agreed apon by a whole huge number of people and
> standardized.  No need for DT to come up with something totally
> different instead, making a mess of things :)
>
> If this is doing what ACPI does, fine, if not, it should.  It was here
> first.

That's not always possible as ACPI and DT work in different ways. The
DT (Open Firmware) USB binding originated in 1998[1]. While ancient,
that is what defines the node structure of USB hubs, ports, and
devices that we use today.

However, after a quick read of ACPI sec 9.14, I'd say what I suggested
is more aligned to ACPI than what's proposed here. Ports are child
nodes ("Device" in ACPI terms) and the properties to determine all
this are properties of the port node(s). Aligning beyond that isn't
really possible. ACPI has a standard thing (not sure what the proper
term is) called '_PLD' for describing device location which includes
'user visible' among several other things. There is no such concept in
DT to align with. What we have is the 'non-removable' property and IMO
that's what we should use here.

Rob

[1] https://www.devicetree.org/open-firmware/bindings/usb/usb-1_0.ps
