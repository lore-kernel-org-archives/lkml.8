Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0FC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96202070A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgBJO1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:27:30 -0500
Received: from mga12.intel.com ([192.55.52.136]:4636 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728273AbgBJO1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:27:30 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 06:27:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="226210474"
Received: from ykatsuma-mobl1.gar.corp.intel.com (HELO [10.251.140.95]) ([10.251.140.95])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2020 06:27:29 -0800
Subject: Re: [PATCH v2 0/5] soundwire: stream: fix state machines and
 transitions
To:     alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
References: <20200114235227.14502-1-pierre-louis.bossart@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5f6af1da-ee9e-dcf8-0353-8f9eb4a39d21@linux.intel.com>
Date:   Mon, 10 Feb 2020 08:27:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200114235227.14502-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/20 5:52 PM, Pierre-Louis Bossart wrote:
> The existing stream support works fine with simple cases, but does not
> map well with ALSA transitions for underflows/resume where prepare()
> can be called multiple times. Concurrency with multiple devices per
> links or multiple streams enabled on the same link also needs to be
> fixed.
> 
> These patches are the result of hours of validation on the Intel side
> and should benefit other implementations since there is nothing
> hardware-specific. The Intel-specific changes being reviewed do depend
> on those stream changes though to be functional.

Vinod, these patches have been in the queue for quite some time, and 
v5.6-rc1 is out. Can we move on with the reviews?
Thanks!

> Changes since v1:
> Removed spurious code block change flagged by Vinod
> 
> No change (replies provided in v1 thread)
> Github link issue is public, no reason to remove it
> Bandwidth computation on ALSA prepare/start (for resume cases) handled
> internally in stream layer.
> Kept emacs comment formatting.
> No additional code/test for concurrent streams (not supported due to locking)
> 
> Bard Liao (1):
>    soundwire: stream: only prepare stream when it is configured.
> 
> Pierre-Louis Bossart (2):
>    soundwire: stream: update state machine and add state checks
>    soundwire: stream: do not update parameters during DISABLED-PREPARED
>      transition
> 
> Rander Wang (2):
>    soundwire: stream: fix support for multiple Slaves on the same link
>    soundwire: stream: don't program ports when a stream that has not been
>      prepared
> 
>   Documentation/driver-api/soundwire/stream.rst | 61 +++++++++----
>   drivers/soundwire/stream.c                    | 90 ++++++++++++++++---
>   2 files changed, 124 insertions(+), 27 deletions(-)
> 
