Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55ADFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C0A20707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590724959;
	bh=SUeeMnXBQv07CP4CjczpzAFDq4JU1ywIaRU3dK0REGE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Vozu2p/nH9EDTTg8IqnQDmmCxACuMN1zpAuu/I5bW3naWAyq4MhKB2mRzi0CeAkG2
	 cD2U4f0XEiSp+iU5P4SxPkGD6sx2x4LdFib5NraduqZehWvtxbpYB6ly5pvDKVQr86
	 Pp6w8JdRmNg/A9ho03vEZ/JHglCOYVc9RXQjZTPQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgE2ECh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgE2ECe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:02:34 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A00F20707;
        Fri, 29 May 2020 04:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590724953;
        bh=SUeeMnXBQv07CP4CjczpzAFDq4JU1ywIaRU3dK0REGE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DUZQ4UhXvN4PWoCll68uRt/AGJC2mWktTXUd0Cd4TFZLVmnrFmhxkSsnwC9KPFLLz
         A6QH5dGvS1ERBFtiblS4E6dyYDKoWfCcBNuM1hpqo+G45+X3TTK5PQj9AcGCwanuSx
         tJIxlHs6QBoSw80WCPcCHUlMB2+Ck+YercVJOygg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAHCN7xLtLPqZV7Qhs1zufzLES3LTh11yyAmOto7EwDQyDEvrVQ@mail.gmail.com>
References: <20200502122126.188001-1-aford173@gmail.com> <20200502122126.188001-2-aford173@gmail.com> <20200512220537.GA14318@bogus> <CAHCN7xLtLPqZV7Qhs1zufzLES3LTh11yyAmOto7EwDQyDEvrVQ@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] clk: vc5: Enable addition output configurations of the Versaclock
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk <linux-clk@vger.kernel.org>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Charles Stevens <charles.stevens@logicpd.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>
Date:   Thu, 28 May 2020 21:02:32 -0700
Message-ID: <159072495287.69627.17133221754230289904@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Adam Ford (2020-05-12 15:21:49)
> On Tue, May 12, 2020 at 5:05 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sat, May 02, 2020 at 07:21:25AM -0500, Adam Ford wrote:
> > > The existing driver is expecting the Versaclock to be pre-programmed,
> > > and only sets the output frequency.  Unfortunately, not all devices
> > > are pre-programmed, and the Versaclock chip has more options beyond
> > > just the frequency.
> > >
> > > This patch enables the following additional features:
> > >
> > >    - Programmable voltage: 1.8V, 2.5V, or 3.3V
> > >    - Slew Percentage of normal: 85%, 90%, or 100%
> > >    - Output Type: LVPECL, CMOS, HCSL, or LVDS
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> >
> > > diff --git a/include/dt-bindings/clk/versaclock.h b/include/dt-bindin=
gs/clk/versaclock.h
> > > new file mode 100644
> > > index 000000000000..c6a6a0946564
> > > --- /dev/null
> > > +++ b/include/dt-bindings/clk/versaclock.h
> >
> > Belongs in binding patch.
>=20
> I can do that, but the binding patch will have to be applied before
> the rest of the series, or the source won't build because it's
> referencing the bindings.  Is that OK?

Yes that's usually how it works.
