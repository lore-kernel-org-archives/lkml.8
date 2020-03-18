Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3951C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7845320767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgCRJ6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:58:01 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:49520 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCRJ6B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:58:01 -0400
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id C0687200ADE;
        Wed, 18 Mar 2020 09:57:59 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 2EFF320B19; Wed, 18 Mar 2020 10:57:45 +0100 (CET)
Date:   Wed, 18 Mar 2020 10:57:45 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com,
        broonie@kernel.org, perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200318095745.GA133849@light.dominikbrodowski.net>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <66c719b3-a66e-6a9f-fab8-721ba48d7ad8@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <66c719b3-a66e-6a9f-fab8-721ba48d7ad8@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:41:42AM +0100, Cezary Rojewski wrote:
> On 2020-03-18 07:30, Dominik Brodowski wrote:
> > Hi!
> > 
> > While 5.5.x works fine, mainline as of ac309e7744be (v5.6-rc6+) causes me
> > some sound-related trouble: after boot, the sound works fine -- but once I
> > suspend and resume my broadwell-based XPS13, I need to switch to headphone
> > and back to speaker to hear something. But what I hear isn't music but
> > garbled output.
> > 
> > A few dmesg snippets from v5.6-rc6-9-gac309e7744be which might be of
> > interest. I've highlighted the lines differing from v.5.5.x which might be
> > of special interest:
> > 
> 
> Thank you for the report, Dominik. You definitely got our attention.
> 
> I've checked the market: Dell XPS 13 9343, yes? Once you confirm model id,
> I'll order a piece immediately to our site.

Thanks, for taking a look at this issue, Czarek. Indeed, it's a

	Dell Inc. XPS 13 9343/0TM99H, BIOS A19 12/24/2018

and IIRC there should be at least one of those already at the Linux sound
team at Intel (you may want to check with Yang Jie and Han Lu; I was in
contact with them relating to a different sound-related issue in 2015).

> In regard to logs, thanks for highlighting important lines. Build is of 'rc'
> so bugs can still be in plenty - any reason for switching to cutting-edge
> kernel on production stuff? Our CI didn't detect any anomalies yet as it is
> running on 5.5.

Well, one has to test things to find bugs ;-) -- and as I sometimes
contribute to the kernel, it is better to keep current on things.

> I'll direct your ticket on todays meeting. On the first look, issue seems to
> be connected with recent changes to /drivers/dma/dmaengine.c. DesignWare DMA
> controller drv - which HSW/BDW makes use of - might not have been updated
> accordingly. Will dig further on that.
> 
> One more, just to make it clear for the rest of the viewers:
> 
> > 	haswell-pcm-audio haswell-pcm-audio: Direct firmware load for intel/IntcPP01.bin failed with error -2
> > 	haswell-pcm-audio haswell-pcm-audio: fw image intel/IntcPP01.bin not available(-2)
> 
> Back in the ancient days of DSP (HSW/BDW are actually the very first audio
> DSP hws for Intel) topology was part of FW - SW could not configure it and
> probably that's why library IntcPP01 is attempted to be loaded on every
> boot, even if it's not part of configuration for given hw. Maybe we could
> make it quieter though..
> 
> > 
> > (these last two messages already are printed a couple of time after boot, and then
> > again during a suspend/resume cycle. On v.5.5.y, there are similar messages
> > "no context buffer need to restore!"). Everything is built-in, no modules
> > are loaded.
> > 
> > Unfortunately, I cannot bisect this issue easily -- i915 was broken for
> > quite some time on this system[*], prohibiting boot...
> 
> Hmm, sounds like that issue is quite old. DSP for Haswell and Broadwell is
> available for I2S devices only, so this relates directly to legacy HDA
> driver. Compared to Skylake+, HDAudio controller for older platforms is
> found within GPU. My advice is to notify the DRM guys about this issue.
> 
> Takashi, are you aware of problems with HDMI on HSW/ BDW or should I just
> loop Jani and other DRM peps here?

Well, it works on v5.5, so this issue is not really "quite old" (the "no
context buffer need to restore!" message seen there seems harmless).

Thanks again, and best wishes,
	Dominik
