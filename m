Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26877C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F140B21734
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 05:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597986785;
	bh=JQU9mXlGQHqxpkXNmcu6IbDvpZpRpleWG+SpVgI46EU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LKXVjLBSouOfY22bfGwaCtCkq8PZVqIEBB9b9e2O6xnWvANUK4ixgWbXC7FG5yoRr
	 MxntLwC/e/LbjOSJb4gp8CJRVoVrHTg4YBVLE6bdIrYSyLX4C78WmuS4vWSx0jkQ6A
	 VfFPQoCj/yXdnpYStc8lPqQzj6DEEPI6Bcg/5Sv0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgHUFND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 01:13:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:46250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgHUFND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 01:13:03 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF910208E4;
        Fri, 21 Aug 2020 05:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597986782;
        bh=JQU9mXlGQHqxpkXNmcu6IbDvpZpRpleWG+SpVgI46EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r3go8lojTbEr7ggmy34F0+6ntC9It3xWedK5ixdQJNd69UfcoBhfw1ZVVES0UBx1C
         53+Qcl+WCvJloPT1DqSyzYFXyohCwPrcIDdDKAgyjRWVO2VirAC4SQGw2n4ZQPJi+Q
         b1EBU3mrpoDTXRzBpebubmxnxIuZYz+en4iTmEZY=
Date:   Fri, 21 Aug 2020 10:42:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: Re: [PATCH v2] soundwire: SDCA: add helper macro to access controls
Message-ID: <20200821051258.GJ2639@vkoul-mobl>
References: <20200816201058.9687-1-yung-chuan.liao@linux.intel.com>
 <20200817121411.GR2639@vkoul-mobl>
 <2ab412c5-bf96-5ba3-c193-5a8ad9071bbb@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ab412c5-bf96-5ba3-c193-5a8ad9071bbb@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-08-20, 10:14, Pierre-Louis Bossart wrote:
> 
> > > The upcoming SDCA (SoundWire Device Class Audio) specification defines
> > > a hiearchical encoding to interface with Class-defined capabilities,
> > 
> > typo hiearchical
> 
> ok
> 
> > > based on which audio function, entity, control and channel being used.
> > 
> > Can you please elaborate on what do these terms refer to?
> > 
> > Also can we have some documentation for this and how Linux is going to
> > use it..
> 
> These are concepts in the SDCA draft spec, and that should be the reference.
> We worked with MIPI so that this spec will be available with a click-through
> agreement when ratified, for now it's only available to contributors per
> MIPI bylaws.
> 
> If you do not have access to this specification, then that's a real problem.
> Maybe you need to let Bard take care of this part as a co-maintainer?
> 
> The goal with this macro is to enable a first set of codecs drivers using
> these concepts to be released upstream. All you need to know at this point
> is that controls are defined in a hierarchical way and accessed with a
> read/write transaction from/to the address created with the following macro.

Hmmm, if we cannot get some kind of Documentation of what it means and
review the code, then I do not see a point in getting this into kernel.

As kernel community we would like to see some form of Documentation
associated with the patches on what this means.

If that is not possible due to MIPI regulations, maybe deferring
this would make sense

Thanks
> 
> > > +/* v1.2 device - SDCA address mapping */
> > > +#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
> > > +						 (((fun) & 0x7) << 22) |	\
> > > +						 (((ent) & 0x40) << 15) |	\
> > > +						 (((ent) & 0x3f) << 7) |	\
> > > +						 (((ctl) & 0x30) << 15) |	\
> > > +						 (((ctl) & 0x0f) << 3) |	\
> > > +						 (((ch) & 0x38) << 12) |	\
> > > +						 ((ch) & 0x07))
> > > +
> > 
> > how about adding an underscore to the arguments here:
> > 
> > #define SDW_SDCA_CTL(_fun, _ent, _ctl, _ch)
> > and so on..
> 
> I checked the SoundWire defines and the vast majority of the macros don't
> use underscores, and when they do there's no consistency between 1 or 2
> underscores.

-- 
~Vinod
