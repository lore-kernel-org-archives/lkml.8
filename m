Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28994C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F1E20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 08:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgDWIdx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 04:33:53 -0400
Received: from mga06.intel.com ([134.134.136.31]:50877 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgDWIdw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 04:33:52 -0400
IronPort-SDR: RKBtUuLJY3IPZ8f65OvgbdVhjwjq6CRdQWSqk8BNwRjXPudyY7C1Z6oG8r0pmQS/wqyaaGwR5y
 DO+/pCX1lpPw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 01:33:51 -0700
IronPort-SDR: zdcdmdOKM+bcv8IcTgKstEsaeuv0+W26sT3uurrkTZ9SvF7wRhKHQh4oRLRJh/1aURwuhBusW5
 nqhE2HO5EJRQ==
X-IronPort-AV: E=Sophos;i="5.73,306,1583222400"; 
   d="scan'208";a="402848601"
Received: from aslawinx-mobl1.ger.corp.intel.com (HELO [10.249.145.81]) ([10.249.145.81])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2020 01:33:48 -0700
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
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
Message-ID: <5e84c48c-a5d1-b2ff-c197-5efa478c5916@linux.intel.com>
Date:   Thu, 23 Apr 2020 10:33:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BN6PR1101MB21328C54E66082227B9F497A97D50@BN6PR1101MB2132.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/2020 6:16 PM, Lu, Brent wrote:
>>
>> Regs width difference between BDW and BYT comes from specification. BDW
>> has IPC registers which are 32 wide. This fact ain't exactly the reason to modify
>> sst_shim32_read64.
>>
>> I'm sharing Amadeo's point of view. Your change should slow down execution a
>> bit - but that might be just what handlers needed to make everything work again.
>> Debug prints also slow down the execution what could have prevented you from
>> spotting the real problem.
>> Let's ignore the memcpy stuff for a moment - could you focus on elaborating
>> the scenario where such issue occurs? Your initial commit message also skips
>> important bits such as platform used when reproducing and so on, please add
>> them.
>>
>> Thanks,
>> Czarek
> 
> This issue is reported to happen on BYT Chrome book (rambi) on Chrome-v4.4
> branch after changing toolchain from clang10 to clang11.
> 
> The reproduce step is simple. Just run arecord multiple times (<10) then you will
> see error message for hw_params ioctl failure.
> 
> $ arecord -D hw:1,0 -f S16_LE -c 2 /dev/null
> $ ctrl+c
> 
> The error message suggests the stream commit (IPC_IA_ALLOC_STREAM, 0x20) IPC
> command failed due to timeout but the msg id field of ipcd read after the timeout is
> also 0x20. It seems to me that the command is success but the host driver does not
> know it for some reason.
> 
> 2020-03-15T23:02:06.614151+00:00 ERR kernel: [  852.023766] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeout-- ipcx 0x2220 isr 0xf0020 ipcd 0x2220 imrx 0x0
> 2020-03-15T23:02:06.614209+00:00 ERR kernel: [  852.023796] baytrail-pcm-audio baytrail-pcm-audio: ipc: error stream commit failed
> 2020-03-15T23:02:06.614218+00:00 ERR kernel: [  852.023813]  Baytrail Audio: PCM: failed stream commit -110
> 2020-03-15T23:02:06.614225+00:00 ERR kernel: [  852.023832] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-audio hw params failed: -110
> 
> I add some messages to make the log easier to read. You can check the gerrit link if you
> are interested:
> https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/2131507
> 
> In the test patch I read the SST_IPCD register in sst_byt_irq_thread() twice and found
> the value could be different. The IPC_IA_FREE_STREAM(0x21) seems to be the last IPC
> command sent in the pcm_release of previous arecord command.
> 
> [  125.009724] sound pcmC1D0c: snd_pcm_release:
> [  125.009732] baytrail-pcm-audio baytrail-pcm-audio: ipc_tx_message: header 0x8000000000000221 wait 1
> [  125.009760] baytrail-pcm-audio baytrail-pcm-audio: byt_tx_msg: header 0x8000000000000226
> [  125.009803] baytrail-pcm-audio baytrail-pcm-audio: sst_byt_irq_thread: header 0x297
> [  125.009823] baytrail-pcm-audio baytrail-pcm-audio: byt_tx_msg: header 0x8000000000000221
> [  125.009872] baytrail-pcm-audio baytrail-pcm-audio: sst_byt_irq_thread: header 0x297
> [  125.010442] baytrail-pcm-audio baytrail-pcm-audio: sst_byt_irq_thread: header 0x80000000000c2226
> [  125.010456] baytrail-pcm-audio baytrail-pcm-audio: sst_ipc_reply_find_msg: not match, msg header 0x8000000000000221
> [  125.010511] baytrail-pcm-audio baytrail-pcm-audio: sst_byt_irq_thread: header 0x8000000000000221
> [  125.011355] baytrail-pcm-audio baytrail-pcm-audio: tx_wait_done: ipc success, header 0x8000000000000221
> [  125.380506] sound pcmC1D0c: snd_pcm_capture_open:
> [  125.380544] sound pcmC1D0c: snd_pcm_capture_ioctl1: INFO
> [  125.380554] sound pcmC1D0c: snd_pcm_capture_ioctl1: PVERSION
> [  125.380561] sound pcmC1D0c: snd_pcm_capture_ioctl1: TTSTAMP
> [  125.380581] sound pcmC1D0c: snd_pcm_mmap:
> [  125.380622] sound pcmC1D0c: snd_pcm_mmap:
> [  125.380648] sound pcmC1D0c: snd_pcm_capture_ioctl1: INFO
> [  125.380717] sound pcmC1D0c: snd_pcm_capture_ioctl1: HW_REFINE
> [  125.380737] sound pcmC1D0c: snd_pcm_capture_ioctl1: HW_REFINE
> [  125.380766] sound pcmC1D0c: snd_pcm_capture_ioctl1: HW_REFINE
> [  125.380779] sound pcmC1D0c: snd_pcm_capture_ioctl1: HW_REFINE
> [  125.380789] sound pcmC1D0c: snd_pcm_capture_ioctl1: HW_REFINE
> [  125.380799] sound pcmC1D0c: snd_pcm_capture_ioctl1: HW_REFINE
> [  125.380808] sound pcmC1D0c: snd_pcm_capture_ioctl1: HW_REFINE
> [  125.380815] sound pcmC1D0c: snd_pcm_capture_ioctl1: HW_PARAMS
> [  125.380839] baytrail-pcm-audio baytrail-pcm-audio: ipc_tx_message: header 0x8000000000642220 wait 1
> [  125.380854] baytrail-pcm-audio baytrail-pcm-audio: byt_tx_msg: header 0x8000000000642220
> => write IPC_IA_ALLOC_STREAM message (0x20) to SST_IPCX
> [  125.380931] baytrail-pcm-audio baytrail-pcm-audio: sst_byt_irq_thread: header 0x8000000000000221
> => read message reply from SST_IPCD and an IPC_IA_FREE_STREAM(0x21) is returned
> [  125.380942] baytrail-pcm-audio baytrail-pcm-audio: sst_byt_irq_thread: ipcd 0x8000000000602220
> => read SST_IPCD again, this time the message id is what we are expected (0x20)
> [  125.380948] baytrail-pcm-audio baytrail-pcm-audio: sst_ipc_reply_find_msg: not match, msg header 0x8000000000642220
> [  125.681171] baytrail-pcm-audio baytrail-pcm-audio: tx_wait_done: ipc timeout, header 0x8000000000642220
> [  125.681204] baytrail-pcm-audio baytrail-pcm-audio: ipc: --message timeout-- ipcx 0x2220 isr 0x50020 ipcd 0x2220 imrx 0x0
> [  125.681212] baytrail-pcm-audio baytrail-pcm-audio: ipc: error stream commit failed
> [  125.681217]  Baytrail Audio: PCM: failed stream commit -110
> [  125.681223] baytrail-pcm-audio baytrail-pcm-audio: ASoC: baytrail-pcm-audio hw params failed: -110
> 
> Regards,
> Brent
> 

I've looked at the code and byt_is_dsp_busy seems suspicious to me.
Can you check if following change fixes problem for you:

diff --git a/sound/soc/intel/baytrail/sst-baytrail-ipc.c 
b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
index 74274bd38f7a..34746fd871b0 100644
--- a/sound/soc/intel/baytrail/sst-baytrail-ipc.c
+++ b/sound/soc/intel/baytrail/sst-baytrail-ipc.c
@@ -666,8 +666,8 @@ static bool byt_is_dsp_busy(struct sst_dsp *dsp)
  {
         u64 ipcx;

-       ipcx = sst_dsp_shim_read_unlocked(dsp, SST_IPCX);
-       return (ipcx & (SST_IPCX_BUSY | SST_IPCX_DONE));
+       ipcx = sst_dsp_shim_read64_unlocked(dsp, SST_IPCX);
+       return (ipcx & (SST_BYT_IPCX_BUSY | SST_BYT_IPCX_DONE));
  }

  int sst_byt_dsp_init(struct device *dev, struct sst_pdata *pdata)

We seem to treat SST_IPCX as 32 bit register instead of 64 one, which 
may explain wrong behaviour. (Specification says it is 64 bit register).

Thanks,
Amadeusz
