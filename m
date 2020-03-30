Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD6BC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77D5920748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 10:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgC3KYI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 06:24:08 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:33906 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729121AbgC3KYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 06:24:07 -0400
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
        by isilmar-4.linta.de (Postfix) with ESMTPSA id E96BA200107;
        Mon, 30 Mar 2020 10:24:05 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 7A4912048A; Mon, 30 Mar 2020 12:23:56 +0200 (CEST)
Date:   Mon, 30 Mar 2020 12:23:56 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Cezary Rojewski <cezary.rojewski@intel.com>
Cc:     Mark Brown <broonie@kernel.org>, kuninori.morimoto.gx@renesas.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
Message-ID: <20200330102356.GA16588@light.dominikbrodowski.net>
References: <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319165157.GA2254@light.dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 05:51:58PM +0100, Dominik Brodowski wrote:
> On Thu, Mar 19, 2020 at 04:48:03PM +0100, Cezary Rojewski wrote:
> > On 2020-03-19 14:41, Mark Brown wrote:
> > > On Thu, Mar 19, 2020 at 02:00:49PM +0100, Dominik Brodowski wrote:
> > > 
> > > > Have some good news now, namely that a bisect is complete: That pointed to
> > > > 1272063a7ee4 ("ASoC: soc-core: care .ignore_suspend for Component suspend");
> > > > therefore I've added Kuninori Morimoto to this e-mail thread.
> > > 
> > > If that's an issue it feels more like a driver bug in that if the driver
> > > asked for ignore_suspend then it should expect not to have the suspend
> > > callback called.
> > > 
> > 
> > Requested for tests with following diff applied:
> > 
> > diff --git a/sound/soc/intel/boards/broadwell.c
> > b/sound/soc/intel/boards/broadwell.c
> > index db7e1e87156d..6ed4c1b0a515 100644
> > --- a/sound/soc/intel/boards/broadwell.c
> > +++ b/sound/soc/intel/boards/broadwell.c
> > @@ -212,7 +212,6 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] =
> > {
> >                 .init = broadwell_rt286_codec_init,
> >                 .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> >                         SND_SOC_DAIFMT_CBS_CFS,
> > -               .ignore_suspend = 1,
> >                 .ignore_pmdown_time = 1,
> >                 .be_hw_params_fixup = broadwell_ssp0_fixup,
> >                 .ops = &broadwell_rt286_ops,
> 
> That patch fixes the issue(s). I didn't even need to revert 64df6afa0dab
> ("ASoC: Intel: broadwell: change cpu_dai and platform components for SOF")
> on top of that. But you can assess better whether that patch needs care for
> other reasons; for me, this one-liner you have suggested is perfect.

Seems this patch didn't make it into v5.6 (and neither did the other ones
you sent relating to the "dummy" components). Can these patches therefore be
marked for stable, please?

Thanks,
	Dominik
