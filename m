Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE6DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 12:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E83F22DFB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 12:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596716987;
	bh=15Y36StYY4iLXnVd4QQeJi/iwqwtVIubaSLXu/Ed4wM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=VFgnIerLpSBYsn4D/aFGRornWdJzfNtKa4/hfLK35/HVOOoWBZsUYy3zQD53KEt5e
	 eZz9xonEGMAIU14r2KWx2yelcSulIKSFRswx6E6ZkKydCK5g23GRTsXxqs0ZDI0KLy
	 jq89EwWKLQ+0Xg1TUmHFyDAAQHERL0IUtUPK3Lpw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgHFMYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 08:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:54650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgHFLPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 07:15:36 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5111A204FD;
        Thu,  6 Aug 2020 11:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596712097;
        bh=15Y36StYY4iLXnVd4QQeJi/iwqwtVIubaSLXu/Ed4wM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LBkShuRw6J2te4O6AWDiRukKL6OXnClqE3VYlOty5A/1jwasG88skIcK9vcLcxNo4
         EKhghtFudkl9hziFOQReHfutbJ6HULIXRcj+IJs8Estw4LurSyWAElN1TD+1r6bDw+
         lDDVlhgQmXQPaeiBnJKQu9I/YKO05WwiH6sIIC5o=
Date:   Thu, 6 Aug 2020 16:38:13 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com
Subject: Re: [RFC PATCH v2 0/6] ALSA: compress: add support to change codec
 profile in gapless playback
Message-ID: <20200806043010.GC12965@vkoul-mobl>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <s5hpn8mqudq.wl-tiwai@suse.de>
 <20200723130522.GB12965@vkoul-mobl>
 <s5hlfjaqsk7.wl-tiwai@suse.de>
 <20200723155612.GC12965@vkoul-mobl>
 <s5hy2naotsa.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hy2naotsa.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-20, 22:33, Takashi Iwai wrote:
> On Thu, 23 Jul 2020 17:56:12 +0200,
> Vinod Koul wrote:
> > 
> > On 23-07-20, 15:17, Takashi Iwai wrote:
> > > On Thu, 23 Jul 2020 15:05:22 +0200,
> > > Vinod Koul wrote:
> > > > 
> > > > On 23-07-20, 14:38, Takashi Iwai wrote:
> > > > > On Tue, 21 Jul 2020 19:00:01 +0200,
> > > > > Srinivas Kandagatla wrote:
> > > > > > 
> > > > > > For gapless playback it is possible that each track can have different
> > > > > > codec profile with same decoder, for example we have WMA album,
> > > > > > we may have different tracks as WMA v9, WMA v10 and so on
> > > > > > Or if DSP's like QDSP have abililty to switch decoders on single stream
> > > > > > for each track, then this call could be used to set new codec parameters.
> > > > > > 
> > > > > > Existing code does not allow to change this profile while doing gapless
> > > > > > playback.
> > > > > > 
> > > > > > This patchset adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL along with
> > > > > > flags in capablity structure to allow userspace to set this new
> > > > > > parameters required which switching codec profile, either for gapless
> > > > > > or cross fade usecase.
> > > > > 
> > > > > One idea that came up at the previous audio conference regarding this
> > > > > implementation was to just allow SET_PARAMS during the stream is
> > > > > running (only if the driver sets the capability) instead of
> > > > > introducing yet a new ioctl and an ops.
> > > > > Would it make sense?
> > > > 
> > > > That does sound good but only issue would be that we need to somehow
> > > > mark/document that buffer info is useless and would be discarded, how do
> > > > we do that?
> > > 
> > > Yes, the buffer and no_wake_mode can be ignored in the gapless
> > > re-setup.  Is your concern only about the documentation?  Or something
> > > else needs to be changed significantly?  It's a new scheme in anyway,
> > > so the documentation update is required...
> > 
> > My concern is potential abuse of API down the road, if you feel it is
> > okay, I am okay with the proposal
> 
> If this can be potentially dangerous, it shouldn't be used, of course.
> What kind of scenario could it be?

I can think of users trying to invoke this incorrectly, right now we
would reject this.

Maybe, we can add checks like, if next_track is set and then copy the
codec params only to prevent any misuse.

Do you think that would be okay?

-- 
~Vinod
