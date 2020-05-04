Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AE7C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C780206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEDJXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:23:51 -0400
Received: from mga04.intel.com ([192.55.52.120]:18923 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgEDJXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:23:50 -0400
IronPort-SDR: grOczGrqUgd5IdhP8BC+M4sqU7GcnQe4PkoL0SMhSCiFazDQgu97cYu+XTDhEmFVnAG1yHxcZ3
 hYFlxxGtD70w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 02:23:49 -0700
IronPort-SDR: J1Cu5dy96mFd8lt0e95yC5aH2xOFfUGHqnzHJD6rhtCYkV88/ylCCYoTfZ9K3hG60rnEgIxdrj
 BMqyUlnNnE8g==
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="434044101"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.151.177]) ([10.249.151.177])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 02:23:45 -0700
Subject: Re: [PATCH] ASoC: Intel: sst: ipc command timeout
To:     "Lu, Brent" <brent.lu@intel.com>,
        "Rojewski, Cezary" <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jie Yang <yang.jie@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Mark Brown <broonie@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>
References: <1586506705-3194-1-git-send-email-brent.lu@intel.com>
 <4f495cf1-4740-cf3b-196f-cc850c503b43@linux.intel.com>
 <BN6PR1101MB21328B6F4147640D07F9E40A97DA0@BN6PR1101MB2132.namprd11.prod.outlook.com>
 <c8309abf-cbfb-a3db-5aa7-2e2f748a6d34@intel.com>
 <BN6PR1101MB21328C54E66082227B9F497A97D50@BN6PR1101MB2132.namprd11.prod.outlook.com>
 <5e84c48c-a5d1-b2ff-c197-5efa478c5916@linux.intel.com>
 <BN6PR1101MB2132D23B042284DDA667642A97AC0@BN6PR1101MB2132.namprd11.prod.outlook.com>
 <9d003948-a651-9920-86b6-307e912dd8ed@linux.intel.com>
 <BN6PR1101MB21325FA4FB1446DC2CAF6C6797AA0@BN6PR1101MB2132.namprd11.prod.outlook.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
Message-ID: <a0648aff-1c85-cc76-650c-1880381c026f@linux.intel.com>
Date:   Mon, 4 May 2020 11:23:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BN6PR1101MB21325FA4FB1446DC2CAF6C6797AA0@BN6PR1101MB2132.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/2020 5:38 PM, Lu, Brent wrote:
>>
>> Hi,
>> yes that seems bit weird. It is bit better as it does not modify common code,
>> but still... Maybe going back to your original idea of replacing memcpy, try
>> replacing it with readq? It should generate one instruction read (although it is
>> only for x64_64, for 32 bit kernel we would still need to do something else).
>>
>> Thanks,
>> Amadeusz
> 
> Hi,
> 
> I've compared the assembly to see if there is clue. Both kernels are using 64-bit
> mov to read register and the only difference is optimized or not. Both
> implementations are looking good to me. Currently I don't have answer why
> slower kernel hits the problem while optimized one survived.
> 
> 1. Old kernel. Code is optimized and not able to reproduce the issue on this kernel.
> 
> (gdb) disas sst_shim32_read64
> Dump of assembler code for function sst_shim32_read64:
>     0x000000000000096c <+0>:     call   0x971 <sst_shim32_read64+5>
> => call __fentry__
>     0x0000000000000971 <+5>:     push   rbp
>     0x0000000000000972 <+6>:     mov    rbp,rsp
>     0x0000000000000975 <+9>:     mov    eax,esi
>     0x0000000000000977 <+11>:    mov    rax,QWORD PTR [rdi+rax*1]
> => perform 64-bit mov
>     0x000000000000097b <+15>:    pop    rbp
>     0x000000000000097c <+16>:    ret
> End of assembler dump.
> 

Hi,

That's why I would suggest trying with readq, it should also generate 
one instruction read x86_64 platforms, I looked a bit more and there is 
fallback to generate two 32 bit reads on 32bit platforms, so my previous 
concern about having to write separate handling for those platforms was 
unneeded. So I would recommend checking using it.

diff --git a/sound/soc/intel/common/sst-dsp.c 
b/sound/soc/intel/common/sst-dsp.c
index ec66be269b69..e96f636387d9 100644
--- a/sound/soc/intel/common/sst-dsp.c
+++ b/sound/soc/intel/common/sst-dsp.c
@@ -34,16 +34,13 @@ EXPORT_SYMBOL_GPL(sst_shim32_read);

  void sst_shim32_write64(void __iomem *addr, u32 offset, u64 value)
  {
-       memcpy_toio(addr + offset, &value, sizeof(value));
+       writeq(value, addr + offset);
  }
  EXPORT_SYMBOL_GPL(sst_shim32_write64);

  u64 sst_shim32_read64(void __iomem *addr, u32 offset)
  {
-       u64 val;
-
-       memcpy_fromio(&val, addr + offset, sizeof(val));
-       return val;
+       return readq(addr + offset);
  }
  EXPORT_SYMBOL_GPL(sst_shim32_read64);


Thanks,
Amadeusz
