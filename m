Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A8E9C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 412DD2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgBJO2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:28:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:5271 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgBJO2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:28:05 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 06:28:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="226210606"
Received: from ykatsuma-mobl1.gar.corp.intel.com (HELO [10.251.140.95]) ([10.251.140.95])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2020 06:28:03 -0800
Subject: Re: [PATCH v2 0/5] soundwire: intel: add DAI callbacks
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <20200114234257.14336-1-pierre-louis.bossart@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <4554b59e-f4ec-ae4a-ef67-276964fcb14d@linux.intel.com>
Date:   Mon, 10 Feb 2020 08:28:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200114234257.14336-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/20 5:42 PM, Pierre-Louis Bossart wrote:
> The existing mainline code is missing most of the DAI callbacks needed
> for a functional implementation, and the existing ones need to be
> modified to provide the relevant information to SOF drivers.
> 
> As suggested by Vinod, these patches are shared first - with the risk
> that they are separated from the actual DAI enablement, so reviewers
> might wonder why they are needed in the first place.
> 
> For reference, the complete set of 90+ patches required for SoundWire
> on Intel platforms is available here:
> 
> https://github.com/thesofproject/linux/pull/1692

Vinod, these patches have been in the queue for quite some time, and 
v5.6-rc1 is out. Can we move on with the reviews?
Thanks!

> 
> changes since v1:
> Fix string allocation (only feedback from Vinod)
> 
> Pierre-Louis Bossart (2):
>    soundwire: intel: rename res field as link_res
>    soundwire: intel: free all resources on hw_free()
> 
> Rander Wang (3):
>    soundwire: intel: add prepare support in sdw dai driver
>    soundwire: intel: add trigger support in sdw dai driver
>    soundwire: intel: add sdw_stream_setup helper for .startup callback
> 
>   drivers/soundwire/intel.c | 197 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 177 insertions(+), 20 deletions(-)
> 
