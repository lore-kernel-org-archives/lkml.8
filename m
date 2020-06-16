Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC50C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20FAF20739
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 01:59:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hdho9rnv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgFPB7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 21:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFPB7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 21:59:09 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CCEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 18:59:08 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x11so2275399plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 18:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c6qSOHXQD4hhumQbZikXxSVaWTqHQyHgmFGcIGOztbI=;
        b=Hdho9rnvhEUVTmAqgZmwWYS8RzOIXPvCmcrdiHoWOSSv9gOV6MjCV5xh7IZtx9ItbZ
         +O4XLUz0sei1/nC+7CPDSozGf6Tgl7lIF96q91XBCfc99Ye6Fi9Jq4d1qxK44UiZhgWT
         6ez7hLSLyQ27AEpC5O/kOv48zLGAqLBArsXn3NjIxmVeEFt/YPJfzgKVXoMWCtoRgcFk
         ysl/KEbk3PSvoy3O+Gwxsqw4LBMpFsoMqjgCu540Za/JDS0WBv58gISlJION8NOnAwCG
         L0bOtLmIY/AUpg4/pIQOfqCHp19HnSWOQ/Y2cNSN1sSHXwTYkle7vTBCppaVG7xYNpPe
         zXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c6qSOHXQD4hhumQbZikXxSVaWTqHQyHgmFGcIGOztbI=;
        b=SwKGUUgROVj8FHI5yFFhZQtOVSFRUwkvZ5f3uFQy15Zhrxd354xmcVy2KJKpa5fNBT
         TBy4FrHY3E9GzQ7Xgi2PgkHlssldh0ECxbe930fopoaMfh7lk0bSoIa1TMnLzkS4NTVj
         jbIq7t++wyOHMvaU/m0nEWDmWKps6fBs+1KRbbDzDKcs+nN/jjCYLvIJnFUw2xgiuN4I
         IC3CLw2q93IBZwK4IETcCD79n2szRk53ZfETYGCw6uNampTktkczQNBMwuo5jkI9XZze
         3EnUMEzpWpFafqOauUj7Eeb6j3gY5imQ2vTE7DS/uhmdAbqqpwdSgY5Eiu2NPc6ds5fT
         4vCA==
X-Gm-Message-State: AOAM532R1wyLUZphk5LJj1qmnMTRPwgBKSjnxnEwzYLEO2cwWvrYEVRi
        gy+BOlYbu5dZfID5AD77ozM=
X-Google-Smtp-Source: ABdhPJwQspXhDL8ZeLiPXsByuB95kCv+TZO5QCOae6ToeEXyIPt0N78KWSViGNui3IvFDCRG0fVYLA==
X-Received: by 2002:a17:90a:336c:: with SMTP id m99mr502352pjb.168.1592272748269;
        Mon, 15 Jun 2020 18:59:08 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id x1sm683125pju.3.2020.06.15.18.59.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2020 18:59:07 -0700 (PDT)
Date:   Mon, 15 Jun 2020 18:58:52 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ASoC: fsl_ssi: Fix bclk calculation for mono channel
Message-ID: <20200616015851.GA23235@Asurada-Nvidia>
References: <b5cf5e3cc39c62f6bb3660b7588b037ffc57f780.1592200690.git.shengjiu.wang@nxp.com>
 <20200615230912.GA16681@Asurada-Nvidia>
 <CAA+D8ANK079rFL-_kwYKkn=nvrsBJPHW8bWMTwNCwDVzHt0PdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8ANK079rFL-_kwYKkn=nvrsBJPHW8bWMTwNCwDVzHt0PdA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 09:48:39AM +0800, Shengjiu Wang wrote:
