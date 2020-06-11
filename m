Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABA4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E57A20801
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 09:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591868671;
	bh=6dGlga2y8rs+Zft++wIUw+5mJiFU392Srhnvy/j+baA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wyhCGWmFYSw+/U+0nOiA9kORMEZQhUNxjXQ4v0L8GQhsUoBlQCPa49rPV8ZMNdT5b
	 XzTqC92f+k1IMF536iS4pOvE6YD/Q9Rgw88JU0b2R4ei1sZZSPQciv1ExWyqe1+lKo
	 ewhglfaIoGWy0XjdMtfF5IVi0OgMdOQdaIGGt6Bk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgFKJo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 05:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:45678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726684AbgFKJo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 05:44:29 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4211A207C3;
        Thu, 11 Jun 2020 09:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591868669;
        bh=6dGlga2y8rs+Zft++wIUw+5mJiFU392Srhnvy/j+baA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iS63csgenQ2UIlmq3F8RtVppTk3Q3dC2Q98LgAd8E6EZj3G/iH8wqNBoU+tqhHIiV
         jrSaLwL0tEOws48ZCq3hfqsgVItkmxQSRynqncIHFRuC2acWnsD9hNEbpsEhs4HoPM
         bNm5tMTuV2Pz2+w3egb3tnrCDCa6kS5x5O3crTs0=
Date:   Thu, 11 Jun 2020 15:14:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, broonie@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ALSA: compress: Fix gapless playback state machine
Message-ID: <20200611094423.GB1393454@vkoul-mobl>
References: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
 <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
 <20200610105820.GA1393454@vkoul-mobl>
 <20200611084659.GO71940@ediswmail.ad.cirrus.com>
 <6a984302-ff01-e326-d338-e50e1f532cd9@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a984302-ff01-e326-d338-e50e1f532cd9@perex.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-20, 11:09, Jaroslav Kysela wrote:
> Dne 11. 06. 20 v 10:46 Charles Keepax napsal(a):
> > On Wed, Jun 10, 2020 at 04:28:20PM +0530, Vinod Koul wrote:
> > > On 10-06-20, 12:40, Jaroslav Kysela wrote:
> > > > Dne 10. 06. 20 v 12:07 Srinivas Kandagatla napsal(a):
> > > > > For gapless playback call to snd_compr_drain_notify() after
> > > > > partial drain should put the state to SNDRV_PCM_STATE_RUNNING
> > > > > rather than SNDRV_PCM_STATE_SETUP as the driver is ready to
> > > > > process the buffers for new track.
> > > > > 
> > > > > With existing code, if we are playing 3 tracks in gapless, after
> > > > > partial drain finished on previous track 1 the state is set to
> > > > > SNDRV_PCM_STATE_SETUP which is then moved to SNDRV_PCM_STATE_PREPARED
> > > > > after data write. With this state calls to snd_compr_next_track() and
> > > > > few other calls will fail as they expect the state to be in
> > > > > SNDRV_PCM_STATE_RUNNING.
> > > > > 
> > > > > Here is the sequence of events and state transitions:
> > > > > 
> > > > > 1. set_params (Track 1), state =  SNDRV_PCM_STATE_SETUP
> > > > > 2. set_metadata (Track 1), no state change, state = SNDRV_PCM_STATE_SETUP
> > > > > 3. fill and trigger start (Track 1), state = SNDRV_PCM_STATE_RUNNING
> > > > > 4. set_next_track (Track 2), state = SNDRV_PCM_STATE_RUNNING
> > > > > 5. partial_drain (Track 1), state = SNDRV_PCM_STATE_SETUP
> > > > > 6  snd_compr_drain_notify (Track 1), state = SNDRV_PCM_STATE_SETUP
> > > > > 7. fill data (Track 2), state = SNDRV_PCM_STATE_PREPARED
> > > > > 8. set_metadata (Track 3), no state change, state = SNDRV_PCM_STATE_PREPARED
> > > > > 9. set_next_track (Track 3), !! FAILURE as state != SNDRV_PCM_STATE_RUNNING
> > > > 
> > > > 
> > > > The snd_compr_drain_notify() is called only from snd_compr_stop(). Something
> > > > is missing in this sequence?
> > > 
> > > It is supposed to be invoked by driver when partial drain is complete..
> > > both intel and sprd driver are calling this. snd_compr_stop is stop
> > > while draining case so legit
> > > 
> > 
> > Not sure I follow this statement, could you elaborate a bit?
> > snd_compr_stop putting the state to RUNNING seems fundamentally
> > broken to me, the whole point of snd_compr_stop is to take the
> > state out of RUNNING.
> 
> Yes. I agree. It seems that the acknowledge for the partial drain should be
> handled differently.

Yeah sorry I overlooked that case and was thinking of it being invoked
from driver!

Yes this would make the snd_compr_stop() behave incorrectly.. so this
cant be done as proposed.

But we still need to set the draining stream state properly and I am
thinking below now:

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 509290f2efa8..9aba851732d7 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -929,7 +929,9 @@ static int snd_compr_partial_drain(struct snd_compr_stream *stream)
        }
 
        stream->next_track = false;
-       return snd_compress_wait_for_drain(stream);
+       retval = snd_compress_wait_for_drain(stream);
+       stream->runtime->state = SNDRV_PCM_STATE_RUNNING;
+       return retval;
 }
 
-- 
~Vinod
