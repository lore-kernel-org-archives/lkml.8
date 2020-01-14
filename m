Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB836C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93D3B24676
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgANRs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:48:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:37596 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgANRsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:48:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 09:48:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; 
   d="scan'208";a="225285564"
Received: from snathamg-mobl.amr.corp.intel.com (HELO [10.252.136.159]) ([10.252.136.159])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2020 09:48:22 -0800
Subject: Re: [alsa-devel] [PATCH] soundwire: intel: report slave_ids for each
 link to SOF driver
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200110220016.30887-1-pierre-louis.bossart@linux.intel.com>
 <a70c54c0-c691-d8eb-4f99-da1bb9306c2f@linux.intel.com>
 <20200114062605.GD2818@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7a2e514c-edd1-fbeb-3ebb-df289c7436e2@linux.intel.com>
Date:   Tue, 14 Jan 2020 10:05:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114062605.GD2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/20 12:26 AM, Vinod Koul wrote:
> On 10-01-20, 16:31, Pierre-Louis Bossart wrote:
>>
>>
>> On 1/10/20 4:00 PM, Pierre-Louis Bossart wrote:
>>> From: Bard Liao <yung-chuan.liao@linux.intel.com>
>>>
>>> The existing link_mask flag is no longer sufficient to detect the
>>> hardware and identify which topology file and a machine driver to load.
>>>
>>> By reporting the slave_ids exposed in ACPI tables, the parent SOF
>>> driver will be able to compare against a set of static configurations.
>>>
>>> This patch only adds the interface change, the functionality is added
>>> in future patches.
>>
>> Vinod, this patch would need to be shared as an immutable tag for Mark, once
>> this is done I can share the SOF parts that make use of the information (cf.
>> https://github.com/thesofproject/linux/pull/1692 for reference)
>>
>> Sorry we missed this in the earlier interface changes, we didn't think we
>> would have so many hardware variations so quickly.
> 
> do you want the tag now..? I can provide... We are already in -rc6
> and i will send PR to greg later this week...

yes please, I'd like to send the SOF patches this week as well.
