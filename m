Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D8F1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1053D2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q01Sv3tA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgFLFC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgFLFC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 01:02:58 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34EAC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 22:02:57 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id n9so3285178plk.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 22:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AQb3my+JsHlPPhTUgek4A/JfdbCiC4/wHqfCQrXHjrU=;
        b=q01Sv3tAmgbAnD8CpTMm/o03irTJ7C9U+SvSNziUnrthARWPJYAHa+QPqOIvkTh6QR
         no4O2hrQdkvUupP2diATC+WeE8zHFg5Z7B2bRDjTf1OHqN1lk9NsKfdNlQObU1InoXUw
         2A4MuUdDhIMNhy8XZYAZb6Nedh0e7AxbreTaiJr/him4Edt1Q345hVImR/g8Kbbc+Uym
         u0evKTdygrq7aUwfb/rkAxmVz0ZIDw++Z3xruuZc4cwf3IzIzQAMXpLnppl51Jc40Ove
         kI9LCyxnPeCzAoB1Eo3kkJlxAQ6o/5/HrUpoluPDcm2kg4ysQZPTDnOHRYs4UAKmkXBw
         bQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AQb3my+JsHlPPhTUgek4A/JfdbCiC4/wHqfCQrXHjrU=;
        b=jIm1QCInTQ5+KWtXb8oIhPvPToNUXvH+ma0bLOx4BZ4NvhavZAe2yJUn0Lm48ITBht
         pveVq9q8H+xvBLzULOo5yc9j5YewTFEqU6/Lvz0hKnAqbbfdcGoFhfooEYigkcyn3xvL
         fm0EF1SNHYNrya0cEDYQwt+mDU97R8oHSNWJ2UNfsXadLdka+NcITMcFKz3Jhx62ecCj
         iU4zhgIEfRnt/+NezARCNT7aMLV4CIAtCyDvpzWgWsuAtrF+fY2ANWknMiwcUQELoFg4
         scHRc8Fak+VuKp9RTCmDqYj2Z8qnPH2IG0rKUeLsdvGzaFgd27c03ah1CkV/0eHEeXjp
         nn5Q==
X-Gm-Message-State: AOAM5328cd+YfRIdU4mRyaCvF0eoR+Y9sstYVkHyOre6BVRET68zgD2U
        gn6wyS41qZ3Y2e+y7sn49fY=
X-Google-Smtp-Source: ABdhPJwjToNwD3VazGS7MHp3JaSxFxVaFsE6O2sMauxx8tbjvDPH4tb7qxRuOF0NFqhRYZWr3cMqNw==
X-Received: by 2002:a17:902:9f8d:: with SMTP id g13mr9910233plq.292.1591938177195;
        Thu, 11 Jun 2020 22:02:57 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id n4sm4088751pjt.48.2020.06.11.22.02.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jun 2020 22:02:56 -0700 (PDT)
Date:   Thu, 11 Jun 2020 22:02:46 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>, lars@metafoo.de,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Liam Girdwood <lgirdwood@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH v2 3/3] ASoC: fsl_asrc_dma: Reuse the dma channel if
 available in Back-End
Message-ID: <20200612050245.GA18921@Asurada-Nvidia>
References: <cover.1591783089.git.shengjiu.wang@nxp.com>
 <0473d4191ae04ab711d63c5c875e47f45f598137.1591783089.git.shengjiu.wang@nxp.com>
 <20200612003103.GA28228@Asurada-Nvidia>
 <CAA+D8ANbr-nAzY436-AFPOzwGb2LBaZSb40VwoEQrYScKr=0NA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8ANbr-nAzY436-AFPOzwGb2LBaZSb40VwoEQrYScKr=0NA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 10:17:08AM +0800, Shengjiu Wang wrote:

> > > diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h

> > > + * @req_dma_chan_dev_to_dev: flag for release dev_to_dev chan
> >
> > Since we only have dma_request call for back-end only:
> > + * @req_dma_chan: flag to release back-end dma chan
> 
> I prefer to use the description "flag to release dev_to_dev chan"
> because we won't release the dma chan of the back-end. if the chan
> is from the back-end, it is owned by the back-end component.

TBH, it just looks too long. But I wouldn't have problem if you
insist so.

> > > @@ -273,19 +299,21 @@ static int fsl_asrc_dma_hw_params(struct snd_soc_component *component,
> > >  static int fsl_asrc_dma_hw_free(struct snd_soc_component *component,
> > >                               struct snd_pcm_substream *substream)
> > >  {
> > > +     bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
> > >       struct snd_pcm_runtime *runtime = substream->runtime;
> > >       struct fsl_asrc_pair *pair = runtime->private_data;
> > > +     u8 dir = tx ? OUT : IN;
> > >
> > >       snd_pcm_set_runtime_buffer(substream, NULL);
> > >
> > > -     if (pair->dma_chan[IN])
> > > -             dma_release_channel(pair->dma_chan[IN]);
> > > +     if (pair->dma_chan[!dir])
> > > +             dma_release_channel(pair->dma_chan[!dir]);
> > >
> > > -     if (pair->dma_chan[OUT])
> > > -             dma_release_channel(pair->dma_chan[OUT]);
> > > +     if (pair->dma_chan[dir] && pair->req_dma_chan_dev_to_dev)
> > > +             dma_release_channel(pair->dma_chan[dir]);
> >
> > Why we only apply this to one direction?
> 
> if the chan is from the back-end, it is owned by the back-end
> component, so it should be released by the back-end component,
> not here. That's why I added the flag "req_dma_chan".

Ah...I forgot the IN and OUT is for front-end and back-end. The
naming isn't very good indeed. Probably we should add a line of
comments somewhere as a reminder.

Thanks
