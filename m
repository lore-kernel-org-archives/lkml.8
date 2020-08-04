Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F6EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F2F22076E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eysYRozR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729294AbgHDHyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgHDHyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:54:03 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C39AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:54:03 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id h21so23852195qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 00:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvk2qNJvO4GyMY2u27NANNM906H79e7FKsYTERAdnHs=;
        b=eysYRozRxiQ0O/eMhXGkxC1m3FgN4Jt0xHrm4uYJtWyGG7WjOqRIlTB8gdny8xLP6A
         u7Cn8L1W3Mc7uu+D5/u3m+yx9DXNuA2huNax+By2Pxi1IsNpncHuICg0rCObHzZsTBOS
         QQFQ889zRHK9ooUTBzN+nToW6VypY+rY8vnkUoPeWav2WnOadMVqNsMVYTp2jYFTKqMe
         qrR2wNv7IO3bzcXN0Ao6N8NkLzEMfov2TG1XAcCtd2u45HkZeZJDmtvxP+5x6G3GqOcc
         JSmW+9liUjRTPh6nU2ienoROfCE0FU1PRm+ZDnyqgzo/htm4F1SpTs+10d5Qt9SHnjix
         1EQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvk2qNJvO4GyMY2u27NANNM906H79e7FKsYTERAdnHs=;
        b=t8F+DGGG14j6U66D8yo9Vymgzdpnk4zXVCT7nwWROkRL7cuy9xrRS+sXK0kmttPPHQ
         nDghBIFQuvwY/RGa7VP3B8oAEG9ESLb0upM/ozHI+patVzgqsGkmnZocQvBTZtDN03Tw
         enktF0C/To9mBDIeKAspxMCWJchW4W6Zl6pnauZyIILmGSicfgky79UTp4wPQ61PlUN6
         RtkN2O9xEXqZOwqsJvftOhtXTnjUyEnl45EedmdVQZbQQAQ+tdiqDB8O2X2BhtYkAdYL
         nECZAjl4tb7VTuUMLUZcGJ3NEoujcf4q4jCmZ/g9xN6pnSwe4RAhUxvO+XN9KsvL8eIs
         aO+Q==
X-Gm-Message-State: AOAM532QtQishLlvIxdiYwE/8JJ7JMA4w7zRuZMAUp/3/JN4X60+6b2J
        +ORCvfbBKeoZ8vXXQgdYyecJ2kETyK8Ooj0+GpI=
X-Google-Smtp-Source: ABdhPJwoa5DLrSm+W2b1xh4wQw7NjhToyJBBLi3p9xIFguNDLPkDzaHtItg0/IPC5AOH6cXxxN5AKvNEE3xnih+beLw=
X-Received: by 2002:ac8:564f:: with SMTP id 15mr20407066qtt.54.1596527642821;
 Tue, 04 Aug 2020 00:54:02 -0700 (PDT)
MIME-Version: 1.0
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia> <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
 <20200803215735.GA5461@Asurada-Nvidia> <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
 <20200804021114.GA15390@Asurada-Nvidia> <CAA+D8ANagfMXPAkK4-vBDY9rZMukVUXs8FfBCHS0avXt57pekA@mail.gmail.com>
 <20200804030004.GA27028@Asurada-Nvidia> <CAA+D8ANuLQuUO+VsABjt2t1ccK+LGayq13d6EEcV18=4KNaC+w@mail.gmail.com>
 <CAA+D8AP=27SdR68T-LiQHkJ0_dJaqtgcS-oi9d8arUzvTz5GwA@mail.gmail.com> <20200804070345.GA27658@Asurada-Nvidia>
In-Reply-To: <20200804070345.GA27658@Asurada-Nvidia>
From:   Shengjiu Wang <shengjiu.wang@gmail.com>
Date:   Tue, 4 Aug 2020 15:53:51 +0800
Message-ID: <CAA+D8ANodghXDbUVOqpf9uq8A5FVbDFEFkf4dWdyMUNDTPaJ7A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
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

