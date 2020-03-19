Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33841C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C92F20787
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCSSfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:35:05 -0400
Received: from mga06.intel.com ([134.134.136.31]:62956 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbgCSSfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:35:05 -0400
IronPort-SDR: aGi4gm73iQn5HhSs+wQX+zY6b0Ee7GPbNotxzldgHMaY2NAF/2qv98TBVlccbvZWB1Chx3fyZF
 OZvVMTqteIOA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 11:35:04 -0700
IronPort-SDR: 8PJ20HU+/1aAUtKkXBhL4ENr19sfOFgV1IzgPk5go10JOk0SJ1/gsJeVsaEb18kxxu80xGUxGu
 /TeOiOTXzOxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="356117527"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.249.128.140]) ([10.249.128.140])
  by fmsmga001.fm.intel.com with ESMTP; 19 Mar 2020 11:35:02 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Mark Brown <broonie@kernel.org>, kuninori.morimoto.gx@renesas.com,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        alsa-devel@alsa-project.org, curtis@malainey.com,
        linux-kernel@vger.kernel.org, tiwai@suse.com,
        liam.r.girdwood@linux.intel.com
References: <e49eec28-2037-f5db-e75b-9eadf6180d81@intel.com>
 <20200318192213.GA2987@light.dominikbrodowski.net>
 <b352a46b-8a66-8235-3622-23e561d3728c@intel.com>
 <20200318215218.GA2439@light.dominikbrodowski.net>
 <e7f4f38d-b53e-8c69-8b23-454718cf92af@intel.com>
 <20200319130049.GA2244@light.dominikbrodowski.net>
 <20200319134139.GB3983@sirena.org.uk>
 <a01359dc-479e-b3e3-37a6-4a9c421d18da@intel.com>
 <20200319165157.GA2254@light.dominikbrodowski.net>
 <a7bf2aee-78e7-f905-bcc3-cd21bf16a976@intel.com>
 <20200319182413.GA3968@light.dominikbrodowski.net>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <750f7841-0b95-9fa8-d858-e0bff4d834d5@intel.com>
Date:   Thu, 19 Mar 2020 19:35:00 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200319182413.GA3968@light.dominikbrodowski.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-19 19:24, Dominik Brodowski wrote:
> On Thu, Mar 19, 2020 at 06:33:50PM +0100, Cezary Rojewski wrote:
>>
>> Could you confirm the same happens on your machine when revert of mentioned
>> patch is not applied ("stream is NULL" messages occur)? Issue may be
>> harmless but explained sequence does not look right.
> 
> Indeed, I still see
> 
> haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no stream to reset, ignore it.
> haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no stream to free, ignore it.
> haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox readback FW info: type 01, - version: 00.00, build 77, source commit id: 876ac6906f31a43b6772b23c7c983ce9dcb18a19
> haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no stream to reset, ignore it.
> haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no stream to free, ignore it.
> 
> though sounds continues to work.
> 

Thanks once again for your input and time!

I'll prepare patches for both issues. My guess is haswell-pcm could be 
updated to handle 'platform' component param just fine, but it is 
probably a change of more than few lines. I'd rather revert non-SOF 
broadwell to its previous behavior and start a separate task from there.

Regards,
Czarek
