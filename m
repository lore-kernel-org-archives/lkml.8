Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEABC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:56:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0913320792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595519779;
	bh=GcS2kAU29xEZ0jnjZv+lYshFkwhHH/EsbplOO3bG05k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pCGRijgf0s1UolMpXYk9XSTlCk5e4ZmlQkPhPYZHWNHwwTgYzT8I/Ugm19dFyo1Wz
	 8b9vq35dL/5mKnZm1zw2e9Td9U63uERUBlrToTIUPHYjmImZvMKHZMB3G2yPMY8Oe4
	 LI0KXDM0BZxv4+6o3Z2sM2NCPyhraNJNnzyuha0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729666AbgGWP4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:34018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgGWP4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:56:17 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15CBB2071A;
        Thu, 23 Jul 2020 15:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595519777;
        bh=GcS2kAU29xEZ0jnjZv+lYshFkwhHH/EsbplOO3bG05k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0oyzTe84hn6Vi+wGOvEXcgLfAzirXbWQJ19VhKfJoYDqWTBUsvmi/Ur6HbDyxfBgK
         OjloT3wXweREikgFKAWxvNvD+ia6USsUei/xHKb5GqTHWIOy3LVZBSvWWni91il77j
         d+RHqZ7QrGeIFiwWbZXrK3MKpywI/hUmjwsAht0I=
Date:   Thu, 23 Jul 2020 21:26:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com
Subject: Re: [RFC PATCH v2 0/6] ALSA: compress: add support to change codec
 profile in gapless playback
Message-ID: <20200723155612.GC12965@vkoul-mobl>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <s5hpn8mqudq.wl-tiwai@suse.de>
 <20200723130522.GB12965@vkoul-mobl>
 <s5hlfjaqsk7.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hlfjaqsk7.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-20, 15:17, Takashi Iwai wrote:
> On Thu, 23 Jul 2020 15:05:22 +0200,
> Vinod Koul wrote:
> > 
> > On 23-07-20, 14:38, Takashi Iwai wrote:
> > > On Tue, 21 Jul 2020 19:00:01 +0200,
> > > Srinivas Kandagatla wrote:
> > > > 
> > > > For gapless playback it is possible that each track can have different
> > > > codec profile with same decoder, for example we have WMA album,
> > > > we may have different tracks as WMA v9, WMA v10 and so on
> > > > Or if DSP's like QDSP have abililty to switch decoders on single stream
> > > > for each track, then this call could be used to set new codec parameters.
> > > > 
> > > > Existing code does not allow to change this profile while doing gapless
> > > > playback.
> > > > 
> > > > This patchset adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL along with
> > > > flags in capablity structure to allow userspace to set this new
> > > > parameters required which switching codec profile, either for gapless
> > > > or cross fade usecase.
> > > 
> > > One idea that came up at the previous audio conference regarding this
> > > implementation was to just allow SET_PARAMS during the stream is
> > > running (only if the driver sets the capability) instead of
> > > introducing yet a new ioctl and an ops.
> > > Would it make sense?
> > 
> > That does sound good but only issue would be that we need to somehow
> > mark/document that buffer info is useless and would be discarded, how do
> > we do that?
> 
> Yes, the buffer and no_wake_mode can be ignored in the gapless
> re-setup.  Is your concern only about the documentation?  Or something
> else needs to be changed significantly?  It's a new scheme in anyway,
> so the documentation update is required...

My concern is potential abuse of API down the road, if you feel it is
okay, I am okay with the proposal

Thanks
-- 
~Vinod
