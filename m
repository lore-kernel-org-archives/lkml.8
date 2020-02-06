Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED799C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A0821741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgBFSB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:01:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:44547 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgBFSBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:01:25 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2020 10:01:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,410,1574150400"; 
   d="scan'208";a="311764928"
Received: from skilgo1x-mobl.amr.corp.intel.com (HELO [10.254.103.251]) ([10.254.103.251])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2020 10:01:24 -0800
Subject: Re: sound/soc/intel/boards/hda_dsp_common.c:76: undefined reference
 to `snd_hda_codec_build_controls'
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>, kbuild test robot <lkp@intel.com>
Cc:     Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <202002061349.zDVX3Qdu%lkp@intel.com>
 <s5hwo909mm9.wl-tiwai@suse.de>
 <e82ceb12-2d0e-ccec-8d8d-eef556918c53@linux.intel.com>
Message-ID: <9d8d130f-47d5-03a5-484e-b0865c6de6f8@linux.intel.com>
Date:   Thu, 6 Feb 2020 12:01:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <e82ceb12-2d0e-ccec-8d8d-eef556918c53@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>     ld: sound/soc/intel/boards/hda_dsp_common.o: in function 
>>> `hda_dsp_hdmi_build_controls':
>>>>> sound/soc/intel/boards/hda_dsp_common.c:76: undefined reference to 
>>>>> `snd_hda_codec_build_controls'
>>
>> Looks like the revert select enforcing the built-in of SOF while the
>> legacy HDA is a module.  It doesn't look so trivial to fix...
> 
> SOF in this case is build as a module, but the machine driver isn't.
> 
> It seems like the SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH option is 
> different from others machine drivers. All others can only be either M 
> or not selected, but here we have a case where the selection can be M or y.

Suggested fix is here, running it through our CI tests for now:

https://github.com/thesofproject/linux/pull/1768

This should be caught by kbuild tests as well.
