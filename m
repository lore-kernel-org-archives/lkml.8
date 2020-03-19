Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F5FC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CB122070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgCST3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:29:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:4273 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbgCST3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:29:18 -0400
IronPort-SDR: bVWigo4Fv7jMZyA8pdsTJL894LCyvB4w8iMEtmVuDfE3IjJ2NMT/eGARjscM85dFS/oo7XS7PB
 p0fkxyguuBXA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2020 12:29:18 -0700
IronPort-SDR: MQXloGgtmfQmn2lTbl+0WLbHTx9QpCVk0qFlUxv6GOqn/OpUgA3EDvcUSRLeEL1HnuDHbQR4cA
 TjDyvYis4T+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,572,1574150400"; 
   d="scan'208";a="391905475"
Received: from mallani-mobl.amr.corp.intel.com (HELO [10.255.35.49]) ([10.255.35.49])
  by orsmga004.jf.intel.com with ESMTP; 19 Mar 2020 12:29:16 -0700
Subject: Re: snd_hda_intel/sst-acpi sound breakage on suspend/resume since
 5.6-rc1
To:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     alsa-devel@alsa-project.org, kuninori.morimoto.gx@renesas.com,
        curtis@malainey.com, tiwai@suse.com,
        Keyon Jie <yang.jie@linux.intel.com>,
        linux-kernel@vger.kernel.org, liam.r.girdwood@linux.intel.com,
        Mark Brown <broonie@kernel.org>
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
 <750f7841-0b95-9fa8-d858-e0bff4d834d5@intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f6b7c60a-d99e-c140-31d0-0b56960c3ec9@linux.intel.com>
Date:   Thu, 19 Mar 2020 14:05:56 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <750f7841-0b95-9fa8-d858-e0bff4d834d5@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/20 1:35 PM, Cezary Rojewski wrote:
> On 2020-03-19 19:24, Dominik Brodowski wrote:
>> On Thu, Mar 19, 2020 at 06:33:50PM +0100, Cezary Rojewski wrote:
>>>
>>> Could you confirm the same happens on your machine when revert of 
>>> mentioned
>>> patch is not applied ("stream is NULL" messages occur)? Issue may be
>>> harmless but explained sequence does not look right.
>>
>> Indeed, I still see
>>
>> haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no 
>> stream to reset, ignore it.
>> haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no 
>> stream to free, ignore it.
>> haswell-pcm-audio haswell-pcm-audio: FW loaded, mailbox readback FW 
>> info: type 01, - version: 00.00, build 77, source commit id: 
>> 876ac6906f31a43b6772b23c7c983ce9dcb18a19
>> haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no 
>> stream to reset, ignore it.
>> haswell-pcm-audio haswell-pcm-audio: warning: stream is NULL, no 
>> stream to free, ignore it.
>>
>> though sounds continues to work.
>>
> 
> Thanks once again for your input and time!
> 
> I'll prepare patches for both issues. My guess is haswell-pcm could be 
> updated to handle 'platform' component param just fine, but it is 
> probably a change of more than few lines. I'd rather revert non-SOF 
> broadwell to its previous behavior and start a separate task from there.

It'd be good to know why a dummy platform component is required though.
