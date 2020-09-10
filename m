Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE593C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96B0221D92
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599773386;
	bh=Lw1AavgBJDMN0TOVehj0nCFIxgBa9OzPfRDPECT1e+U=;
	h=In-Reply-To:References:Subject:From:To:Date:List-ID:From;
	b=NkeSGrYtnJM2Y+4nvPE9fCYkQAju5MsTtl79Gd67jTPBW9YG3t28OibvgBHox3Gxa
	 ++YF+jIgh3ES+YXJPtADylnThuGh895dsERLunUfzhZPDLtn83gHPnqVV/eBcPdeDl
	 WU34EooLwjZKnyb4wXam/zSeVU6F2qWiQlmxflQ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728326AbgIJV3f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:29:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728201AbgIJV3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 17:29:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9573E221E2;
        Thu, 10 Sep 2020 21:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599773354;
        bh=Lw1AavgBJDMN0TOVehj0nCFIxgBa9OzPfRDPECT1e+U=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=PXJr4h8aRaDGP/eHraHoXO/fHaqKfTlU4e3y75uDNY/gRfRmYTuucjeBalXK54atR
         hb/xlMEHupurUagfpRPzPlMLJsr8vFxfIBPbeh6GUPCF//g/Arup3Y8X/4CQ645UNp
         /4wA9n+YxR+54YelCbAEfnorOjqmfOwvodFDXYik=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8a594a9d-8e10-6e01-908c-8e59da1d7fbe@oracle.com>
References: <20200907085740.1083-1-t-kristo@ti.com> <8a594a9d-8e10-6e01-908c-8e59da1d7fbe@oracle.com>
Subject: Re: [PATCH 0/3] clk: keystone: some minor fixes
From:   Stephen Boyd <sboyd@kernel.org>
To:     Tero Kristo <t-kristo@ti.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        santosh.shilimkar@oracle.com, ssantosh@kernel.org
Date:   Thu, 10 Sep 2020 14:29:13 -0700
Message-ID: <159977335346.2295844.11165311759086345858@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting santosh.shilimkar@oracle.com (2020-09-08 10:19:32)
>=20
>=20
> On 9/7/20 1:57 AM, Tero Kristo wrote:
> > Hi Santosh,
> >=20
> > This series contains a few fixes for the TI SCI clock driver.
> > - Patch #1 is a clear bug fix, where we missed to parse assigned-clock
> >    data properly to detect which clocks are in use on the SoC.
> > - Patch #2 is a performance improvement patch which avoids some
> >    unnecessary round trips to firmware side while setting clock
> >    frequency.
> > - Patch #3 fixes some issues with set_rate passed to firmware, where the
> >    parameters are too strict; namely, firmware fails to handle some cas=
es
> >    properly if min,tgt,max values for a clock rate are exactly the same
> >    value. Yeah, the firmware is quite weird here but nothing much else =
we
> >    can do from kernel side other than this....
> >=20
> Looks fine to me Tero.
>=20
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
>=20
>=20
> Hi Stephen, Mike,
> Can you please pick these fixes via clk tree ?

Sure. I assume this is -next material and not critical fixes.
