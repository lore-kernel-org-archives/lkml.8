Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41646C4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 140E024653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:36:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582706217;
	bh=mSMMXe4CcAPwrz9afb6AoMD/VJD8uxcrEcPdecrZtlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sCd3jQrrhazL+RJbQC90zYVMb/qnJKoPNZ5shnlkggmRDiDL0np5nC5yG2EoG3WV4
	 bCz4snVG3NP4NyMNpx8P6UqF2eSSLblMPuwya8Q/B+NeggpmD3GG6cYN/xHUCK9TiH
	 +8gKsla13/klHd0EVTzejqqdEbnkkzPI+UVl1FBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBZIg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:36:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727075AbgBZIgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:36:55 -0500
Received: from localhost (unknown [171.76.87.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29CE02084E;
        Wed, 26 Feb 2020 08:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582706215;
        bh=mSMMXe4CcAPwrz9afb6AoMD/VJD8uxcrEcPdecrZtlw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guyZnlti7qGjLVFOsV2v1H4274OP9X9PrO517UFvHX/YLtsJldG8e9m2KALAh647p
         /h24IJgyBnds7z5baiXtBg5/4aUn4XCAkFN9lt1QTONUuJiHh1KqkWPUk7a3MVX3sp
         hNijMKb44RT9WYQ7ePo+zA9g1pqUw0p8EesVOn18=
Date:   Wed, 26 Feb 2020 14:06:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>
Subject: Re: [PATCH 0/3] SoundWire: ASoC interfaces for multi-cpu dais and
 DisCo helpers
Message-ID: <20200226083644.GV2618@vkoul-mobl>
References: <20200225170041.23644-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225170041.23644-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-02-20, 11:00, Pierre-Louis Bossart wrote:
> The first two patches prepare the support of multi-cpu dais for
> synchronized playback and capture. We remove an unused set of

Can you explain how this set does that..?

> prototypes and add a get_sdw_stream() callback prototype currently

Right, how does something which is unused and getting removed help in
supporting multi-cpu dais?

> missing (the implementation will come later as part of the
> synchronized playback)

I guess Mark can comment on this but we really want to see users of APIs
as well.

> The last exposes macros used internally, so that they can be reused to
> extract information from the _ADR 64-bit values in SOF platform
> drivers and related machine drivers.

On it is own, i think 1st and last patch look fine to me, so I guess I
will go ahead and apply them. I can understand that last one can be used
by SOF driver so can be pulled by Mark, will put on topic branch..

> I think it's simpler if all these simple patches are merged through
> the SoundWire tree. With the additional changes to remove the platform
> drivers and the merge of interrupt handling, that will result in a
> single immutable tag provided to Mark Brown.
> 
> Pierre-Louis Bossart (3):
>   soundwire: cadence: remove useless prototypes
>   ASoC: soc-dai: add get_sdw_stream() callback
>   soundwire: add helper macros for devID fields
> 
>  drivers/soundwire/bus.c            | 21 +++++----------------
>  drivers/soundwire/cadence_master.h |  8 --------
>  include/linux/soundwire/sdw.h      | 23 +++++++++++++++++++++++
>  include/sound/soc-dai.h            | 21 +++++++++++++++++++++
>  4 files changed, 49 insertions(+), 24 deletions(-)
> 
> -- 
> 2.20.1

-- 
~Vinod
