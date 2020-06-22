Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74913C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 05:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EAC125403
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 05:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592804088;
	bh=E3RXzVUV2XgnYSHsFHYQBv8Wt4U72vQ9giqYbfrpai0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=CasWXyLvX3TyOY8aqNg+S1V3ZHbzLc94rIAblMpOsaTvyqyRk/ZjV/MKYqFXWV+y8
	 jZ3Odhh4K42vc9B9gDk4m0db4KUui6XtJWr7nAHwNMulIuT3qsLKrhUZJAlTsXdWlD
	 rULbm2rzf/s/QzorFxvR/5lEs84Yi8si1I0ySOwg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731228AbgFVFeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 01:34:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731210AbgFVFeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 01:34:46 -0400
Received: from localhost (unknown [171.61.66.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78482253E9;
        Mon, 22 Jun 2020 05:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592804085;
        bh=E3RXzVUV2XgnYSHsFHYQBv8Wt4U72vQ9giqYbfrpai0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r/HD9M5IHBDvlCPkxSg/s2VSNOE1JY8phHpLiQuVHwgWBzZoQoUtBSXI3GI3aDom8
         BvKAkZVhh8j3nyl8NaWYDQbyj5CawS5c8DZrURjEv8rOmpmJBNMpidK4+TiSzf3d06
         t+qsGvgVMCmzwvP4CuJzG34SpxPyZy5+4GaswZjw=
Date:   Mon, 22 Jun 2020 11:04:41 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] ALSA: compress: document the compress gapless audio
 state machine
Message-ID: <20200622053441.GE2324254@vkoul-mobl>
References: <20200619045449.3966868-1-vkoul@kernel.org>
 <20200619045449.3966868-3-vkoul@kernel.org>
 <5c878ccf-43dd-4e13-aa6b-a6cb1e82af72@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c878ccf-43dd-4e13-aa6b-a6cb1e82af72@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-06-20, 09:27, Pierre-Louis Bossart wrote:
> 
> > +For Gapless, we move from running state to partial drain and back, along
> > +with setting of meta_data and signalling for next track ::
> > +
> > +
> > +                                        +----------+
> > +                compr_drain_notify()    |          |
> > +              +------------------------>|  RUNNING |
> > +              |                         |          |
> > +              |                         +----------+
> > +              |                              |
> > +              |                              |
> > +              |                              | compr_next_track()
> > +              |                              |
> > +              |                              V
> > +              |                         +----------+
> > +              |                         |          |
> > +              |                         |NEXT_TRACK|
> > +              |                         |          |
> > +              |                         +----------+
> > +              |                              |
> > +              |                              |
> > +              |                              | compr_partial_drain()
> > +              |                              |
> > +              |                              V
> > +              |                         +----------+
> > +              |                         |          |
> > +              +------------------------ | PARTIAL_ |
> > +                                        |  DRAIN   |
> > +                                        +----------+
> 
> May I suggest having a single state machine, not a big one and an additional
> partial one. It would help explain why in one case compr_drain_notify()
> triggers a transition to RUNNING while in the other one it goes to SETUP.
> 
> I realize it's more complicated to edit but it'd be easier on
> reviewers/users.

Ell adding stop and transitions would really make it complicated and
gapless is a bit different handling and it looks cleaner this way IMO,
so lets stick to this. Feel free to create one if you are up for it.

-- 
~Vinod
