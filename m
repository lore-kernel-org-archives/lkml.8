Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E26C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5374D2074A
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590954516;
	bh=oMG31ruizf0PT2eqzYHe3Y//MErsN7jgOSJtM3J6bno=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=0e9E2+Rg5aVELG5z87qWwn0f0lvArfTcu+Qdgjka88a4uac4GupkOEpQA8ornkEXw
	 M80borIyt4BCraj4l5tEDP3EbqSoP9aJh5j9RXq3LdyuhucnslelRh/rJXiN5QxZKZ
	 UrnPQve1maFXRjktjbiTovAlXeom5HtyVY3Jw0wE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgEaTsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 15:48:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:34368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgEaTsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 15:48:35 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE752206A1;
        Sun, 31 May 2020 19:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590954514;
        bh=oMG31ruizf0PT2eqzYHe3Y//MErsN7jgOSJtM3J6bno=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TFNEkgeMKZhqg/D78OXoww71gIeIvns30seeelalOwhlj3RnPEGsSfzMS5S3OBQ3q
         MABGkpcDCLCZ1EkzjZzJyXKfEzpLWBS9VyEyl9+k+3rv697DzRd6GaQdzqqwsnsmcw
         iVkuW2vUzdoQn8hbIKjhuKkj0kGePPV1HvPxqRPE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <d5813ebc-dcb2-afc2-7a7e-71e73113f8fc@infradead.org>
References: <20200531174612.260113-1-konradybcio@gmail.com> <20200531174612.260113-5-konradybcio@gmail.com> <d5813ebc-dcb2-afc2-7a7e-71e73113f8fc@infradead.org>
Subject: Re: [PATCH 4/4] driver: clk: Add msm8992 GCC Kconfig and Makefile entries
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Konrad Dybcio <konradybcio@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
Date:   Sun, 31 May 2020 12:48:34 -0700
Message-ID: <159095451410.69627.2951185163238676732@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Randy Dunlap (2020-05-31 10:50:26)
> On 5/31/20 10:46 AM, Konrad Dybcio wrote:
> > Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> > ---
> >  drivers/clk/qcom/Kconfig  | 8 ++++++++
> >  drivers/clk/qcom/Makefile | 1 +
> >  2 files changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> > index 11ec6f466467..d102b4015289 100644
> > --- a/drivers/clk/qcom/Kconfig
> > +++ b/drivers/clk/qcom/Kconfig
> > @@ -197,6 +197,14 @@ config MSM_MMCC_8974
> >         Say Y if you want to support multimedia devices such as display,
> >         graphics, video encode/decode, camera, etc.
> > =20
> > +config MSM_GCC_8992
> > +     tristate "MSM8992 Global Clock Controller"
> > +     select QCOM_GDSC
> > +     help
> > +       Support for the global clock controller on msm8992 devices.
> > +       Say Y if you want to use peripheral devices such as UART, SPI,
> > +       i2c, USB, SD/eMMC, PCIe, etc.
>=20
>           I2C
> please.

Also please put someone in the "To:" field of these emails.
