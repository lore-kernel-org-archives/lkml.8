Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B3EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 159E02070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOE0YlfB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729109AbgFJSgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgFJSgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:36:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FEFC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:36:41 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s135so683512pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yw3q9eI6lwTKHkfbX8g8ks9O/Eo9T2Je00bLzcJ2GYc=;
        b=NOE0YlfB0mY/JBt1JlVH902N0/uUPHd7L9Kahu8HrCsJ9M2i7PnznTAA3N78Oif8tk
         axxD9WhHeKXlpUIEILYwj69M74f0/48wJl4fqEB/f+bsGLV7D4Og5MohtjSlmnzURMxN
         ONq4eO27y2e5oJqz+WjB8h5yBSe5Mcp4tyA5TUgT525dxI3IqvgFer5AwVZX2U/hlLur
         Axs6ej3TVkd2M8JHVIG57jgn+4gaElz0Eq/R4qSMuib8Z9Kv8mhHDAuQgIJ5vTj1+Ax8
         pWgWLin/eyXmmCMdh6rQsrjP9QCVviX42skFA18m000+M0UU3YSKJlm/syX0sQBHHH7/
         oRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yw3q9eI6lwTKHkfbX8g8ks9O/Eo9T2Je00bLzcJ2GYc=;
        b=oIvZKCOeGKr9R3IV0V8BtIuWAwcFNwY9FiLIO21IA8Vt+05OjIFJ4Zdqr2vcAba7OC
         5ArTMwvtN6uS44xjTuDNyP0IMPaZno0mjbz3pUZSSmyTYS680o/Kgu4TjzudsnUz/30m
         h3w+IATK6U+9tLCSWTiKgnXOu+k7jRC7Ub9yyK1688HnOOLqr0V4josw0JHMjxO2fmzv
         W/6gwZTN0de08z+cSfLDKFPEGTG1YX82YAsLDQnWlQ/WhR2ki369rOfSSUbZJYoh/lg9
         r0RPdSowqrK30aCchSkoThfbXFJAJh0QHFYDgksj7xMkhc4kR9TGSf+ZklLpdHOPgODp
         z8Pw==
X-Gm-Message-State: AOAM5326cha9aCVPZC6VDJfEYKOZSZh+xB89Ms2UVAXr6qL4xt17UDBj
        0dcT0YHwvF1Rrba/YlpBAd0=
X-Google-Smtp-Source: ABdhPJx9yBS3TpsCYB0M2k/HUJCqFbrfJDrQFqu6V3G1g3niXzTVJlGN/tj/FlKmZYYb2YwY0BjsVg==
X-Received: by 2002:a63:c04b:: with SMTP id z11mr3760360pgi.215.1591814200411;
        Wed, 10 Jun 2020 11:36:40 -0700 (PDT)
Received: from gmail.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id p31sm483529pgb.46.2020.06.10.11.36.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 11:36:39 -0700 (PDT)
Date:   Thu, 11 Jun 2020 00:06:32 +0530
From:   Vaibhav Agarwal <vaibhav.sr@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Elder <elder@kernel.org>, Johan Hovold <johan@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devel@driverdev.osuosl.org, alsa-devel@alsa-project.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [PATCH v2 4/6] staging: greybus: audio: Resolve compilation
 error in topology parser
Message-ID: <20200610183630.GA26807@gmail.com>
References: <cover.1591802243.git.vaibhav.sr@gmail.com>
 <7cbb81585474e895faa842e2af05ec3fb2079386.1591802243.git.vaibhav.sr@gmail.com>
 <20200610174535.GB4151@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200610174535.GB4151@kadam>
User-Agent: Mutt/1.10.1+3 (f9293d646485) (2018-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 08:45:35PM +0300, Dan Carpenter wrote:
> On Wed, Jun 10, 2020 at 10:58:28PM +0530, Vaibhav Agarwal wrote:
> > @@ -437,11 +433,12 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
> >  	struct gbaudio_module_info *module;
> >  	struct snd_soc_dapm_widget_list *wlist = snd_kcontrol_chip(kcontrol);
> >  	struct snd_soc_dapm_widget *widget = wlist->widgets[0];
> > -	struct snd_soc_codec *codec = widget->codec;
> > -	struct gbaudio_codec_info *gb = snd_soc_codec_get_drvdata(codec);
> > +	struct device *codec_dev = widget->dapm->dev;
> > +	struct gbaudio_codec_info *gb = dev_get_drvdata(codec_dev);
> > +	struct snd_soc_dapm_update *update = NULL;
>                                     ^^^^^^^^^^^^^
> 
> >  	struct gb_bundle *bundle;
> >  
> > -	dev_dbg(codec->dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
> > +	dev_dbg(codec_dev, "Entered %s:%s\n", __func__, kcontrol->id.name);
> >  	module = find_gb_module(gb, kcontrol->id.name);
> >  	if (!module)
> >  		return -EINVAL;
> > @@ -458,17 +455,13 @@ static int gbcodec_mixer_dapm_ctl_put(struct snd_kcontrol *kcontrol,
> >  	max = le32_to_cpu(info->value.integer.max);
> >  	mask = (1 << fls(max)) - 1;
> >  	val = ucontrol->value.integer.value[0] & mask;
> > -	connect = !!val;
> >  
> >  	/* update ucontrol */
> >  	if (gbvalue.value.integer_value[0] != val) {
> >  		for (wi = 0; wi < wlist->num_widgets; wi++) {
> >  			widget = wlist->widgets[wi];
> > -
> > -			widget->value = val;
> > -			widget->dapm->update = NULL;
> > -			snd_soc_dapm_mixer_update_power(widget, kcontrol,
> > -							connect);
> > +			snd_soc_dapm_mixer_update_power(widget->dapm, kcontrol,
> > +							val, update);
>                                                              ^^^^^^
> Always NULL.  Just delete the update variable.

Aah, my bad! Thanks Dan for sharing your comments. I'll fix this while 
sharing next patchset.

--
Regards,
Vaibhav

> 
> regards,
> dan carpenter
> 
> 
