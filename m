Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA908C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83D7820729
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d7Aa9uvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHJIxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgHJIxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:53:43 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E3FC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:53:43 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id g26so7650922qka.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hn/uvI5guaY3D0G4/sdlh6Gx/KpGc+PN8jIJlWv4gfw=;
        b=d7Aa9uvkgM7oBz+js2KgV6ryeTcBKg1+nuyabNAVpCSEqUIVRt494wY2baViHTGqKZ
         aF8nGJPx0RtjOgE/N1sdXrZ5LC0r/EHlwHUFetfeuk2Shc5Vgs2rX7/rFOfAJ9fOSvZX
         c03EyDruLop4NtSphCrDRGpVngIJMJJhzgRS8dseZLs8U/scj0te95vbIW8mYJqoro1t
         cIgFamiIKdggQQ8iXVxxwWkmWuXVpJkxyQRerU5lir3AWhL1OVYlRUkI5PFHFweMQssu
         f5lmFSUmVMWE08JFuNHHPBbwf+uMCMnNuki5SkOm8ov4A5AFAwy2zcaornwwpbm+zdOD
         5hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hn/uvI5guaY3D0G4/sdlh6Gx/KpGc+PN8jIJlWv4gfw=;
        b=e1MygrkKJuv9TIyxEShyGI3MSKNvVnO1uVtSTs5xSfq2GE/22AtMtFIwcpeKXvIoFf
         GWIqY2izdC24VMJBHdEwuXnyJ2b1dzeExXCmY3vn7MdtRy0txwM2lwK42VisZG779gR1
         Gc5/MDfxCzgbHF1eobXvcflES/svxT/56m5CKfakmKkdU3YrDSS6qQPs2skVfd3OwcCb
         3BfNWzT773O6Uji/ka1E73zbFOW7yJCdDlV9AC/oLESQf90e+37OgNkPWIYh888sdY3Z
         O462AeKr+EjfwLEAGmiKIqDK1m2iOKzZ5LHcxDUlePojRv6StaZjcBiIqvD1oPsc+i0a
         2iqA==
X-Gm-Message-State: AOAM531FhNyrDiUwEZfVPyRLVrRQwuSZBZ6tLQ4McVuYeaQqX1uMr0ik
        u8euTypgCv774pDoHR3tvEuQuJwohUTzG1VNKcc=
X-Google-Smtp-Source: ABdhPJw4PLTjbhjwDy6EiKaJ7HTrl8YRVLWi1NAyqs9jnrxv1KPWBcnGXX4x7q7HcmegO6cIZyeDvkpZWdqQjLRd+WU=
X-Received: by 2002:a37:e92:: with SMTP id 140mr24720492qko.121.1597049622701;
 Mon, 10 Aug 2020 01:53:42 -0700 (PDT)
MIME-Version: 1.0
References: <1596791682-4311-1-git-send-email-shengjiu.wang@nxp.com> <20200810080018.GA13408@Asurada-Nvidia>
In-Reply-To: <20200810080018.GA13408@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Mon, 10 Aug 2020 16:53:31 +0800
Message-ID: <CAA+D8AP6thymUXN_OTGMxz6Xun0c8Ep0s1-LKj6b0odoBQ0K=g@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Add -EPROBE_DEFER check for regmap init
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 4:02 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Fri, Aug 07, 2020 at 05:14:42PM +0800, Shengjiu Wang wrote:
> > Regmap initialization may return -EPROBE_DEFER for clock
> > may not be ready, so check -EPROBE_DEFER error type before
> > start another Regmap initialization.
> >
> > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > ---
> >  sound/soc/fsl/fsl_sai.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index a22562f2df47..eb933fe9b6d1 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -927,7 +927,7 @@ static int fsl_sai_probe(struct platform_device *pdev)
> >                       "bus", base, &fsl_sai_regmap_config);
> >
> >       /* Compatible with old DTB cases */
> > -     if (IS_ERR(sai->regmap))
> > +     if (IS_ERR(sai->regmap) && PTR_ERR(sai->regmap) != -EPROBE_DEFER)
> >               sai->regmap = devm_regmap_init_mmio_clk(&pdev->dev,
> >                               "sai", base, &fsl_sai_regmap_config);
> >       if (IS_ERR(sai->regmap)) {
>
> In that case, might need a !EPROBE_DEFER check for this
> fallback devm_regmap_init_mmio_clk at "sai" clock too?

No, I think it is ok for this fallback to return directly with
EPROBE_DEFER.

best regards
wang shengjiu
