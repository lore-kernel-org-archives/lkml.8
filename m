Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F41C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1C9A2168B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550082;
	bh=+9cAmBytFDRq8v6DYSm8WyN2UcW1McuocntwVo6iKUg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=HLD+iesW6z+M1hPAT2qEPCK/WUkajLzAlHXjr0uGHxIgo7STiZjFnDMVIUFbsGXKY
	 eRPVGeYNdvoBONunU9MDUshMX4Et6/Dqdrvh1GpM8YcuTrsGWMnLFtrRzBJ+mZbJBl
	 e3i2GJzPn/i4IdOjPlkz26KipxKZrYqoX75P81u0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgBLX2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:28:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLX2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:28:01 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FFED20848;
        Wed, 12 Feb 2020 23:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550080;
        bh=+9cAmBytFDRq8v6DYSm8WyN2UcW1McuocntwVo6iKUg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=r+POCyTBoKgcIxvtq7ycJ+KCMoaMiduzaZZ3xQ1SduU7sjMokzzjOtPw6wqwZS3io
         eU2lNzojqF0xej67TAjee758E6QUFOLcPBr/IOOQFkAu/ieFSPcEww5snQX4wqChXy
         MY6fMSsDNmdFYDbCy7CC7F6cyPJGTOR59Nf+kmb8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1jv9okazq9.fsf@starbuckisacylon.baylibre.com>
References: <20200205232802.29184-1-sboyd@kernel.org> <20200205232802.29184-2-sboyd@kernel.org> <1jv9okazq9.fsf@starbuckisacylon.baylibre.com>
Subject: Re: [PATCH v2 1/4] clk: Don't cache errors from clk_ops::get_phase()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Wed, 12 Feb 2020 15:27:59 -0800
Message-ID: <158155007950.184098.15676908208357845365@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-02-06 00:26:06)
>=20
> On Thu 06 Feb 2020 at 00:27, Stephen Boyd <sboyd@kernel.org> wrote:
>=20
> > We don't check for errors from clk_ops::get_phase() before storing away
> > the result into the clk_core::phase member. This can lead to some fairly
> > confusing debugfs information if these ops do return an error. Let's
> > skip the store when this op fails to fix this. While we're here, move
> > the locking outside of clk_core_get_phase() to simplify callers from
> > the debugfs side.
> >
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> > ---
> >  drivers/clk/clk.c | 48 +++++++++++++++++++++++++++++++----------------
> >  1 file changed, 32 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index d529ad67805c..26213e82f5f9 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -2660,12 +2660,14 @@ static int clk_core_get_phase(struct clk_core *=
core)
> >  {
> >       int ret;
> > =20
> > -     clk_prepare_lock();
>=20
> Should the function name get the "_nolock" suffix then ?
>=20

I figure we can add such a one if clk_core_ prefix isn't enough to
differentiate.
