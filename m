Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FA01C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F822065C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:02:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r8YCpftd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgEOKCN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgEOKCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:02:12 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733C3C061A0C;
        Fri, 15 May 2020 03:02:12 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id t25so1453533qtc.0;
        Fri, 15 May 2020 03:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IcUXaEpbXUpVL01oFB6hRlgR7PeeYt7QBRNoruvyCbY=;
        b=r8YCpftd/P5xTvlYz3ynLdKuAbb+OBjgoQ+380Hvgp8upI9U0p29w3r2M23HNeCgny
         McaR//XORw7nRXahwn89WFF8xUs69HoY61LqdifB+ntJhZBcgCEhRowcUg3hY3cYjKZ0
         6F59Y/UK6GcZ4mbkdZLbEumgJq5MUdfRZhRLqfiwOq51Dbl3T7F8lYTDBhMspj1vAuvq
         nJydlHTEGiCKCqeftb0h7NchqDXRkBxaHSPSCfSS0nO5gwg6en13tc786ZnofttzAwsx
         pTizqaZb2nXkk1NFaVceiuZLCPW0zb3K6jE3itFdgovcgWjul7Fb0avWf1RtyBzW0gE8
         lonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IcUXaEpbXUpVL01oFB6hRlgR7PeeYt7QBRNoruvyCbY=;
        b=BpG7OKdYIbKlUmLKp9XnUqim61O5CBNw5DLumEWAmoBLIY/TKGGYVkPHRMXV5U0BQW
         aXlKgHS+qz/mYmwax+UuANRLWclMz6YSfxyIqNbNShMdwKtsX45+bifr/FshAAWTdUOE
         lnxBGriQZ0RC4hvzOZ/ADXDpK2pCtWPrtwzBSO2gcfwzs1qQp1nhXytYxBZSxdih+b/g
         rZIw7u5iSLBHGpM5TxPcA3kgiefTP+BJm0tMOWryDAloW1ShK15hNmzKkHKBrpKS5WKn
         FX7O0EHCP3h9n1xXW/OjNK4lTBD7nqfoRCc3bfnIyy8CJfHgRIBkCOHmXrbAa+qtZFnq
         /wzA==
X-Gm-Message-State: AOAM531TKXuipdQACI9bRgkNSmnwpHV39gd9IpE/MtP8G6wrfV0K7MXy
        PP6P1tcCeUzVSgjgO/t9cbrn7lEviTqrLsTh13M=
X-Google-Smtp-Source: ABdhPJyznFMUdqKh5MEAtGN+Z5aVH5R/r5Mj4195QZGvA37EfsjjNUwLr+rQki1u4TDjULiTD0B2I6/8TxiO06OU3cA=
X-Received: by 2002:ac8:302f:: with SMTP id f44mr2485555qte.121.1589536931527;
 Fri, 15 May 2020 03:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588320655.git.shengjiu.wang@nxp.com> <a933bafd2d6a60a69f840d9d4b613337efcf2816.1588320656.git.shengjiu.wang@nxp.com>
 <20200501102158.GA5276@sirena.org.uk> <CAA+D8ANDHHejFD1rYmFOG24yivpEJa+xO-WpVr=Vzfz9yW9H7g@mail.gmail.com>
 <CAA+D8ANK+Sd=nPeDZpd_=fQRFOdLtKgvsCmfQ_fRU3RCjMY+rQ@mail.gmail.com> <20200512123801.GG5110@sirena.org.uk>
In-Reply-To: <20200512123801.GG5110@sirena.org.uk>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Fri, 15 May 2020 18:01:57 +0800
Message-ID: <CAA+D8ANTv3R-vDki3No0rG++u4OKrNFGh_Eq3DNLSAQ4f=mLwQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] ASoC: fsl_esai: Add support for imx8qm
To:     Mark Brown <broonie@kernel.org>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 8:38 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 12, 2020 at 10:48:41AM +0800, Shengjiu Wang wrote:
> > On Wed, May 6, 2020 at 10:33 AM Shengjiu Wang <shengjiu.wang@gmail.com> wrote:
> > > On Fri, May 1, 2020 at 6:23 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > > > EDMA requires the period size to be multiple of maxburst. Otherwise
> > > > > the remaining bytes are not transferred and thus noise is produced.
>
> > > > If this constraint comes from the DMA controller then normally you'd
> > > > expect the DMA controller integration to be enforcing this - is there no
> > > > information in the DMA API that lets us know that this constraint is
> > > > there?
>
> > > No, I can't find one API for this.
> > > Do you have a recommendation?
>
> > could you please recommend which DMA API can I use?
>
> Not off-hand, you'd probably need to extend the API to export the
> information.

Thanks.  I will think about if I can find a better solution.
And I will drop this change and send v2 of this patch-set.
