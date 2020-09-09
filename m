Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E2FC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40847208FE
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 07:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599637771;
	bh=Ujzu08sFRyCMDhvVsoI1m0iKA5o9FG6NKI6n+mvre50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W8JoS106VPU1c6X2iUsiU/eiFr0JMdV1o1mXQ5VPvCv0pe2QH7l7RDJv/1cpaO9oD
	 h1OBBbRLyDjsZ5mopKzZiwBJjXxFJHKp/uMx+/QWwOL2tDMkYGCNTs7xcB/v1PhdMD
	 npOkLsFroh5o5aq7U2yrYUFAOd1wadxNNAy38mh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbgIIHt2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:49:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgIIHt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 03:49:27 -0400
Received: from localhost (unknown [122.179.21.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0297620732;
        Wed,  9 Sep 2020 07:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599637766;
        bh=Ujzu08sFRyCMDhvVsoI1m0iKA5o9FG6NKI6n+mvre50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qWC5m8O3Px8t6xUn6sKDugGjmYp7K7Be5rDCf/75V9oDDKcRRfVGENN8ile3NHh+E
         TKPHDonJGeYrvwU9Xl6Z3DHI9WtM+HRwc1I3IOqq45oHvRg1NdH0FpCfVHTbCYfbZJ
         fna6S1rlo4q/If2O98KCX6AHc8Yr+3YOGd1pm0dA=
Date:   Wed, 9 Sep 2020 13:19:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jaroslav Kysela <perex@perex.cz>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH v3 0/3] ASoC: Add sdw stream operations to dailink ops.
Message-ID: <20200909074918.GJ77521@vkoul-mobl>
References: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
 <46f44acb-7d4b-965c-a6e2-98a4da79e6cc@perex.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46f44acb-7d4b-965c-a6e2-98a4da79e6cc@perex.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-20, 14:26, Jaroslav Kysela wrote:
> Dne 04. 09. 20 v 20:28 Bard Liao napsal(a):
> > Sdw stream operation APIs can be called once per stream. Move these
> > operations to dailink ops. The linked series is "soundwire: Remove sdw
> > stream operations from Intel soundwire dai".
> > 
> > Reviewed-by: Vinod Koul <vkoul@kernel.org>
> > 
> > Changes in v3:
> >  - s/ASOC/ASoC
> > 
> > Pierre-Louis Bossart (3):
> >   ASoC: soc-dai: clarify return value for get_sdw_stream()
> >   ASoC: Intel: sof_sdw: add dailink .trigger callback
> >   ASoC: Intel: sof_sdw: add dailink .prepare and .hw_free callback
> > 
> >  include/sound/soc-dai.h          |  3 +-
> >  sound/soc/intel/boards/sof_sdw.c | 81 ++++++++++++++++++++++++++++++++
> >  2 files changed, 83 insertions(+), 1 deletion(-)
> > 
> 
> This patchset depends on the SoundWire patchset
>   "[PATCH v2 0/4] soundwire: Remove sdw stream operations from Intel" and
> cannot be used standalone. I believe that one maintainer should accept it or
> there should be a co-ordination between Mark and Vinod to push this in sync.
> We should really settle, how to accept such changes. I believe that Vinod
> should take it with the ack from Mark for this case. Please, don't require to
> split changes which depends on each other.

I did ask about dependencies, and IIRC looking at code there were none.
Yes you need both the parts to make it work, but both the trees build
fine and these will go for 5.10, so I think these merged are okay.

> 
> For all above patches (I tested them):
> 
> Acked-by: Jaroslav Kysela <perex@perex.cz>
> 
> -- 
> Jaroslav Kysela <perex@perex.cz>
> Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

-- 
~Vinod