> On Tue, Jun 16, 2020 at 7:11 AM Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > On Mon, Jun 15, 2020 at 01:56:18PM +0800, Shengjiu Wang wrote:
> > > For mono channel, SSI will switch to Normal mode.
> > >
> > > In Normal mode and Network mode, the Word Length Control bits
> > > control the word length divider in clock generator, which is
> > > different with I2S Master mode (the word length is fixed to
> > > 32bit), it should be the value of params_width(hw_params).
> > >
> > > The condition "slots == 2" is not good for I2S Master mode,
> > > because for Network mode and Normal mode, the slots can also
> > > be 2. Then we need to use (ssi->i2s_net & SSI_SCR_I2S_MODE_MASK)
> > > to check if it is I2S Master mode.
> >
> > The fsl_ssi_set_bclk is only called when fsl_ssi_is_i2s_master,
> > though I agree that that line of comments sounds confusing now.
> 
> Actually I think fsl_ssi_is_i2s_master is not accurate, it just checks
> the Master mode,  but didn't check the I2S mode.
> 
> >
> > > So we refine the famula for mono channel, otherwise there
> >
> > famula => formula?
> >
> > > will be sound issue for S24_LE.
> > >
> > > Fixes: b0a7043d5c2c ("ASoC: fsl_ssi: Caculate bit clock rate using slot number and width")
> > > Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> > > ---
> > > changes in v2
> > > - refine patch for Network mode and Normal mode.
> > >
> > >  sound/soc/fsl/fsl_ssi.c | 15 +++++++++++----
> > >  1 file changed, 11 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
> > > index bad89b0d129e..cbf67d132fda 100644
> > > --- a/sound/soc/fsl/fsl_ssi.c
> > > +++ b/sound/soc/fsl/fsl_ssi.c
> > > @@ -678,7 +678,8 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
> > >       struct regmap *regs = ssi->regs;
> > >       u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
> > >       unsigned long clkrate, baudrate, tmprate;
> > > -     unsigned int slots = params_channels(hw_params);
> > > +     unsigned int channels = params_channels(hw_params);
> > > +     unsigned int slots;
> > >       unsigned int slot_width = 32;
> > >       u64 sub, savesub = 100000;
> > >       unsigned int freq;
> > > @@ -688,9 +689,15 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
> > >       /* Override slots and slot_width if being specifically set... */
> > >       if (ssi->slots)
> > >               slots = ssi->slots;
> > > -     /* ...but keep 32 bits if slots is 2 -- I2S Master mode */
> > > -     if (ssi->slot_width && slots != 2)
> > > -             slot_width = ssi->slot_width;
> > > +     else
> > > +             /* Apply two slots for mono channel, because DC = 2 */
> > > +             slots = (channels == 1) ? 2 : channels;
> > > +
> > > +     /* ...but keep 32 bits if I2S Master mode */
> > > +     if ((ssi->i2s_net & SSI_SCR_I2S_MODE_MASK) != SSI_SCR_I2S_MODE_MASTER ||
> > > +         channels == 1)
> > > +             slot_width = ssi->slot_width ? ssi->slot_width :
> >
> > This looks very complicated...can you review and try mine?
> > (Basically, take 32-bit out of default but force it later)
> >
> > @@ -678,8 +678,9 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
> >         struct regmap *regs = ssi->regs;
> >         u32 pm = 999, div2, psr, stccr, mask, afreq, factor, i;
> >         unsigned long clkrate, baudrate, tmprate;
> > -       unsigned int slots = params_channels(hw_params);
> > -       unsigned int slot_width = 32;
> > +       unsigned int channels = params_channels(hw_params);
> > +       unsigned int slot_width = params_width(hw_params);
> > +       unsigned int slots = 2;
> >         u64 sub, savesub = 100000;
> >         unsigned int freq;
> >         bool baudclk_is_used;
> > @@ -688,10 +689,16 @@ static int fsl_ssi_set_bclk(struct snd_pcm_substream *substream,
> >         /* Override slots and slot_width if being specifically set... */
> >         if (ssi->slots)
> >                 slots = ssi->slots;
> > -       /* ...but keep 32 bits if slots is 2 -- I2S Master mode */
> > -       if (ssi->slot_width && slots != 2)
> > +       if (ssi->slot_width)
> >                 slot_width = ssi->slot_width;
> >
> > +       /*
> > +        * ...but force 32 bits for stereo audio. Note that mono audio is also
> > +        * sent in 2 slots via NORMAL mode, so check both slots and channels.
> > +        */
> > +       if (slots == 2 && channels == 2)
> > +               slot_width = 32;
> 
> slots ==2 && channels ==2 does not mean the I2S Master mode.
> For LEFT_J, it is also slots =2 & channels = 2, then the slot_width
> should be params_width(hw_params).
> and DSP_A/B also supports stereo.

I think you have a point. Then would this condition work?

+       /* ...but force 32 bits for stereo audio using I2S Master Mode */
+	if (channels == 2 &&
+	    ssi->i2s_net & SSI_SCR_I2S_MODE_MASK == SSI_SCR_I2S_MODE_MASTER)

Similar to yours but the code above it could look straightforward.
