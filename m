Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454A9C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235A920838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:55:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgBFQzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:55:48 -0500
Received: from mga17.intel.com ([192.55.52.151]:26562 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727390AbgBFQzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:55:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 08:55:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="432278241"
Received: from rrmuthya-mobl1.amr.corp.intel.com (HELO [10.251.129.34]) ([10.251.129.34])
  by fmsmga006.fm.intel.com with ESMTP; 06 Feb 2020 08:55:46 -0800
Subject: Re: sound/soc/intel/boards/hda_dsp_common.c:76: undefined reference
 to `snd_hda_codec_build_controls'
To:     Takashi Iwai <tiwai@suse.de>, kbuild test robot <lkp@intel.com>
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <202002061349.zDVX3Qdu%lkp@intel.com>
 <s5hwo909mm9.wl-tiwai@suse.de>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e82ceb12-2d0e-ccec-8d8d-eef556918c53@linux.intel.com>
Date:   Thu, 6 Feb 2020 10:55:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <s5hwo909mm9.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/6/20 1:54 AM, Takashi Iwai wrote:
> On Thu, 06 Feb 2020 06:29:52 +0100,
> kbuild test robot wrote:
>>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   4c7d00ccf40db99bfb7bd1857bcbf007275704d8
>> commit: 7de9a47c8971bdec07cc9a62e948382003c5908f ASoC: Intel: skl-hda-dsp-generic: use snd-hda-codec-hdmi
>> date:   3 months ago
>> config: i386-randconfig-e003-20200206 (attached as .config)
>> compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
>> reproduce:
>>          git checkout 7de9a47c8971bdec07cc9a62e948382003c5908f
>>          # save the attached .config to linux build tree
>>          make ARCH=i386
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     ld: sound/soc/intel/boards/hda_dsp_common.o: in function `hda_dsp_hdmi_build_controls':
>>>> sound/soc/intel/boards/hda_dsp_common.c:76: undefined reference to `snd_hda_codec_build_controls'
> 
> Looks like the revert select enforcing the built-in of SOF while the
> legacy HDA is a module.  It doesn't look so trivial to fix...

SOF in this case is build as a module, but the machine driver isn't.

It seems like the SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH option is 
different from others machine drivers. All others can only be either M 
or not selected, but here we have a case where the selection can be M or y.

The following diff seems to make the problem go away by preventing this 
case, it seems we didn't propagate the constraints from the higher level.

More testing needed, this is just a first result.

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 9ca2567d0059..db08b3af07c2 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -426,6 +426,7 @@ config SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH

  endif ## SND_SOC_SOF_GEMINILAKE  && SND_SOC_SOF_HDA_LINK

+if SND_SOC_SOF_HDA
  if SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC || SND_SOC_SOF_HDA_AUDIO_CODEC

  config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
@@ -441,6 +442,7 @@ config SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH
           If unsure select "N".

  endif ## SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC || 
SND_SOC_SOF_HDA_AUDIO_CODEC
+endif

  if SND_SOC_SOF_HDA_LINK || SND_SOC_SOF_BAYTRAIL
  config SND_SOC_INTEL_SOF_RT5682_MACH
