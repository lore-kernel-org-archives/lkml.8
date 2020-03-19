Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8263BC4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5798520724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 15:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgCSPsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 11:48:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:31964 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726912AbgCSPsI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 11:48:08 -0400
IronPort-SDR: 9gdBxmL9hnnQaMcQAJLjxnEhTQjbCA/dfCnqYRqXjgIAfQ5Muud0MD6wnxkWtXR8BsqX5DbR/7
 Jjk79lqYzyMw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 08:48:07 -0700
IronPort-SDR: CGTdcGF3z7TQ09hhIoa4PjIUsXi6Tbq+unUG7nuDe2of5JawDCFCSTssDwLvkPSjQcKLQgravP
 imxwFtrF77Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="245198430"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.128.140]) ([10.249.128.140])
  by orsmga003.jf.intel.com with ESMTP; 19 Mar 2020 08:48:04 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Mark Brown <broonie@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     kuninori.morimoto.gx@renesas.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com
References: <41d0b2b5-6014-6fab-b6a2-7a7dbc4fe020@linux.intel.com>
 <20200318123930.GA2433@light.dominikbrodowski.net>
 <d7a357c5-54af-3e69-771c-d7ea83c6fbb7@linux.intel.com>
 <20200318162029.GA3999@light.dominikbrodowski.net>
 <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
Date:   Thu, 19 Mar 2020 16:48:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319134139.GB3983@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-19 14:41, Mark Brown wrote:
> On Thu, Mar 19, 2020 at 02:00:49PM +0100, Dominik Brodowski wrote:
> 
>> Have some good news now, namely that a bisect is complete: That pointed to
>> 1272063a7ee4 ("ASoC: soc-core: care .ignore_suspend for Component suspend");
>> therefore I've added Kuninori Morimoto to this e-mail thread.
> 
> If that's an issue it feels more like a driver bug in that if the driver
> asked for ignore_suspend then it should expect not to have the suspend
> callback called.
> 

Requested for tests with following diff applied:

diff --git a/sound/soc/intel/boards/broadwell.c 
b/sound/soc/intel/boards/broadwell.c
index db7e1e87156d..6ed4c1b0a515 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -212,7 +212,6 @@ static struct snd_soc_dai_link 
broadwell_rt286_dais[] = {
                 .init = broadwell_rt286_codec_init,
                 .dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
                         SND_SOC_DAIFMT_CBS_CFS,
-               .ignore_suspend = 1,
                 .ignore_pmdown_time = 1,
                 .be_hw_params_fixup = broadwell_ssp0_fixup,
                 .ops = &broadwell_rt286_ops,
