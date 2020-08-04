Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E823FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E7222B45
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 07:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="las3ya+y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHDHEA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 03:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgHDHEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 03:04:00 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3898BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 00:04:00 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id u185so19679248pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 00:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7rgf9ZDWcgim9KmP/Dkpn+5XAX3gGbMuw5yC7kTtCN0=;
        b=las3ya+yQ5IzlPU9pUDteEf6iEenUhEN9huaguWQhjgL9LmtNWPSSHbzR4rmZkoIyt
         as2mWRlW3SwqwryRDMWqySjxdUVG1JQlVQ/IA3Bw7ZnyxAi7OClmjj/PJ+WImZrCg1dt
         sf58RJLyY3tb2u/w9Pmj2ZQRfvHJ7p8Y2rzkVXq+EESnS1UV3LWTqlJauLd5bSyYEQ3S
         kFbPKPadP8ehIUbeJr68HapO9KfCrgEnwTwkrUtfUzgQ1byahZobh7TEVhltolX9MzJ1
         nKAP2Gy5U/BgAEu2DWhHOBjGXdYjXBUZ7tn3T6eMTA8ub3ekiajMiJdqe4JQe2k0qDey
         dvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7rgf9ZDWcgim9KmP/Dkpn+5XAX3gGbMuw5yC7kTtCN0=;
        b=Bm6QBAeQTxWvg/qO7Tb78acwDTxUF5yzoLoEAXDoEtQ9JuCDA4yHVHerBL+JRYv1d4
         HOezai2LEOTVWwuRhyxt7NGpIs2JttgVk38JZjNUbB/TM0XGBAUtgAh1mut4qYFcEMRe
         fmF+Mk2hGc4y3fE1mwMqJNX++d5tdfZR0GYSu9WTbKs82RX5FUM0nnYWzGCSrXU3TFel
         GAUngWFnFngjfdloYQwx2IlRAexGv63Q+NDzBJ7+FdpJry6agwgo8zsMRTZlXehl1Rko
         TDYUckBxAnwjW/Q+zQz0uzkqBnBFVniWxVLv93eUYsv5iQ01e4B0mjMMNmoMFamxeCFi
         5/8w==
X-Gm-Message-State: AOAM5304jJQBtxvQ/dGrYndNAzMi0sCazX+4l0uw5V+XtgwCUE46YrjY
        2TfrN/fUHv7Yos2qwOrb7M4=
X-Google-Smtp-Source: ABdhPJyolTMgvR6vhnnh/ll6ddmuWsu5pD8jeTYjHz/0KNZQ5ZkQwrcoeX1i+fEFcE8Sy5vBkJtMHg==
X-Received: by 2002:a65:6447:: with SMTP id s7mr18478361pgv.320.1596524639650;
        Tue, 04 Aug 2020 00:03:59 -0700 (PDT)
