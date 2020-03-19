Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91F4C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC7C420732
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 13:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCSNAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 09:00:55 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:57546 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgCSNAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 09:00:54 -0400
X-isilmar-external: YES
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
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 5E6E12009CA;
        Thu, 19 Mar 2020 13:00:53 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 172B020B1E; Thu, 19 Mar 2020 14:00:49 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:00:49 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        kuninori.morimoto.gx@renesas.com
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200319130049.GA2244@light.dominikbrodowski.net>
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 11:20:55PM +0100, Cezary Rojewski wrote:
> On 2020-03-18 22:52, Dominik Brodowski wrote:
> > On Wed, Mar 18, 2020 at 09:43:54PM +0100, Cezary Rojewski wrote:
> > > On 2020-03-18 20:22, Dominik Brodowski wrote:
> > > > On Wed, Mar 18, 2020 at 07:27:58PM +0100, Cezary Rojewski wrote:
> > > 
> > > > > 
> > > > > Due to pandemic I'm working remotely and right now won't be able to test
> > > > > audio quality so focusing on the stream==NULL issue. And thus we got to help
> > > > > each other out : )
> > > > 
> > > > Sure, and thanks for taking a look at this!
> > > > 
> > > > > Could you verify issue reproduces on 5.6.0-rc1 on your machine?
> > > > 
> > > > It reproduces on 5.6.0-rc1 + i915-bugfix. I'm trying to bisect it further in
> > > > the background, but that may take quite some time.
> > > > 
> > > 
> > > Could you checkout v5.6-rc1 with following commit reverted:
> > > 	ASoC: Intel: broadwell: change cpu_dai and platform components for SOF
> > > 
> > > For my working v5.6-rc1 commit id is:
> > > 64df6afa0dab5eda95cc4cc2269e3d4e83b6b6ce.
> > 
> > Hm, no joy -- after suspend/resume, no sound at first, and if I twiggle some
> > options with pulseaudio, I get garbled output (even when using
> > 
> > 	aplay -f S16_LE -r 44100 -c 2 --device="sysdefault:CARD=broadwellrt286"
> > 
> > ). Will try to bisect further the next days.
> > 
> 
> Thanks for quick reply. Revert of said commit fixes stream==NULL issue for
> me. See if there were any changes in dmesg.
> Will ask technicians to assist me on site tomorrow.

Have some good news now, namely that a bisect is complete: That pointed to
1272063a7ee4 ("ASoC: soc-core: care .ignore_suspend for Component suspend");
therefore I've added Kuninori Morimoto to this e-mail thread.

Additionally, I have tested mainline (v5.6-rc6+ as of 5076190daded) with
*both* 64df6afa0dab (which you suggested yesterday) and 1272063a7ee4
reverted. And that works like a charm as well.

Hope this helps!

Thanks,
	Dominik
