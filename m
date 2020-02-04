Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB73C3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DD852192A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 10:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rITuRlnU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgBDK7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 05:59:42 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38866 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgBDK7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 05:59:41 -0500
Received: by mail-qk1-f195.google.com with SMTP id 21so345502qki.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 02:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OkYuSAHSvR9IiWlcEsrQapzeBiIfaoP2obtZIjgXQhs=;
        b=rITuRlnU5/24sQNwIAAIdWCPBPPBD353FYTZvrULxlwi2ajLaJpHIUmUjtLGA4NvOs
         Vw0gnzxypm5dmKpNeYwo9Jr6qEc/iPregoYplOyR8itbWunGqVIzzFqeAClewPy/eJcI
         pOFpyvvCPqg2QPnaMa1baSZ4Epw9tMeEFv4pHP2tb1behBX1096LA6gMrDoL5XeOGa4A
         wK7wwwp0b3LKC8aub/4AljYlboky34EsIRUjoNs1FF+E09Wfqb+ajh8k8vSd8E1UpTt0
         AGTBrMXe9IWJxZWinTXd5Lk72BZl5qU0BqZiYnxcapLmPdJwY5/EvEVEnhuEaZDyxYOY
         ijuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OkYuSAHSvR9IiWlcEsrQapzeBiIfaoP2obtZIjgXQhs=;
        b=MazzrVxoYBJN9peDRr/kmGWfm3qXrXIoUVmzojX003BkXCNeQOeej/FUVmjfv2xIRK
         zKlcDWqU5xetvV+UjZTvE+BGwlL2SIcrcUQ/a7XK8YvrWOahKFWJd9VRuCi0k7kn1j86
         IyWUAWng4Rw44ptuHH4EUbvs6Azetf0bKvBXgptsg0Q4OJoxiWpU/WfBZo5pu8EuwaW4
         H0pUyLRW2FZvvdAFKsEo3i3Og6BTQxWPZcFqlJJ7zFiUQGFb3Z7BPf5oDhOGKSC3iGFx
         34hSf+aKHrqkxxjSJ3pxgmN1n1xwfQDTRUrY2O/DB5ImGxhgxiY8Clbu+JzpxCVFQDZ5
         kG3w==
X-Gm-Message-State: APjAAAXIelQ1h7v58h6j+HI/3hUjWGUDwbs2tbgDSMR8f7g4RNgCjTS/
        ZBWM4V9xpewi2RbCiyorPDoMZGg8Jgsj2vZSEHky45+/m+0=
X-Google-Smtp-Source: APXvYqwW+VXZSsGTnbaiHcIw6633UG2ZmqWmA1RIngmVgnjon5IKG3UFUyO2ideE4wKuZmUV4TLy1aHR+b//QPX9+Qw=
X-Received: by 2002:a37:9c07:: with SMTP id f7mr28696197qke.103.1580813980425;
 Tue, 04 Feb 2020 02:59:40 -0800 (PST)
MIME-Version: 1.0
References: <1579602245-7577-1-git-send-email-yannick.fertre@st.com> <1fd9adf5-873b-2b9d-fe22-278f2ea64746@st.com>
In-Reply-To: <1fd9adf5-873b-2b9d-fe22-278f2ea64746@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Tue, 4 Feb 2020 11:59:29 +0100
Message-ID: <CA+M3ks45=r+gQ9bHaiaNObVFBA07XyDm=gPrwSq7o9EHdhVz5g@mail.gmail.com>
Subject: Re: [PATCH] drm/stm: dsi: stm mipi dsi doesn't print error on probe deferral
To:     Philippe CORNU <philippe.cornu@st.com>
Cc:     Yannick FERTRE <yannick.fertre@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 23 janv. 2020 =C3=A0 10:54, Philippe CORNU <philippe.cornu@st.com> =
a =C3=A9crit :
>
> Dears Yannick & Etienne,
> Thank you for your patch,
>
> Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
>
> Philippe :-)
>
> On 1/21/20 11:24 AM, Yannick Fertre wrote:
> > From: Etienne Carriere <etienne.carriere@st.com>
> >
> > Change DSI driver to not print an error trace when probe
> > is deferred for a clock resource.

Applied on drm-misc-next?
Thanks,
Benjamin

> >
> > Signed-off-by: Etienne Carriere <etienne.carriere@st.com>
> > ---
> >   drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/st=
m/dw_mipi_dsi-stm.c
> > index 4b16563..2e1f266 100644
> > --- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > +++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
> > @@ -377,7 +377,9 @@ static int dw_mipi_dsi_stm_probe(struct platform_de=
vice *pdev)
> >       dsi->pllref_clk =3D devm_clk_get(dev, "ref");
> >       if (IS_ERR(dsi->pllref_clk)) {
> >               ret =3D PTR_ERR(dsi->pllref_clk);
> > -             DRM_ERROR("Unable to get pll reference clock: %d\n", ret)=
;
> > +             if (ret !=3D -EPROBE_DEFER)
> > +                     DRM_ERROR("Unable to get pll reference clock: %d\=
n",
> > +                               ret);
> >               goto err_clk_get;
> >       }
> >
> >
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
