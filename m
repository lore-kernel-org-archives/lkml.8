Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE0CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5FD3206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505260AbgDNTx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:53:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:46409 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505250AbgDNTxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:53:38 -0400
IronPort-SDR: rYE20Kx336l/e+i8TOVnQQ5/qI6DNckykS750Moj2LriV6mhwyWRysH4HzfegcfdRtOq1oLuH8
 cKQY4srsvBcA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 12:53:37 -0700
IronPort-SDR: K8PzKGe3/jwdy9SXZ7JQqasIBrAoadMme1gQ19RmYmMAkShCgfhcK6r5YaWJVvvgVnvXuPicff
 XdpRA5fKzmWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,384,1580803200"; 
   d="scan'208";a="277378888"
Received: from crojewsk-mobl1.ger.corp.intel.com (HELO [10.213.0.57]) ([10.213.0.57])
  by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2020 12:53:34 -0700
Subject: Re: [PATCH] ASoC: Intel: sst: ipc command timeout
To:     "Lu, Brent" <brent.lu@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Richard Fontana <rfontana@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        "amadeuszx.slawinski@linux.intel.com" 
        <amadeuszx.slawinski@linux.intel.com>
References: <1586506705-3194-1-git-send-email-brent.lu@intel.com>
 <4f495cf1-4740-cf3b-196f-cc850c503b43@linux.intel.com>
 <BN6PR1101MB21328B6F4147640D07F9E40A97DA0@BN6PR1101MB2132.namprd11.prod.outlook.com>
From:   Cezary Rojewski <cezary.rojewski@intel.com>
Message-ID: <c8309abf-cbfb-a3db-5aa7-2e2f748a6d34@intel.com>
Date:   Tue, 14 Apr 2020 21:53:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BN6PR1101MB21328B6F4147640D07F9E40A97DA0@BN6PR1101MB2132.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-14 18:20, Lu, Brent wrote:
>>
>> I have mixed feelings about this.
>>
>> One one hand, this looks simple enough.
>>
>> But on the other hand we have other users of memcpy_fromio(), including
>> SOF drivers, so what are the odds we have the same problems in other
>> places? Wouldn't it be safer to either change this function so that it's
>> behavior is not ambiguous or compiler-dependent, or fix the compiler?
>>
> 
> Hi Pierre and Amadeusz,
> 
> I have to admit that I didn't dig into clang's __builtin_memcpy to see what's
> happening inside so I don't have direct evidence to say it's clang's problem.
> What I know is kernel built by clang10 works fine but have this issue once
> changed to clang11. At first I also suspect that it's a timing issue so I checked
> the command transaction. The transaction is simple, host writes command
> in SST_IPCX register, the DSP then writes reply in SST_IPCD register and
> trigger an interrupt. Finally the irq thread sst_byt_irq_thread() reads the
> SST_IPCD register to complete the transaction. I added some debug messages
> to see if there is something wrong in the transaction but it all looks good.
> 
> I am also confused that why this only happens to BYT but not BDW since they
> share the same register accessing code in sst-dsp.c. I checked the code and
> realized that in BDW, the irq thread (hsw_irq_thread) performs 32-bit register
> read instead of 64-bit in BYT platform. Therefore I change the code in BYT to
> use two readl() calls and found the problem is gone. My best guess is it's
> related to the implementation of __builtin_memcpy() but not sure it's the
> timing or implementing cause this problem.
> 
> 
> Regards,
> Brent
> 

Regs width difference between BDW and BYT comes from specification. BDW 
has IPC registers which are 32 wide. This fact ain't exactly the reason 
to modify sst_shim32_read64.

I'm sharing Amadeo's point of view. Your change should slow down 
execution a bit - but that might be just what handlers needed to make 
everything work again. Debug prints also slow down the execution what 
could have prevented you from spotting the real problem.
Let's ignore the memcpy stuff for a moment - could you focus on 
elaborating the scenario where such issue occurs? Your initial commit 
message also skips important bits such as platform used when reproducing 
and so on, please add them.

Thanks,
Czarek