Received: from Asurada-Nvidia (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id 77sm21698139pfx.85.2020.08.04.00.03.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Aug 2020 00:03:59 -0700 (PDT)
Date:   Tue, 4 Aug 2020 00:03:46 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_sai: Clean code for synchronize mode
Message-ID: <20200804070345.GA27658@Asurada-Nvidia>
References: <1596424674-32127-1-git-send-email-shengjiu.wang@nxp.com>
 <20200803054037.GA1056@Asurada-Nvidia>
 <CAA+D8AOGF44UUq=P1S-M5TUwDUaOnqVmHJKPDBM9DAzt1nVzmQ@mail.gmail.com>
 <20200803215735.GA5461@Asurada-Nvidia>
 <CAA+D8ANQxnvR2bOyHVRs5h2NJhMeVh4gjLPknaz7aQ86MtL0sQ@mail.gmail.com>
 <20200804021114.GA15390@Asurada-Nvidia>
 <CAA+D8ANagfMXPAkK4-vBDY9rZMukVUXs8FfBCHS0avXt57pekA@mail.gmail.com>
 <20200804030004.GA27028@Asurada-Nvidia>
 <CAA+D8ANuLQuUO+VsABjt2t1ccK+LGayq13d6EEcV18=4KNaC+w@mail.gmail.com>
 <CAA+D8AP=27SdR68T-LiQHkJ0_dJaqtgcS-oi9d8arUzvTz5GwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA+D8AP=27SdR68T-LiQHkJ0_dJaqtgcS-oi9d8arUzvTz5GwA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 12:22:53PM +0800, Shengjiu Wang wrote:

> > > Btw, do we need similar change for TRIGGER_STOP?
> >
> > This is a good question. It is better to do change for STOP,
> > but I am afraid that there is no much test to guarantee the result.

> Maybe we can do this change for STOP.

The idea looks good to me...(check inline comments)
 
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index 1c0e06bb3783..6e4be398eaee 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -517,6 +517,37 @@ static int fsl_sai_hw_free(struct
> snd_pcm_substream *substream,
>         return 0;
>  }
> 
> +static void fsl_sai_config_disable(struct fsl_sai *sai, bool tx)
> +{
> +       unsigned int ofs = sai->soc_data->reg_offset;
> +       u32 xcsr, count = 100;
> +
> +       regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
> +                          FSL_SAI_CSR_TERE, 0);
> +
> +       /* TERE will remain set till the end of current frame */
> +       do {
> +               udelay(10);
> +               regmap_read(sai->regmap, FSL_SAI_xCSR(tx, ofs), &xcsr);
> +       } while (--count && xcsr & FSL_SAI_CSR_TERE);
> +
> +       regmap_update_bits(sai->regmap, FSL_SAI_xCSR(tx, ofs),
> +                          FSL_SAI_CSR_FR, FSL_SAI_CSR_FR);
> +
> +       /*
> +        * For sai master mode, after several open/close sai,
> +        * there will be no frame clock, and can't recover
> +        * anymore. Add software reset to fix this issue.
> +        * This is a hardware bug, and will be fix in the
> +        * next sai version.
> +        */
> +       if (!sai->is_slave_mode) {
> +               /* Software Reset for both Tx and Rx */

Remove "for both Tx and Rx"

>                 /* Check if the opposite FRDE is also disabled */
>                 regmap_read(sai->regmap, FSL_SAI_xCSR(!tx, ofs), &xcsr);
> +               if (sai->synchronous[tx] && !sai->synchronous[!tx] && !(xcsr & FSL_SAI_CSR_FRDE))
> +                       fsl_sai_config_disable(sai, !tx);

> +               if (sai->synchronous[tx] || !sai->synchronous[!tx] || !(xcsr & FSL_SAI_CSR_FRDE))
> +                       fsl_sai_config_disable(sai, tx);

The first "||" should probably be "&&".

The trigger() logic is way more complicated than a simple cleanup
in my opinion. Would suggest to split RMR part out of this change.

And for conditions like "sync[tx] && !sync[!tx]", it'd be better
to have a helper function to improve readability:

/**
 * fsl_sai_dir_is_synced - Check if stream is synced by the opposite stream
 *
 * SAI supports synchronous mode using bit/frame clocks of either Transmitter's
 * or Receiver's for both streams. This function is used to check if clocks of
 * current stream's are synced by the opposite stream.
 *
 * @sai: SAI context
 * @dir: direction of current stream
 */
static inline bool fsl_sai_dir_is_synced(struct fsl_sai *sai, int dir)
{
	int adir = (dir == TX) ? RX : TX;

	/* current dir in async mode while opposite dir in sync mode */
	return !sai->synchronous[dir] && sai->synchronous[adir];
}

Then add more comments in trigger:

static ...trigger()
{
	bool tx = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;
	int adir = tx ? RX : TX;
	int dir = tx ? TX : RX;

	// ....
	{
		// ...

		/* Check if the opposite FRDE is also disabled */
		regmap_read(sai->regmap, FSL_SAI_xCSR(!tx, ofs), &xcsr);

		/*
		 * If opposite stream provides clocks for synchronous mode and
		 * it is inactive, disable it before disabling the current one
		 */
		if (fsl_sai_dir_is_synced(adir) && !(xcsr & FSL_SAI_CSR_FRDE))
			fsl_sai_config_disable(sai, adir);

		/*
		 * Disable current stream if either of:
		 * 1. current stream doesn't provide clocks for synchronous mode
		 * 2. current stream provides clocks for synchronous mode but no
		 *    more stream is active.
		 */
		if (!fsl_sai_dir_is_synced(dir) || !(xcsr & FSL_SAI_CSR_FRDE))
			fsl_sai_config_disable(sai, dir);

		// ...
	}
	// ....
}

Note, in fsl_sai_config_disable(sai, dir):
	bool tx = dir == TX;

Above all, I am just drafting, so please test it thoroughly :)