On Tue, Aug 4, 2020 at 3:04 PM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> On Tue, Aug 04, 2020 at 12:22:53PM +0800, Shengjiu Wang wrote:
>
> > > > Btw, do we need similar change for TRIGGER_STOP?
> > >
> > > This is a good question. It is better to do change for STOP,
> > > but I am afraid that there is no much test to guarantee the result.
>
> > Maybe we can do this change for STOP.
>
> The idea looks good to me...(check inline comments)
>
> > diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> > index 1c0e06bb3783..6e4be398eaee 100644
> > --- a/sound/soc/fsl/fsl_sai.c
> > +++ b/sound/soc/fsl/fsl_sai.c
> > @@ -517,6 +517,37 @@ static int fsl_sai_hw_free(struct
> > snd_pcm_substream *substream,
> >         return 0;
> >  }
> >
> > +static void fsl_sai_config_disable(struct fsl_sai *sai, bool tx)
> > +{
> > +       unsigned int ofs = sai->soc_data->reg_offset;
> > +       u32 xcsr, count = 100;
> > +
> > +       regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
> > +                          FSL_SAI_CSR_TERE, 0);
> > +
> > +       /* TERE will remain set till the end of current frame */
> > +       do {
> > +               udelay(10);
> > +               regmap_read(sai->regmap, FSL_SAI_xCSR(tx, ofs), &xcsr);
> > +       } while (--count && xcsr & FSL_SAI_CSR_TERE);
> > +
> > +       regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
> > +                          FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
> > +
> > +       /*
> > +        * For sai master mode, after several open/close sai,
> > +        * there will be no frame clock, and can't recover
> > +        * anymore. Add software reset to fix this issue.
> > +        * This is a hardware bug, and will be fix in the
> > +        * next sai version.
> > +        */
> > +       if (!sai->is_slave_mode) {
> > +               /* Software Reset for both Tx and Rx */
>
> Remove "for both Tx and Rx"
>
> >                 /* Check if the opposite FRDE is also disabled */
> >                 regmap_read(sai->regmap, FSL_SAI_xCSR(!tx, ofs), &xcsr);
> > +               if (sai->synchronous[tx] && !sai->synchronous[!tx] && !(xcsr & FSL_SAI_CSR_FRDE))
> > +                       fsl_sai_config_disable(sai, !tx);
>
> > +               if (sai->synchronous[tx] || !sai->synchronous[!tx] || !(xcsr & FSL_SAI_CSR_FRDE))
> > +                       fsl_sai_config_disable(sai, tx);
>
> The first "||" should probably be "&&".

No. it is !(!sai->synchronous[tx] && sai->synchronous[!tx] && (xcsr &
FSL_SAI_CSR_FRDE))
so then convert to
(sai->synchronous[tx] || !sai->synchronous[!tx] || !(xcsr & FSL_SAI_CSR_FRDE))

if change to &&, then it won't work for:
sai->synchronous[tx] = false, sai->synchronous[!tx]=false.
or
sai->synchronous[tx] = true, sai->synchronous[!tx]=true.
(even we don't have such a case).

>
> The trigger() logic is way more complicated than a simple cleanup
> in my opinion. Would suggest to split RMR part out of this change.
>
> And for conditions like "sync[tx] && !sync[!tx]", it'd be better
> to have a helper function to improve readability:
>
> /**
>  * fsl_sai_dir_is_synced - Check if stream is synced by the opposite stream
>  *
>  * SAI supports synchronous mode using bit/frame clocks of either Transmitter's
>  * or Receiver's for both streams. This function is used to check if clocks of
>  * current stream's are synced by the opposite stream.
>  *
>  * @sai: SAI context
>  * @dir: direction of current stream
>  */
> static inline bool fsl_sai_dir_is_synced(struct fsl_sai *sai, int dir)
> {
>         int adir = (dir == TX) ? RX : TX;
>
>         /* current dir in async mode while opposite dir in sync mode */
>         return !sai->synchronous[dir] && sai->synchronous[adir];
> }
>
> Then add more comments in trigger:
>
> static ...trigger()
> {
>         bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
>         int adir = tx ? RX : TX;
>         int dir = tx ? TX : RX;
>
>         // ....
>         {
>                 // ...
>
>                 /* Check if the opposite FRDE is also disabled */
>                 regmap_read(sai->regmap, FSL_SAI_xCSR(!tx, ofs), &xcsr);
>
>                 /*
>                  * If opposite stream provides clocks for synchronous mode and
>                  * it is inactive, disable it before disabling the current one
>                  */
>                 if (fsl_sai_dir_is_synced(adir) && !(xcsr & FSL_SAI_CSR_FRDE))
>                         fsl_sai_config_disable(sai, adir);
>
>                 /*
>                  * Disable current stream if either of:
>                  * 1. current stream doesn't provide clocks for synchronous mode
>                  * 2. current stream provides clocks for synchronous mode but no
>                  *    more stream is active.
>                  */
>                 if (!fsl_sai_dir_is_synced(dir) || !(xcsr & FSL_SAI_CSR_FRDE))
>                         fsl_sai_config_disable(sai, dir);
>
>                 // ...
>         }
>         // ....
> }
>
> Note, in fsl_sai_config_disable(sai, dir):
>         bool tx = dir == TX;
>
> Above all, I am just drafting, so please test it thoroughly :)
