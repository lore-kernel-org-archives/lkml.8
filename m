Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 881A9C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D95520780
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCRS2C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:28:02 -0400
Received: from mga11.intel.com ([192.55.52.93]:50342 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRS2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:28:02 -0400
IronPort-SDR: Utgh65ylLtaLIHdU6R5hwY0OaG6PvF6i7MKB2J0BksA/TF7kK5qJzknaPkT6gefy1QTTBIcWaj
 dRN5sbJobRCw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2020 11:28:01 -0700
IronPort-SDR: BMWnTxp5mP7hpDPV12jYZlOkIw0FwIKIg9ugR2uLOimWaoODTZ5nQpw0Ad0dNZVDOqeElTK3qu
 VY9pcQ9/POpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,568,1574150400"; 
   d="scan'208";a="238266266"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.155.222]) ([10.249.155.222])
  by fmsmga008.fm.intel.com with ESMTP; 18 Mar 2020 11:27:59 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Dominik Brodowski <linux@dominikbrodowski.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Keyon Jie <yang.jie@linux.intel.com>, alsa-devel@alsa-project.org,
        curtis@malainey.com, linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com, broonie@kernel.org
References: <20200318063022.GA116342@light.dominikbrodowski.net>
 <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
Date:   Wed, 18 Mar 2020 19:27:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200318162029.GA3999@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-18 17:20, Dominik Brodowski wrote:
> On Wed, Mar 18, 2020 at 10:13:54AM -0500, Pierre-Louis Bossart wrote:
>>>>> While 5.5.x works fine, mainline as of ac309e7744be (v5.6-rc6+) causes me
>>>>> some sound-related trouble: after boot, the sound works fine -- but once I
>>>>> suspend and resume my broadwell-based XPS13, I need to switch to headphone
>>>>> and back to speaker to hear something. But what I hear isn't music but
>>>>> garbled output.

> 
> I had (see 18d78b64fddc), but not any more in years (and I'd like to keep
> using I2S, which has worked flawlessly in these years).
> 

Due to pandemic I'm working remotely and right now won't be able to test 
audio quality so focusing on the stream==NULL issue. And thus we got to 
help each other out : )

Could you verify issue reproduces on 5.6.0-rc1 on your machine? On my 
RVPs looks like it does. There is one more thing that worries me. After 
enabling dbg logs I see some IPCs queried but not delivered (dsp busy):

[  170.330009] snd_soc_core:dpcm_fe_dai_prepare:  System PCM: ASoC: 
prepare FE System PCM
[  170.330019] snd_soc_core:dpcm_be_dai_prepare:  Codec: ASoC: prepare 
BE Codec
[  170.347068] snd_soc_core:dpcm_dapm_stream_event:  Codec: ASoC: BE 
Codec event 1 dir 0
[  170.348814] snd_soc_core:dpcm_do_trigger:  Codec: ASoC: trigger BE 
Codec cmd 1
[  170.348826] snd_soc_core:dpcm_dai_trigger_fe_be:  System PCM: ASoC: 
post trigger FE System PCM cmd 1
[  170.348839] snd_soc_sst_ipc:ipc_tx_msgs: haswell-pcm-audio 
haswell-pcm-audio: ipc_tx_msgs dsp busy
[  182.583710]  System PCM: ASoC: trigger FE cmd: 7 failed: -22
[  182.583811] snd_soc_core:dpcm_dai_trigger_fe_be:  System PCM: ASoC: 
pre trigger FE System PCM cmd 0
[  182.583839] snd_soc_core:dpcm_do_trigger:  Codec: ASoC: trigger BE 
Codec cmd 0
[  182.583862] snd_soc_core:dpcm_fe_dai_hw_free:  System PCM: ASoC: 
hw_free FE System PCM
[  182.583872] snd_soc_core:dpcm_be_dai_hw_free:  Codec: ASoC: hw_free 
BE Codec
[  182.584127] snd_soc_core:dpcm_fe_dai_hw_free:  System PCM: ASoC: 
hw_free FE System PCM
[  182.584144] snd_soc_core:dpcm_be_dai_hw_free:  Codec: ASoC: hw_free 
BE Codec
[  182.584161] snd_soc_core:dpcm_be_dai_shutdown:  Codec: ASoC: close BE 
Codec
[  182.584211] snd_soc_sst_ipc:ipc_tx_msgs: haswell-pcm-audio 
haswell-pcm-audio: ipc_tx_msgs dsp busy
[  182.587411] snd_soc_core:dpcm_fe_dai_shutdown:  System PCM: ASoC: 
close FE System PCM
[  182.587427] haswell-pcm-audio haswell-pcm-audio: warning: stream is 
NULL, no stream to reset, ignore it.
[  182.587435] haswell-pcm-audio haswell-pcm-audio: warning: stream is 
NULL, no stream to free, ignore it.
[  182.587451] snd_soc_core:dpcm_be_disconnect:  System PCM: ASoC: BE 
playback disconnect check for Codec
[  182.587460] snd_soc_core:dpcm_be_disconnect:  System PCM: freed DSP 
playback path System PCM -> Codec
[  187.626116] snd_soc_core:snd_soc_close_delayed_work:  System PCM: 
ASoC: pop wq checking: Playback status: inactive waiting: yes

Will be scanning IPCs now. Seems like regression has been introduced 
immediately in 5.6.0-rc1 as linux-stable 5.5.7 works just fine for me.

Regards,
Czarek
