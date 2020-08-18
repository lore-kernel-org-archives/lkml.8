Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8907AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6737920855
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597732161;
	bh=zBw9hFO+H66X4Rr03LngM7OaVXF0mK9y8qCEVNvyBVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=X/dgp+axSqbIXDYPFOkX5sD43LusvPQd4q+ohYnRksBT4l17ojJOkQCXEivde3OiD
	 Awh4hrxAteb9/oukdhAbtKXVZt1ODiM6r1sRlvS3qW39HrrUfSTVhVobF/CmtUqF9t
	 gfcsHWrRkezIW9WNa/MKUUdywf8tgIDcoB5LV228=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHRG3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:29:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgHRG3T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:29:19 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B24B20825;
        Tue, 18 Aug 2020 06:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597732159;
        bh=zBw9hFO+H66X4Rr03LngM7OaVXF0mK9y8qCEVNvyBVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BdGkNHmLk2pD8vhckIj7kQXtI+aSrPKhj9pKMOHnMPS+QaPuN8td+x1ZzXfkOMgaz
         Sb7XmZP1K4Y2i/7naBcfrKZXcR6wL2fzwmNgf9zTHsy2e1knLwsWsAJCa7SVWm3vvC
         EkVIEdHbsKHoDTlzVRmPuqctTDKnKWBq0nx1oz/0=
Date:   Tue, 18 Aug 2020 11:59:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 00/13] soundwire: intel: add power management support
Message-ID: <20200818062915.GT2639@vkoul-mobl>
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
 <20200817120841.GQ2639@vkoul-mobl>
 <d8f8f64f-34db-9c9a-c821-83dda3b2db9a@linux.intel.com>
 <093dcb7d-e2b7-b568-6a23-aeaf9bfb6004@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <093dcb7d-e2b7-b568-6a23-aeaf9bfb6004@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-20, 11:10, Pierre-Louis Bossart wrote:
> 
> 
> > > I had applied except 3 & 9 (few skipped in middle due to conflict while
> > > applying), BUT I get a build failure on patch 2 onwards :(
> > > 
> > > drivers/soundwire/intel_init.c: In function ‘sdw_intel_cleanup’:
> > > drivers/soundwire/intel_init.c:72:4: error: implicit declaration of
> > > function ‘pm_runtime_disable’
> > > [-Werror=implicit-function-declaration]
> > >     72 |    pm_runtime_disable(&link->pdev->dev);
> > > 
> > > I suspect due to missing header? I was on x64 build with allmodconfig
> > > 
> > > So only patch 1 is applied and pushed now
> > 
> > I just tried on these series applied on top of soundwire/next
> > 
> > commit 9b3b4b3f2f2af863d2f6dd65afd295a5a673afa2 (soundwire/next)
> > 
> >      soundwire: intel: Add basic power management support
> > 
> > And I don't see any issue?
> 
> Sorry, I misunderstood the issue. Yes indeed the #include
> <linux/pm_runtime.h> is added to the wrong patch, I see Bard fixed this in
> our tree. Not sure what happened here, I ran a patch-by-patch compilation
> test a long time ago and kbuild was silent. Thanks for spotting this.
> 
> > If you want to double-check merge issues, I pushed the code here:
> > https://github.com/plbossart/sound/tree/sdw/pm_runtime_soundwire_next
> > 
> > I am really not sure what conflicts you are referring to, git am worked
> > fine for me, only skipped the first patch that's already applied.
> 
> But the point about conflicts does remain, I am not sure why you skipped
> patches, I have no merge conflicts on my side.

As noted above, I tried to apply except 3 & 9 due to questions on them.
It is quite normal that dependencies fail to apply, not sure why you are
confused.

-- 
~Vinod
