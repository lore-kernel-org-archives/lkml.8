Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5829C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:31:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965EE2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593466294;
	bh=crmtCeTm/UluhEluBQPykauUvFRi/Z9kzPRAWcvYg0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2hkGSVKMMJtNwAc+5uZyTEcsNbSpLPyWgXDpmz+pzynD71jVkgvm+vjOwue5pSByD
	 MtlAkWIJl5O/WVOaN6DXHqv9Je9GYiqF6XWoMpruugphmsQY7TWHKdJLROMSirvQuO
	 cY0Y9FZr9dZ7kluP6aEmBMVEhfVwe/DgAOZ+nMQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgF2SlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:41:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:60668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbgF2SlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:41:07 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D53423125;
        Mon, 29 Jun 2020 05:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593407824;
        bh=crmtCeTm/UluhEluBQPykauUvFRi/Z9kzPRAWcvYg0k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i5YR6pw/aFV2iOyU/9vkfAejtQ2CzfxmUzysh7DBmuU5k6mThFvvnOO3/Y85M8IJN
         gKHLvO4LX3X6YXz+O5+Jhj6+78ejPHVSmLwVUt+KgCUsBjEjnlYYtRBU1mymTpk1/z
         VaXloID+owO3dQOa4GY9oSltJigVxf44g4Sp0H9s=
Date:   Mon, 29 Jun 2020 10:46:59 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] ALSA: compress: fix partial_drain completion state
Message-ID: <20200629051659.GB376808@vkoul-mobl>
References: <20200625154651.99758-1-vkoul@kernel.org>
 <20200625154651.99758-4-vkoul@kernel.org>
 <20200626103549.GB71940@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626103549.GB71940@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-06-20, 10:35, Charles Keepax wrote:

> > -	stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> > +	mutex_lock(&stream->device->lock);
> > +	/* for partial_drain case we are back to running state on success */
> > +	if (stream->partial_drain) {
> > +		stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> > +		stream->partial_drain = false; /* clear this flag as well */
> > +	} else {
> > +		stream->runtime->state = SNDRV_PCM_STATE_SETUP;
> > +	}
> > +	mutex_unlock(&stream->device->lock);
> 
> You have added locking here in snd_compr_drain_notify but....
> >  
> >  	wake_up(&stream->runtime->sleep);
> >  }
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > index e618580feac4..1c4b2cf450a0 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -803,6 +803,9 @@ static int snd_compr_stop(struct snd_compr_stream *stream)
> >  
> >  	retval = stream->ops->trigger(stream, SNDRV_PCM_TRIGGER_STOP);
> >  	if (!retval) {
> > +		/* clear flags and stop any drain wait */
> > +		stream->partial_drain = false;
> > +		stream->metadata_set = false;
> >  		snd_compr_drain_notify(stream);
> 
> that can be called from snd_compr_stop here which is already
> holding the lock resulting in deadlock.

Thanks Charles, right somehow my testing missed this, have verified that
it is the case.

I will remove the locks here, and we should add a comment to note this..

Thanks

-- 
~Vinod
