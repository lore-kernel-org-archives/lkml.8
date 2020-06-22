Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AA6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 05:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F1B325409
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 05:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592804108;
	bh=buogNVymtxZczQRvv8+g2nbdqd82HeUu7XS5fvcsNUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P1VoX28onT46KT2uc4wcjP/P2bQAfkGq9JQE+OQ4nQbew29SJq1r6zxGnmCjympid
	 LEHHIbr3+tS4P+IzX2oIoAa0KT3JRZzhpZcv9PwW5i8zBIs3wCmDLoG26hTMiVRIX2
	 CA9ltp0Xh4xZAEaCJinZe1yZhCnhYqVlzmVLGzaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731239AbgFVFfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 01:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:50712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729114AbgFVFfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 01:35:06 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AB7A25403;
        Mon, 22 Jun 2020 05:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592804106;
        bh=buogNVymtxZczQRvv8+g2nbdqd82HeUu7XS5fvcsNUM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ixsUV6i006rFSF+BM2wZPMzJv+W3L5HSubsSio34AulKk4MXs2Zb7H+/kNttBvXiM
         SwXB5XtJo87eWhierQ0slWFCy2kP5p+1akvFfW9tEqmefbq2Op1Q90NPSCEHM+tg0R
         vhlfcxdyuaD45ZqJCoRSPauOdqisrQDccUFivVuc=
Date:   Mon, 22 Jun 2020 11:05:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] ALSA: compress: fix partial_drain completion state
Message-ID: <20200622053502.GF2324254@vkoul-mobl>
References: <20200619045449.3966868-1-vkoul@kernel.org>
 <20200619045449.3966868-4-vkoul@kernel.org>
 <0a0fcd4c-40dd-621e-b0ad-51296178aa9e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a0fcd4c-40dd-621e-b0ad-51296178aa9e@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-20, 10:13, Srinivas Kandagatla wrote:
> 
> 
> On 19/06/2020 05:54, Vinod Koul wrote:
> > On partial_drain completion we should be in SNDRV_PCM_STATE_RUNNING
> > state, so set that for partially draining streams in
> > snd_compr_drain_notify() and use a flag for partially draining streams
> > 
> > While at it, add locks for stream state change in
> > snd_compr_drain_notify() as well.
> > 
> > Fixes: f44f2a5417b2 ("ALSA: compress: fix drain calls blocking other compress functions (v6)")
> > Reported-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> 
> Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Tested-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks for testing Srini

-- 
~Vinod
