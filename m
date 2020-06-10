Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD870C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D7DF2078C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591786707;
	bh=rSbEJSH5wWHm/u11HYgmNGrwGzUdhPr2VTU9myeit8Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PsDM3o6zvMUc0DDpChEInNCYxTYdQ65v8eHeFN8XKuSxngljn4Xup6OwIktmCpm0f
	 1loyymryl0+0htGQrvOZHT5CLXc+3KUyD5qkPZwip3uK1PWkBLPImho3aeIHyBKr9P
	 CF1jZ/3wAVQTJcKZhC4NPYogaC+N1GVHzG9g7uDY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgFJK60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728267AbgFJK60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:58:26 -0400
Received: from localhost (unknown [122.171.156.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64F92206F7;
        Wed, 10 Jun 2020 10:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591786705;
        bh=rSbEJSH5wWHm/u11HYgmNGrwGzUdhPr2VTU9myeit8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B88mvquodblHQiVmx/bmvCnLjjKFTzUMx6y9jLgDG+utdI1Sat2H6uJiyvFafdAcW
         EUfQcV3aPa8DikIELFcI2W82W6ZH3AZ9zyu9If+6SgeygqbbhcJUk+d0g8Da8UfxZL
         aq88/Fy/nLQ+DwxJDvl7BRg3I4mJ/g5Q7/iyjX1M=
Date:   Wed, 10 Jun 2020 16:28:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, broonie@kernel.org
Subject: Re: [RFC PATCH] ALSA: compress: Fix gapless playback state machine
Message-ID: <20200610105820.GA1393454@vkoul-mobl>
References: <20200610100729.362-1-srinivas.kandagatla@linaro.org>
 <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <817d009e-fa09-e897-cfc3-997bf1dd5e30@perex.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-06-20, 12:40, Jaroslav Kysela wrote:
> Dne 10. 06. 20 v 12:07 Srinivas Kandagatla napsal(a):
> > For gapless playback call to snd_compr_drain_notify() after
> > partial drain should put the state to SNDRV_PCM_STATE_RUNNING
> > rather than SNDRV_PCM_STATE_SETUP as the driver is ready to
> > process the buffers for new track.
> > 
> > With existing code, if we are playing 3 tracks in gapless, after
> > partial drain finished on previous track 1 the state is set to
> > SNDRV_PCM_STATE_SETUP which is then moved to SNDRV_PCM_STATE_PREPARED
> > after data write. With this state calls to snd_compr_next_track() and
> > few other calls will fail as they expect the state to be in
> > SNDRV_PCM_STATE_RUNNING.
> > 
> > Here is the sequence of events and state transitions:
> > 
> > 1. set_params (Track 1), state =  SNDRV_PCM_STATE_SETUP
> > 2. set_metadata (Track 1), no state change, state = SNDRV_PCM_STATE_SETUP
> > 3. fill and trigger start (Track 1), state = SNDRV_PCM_STATE_RUNNING
> > 4. set_next_track (Track 2), state = SNDRV_PCM_STATE_RUNNING
> > 5. partial_drain (Track 1), state = SNDRV_PCM_STATE_SETUP
> > 6  snd_compr_drain_notify (Track 1), state = SNDRV_PCM_STATE_SETUP
> > 7. fill data (Track 2), state = SNDRV_PCM_STATE_PREPARED
> > 8. set_metadata (Track 3), no state change, state = SNDRV_PCM_STATE_PREPARED
> > 9. set_next_track (Track 3), !! FAILURE as state != SNDRV_PCM_STATE_RUNNING
> 
> 
> The snd_compr_drain_notify() is called only from snd_compr_stop(). Something
> is missing in this sequence?

It is supposed to be invoked by driver when partial drain is complete..
both intel and sprd driver are calling this. snd_compr_stop is stop
while draining case so legit

Somehow not sure how it got missed earlier, but this seem a decent fix
but we still need to check all the states here..

-- 
~Vinod
