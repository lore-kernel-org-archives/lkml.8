Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C4FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02A9720C56
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598600967;
	bh=0tjlBtvKkul42khLrBsQqQgWErMtE09glUlRUTYCCew=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ngES9/5R46DkWbKllSgjY8wFJEQxIoh9tyWjD+OdOAw7eR8TlhBAn9l7nO9uaTgc1
	 DzaYMbEmq6Z3EKd413Jwh2MiLB4J4WVnrO9hcIi1sqz871PWXJwPenG7nx4gEmHbhS
	 CLTd/exYNT5oSmqNS0fiUOdKoZJ59erSlsD0DDBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgH1HtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgH1HtX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:49:23 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4AAE2078A;
        Fri, 28 Aug 2020 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598600962;
        bh=0tjlBtvKkul42khLrBsQqQgWErMtE09glUlRUTYCCew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VqrnaPtRoobZq9TXSgog8vE3JTy6fqzJTUpBC6OTs01lYX4RtXxLE3RLFokwkcx7t
         HbNkkNEIJdvesNgWMu5FZf0MPvc1VJuiuBb9QjGXZjtuO/Ajk9lU909es7h794cIdy
         JNdJAw3OxZihqgPqeCUO4lbm69gUq9DsCAXNSV5s=
Date:   Fri, 28 Aug 2020 13:19:18 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH 07/11] soundwire: intel: Only call sdw stream APIs for
 the first cpu_dai
Message-ID: <20200828074918.GN2639@vkoul-mobl>
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-8-yung-chuan.liao@linux.intel.com>
 <20200826094636.GB2639@vkoul-mobl>
 <5a7b75e5-4d64-9927-df81-68164ef2662a@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5a7b75e5-4d64-9927-df81-68164ef2662a@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-08-20, 09:35, Pierre-Louis Bossart wrote:
> 
> > > -	ret = sdw_prepare_stream(dma->stream);
> > > +	/*
> > > +	 * All cpu dais belong to a stream. To ensure sdw_prepare_stream
> > > +	 * is called once per stream, we should call it only when
> > > +	 * dai = first_cpu_dai.
> > > +	 */
> > > +	if (first_cpu_dai == dai)
> > > +		ret = sdw_prepare_stream(dma->stream);
> > 
> > Hmmm why not use the one place which is unique in the card to call this,
> > hint machine dais are only called once.
> 
> we are already calling directly sdw_startup_stream() and
> sdw_shutdown_stream() from the machine driver.
> 
> We could call sdw_stream_enable() in the dailink .trigger as well, since it
> only calls the stream API.

Correct :)

> However for both .prepare() and .hw_free() there are a set of dai-level
> configurations using static functions defined only in intel.c, and I don't
> think we can move the code to the machine driver, or split the
> prepare/hw_free in two (dailink and dai operations).

Cant they be exported and continue to call those apis

> I am not against your idea, I am not sure if it can be done.
> 
> Would you be ok to merge this as a first step and let us work on an
> optimization later (which would require ASoC/SoundWire synchronization)?

The problem is that we add one flag then another and it does become an
issue eventually, better to do the right thing now than later.

-- 
~Vinod
