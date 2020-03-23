Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF8C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA97207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584965768;
	bh=jCOWRh42vHKRmuLejlk3NOJX2vnfeEJTZUiki6Qd37I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U/qmCNKH5aKu/vhYAAQ3gHyin42/4YAUByMqcN70J9dg6y92wd4rr4Zr+mRjEGb0a
	 t4X/8OHzBqfnRwQI4Ea+1lO0thXx2jmvQGOY6nJOP6gmiCYCNE4apJM5NDl/oETfZn
	 PMH1/Q7aNI02AA7BBXHQRq5jeiFtN0nXmducFdZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgCWMQH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:16:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbgCWMQG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:16:06 -0400
Received: from localhost (unknown [122.178.205.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B33B92078B;
        Mon, 23 Mar 2020 12:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584965765;
        bh=jCOWRh42vHKRmuLejlk3NOJX2vnfeEJTZUiki6Qd37I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oHBwIXyT+XFi4LgqRYZP+1b1FgpZ6QuEpEq3rOBoebxb+yPg5AjdQZXLn3SNgH5U9
         4sXay+DVxIVNhgy44uw9EhRIx3MgBCLlScZHpwW22fKI6DgMOpLlQGkotJvJNO2ZQO
         tVTQvsd5xQcvW44VLPsdwtjNVuz9SaX9rG+SQOB4=
Date:   Mon, 23 Mar 2020 17:46:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [PATCH 1/8] soundwire: bus_type: add master_device/driver support
Message-ID: <20200323121601.GJ72691@vkoul-mobl>
References: <20200306050115.GC4148@vkoul-mobl>
 <4fabb135-6fbb-106f-44fd-8155ea716c00@linux.intel.com>
 <20200311063645.GH4885@vkoul-mobl>
 <0fafb567-10e5-a1ea-4a6d-b3c53afb215e@linux.intel.com>
 <20200313115011.GD4885@vkoul-mobl>
 <4cb16467-87d0-ef99-e471-9eafa9e669d2@linux.intel.com>
 <20200314094904.GP4885@vkoul-mobl>
 <3c32830c-cd12-867f-a763-7c3e385cb1e9@linux.intel.com>
 <20200320153334.GJ4885@vkoul-mobl>
 <70d6e0cb-22a6-5ada-83a8-b605974bdd84@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70d6e0cb-22a6-5ada-83a8-b605974bdd84@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-03-20, 11:36, Pierre-Louis Bossart wrote:
> 
> 
> On 3/20/20 10:33 AM, Vinod Koul wrote:
> > On 16-03-20, 14:15, Pierre-Louis Bossart wrote:
> > > 
> > > 
> > > > > It's really down to your objection to the use of 'struct driver'... For ASoC
> > > > > support we only need the .name and .pm_ops, so there's really no possible
> > > > > path forward otherwise.
> > > > 
> > > > It means that we cannot have a solution which is Intel specific into
> > > > core. If you has a standalone controller you do not need this.
> > > 
> > > A 'struct driver' is not Intel-specific, sorry.
> > 
> > We are discussing 'struct sdw_master_driver'. Please be very specific in
> > you replies and do not use incorrect terminology which confuses people.
> > 
> > Sorry a 'struct sdw_master_driver' IMHO is. As I have said it is not
> > needed if you have standalone controller even in Intel case, and rest of
> > the world.
> 
> You're splitting hair without providing a solution.
> 
> Please see the series [PATCH 0/5] soundwire: add sdw_master_device support
> on Qualcomm platforms
> 
> This solution was tested on Qualcomm platforms, that doesn't require this
> sdw_master_driver to be used, so your objections are now invalid.

I have given you a solution which you dont like. I have asked you to
talk to your colleagues at Intel, I have not heard back. I cant do
anymore than this.

testing on QC boards doesnt make sense, the contention is
'sdw_master_driver' which doesnt get used. I have said earlier, will say
again, if you drop this piece I am ready to apply the rest of the
patches.

-- 
~Vinod
