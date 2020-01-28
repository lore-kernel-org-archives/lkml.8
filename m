Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADB1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF92214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 17:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580232473;
	bh=2r7YfbL9UUbs/P7wgljyb0t694akOrvI4j3adZdefA4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Bgu14N8RhjsvnhgxoKf5zNu151ouq3zttgr3+4ABA6ypmcLpFDszOq0tytMFQJUvf
	 k+ib9XRImOIz8JtM/YiG8nIzBR6fc2rpq8cIh8CqiRqPhlVh+rLMJA7CGcTY7PZtGS
	 MRSWSYGCa5kY98d4XzbNpCSCKLrUAyPj+qO8fYXw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgA1R1w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 12:27:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:35648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgA1R1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 12:27:52 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A42CE2467E;
        Tue, 28 Jan 2020 17:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580232470;
        bh=2r7YfbL9UUbs/P7wgljyb0t694akOrvI4j3adZdefA4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W0wgul/caH/Yc+effaSlwkpSvk4pKuOoE2OHFoCUiNSrffgDE9XIgUNFVS0TSC+gD
         M7EXVFuFbJYfPEjS6CkOh7J39YWxDe4lM1QBnpqOGexAUcHSvN1Qr54sU0t03/omCi
         2oUXeUBIKZxIiGcRnljzNAzTL5x8fw9OUkv+PA7Y=
Received: by mail-qk1-f174.google.com with SMTP id s187so14138996qke.8;
        Tue, 28 Jan 2020 09:27:50 -0800 (PST)
X-Gm-Message-State: APjAAAWJYROtQT+P+LQNQi3IZudd4GuQXWFOTIWM8Oka+FV56pWtrymR
        nR1q3+Yjfpe1dNdpOzncUBzHhrxSQ/38S0RXgw==
X-Google-Smtp-Source: APXvYqxWnBqpx/z38JlVgWNF4cQ9OxBTlrKB37T1Va9nNc30arKtXukF/RW57qRkfaYEVw9/c+JiqeGTUuaobBybgTI=
X-Received: by 2002:a05:620a:9c7:: with SMTP id y7mr23200508qky.393.1580232469721;
 Tue, 28 Jan 2020 09:27:49 -0800 (PST)
MIME-Version: 1.0
References: <20200124152504.23411-1-mans@mansr.com> <20200127153506.GA4589@bogus>
 <yw1xy2tsvnww.fsf@mansr.com> <20200128134745.GA3048749@kroah.com>
 <yw1xpnf3vchs.fsf@mansr.com> <20200128152818.GB3437093@kroah.com>
In-Reply-To: <20200128152818.GB3437093@kroah.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 28 Jan 2020 11:27:38 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLiELcXaAJAaD5jk05ifjVvgrRqGtEQJmg5iKxptZi5dw@mail.gmail.com>
Message-ID: <CAL_JsqLiELcXaAJAaD5jk05ifjVvgrRqGtEQJmg5iKxptZi5dw@mail.gmail.com>
Subject: Re: [RESEND][PATCH 1/2] dt-bindings: usb: add non-removable-ports hub property
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 9:28 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 28, 2020 at 03:15:11PM +0000, M=C3=A5ns Rullg=C3=A5rd wrote:
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> >
> > > On Mon, Jan 27, 2020 at 04:56:15PM +0000, M=C3=A5ns Rullg=C3=A5rd wro=
te:
> > >> Rob Herring <robh@kernel.org> writes:
> > >>
> > >> > On Fri, Jan 24, 2020 at 03:25:03PM +0000, Mans Rullgard wrote:
> > >> >> Add a non-removable-ports property that lists the hardwired downs=
tream
> > >> >> ports of a hub.  Although hubs can provide this information, they=
 are
> > >> >> not always configured correctly.  An alternate means of indicatin=
g this
> > >> >> for built-in USB devices is thus useful.
> > >> >>
> > >> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> > >> >
> > >> > I reviewed this already, but since you didn't add my reviewed-by, =
I'm
> > >> > looking at it again and having 2nd thoughts.
> > >> >
> > >> >> ---
> > >> >>  Documentation/devicetree/bindings/usb/usb-device.txt | 4 ++++
> > >> >>  1 file changed, 4 insertions(+)
> > >> >>
> > >> >> diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt=
 b/Documentation/devicetree/bindings/usb/usb-device.txt
> > >> >> index 036be172b1ae..92d863cc96b6 100644
> > >> >> --- a/Documentation/devicetree/bindings/usb/usb-device.txt
> > >> >> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> > >> >> @@ -66,6 +66,10 @@ Required properties for host-controller nodes =
with device nodes:
> > >> >>  - #size-cells: shall be 0
> > >> >>
> > >> >>
> > >> >> +Optional properties for hub and host-controller nodes:
> > >> >> +- non-removable-ports: list of hardwired downstream ports
> > >> >
> > >> > If you have a hardwired device and need to know that, doesn't that=
 imply
> > >> > there's some other stuff you need to describe beyond what a standa=
rd USB
> > >> > device has. Such as a power supply that's not Vbus from the hub.
> > >>
> > >> I suppose there could be, but there isn't in my actual situation.
> > >>
> > >> > At a minimum, I think this should be a per port property.
> > >>
> > >> That's what I suggested first.  Greg told me to do it like this inst=
ead.
> > >
> > > I said that?  I do not remember discussing this at all, when did that
> > > happen?
> >
> > https://lore.kernel.org/lkml/20190228155241.GC12050@kroah.com/
>
> Almost a full year ago!  Hah, I can't remember what I wrote last week.

I was typing up the same thing... :)
