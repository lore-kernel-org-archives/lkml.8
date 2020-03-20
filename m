Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633C5C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372FE20777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584718424;
	bh=gPg6Rj9rfVl3kr0MPwORpU97iokmhn0TxIQRvdMirpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sOA/l2z8v3EpY53c4II+lX2VstQFrwLFpTJ3vfD2S4b2lroj9fzKggvl0jPy8oCn+
	 4Vh4rtC3gGN+XRM/wjPno0bsbn1ASOYfGlYAfi8GA1Pvxi6MVQ4KAhnQxMp7KK3+up
	 LferNMbnrEDecrRa8xeOG2Sk3Mm9Cb0XN0LkJCGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgCTPdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:33:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgCTPdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:33:42 -0400
Received: from localhost (unknown [122.167.82.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD54B2070A;
        Fri, 20 Mar 2020 15:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584718422;
        bh=gPg6Rj9rfVl3kr0MPwORpU97iokmhn0TxIQRvdMirpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gtm7eDZ4ul2aZhkwWfERCf2d8ES2RWgsn5LRSiSAvao2eRzLMh4FUMTqzPLEE+WNO
         KcMHbqpvZ7Xkc4uQtLVmgOc27GLBd8hZil0/fbdrww95gtU2+X6vXMf96TVJgMpxU4
         cjT9on1SYCMidYkLDHQFI/gXP9Mj5vE/4sLO3gxI=
Date:   Fri, 20 Mar 2020 21:03:34 +0530
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
Message-ID: <20200320153334.GJ4885@vkoul-mobl>
References: <20200305063646.GW4148@vkoul-mobl>
 <eb30ac49-788f-b856-6fcf-84ae580eb3c8@linux.intel.com>
 <20200306050115.GC4148@vkoul-mobl>
 <4fabb135-6fbb-106f-44fd-8155ea716c00@linux.intel.com>
 <20200311063645.GH4885@vkoul-mobl>
 <0fafb567-10e5-a1ea-4a6d-b3c53afb215e@linux.intel.com>
 <20200313115011.GD4885@vkoul-mobl>
 <4cb16467-87d0-ef99-e471-9eafa9e669d2@linux.intel.com>
 <20200314094904.GP4885@vkoul-mobl>
 <3c32830c-cd12-867f-a763-7c3e385cb1e9@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c32830c-cd12-867f-a763-7c3e385cb1e9@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-03-20, 14:15, Pierre-Louis Bossart wrote:
> 
> 
> > > It's really down to your objection to the use of 'struct driver'... For ASoC
> > > support we only need the .name and .pm_ops, so there's really no possible
> > > path forward otherwise.
> > 
> > It means that we cannot have a solution which is Intel specific into
> > core. If you has a standalone controller you do not need this.
> 
> A 'struct driver' is not Intel-specific, sorry.

We are discussing 'struct sdw_master_driver'. Please be very specific in
you replies and do not use incorrect terminology which confuses people.

Sorry a 'struct sdw_master_driver' IMHO is. As I have said it is not
needed if you have standalone controller even in Intel case, and rest of
the world.

> > > Like I said, we have 3 options
> > 
> > Repeating the already discussed doesn't help. I have already told you the
> > constraint to work is not to add Intel specific change into core.
> > 
> > I have already said that expect the driver part I dont have objections
> > to rest of this series and am ready to merge
> > 
> > > a) stay with platform devices for now. You will need to have a conversation
> > > with Greg on this.
> > > 
> > > b) use a minimal sdw_master_device with a minimal 'struct driver' use.
> > > 
> > > c) use a more elaborate solution suggested in this patchset and yes that
> > > means the Qualcomm driver would need to change a bit.
> > > 
> > > Pick one or suggest something that is implementable. The first version of
> > > the patches was provided in October, the last RFC was provided on January
> > > 31, time's up. At the moment you are preventing ASoC integration from moving
> > > forward.
> > 
> > In opensource review we go back and forth and we debate and come to a
> > common conclusion. Choosing a specific set of solutions and constraining
> > yourself to pick one does not help.
> 
> First off, the ask to move away from platform devices came from Greg. Not
> me. All I did here was suggest solutions, one reviewed by Greg as 'sane' and
> 'nice work'. Greg essentially wrote the book on devices/drivers so his
> review means I am not completely senile just yet.
> 
> You pushed back with two proposals that don't account for power management
> and the driver name required for ASoC. That was on top on another suggestion
> to use platform devices that was shot down by Greg himself with language I
> can't quote here.
> 
> Please re-read my words: my ask was "Pick one or suggest something that is
> implementable."

IMO the path I suggested is implementable..
> 
> You don't pick one and don't suggest anything implementable either, so
> there's really not much I can do, can I? I don't have a solution without a
> 'struct driver', and you don't want it.
> 
> The only short-term path forward I see is to ask Greg to agree to keep the
> platform devices for now.

And I guess you didn't talk to your Intel colleagues... Please talk to
them on how they did it.


> 
> > I have only _one_ constraint no platform specific change in core. If that
> > is satisfied I will go with it. Sorry but this is non-negotiable for me.
> 
> How is a 'struct driver' platform specific?
> 
> > Ask yourself, do you need this intrusive core change if you had this
> > exact same controller(s) but only as standalone one...
> 
> That would really not change anything. There would be some sort of ID (PCI
> or something else) for the controller and multiple masters below. The

If it is single master?

If it is multiple master with different ACPI ID for each master?

Would you still need 'struct sdw_master_driver'?

> ACPI/DisCo spec does not account for masters so they would have to be
> created by hand.


> 
> Again how is a 'struct driver' an 'intrusive change'?

Again do not confuse by using incorrect terminology.

Again 'struct sdw_master_driver' for a specific Intel hw configuration is.

-- 
~Vinod
