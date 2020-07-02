Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80A8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2BB920737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730026AbgGBPC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:02:58 -0400
Received: from mga18.intel.com ([134.134.136.126]:43273 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbgGBPCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:02:55 -0400
IronPort-SDR: E0qYAWZBeA4GBazMfm3ssNwVWqF/nFr8pg/BO+SX3Aj5joSYmsl5XSlrOKFYiJ6gt0Zlx/Nst0
 eLxUOQbwGCVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134384152"
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="134384152"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 08:02:48 -0700
IronPort-SDR: 8NAIp4cDCc3muxHVReeY1Ie+1bQ3zuO3HF1mAWNYARkco+6VdXe7su/ieLRgqDvpIPQdPU9dJQ
 VFrMfrZbfvVQ==
X-IronPort-AV: E=Sophos;i="5.75,304,1589266800"; 
   d="scan'208";a="304275519"
Received: from nchava-mobl1.amr.corp.intel.com (HELO [10.252.135.144]) ([10.252.135.144])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2020 08:02:47 -0700
Subject: Re: [PATCH 7/9] soundwire: intel/cadence: merge Soundwire interrupt
 handlers/threads
To:     "Liao, Bard" <bard.liao@intel.com>, Vinod Koul <vkoul@kernel.org>
Cc:     "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ranjani.sridharan@linux.intel.com" 
        <ranjani.sridharan@linux.intel.com>,
        "hui.wang@canonical.com" <hui.wang@canonical.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "jank@cadence.com" <jank@cadence.com>,
        "Lin, Mengdong" <mengdong.lin@intel.com>,
        "Blauciak, Slawomir" <slawomir.blauciak@intel.com>,
        "Kale, Sanyog R" <sanyog.r.kale@intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        "rander.wang@linux.intel.com" <rander.wang@linux.intel.com>
References: <20200623173546.21870-1-yung-chuan.liao@linux.intel.com>
 <20200623173546.21870-8-yung-chuan.liao@linux.intel.com>
 <20200630162448.GS2599@vkoul-mobl>
 <55fbc41e-cb41-8bdf-bdbd-1d1b76938683@linux.intel.com>
 <20200701054224.GV2599@vkoul-mobl>
 <MN2PR11MB4080CF23D00A3AF817AC1E7CFF6D0@MN2PR11MB4080.namprd11.prod.outlook.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <077d4430-bb76-df2c-2c39-8077998e6fdc@linux.intel.com>
Date:   Thu, 2 Jul 2020 10:01:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <MN2PR11MB4080CF23D00A3AF817AC1E7CFF6D0@MN2PR11MB4080.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/20 2:35 AM, Liao, Bard wrote:
>> -----Original Message-----
>> From: Vinod Koul <vkoul@kernel.org>
>> Sent: Wednesday, July 1, 2020 1:42 PM
>> To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>; alsa-devel@alsa-project.org;
>> tiwai@suse.de; gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org;
>> ranjani.sridharan@linux.intel.com; hui.wang@canonical.com;
>> broonie@kernel.org; srinivas.kandagatla@linaro.org; jank@cadence.com; Lin,
>> Mengdong <mengdong.lin@intel.com>; Blauciak, Slawomir
>> <slawomir.blauciak@intel.com>; Kale, Sanyog R <sanyog.r.kale@intel.com>;
>> rander.wang@linux.intel.com; Liao, Bard <bard.liao@intel.com>
>> Subject: Re: [PATCH 7/9] soundwire: intel/cadence: merge Soundwire interrupt
>> handlers/threads
>>
>> On 30-06-20, 11:46, Pierre-Louis Bossart wrote:
>>
>>>> Is this called from irq context or irq thread or something else?
>>>
>>> from IRQ thread, hence the name, see pointers above.
>>>
>>> The key part is that we could only make the hardware work as intended by
>>> using a single thread for all interrupt sources, and that patch is just the
>>> generalization of what was implemented for HDaudio in mid-2019 after
>> months
>>> of lost interrupts and IPC errors. See below the code from
>>> sound/soc/sof/intel/hda.c for interrupt handling.
>>
>> Sounds good. Now that you are already in irq thread, does it make sense
>> to spawn a worker thread for this and handle it there? Why not do in the
>> irq thread itself. Using a thread kind of defeats the whole point behind
>> concept of irq threads
> 
> Not sure If you are talking about cdns_update_slave_status_work().
> The reason we need to spawn a worker thread in sdw_cdns_irq() is
> that we will do sdw transfer which will generate an interrupt when
> a slave interrupt is triggered. And the handler will not be invoked if the
> previous handler is not return yet.
> Please see the scenario below for better explanation.
> 1. Slave interrupt arrives
> 	2.1 Try to read Slave register and waiting for the transfer response
> 	2.2 Get the transfer response interrupt and finish the sdw transfer.
> 3. Finish the Slave interrupt handling.
> 
> Interrupts are triggered in step 1 and 2.2, but step 2.2's handler will not be
> invoked if step 1's handler is not return yet.
> What we do is to spawn a worker thread to do step 2 and return from step 1.
> So the handler can be invoked when the transfer response interrupt arrives.

To build on Bard's correct answer, the irq thread only takes care of 
'immediate' actions, such as command completion, parity or bus clash 
errors. The rest of the work can be split in
a) changes to device state, usually for attachment and enumeration. This 
is rather slow and will entail regmap syncs.
b) device interrupts - typically only for jack detection which is also 
rather slow.

Since this irq thread function is actually part of the entire HDaudio 
controller interrupt handling, we have to defer the work for cases a) 
and b) and re-enable the HDaudio interrupts at the end of the irq thread 
function - see the code I shared earlier.

In addition, both a) and b) will result  in transactions over the bus, 
which will trigger interrupts to signal the command completions. In 
other words, because of the asynchronous nature of the transactions, we 
need a two-level implementation. If you look at the previous solution it 
was the same, the commands were issued in the irq thread and the command 
completion was handled in the handler, since we had to make the handler 
minimal with a global GIE interrupt disable we kept the same hierarchy 
to deal with commands but move it up one level.

You could argue that maybe a worker thread is not optimal and could be 
replaced by something better/faster. Since the jack detection is 
typically handled with a worker thread in all ASoC codec drivers, we 
didn't feel the need to optimize further. We did not see any performance 
impact with this change.

Does this answer to your concern?




