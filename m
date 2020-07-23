Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3C5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A27F2068F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595509529;
	bh=D93rNzAL3USHhE9CiOsmWZA4GSaCfM1HHTv9GxgV/TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s6CfV9Ce+6b89nJXgkXahU2IdEZGWW+D2vsqYuw529EbcfxNye81VkZwYt/hHbNZc
	 IFmyVYjF/YdUrhBugvMEb4DlFWzep4Ts/tBPZDrPerebLIlhBZy3Gf3KXlCbBa4wFM
	 r0jjYHnSg8KSZw+95jEzuuBSegV1QbUi4tCEKxL4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgGWNF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:05:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:45752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgGWNF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:05:26 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCA752064C;
        Thu, 23 Jul 2020 13:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595509526;
        bh=D93rNzAL3USHhE9CiOsmWZA4GSaCfM1HHTv9GxgV/TQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzkjyiaWEP47zA/ArSXhwj8fLX4f+WunUlSeYwjiPe/ckQr0mmOcvq1LRK6nJqXtu
         DbKe/qBCHhSjtSwCH/baM6gChe+fAftSzYxX22ms5Ayh3VNCURT7gZ5rpiU5sxhCuJ
         36CAOZH6TKlC9u4hTeGeCwvTrtzy6qwXShSDQMXY=
Date:   Thu, 23 Jul 2020 18:35:22 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com
Subject: Re: [RFC PATCH v2 0/6] ALSA: compress: add support to change codec
 profile in gapless playback
Message-ID: <20200723130522.GB12965@vkoul-mobl>
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <s5hpn8mqudq.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hpn8mqudq.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-07-20, 14:38, Takashi Iwai wrote:
> On Tue, 21 Jul 2020 19:00:01 +0200,
> Srinivas Kandagatla wrote:
> > 
> > For gapless playback it is possible that each track can have different
> > codec profile with same decoder, for example we have WMA album,
> > we may have different tracks as WMA v9, WMA v10 and so on
> > Or if DSP's like QDSP have abililty to switch decoders on single stream
> > for each track, then this call could be used to set new codec parameters.
> > 
> > Existing code does not allow to change this profile while doing gapless
> > playback.
> > 
> > This patchset adds new SNDRV_COMPRESS_SET_CODEC_PARAMS IOCTL along with
> > flags in capablity structure to allow userspace to set this new
> > parameters required which switching codec profile, either for gapless
> > or cross fade usecase.
> 
> One idea that came up at the previous audio conference regarding this
> implementation was to just allow SET_PARAMS during the stream is
> running (only if the driver sets the capability) instead of
> introducing yet a new ioctl and an ops.
> Would it make sense?

That does sound good but only issue would be that we need to somehow
mark/document that buffer info is useless and would be discarded, how do
we do that?

> I have no big objection to add a new ioctl if other people agree,
> though.
> 
> 
> thanks,
> 
> Takashi

-- 
~Vinod
