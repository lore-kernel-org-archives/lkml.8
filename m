Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80913C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 480942076B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgFAUuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:50:16 -0400
Received: from mga02.intel.com ([134.134.136.20]:50292 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727875AbgFAUuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:50:16 -0400
IronPort-SDR: Y1BfYK2eGHKEuwF9EWLh1bxyveMaa7LG1tXn84uESszps7e23NsnnZCa46FDQonlOCtSah6oat
 BBV7zcum+joA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 13:50:15 -0700
IronPort-SDR: bTUm3amk7QMCFwB2VTG76Lhz3xQiMTgOilKl0Norwi6VrvskLOxHpyrYURhD4p2u+PkUzLd+uh
 I0r78hlFKpHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="257376265"
Received: from fwong2-mobl.amr.corp.intel.com (HELO [10.251.12.107]) ([10.251.12.107])
  by orsmga007.jf.intel.com with ESMTP; 01 Jun 2020 13:50:14 -0700
Subject: Re: [PATCH] soundwire: clarify SPDX use of GPL-2.0
To:     Greg KH <gregkh@linuxfoundation.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vinod.koul@linaro.org, tiwai@suse.de,
        mengdong.lin@intel.com, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200531172807.27042-1-yung-chuan.liao@linux.intel.com>
 <20200601053809.GA1420218@kroah.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <686345af-4fda-4bc1-c3bf-da31406e806b@linux.intel.com>
Date:   Mon, 1 Jun 2020 15:50:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200601053809.GA1420218@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/1/20 12:38 AM, Greg KH wrote:
> On Mon, Jun 01, 2020 at 01:28:07AM +0800, Bard Liao wrote:
>> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>>
>> Change SPDX from GPL-2.0 to GPL-2.0-only for Intel-contributed
>> code. This was explicit before the transition to SPDX and lost in
>> translation.
> 
> It is also explicit in the "GPL-2.0" lines as well, did you read the
> LICENSES/preferred/GPL-2.0 file for the allowed tags to be used for this
> license?
> 
> So this doesn't change anything, and we are trying to cut down on this
> type of churn until, maybe, after the whole kernel has proper SPDX
> lines.

My commit message was misleading, sorry. For SoundWire, we recently 
added new files with GPL-2.0-only (master + sysfs), as recommended since 
the short GPL-2.0 identifier is deprecated 
(https://spdx.org/licenses/GPL-2.0.html https://spdx.org/licenses/).

Intel does not mind if we delay this change, you are right that this 
doesn't change anything license-wise. I just felt it was a good time to 
align old and new contributions to avoid having half of the files with 
GPL-2.0 and half with GPL-2.0-only.

We still have quite a few patches for SoundWire (~80 coming w/ 7k lines 
changed), so those changes are really minimal in comparison with the 
actual 'churn' to fix programming sequences, power management, 
multi-link management and bit allocation.

Oh and this was not intended to be added to 5.8 btw or pulled as a fix, 
really nothing to do with the merge window.

If you prefer us to keep this change on the back burner, that's fine, 
the only intent was to keep all SoundWire-related files consistent.


