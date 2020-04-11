Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D1FC2BB86
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 02:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAF82082D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586571029;
	bh=MVZeCBaeFj9XOKurdEfteBiPqF9xwPkxkHqXXdFsTmM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=i142tircO8i3fLJIo9TdeAk01Aa2ME0DXrM8aCzenxRn89fC0ywZVbDLtZKGl/hxe
	 7+qt4HUQr4X1PrmKD49fN7jO+lSa/xVE3hNTUqEtAXv2q3RUGf4vgxNr3BgVEozIA4
	 hMznuatS1n4CBHZkSemi3bVe6d+IDPt+U6vjaJu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgDKCK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 22:10:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgDKCK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 22:10:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54DD92078E;
        Sat, 11 Apr 2020 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586571027;
        bh=MVZeCBaeFj9XOKurdEfteBiPqF9xwPkxkHqXXdFsTmM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Lc2Rz+M3mIlm6bIM9mTDzvxfb6Gozq5W06V1nX10dSvD6r6URkbJuQ88lUvUrzXJO
         /FwpXbZ+CRAkaqbALCOPq/AlnxyH5K5BbG/DPuv02LSWIVXTw2h4g4CWVW4Q6v6gSO
         IgoHrkkJ/gMSIbr/9Pb3Lx9H440PX57svoy1KkJs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFd5g46JHKmrEbYeL_Yu8djPHr-6QwidumLKtdYoYOwC_ALpaQ@mail.gmail.com>
References: <20200408035637.110858-1-sboyd@kernel.org> <CAFd5g46JHKmrEbYeL_Yu8djPHr-6QwidumLKtdYoYOwC_ALpaQ@mail.gmail.com>
Subject: Re: [PATCH/RFC] clk: gate: Add some kunit test suites
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>
To:     Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 10 Apr 2020 19:10:26 -0700
Message-ID: <158657102650.199533.18319832135089303080@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brendan Higgins (2020-04-09 13:09:03)
> On Tue, Apr 7, 2020 at 8:56 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Test various parts of the clk gate implementation with the kunit testing
> > framework.
> >
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Cc: <kunit-dev@googlegroups.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>=20
> One very minor nit below, other than that this looks great! I couldn't
> have done a better job myself.
>=20
> Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
>=20
> > ---
> >
> > This patch is on top of this series[1] that allows the clk
> > framework to be selected by Kconfig language.
> >
> > [1] https://lore.kernel.org/r/20200405025123.154688-1-sboyd@kernel.org
> >
> >  drivers/clk/Kconfig         |   8 +
> >  drivers/clk/Makefile        |   1 +
> >  drivers/clk/clk-gate-test.c | 481 ++++++++++++++++++++++++++++++++++++
> >  3 files changed, 490 insertions(+)
> >  create mode 100644 drivers/clk/clk-gate-test.c
> >
> > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > index 6ea0631e3956..66193673bcdf 100644
> > --- a/drivers/clk/Kconfig
> > +++ b/drivers/clk/Kconfig
> > @@ -377,4 +377,12 @@ source "drivers/clk/ti/Kconfig"
> >  source "drivers/clk/uniphier/Kconfig"
> >  source "drivers/clk/zynqmp/Kconfig"
> >
> > +# Kunit test cases
>=20
> Minor nit: Elsewhere you use KUnit.
>=20
> I wasn't going to say anything because so many people go with the
> "Kunit" capitalization (and actually I kind of prefer it), but you
> should at least be consistent within your patch.

Ok I will go with Kunit. Thanks!
