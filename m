Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BB6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9004422B51
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 19:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595272521;
	bh=y7vjF/7Gg0I1ck7MMsCAO02jGh/RyFblscWzzPbMNTY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Dtiu2rFBTiOPMcKipCx63cBvLZamXe1V/1iohfDmnTS0BYa7+eCw19HtrfpcyIMvw
	 b0KasxZYsuGV/vnUB1NBQ+toG89HQD+e1dQpiD1tuKaeobSQB9H7Cfwz9y5DpfrIhJ
	 RpfmIJR8N9O7acZ+yf+TUhbQ+ih6POFeYd6uIUtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730186AbgGTTPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 15:15:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727833AbgGTTPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 15:15:19 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B6A622B51;
        Mon, 20 Jul 2020 19:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595272519;
        bh=y7vjF/7Gg0I1ck7MMsCAO02jGh/RyFblscWzzPbMNTY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RFu8cSEQvecMwBh39qwG5H5zY+mfq5FmgFW9pAi1aAPgLmqfb8s1g8NFs+hmwEcuP
         r28JVhuAtnMFTscgbaDhTTbV6u8UajCLiq6hiu8uV1sn4h3LCW267xLRwYulgIJHXY
         c6FRcJPLzrqQM1toSZTDjrhPXQD3O9q30hs3GuzA=
Received: by mail-oi1-f169.google.com with SMTP id l63so15197606oih.13;
        Mon, 20 Jul 2020 12:15:19 -0700 (PDT)
X-Gm-Message-State: AOAM533unQJ2wZrcxgp3juu4dx2PVOJifqQTK6la5D2dyD71EE0WluZy
        apuUxU+ZvzUQQl92rJzEfOx/ov5eIuHvY2JmyQ==
X-Google-Smtp-Source: ABdhPJxJt9eB3LJsFXU6KUnTkSdkYxCVHUD4AW2u4MEtSuMgxN9FUFdmQ/V73vIzN2u7Age2BlV1QCfDkUb0wEfouYk=
X-Received: by 2002:aca:30d2:: with SMTP id w201mr625735oiw.147.1595272518900;
 Mon, 20 Jul 2020 12:15:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200717144132.2206-1-laurentiu.palcu@oss.nxp.com>
 <20200717144132.2206-5-laurentiu.palcu@oss.nxp.com> <20200720164927.GA2650420@bogus>
 <20200720165537.kwlxwrtlmlijhuoh@fsr-ub1864-141>
In-Reply-To: <20200720165537.kwlxwrtlmlijhuoh@fsr-ub1864-141>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 20 Jul 2020 13:15:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLbYvekVe_YeCKYCDO69RtTTNBoJQ9X1n=K_ToGwrMVXg@mail.gmail.com>
Message-ID: <CAL_JsqLbYvekVe_YeCKYCDO69RtTTNBoJQ9X1n=K_ToGwrMVXg@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] dt-bindings: display: imx: add bindings for DCSS
To:     Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Fabio Estevam <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, lukas@mntmn.com,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:55 AM Laurentiu Palcu
<laurentiu.palcu@oss.nxp.com> wrote:
>
> Hi Rob,
>
> On Mon, Jul 20, 2020 at 10:49:27AM -0600, Rob Herring wrote:
> > On Fri, 17 Jul 2020 17:41:29 +0300, Laurentiu Palcu wrote:
> > > From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > >
> > > Add bindings for iMX8MQ Display Controller Subsystem.
> > >
> > > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > > ---
> > >  .../bindings/display/imx/nxp,imx8mq-dcss.yaml | 104 ++++++++++++++++++
> > >  1 file changed, 104 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> > >
> >
> >
> > Please add Acked-by/Reviewed-by tags when posting new versions. However,
> > there's no need to repost patches *only* to add the tags. The upstream
> > maintainer will do that for acks received on the version they apply.
> >
> > If a tag was not added on purpose, please state why and what changed.
>
> Well, I kind of did exactly that... in the cover letter. I stated
> clearly why this patch needs another look... :/

Put information closest to where it applies which is this patch. I
don't read cover letters typically.

R-by still stands.

Rob
