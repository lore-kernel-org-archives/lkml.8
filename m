Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A8DC41621
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CCAC2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 02:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585101810;
	bh=a5sLoUg3Aive4Nmani892KB5AR+S11H+jgOesQ0f2Jk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=zktTPC/gDrdlRJxMasTNipCAEP8p2NygxlwW3ZcwLHn+ckHiyj0nHMIuLt+nfjc3Y
	 +485PdzKHBJhESWE2axApJKcxGuLtIDEwDs2y1z5Ffa7bNf4yToDxE9MwFRfAY8CVZ
	 VsoNB11ytZW3v1rwS/r0msDQPsC28P4dFp/eVQIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727313AbgCYCD3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 22:03:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:54094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727228AbgCYCD3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 22:03:29 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B06ED2072E;
        Wed, 25 Mar 2020 02:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585101808;
        bh=a5sLoUg3Aive4Nmani892KB5AR+S11H+jgOesQ0f2Jk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=nXqYsA8gR4DGM8yJWM6Tcz5upFPlsg1rzKbvVHANs47RRcIIYvlNMeu8Jsfa9aWnD
         H/GmgmUB/wJAzvWH++8eV5VxNo/lJOsMQn7ZYb8gQaJqhRXN1jHgzDSTZnmPzgd8Nn
         nrLzr6CbX5YL94XD22HqWI795y2f7OzhXrSK0aic=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAfSe-sQnZLn8J7Ct5OES=2PmT-nGT-_0zXxRaO=mcHVtgTcnQ@mail.gmail.com>
References: <20200304072730.9193-1-zhang.lyra@gmail.com> <20200304072730.9193-4-zhang.lyra@gmail.com> <158475317083.125146.1467485980949213245@swboyd.mtv.corp.google.com> <CAAfSe-sQnZLn8J7Ct5OES=2PmT-nGT-_0zXxRaO=mcHVtgTcnQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] dt-bindings: clk: sprd: add bindings for sc9863a clock controller
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Tue, 24 Mar 2020 19:03:27 -0700
Message-ID: <158510180797.125146.1966913179385526344@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chunyan Zhang (2020-03-22 04:00:39)
> Hi Stephen,
>=20
> On Sat, 21 Mar 2020 at 09:12, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Chunyan Zhang (2020-03-03 23:27:26)
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > add a new bindings to describe sc9863a clock compatible string.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > [...]
> > > +examples:
> > > +  - |
> > > +    ap_clk: clock-controller@21500000 {
> > > +      compatible =3D "sprd,sc9863a-ap-clk";
> > > +      reg =3D <0 0x21500000 0 0x1000>;
> > > +      clocks =3D <&ext_26m>, <&ext_32k>;
> > > +      clock-names =3D "ext-26m", "ext-32k";
> > > +      #clock-cells =3D <1>;
> > > +    };
> > > +
> > > +  - |
> > > +    soc {
> > > +      #address-cells =3D <2>;
> > > +      #size-cells =3D <2>;
> > > +
> > > +      ap_ahb_regs: syscon@20e00000 {
> > > +        compatible =3D "sprd,sc9863a-glbregs", "syscon", "simple-mfd=
";
> > > +        reg =3D <0 0x20e00000 0 0x4000>;
> > > +        #address-cells =3D <1>;
> > > +        #size-cells =3D <1>;
> > > +        ranges =3D <0 0 0x20e00000 0x4000>;
> > > +
> > > +        apahb_gate: apahb-gate@0 {
> >
> > Why do we need a node per "clk type" in the simple-mfd syscon? Can't we
> > register clks from the driver that matches the parent node and have that
> > driver know what sorts of clks are where? Sorry I haven't read the rest
> > of the patch series and I'm not aware if this came up before. If so,
> > please put details about this in the commit text.
>=20
> Please see the change logs after v2 in cover-letter.
>=20
> Rob suggested us to put some clocks under syscon nodes, since these
> clocks have the same
> physical address base with the syscon;

Ok. I'll apply the series to clk-next then.
