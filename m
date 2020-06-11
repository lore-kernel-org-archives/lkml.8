Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4619C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA9E20829
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 18:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgFKSM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 14:12:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:7619 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725824AbgFKSM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:12:56 -0400
IronPort-SDR: Hf93qwpQ015UEyGGZFmUzkZUB1ForM3wysQOg+SmPCZtVdeqK+AYfP/IeAUV9956YlgINwaNJf
 KklBRKbJ1RkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 11:12:54 -0700
IronPort-SDR: sgGeycKqS49OljXzUmElxdqto92wMSFKg9+yX1gughcpFA1byNZuzBPzJ+vRJabTr/S1Wb8+DX
 0OH2e2Ii1Fig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,500,1583222400"; 
   d="scan'208";a="289624840"
Received: from ttvo1-mobl.amr.corp.intel.com ([10.251.138.170])
  by orsmga002.jf.intel.com with ESMTP; 11 Jun 2020 11:12:53 -0700
Message-ID: <ccccab4d074878cd8fc3b3c4313025e54f78b65a.camel@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: hda: unsolicited RIRB response
From:   Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>, "Lu, Brent" <brent.lu@intel.com>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        Pierre-Louis Bossart DRIVERS 
        <pierre-louis.bossart@linux.intel.com>,
        "authored:2/16=12%,added_lines:21/248=8%,removed_lines:5/84=6%,),Liam "
         "Girdwood DRIVERS )" <lgirdwood@gmail.com>,
        "commit_signer:6/16=38%,authored:6/16=38%,added_lines:123/248=50% 
        ,removed_lines:36/84=43%,Kai " "Vehmanen DRIVERS )" 
        <kai.vehmanen@linux.intel.com>,
        "Daniel Baluta DRIVERS )" <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "sound-open-firmware@alsa-project.orgDRIVERS" 
        <sound-open-firmware@alsa-project.orgDRIVERS>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 11 Jun 2020 11:12:53 -0700
In-Reply-To: <s5h5zbxeb5t.wl-tiwai@suse.de>
References: <1591883073-17190-1-git-send-email-brent.lu@intel.com>
         <b7e0b822a9deea506acaa40e0e31cc9f488bb446.camel@linux.intel.com>
         <DM6PR11MB4316108BCF449D52E49C7E4297800@DM6PR11MB4316.namprd11.prod.outlook.com>
         <s5h5zbxeb5t.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-06-11 at 19:59 +0200, Takashi Iwai wrote:
> On Thu, 11 Jun 2020 19:09:08 +0200,
> Lu, Brent wrote:
> > 
> > > Hi Brent,
> > > 
> > > Thanks for the patch. Is this fix for a specific issue you're
> > > seeing?
> > > If so, could you please give us some details about it?
> > > 
> > > Thanks,
> > > Ranjani
> > 
> > Hi Ranjani,
> > 
> > It's reported to happen on GLK Chromebook 'Fleex' that sometimes it
> > cannot output the audio stream to external display. The kernel is
> > Chrome v4.14 branch. Following is the reproduce step provided by
> > ODM but I could reproduce it simply running aplay or
> > cras_test_client
> > so I think it's not about the cable plug/unplug handling.
> > 
> > What steps will reproduce the problem?
> > 1.      Play YouTube video on Chromebook and connect it to external
> > monitor with Type C to DP dongle
> > 2.      Press monitor power button to turn off the monitor
> > 3.      Press monitor power button again to turn on the monitor
> > 4.      Continue to play YouTube video and check audio playback
> > 5.      No sound comes out from built-in speaker of external
> > monitor when turn on external monitor
> > 
> > I added debug messages to print the RIRBWP register and realize
> > that
> > response could come between the read of RIRBWP in the
> > snd_hdac_bus_update_rirb() function and the interrupt clear in the
> > hda_dsp_stream_interrupt() function. The response is not handled
> > but
> > the interrupt is already cleared. It will cause timeout unless more
> > responses coming to RIRB.
> 
> Now I noticed that the legacy driver already addressed it recently
> via
> commit 6d011d5057ff
>     ALSA: hda: Clear RIRB status before reading WP
> 
> We should have checked SOF at the same time, too...

Thanks, Takashi. But the legacy driver but doesnt remove the loop. The
loop added in the SOF driver was based on the legacy driver and
specifically to handle missed stream interrupts. Is there any harm in
keeping the loop?

Thanks,
Ranjani

