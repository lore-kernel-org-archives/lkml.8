Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4321BC352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:42:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2370220838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 14:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgBJOmO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 09:42:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:18244 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728300AbgBJOmK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 09:42:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 06:42:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="226213730"
Received: from ykatsuma-mobl1.gar.corp.intel.com (HELO [10.251.140.95]) ([10.251.140.95])
  by fmsmga007.fm.intel.com with ESMTP; 10 Feb 2020 06:42:09 -0800
Subject: Re: [alsa-devel] [PATCH 00/10] soundwire: bus: fix race conditions,
 add suspend-resume
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        vkoul@kernel.org, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <f461be74-8acc-85c8-fd4e-8257ca85863f@linux.intel.com>
Date:   Mon, 10 Feb 2020 08:30:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200115000844.14695-1-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/20 6:08 PM, Pierre-Louis Bossart wrote:
> The existing mainline code for SoundWire does not handle critical race
> conditions, and does not have any support for pm_runtime suspend or
> clock-stop modes needed for e.g. jack detection or external VAD.
> 
> As suggested by Vinod, these patches for the bus are shared first -
> with the risk that they are separated from their actual use in Intel
> drivers, so reviewers might wonder why they are needed in the first
> place.
> 
> For reference, the complete set of 90+ patches required for SoundWire
> on Intel platforms is available here:
> 
> https://github.com/thesofproject/linux/pull/1692
> 
> These patches are not Intel-specific and are likely required for
> e.g. Qualcomm-based implementations.
> 
> All the patches in this series were generated during the joint
> Intel-Realtek validation effort on Intel reference designs and
> form-factor devices. The support for the initialization_complete
> signaling is already available in the Realtek codecs drivers merged in
> the ASoC tree (rt700, rt711, rt1308, rt715)

there's been no feedback since January 14, can we move on with the 
reviews now that r.6-rc1 is out?
Thanks!

> 
> Pierre-Louis Bossart (8):
>    soundwire: bus: fix race condition with probe_complete signaling
>    soundwire: bus: fix race condition with enumeration_complete signaling
>    soundwire: bus: fix race condition with initialization_complete
>      signaling
>    soundwire: bus: add PM/no-PM versions of read/write functions
>    soundwire: bus: write Slave Device Number without runtime_pm
>    soundwire: bus: add helper to clear Slave status to UNATTACHED
>    soundwire: bus: disable pm_runtime in sdw_slave_delete
>    soundwire: bus: don't treat CMD_IGNORED as error on ClockStop
> 
> Rander Wang (2):
>    soundwire: bus: fix io error when processing alert event
>    soundwire: bus: add clock stop helpers
> 
>   drivers/soundwire/bus.c       | 509 ++++++++++++++++++++++++++++++++--
>   drivers/soundwire/bus.h       |   9 +
>   drivers/soundwire/bus_type.c  |   5 +
>   drivers/soundwire/slave.c     |   4 +
>   include/linux/soundwire/sdw.h |  24 ++
>   5 files changed, 526 insertions(+), 25 deletions(-)
> 
