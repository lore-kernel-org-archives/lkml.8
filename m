Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499A3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18C64207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591873577;
	bh=5xztsiOiY57NOrldvHQaSbPHBI/nqb2sD9DT5pU4IM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dUo2N4rOz+dpD5OfKMQJupRHtxrU0NiXy+xkGS9vkFTPROLdRrllWNFeQYeJBegKo
	 RXFLgjyukXpILgSUyb5Lac5WylZnpBuSVj0yI8tdkq0uMAlDZzZrUqWBW2zGR1vosA
	 YuXzXoo3acWjfQoadquK1zfzfAqfcmTlErOMfPm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgFKLGP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:06:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:41998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbgFKLGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:06:01 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 806C220760;
        Thu, 11 Jun 2020 11:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591873560;
        bh=5xztsiOiY57NOrldvHQaSbPHBI/nqb2sD9DT5pU4IM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sWexdplgNcNA9c4C27/MCEKAPWZINpDcVLeeaYvTIVgXDrBgjurvVJdMDiH/K5ygC
         IvzTB6fA/KG/DMLc0BjkcTKlqTpulq+tcD3IssoXMrdXXX/c5Fb2TBAtABMKDMv/Ws
         qi4WZhhY4jCGHoYO82PMV2FX91TP3uncmzNzVdwg=
Date:   Thu, 11 Jun 2020 16:35:56 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        tiwai@suse.com, linux-kernel@vger.kernel.org, broonie@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH] ALSA: compress: Fix gapless playback state machine
Message-ID: <20200611110556.GD1393454@vkoul-mobl>
References: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
 <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
 <20200610105820.GA1393454@vkoul-mobl>
 <20200611084659.GO71940@ediswmail.ad.cirrus.com>
 <6a984302-ff01-e326-d338-e50e1f532cd9@perex.cz>
 <20200611094423.GB1393454@vkoul-mobl>
 <20200611104234.GQ71940@ediswmail.ad.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611104234.GQ71940@ediswmail.ad.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-20, 10:42, Charles Keepax wrote:
> On Thu, Jun 11, 2020 at 03:14:23PM +0530, Vinod Koul wrote:
> > On 11-06-20, 11:09, Jaroslav Kysela wrote:
> > > Dne 11. 06. 20 v 10:46 Charles Keepax napsal(a):
> > > > On Wed, Jun 10, 2020 at 04:28:20PM +0530, Vinod Koul wrote:
> > > > > On 10-06-20, 12:40, Jaroslav Kysela wrote:
> > > > > > Dne 10. 06. 20 v 12:07 Srinivas Kandagatla napsal(a):
> > > > > > > Here is the sequence of events and state transitions:
> > > > > > > 
> > > > > > > 1. set_params (Track 1), state =  SNDRV_PCM_STATE_SETUP
> > > > > > > 2. set_metadata (Track 1), no state change, state = SNDRV_PCM_STATE_SETUP
> > > > > > > 3. fill and trigger start (Track 1), state = SNDRV_PCM_STATE_RUNNING
> > > > > > > 4. set_next_track (Track 2), state = SNDRV_PCM_STATE_RUNNING
> > > > > > > 5. partial_drain (Track 1), state = SNDRV_PCM_STATE_SETUP
> > > > > > > 6  snd_compr_drain_notify (Track 1), state = SNDRV_PCM_STATE_SETUP
> > > > > > > 7. fill data (Track 2), state = SNDRV_PCM_STATE_PREPARED
> > > > > > > 8. set_metadata (Track 3), no state change, state = SNDRV_PCM_STATE_PREPARED
> > > > > > > 9. set_next_track (Track 3), !! FAILURE as state != SNDRV_PCM_STATE_RUNNING
> > Yeah sorry I overlooked that case and was thinking of it being invoked
> > from driver!
> > 
> > Yes this would make the snd_compr_stop() behave incorrectly.. so this
> > cant be done as proposed.
> > 
> > But we still need to set the draining stream state properly and I am
> > thinking below now:
> > 
> > diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
> > index 509290f2efa8..9aba851732d7 100644
> > --- a/sound/core/compress_offload.c
> > +++ b/sound/core/compress_offload.c
> > @@ -929,7 +929,9 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
> >         }
> >  
> >         stream->next_track = false;
> > -       return snd_compress_wait_for_drain(stream);
> > +       retval = snd_compress_wait_for_drain(stream);
> > +       stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
> > +       return retval;
> 
> This is looking better, I think you probably need to make the
> switch to RUNNING conditional on snd_compress_wait_for_drain
> succeeding, as the state should remain in DRAINING if we are
> interrupted or some such.

Hmmm, only interrupt would be terminate, so yes we should not do running
conditionally here..

> I also have a slight concern that since
> snd_compress_wait_for_drain, releases the lock the set_next_track
> could come in before the state is moved to RUNNING, but I guess
> from user-spaces perspective that is the same as it coming in
> whilst the state is still DRAINING, so should be handled fine?

yeah userspace is blocked on this call, till signalling for partial
drain is done. So it should work. But next_track 'should' be signalled
before this, but yes we need to recheck this logic here and ensure no
gaps are left in gapless :-)

-- 
~Vinod
