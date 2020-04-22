Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9443C55186
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:14:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65F22071E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550469;
	bh=QR1NHEAeB7Pb6pt/2UuzlqAk9OkMYR0Ply0bFo3EXSU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=RQn2uMlLbS3pE3wT4AVc388bf9rR+dTXV59M/93ZEt99xbyiSs+Xy21JZiFXbzkmO
	 hzz4kQETz6eaMIFeZqJCY/3GKQC6sNUIpFu1F47a0w1+x+vX9IlL58jlDn9xHNF6h5
	 O4eC9ZZyICkpYc1Q8MmyKvgMEPwVKTEpi1ER7tyU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbgDVKO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:14:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:48866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbgDVKOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:14:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D5020575;
        Wed, 22 Apr 2020 10:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550461;
        bh=QR1NHEAeB7Pb6pt/2UuzlqAk9OkMYR0Ply0bFo3EXSU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=tGD3b6T0+ZDbE6+isLMUgz5WS+FTXFukeNNEvEbF3Yr5vSdkrCZ3c4K8SkPtUw8l8
         mmodx0FjFCH1RihFODV/EuIjNM4OYdVo/1iSF/cFNZa06j9RDLFw0/C9rTRlxVYeTr
         k4R6Dt1pLqsXTC1pip1xJ1iZfiQ7+BJAgghUWP6k=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPDyKFqpS=wke5Y=rTeq3+8bQyacVHcbWnBwG5pxsJ4hPys+9g@mail.gmail.com>
References: <20200409064416.83340-1-sboyd@kernel.org> <20200409064416.83340-7-sboyd@kernel.org> <CAPDyKFqpS=wke5Y=rTeq3+8bQyacVHcbWnBwG5pxsJ4hPys+9g@mail.gmail.com>
Subject: Re: [PATCH v2 06/10] mmc: meson-mx-sdio: Depend on OF_ADDRESS and not just OF
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 22 Apr 2020 03:14:20 -0700
Message-ID: <158755046077.159702.10648240040343779828@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ulf Hansson (2020-04-21 07:04:54)
> On Thu, 9 Apr 2020 at 08:44, Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Making COMMON_CLK a visible option causes the sparc allyesconfig to fail
> > to build like so:
> >
> >    sparc64-linux-ld: drivers/mmc/host/meson-mx-sdio.o: in function `mes=
on_mx_mmc_remove':
> >    meson-mx-sdio.c:(.text+0x70): undefined reference to `of_platform_de=
vice_destroy'
> >    sparc64-linux-ld: drivers/mmc/host/meson-mx-sdio.o: in function `mes=
on_mx_mmc_probe':
> >    meson-mx-sdio.c:(.text+0x9e4): undefined reference to `of_platform_d=
evice_create'
> >    sparc64-linux-ld: meson-mx-sdio.c:(.text+0xdd4): undefined reference=
 to `of_platform_device_destroy'
> >
> > This is because the implementation of of_platform_device_destroy() is
> > inside an #ifdef CONFIG_OF_ADDRESS section of drivers/of/platform.c.
> > This driver already depends on OF being enabled, so let's tighten that
> > constrain a little more so that it depends on OF_ADDRESS instead. This
> > way we won't try to build this driver on platforms that don't have this
> > function.
> >
> > Reported-by: kbuild test robot <lkp@intel.com>
> > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Stephen Boyd <sboyd@kernel.org>
>=20
> I don't have the complete picture here, can I just apply this a fix to
> my mmc tree?
>=20

If this patch stays in the series then I can avoid a bisection hole. And
it also doesn't matter until COMMON_CLK config becomes selectable. Maybe
just ack and let it go through clk tree? Unless there's something
changing here in the mmc tree?
