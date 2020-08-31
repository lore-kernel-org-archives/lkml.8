Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33ECC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DFF2083E
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgHaPMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:12:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:60079 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728150AbgHaPMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:12:13 -0400
IronPort-SDR: U7+C17HVFByB6Euuc0SBdvXp3o47SMB60HOO10m4VkXS9slgenepXVdv2li2HlWp6FvthLa9Ms
 N+8RWN0sdhFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9730"; a="154514628"
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="154514628"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 08:12:11 -0700
IronPort-SDR: W2JTNx3hI1AVbQtJmUolyOm5HWXco2Bnn/FosS7i9xHr7AwwAdVR8Ta4SJaiRdxTSqkdd6aiE4
 FlbHmIAICbtw==
X-IronPort-AV: E=Sophos;i="5.76,376,1592895600"; 
   d="scan'208";a="501375147"
Received: from jaeikcho-mobl.amr.corp.intel.com (HELO [10.213.165.6]) ([10.213.165.6])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 08:12:09 -0700
Subject: Re: [PATCH v3 0/3] ASoC: soundwire: fix port_ready[] dynamic
 allocation
To:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200830132742.20404-1-yung-chuan.liao@linux.intel.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <dd947a84-87cb-7eed-9ac2-fe3de42dfc31@linux.intel.com>
Date:   Mon, 31 Aug 2020 10:12:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200830132742.20404-1-yung-chuan.liao@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/20 8:27 AM, Bard Liao wrote:
> The existing code allocates memory for the total number of ports.
> This only works if the ports are contiguous, but will break if e.g. a
> Devices uses port0, 1, and 14. The port_ready[] array would contain 3
> elements, which would lead to an out-of-bounds access. Conversely in
> other cases, the wrong port index would be used leading to timeouts on
> prepare.
> 
> This can be fixed by allocating for the worst-case of 15
> ports (DP0..DP14). In addition since the number is now fixed, we can
> use an array instead of a dynamic allocation.

Bard, the order of patches will break git bisect, no? I tried on my side 
and get the following error after applying patch1

sound/soc/codecs/max98373-sdw.c:337:20: error: assignment to expression 
with array type
   337 |  slave->port_ready = devm_kcalloc(&slave->dev, num_of_ports,
       |

the order should be

ASoC: codecs: soundwire: remove port_ready[] usage from codecs.
soundwire: add definition for maximum number of ports
soundwire: fix port_ready[] dynamic allocation in mipi_disco

> Changes in v3:
> - Add ASoC tag in the cover letter title.
> - Edit the title and commit message of the third patch for better
>    understanding.
> 
> Changes in v2:
> - Split patches into sdw and asoc patches. Please note that "soundwire:
>    fix port_ready[] dynamic allocation in mipi_disco" and "ASoC: codecs:
>    fix port_ready[] dynamic allocation in ASoC codecs" should be merged
>    at the same time.
> 
> Pierre-Louis Bossart (3):
>    soundwire: add definition for maximum number of ports
>    soundwire: fix port_ready[] dynamic allocation in mipi_disco
>    ASoC: codecs: soundwire: remove port_ready[] usage from codecs.
> 
>   drivers/soundwire/mipi_disco.c  | 18 +-----------------
>   drivers/soundwire/slave.c       |  4 ++++
>   include/linux/soundwire/sdw.h   |  5 +++--
>   sound/soc/codecs/max98373-sdw.c | 15 +--------------
>   sound/soc/codecs/rt1308-sdw.c   | 14 +-------------
>   sound/soc/codecs/rt5682-sdw.c   | 15 +--------------
>   sound/soc/codecs/rt700-sdw.c    | 15 +--------------
>   sound/soc/codecs/rt711-sdw.c    | 15 +--------------
>   sound/soc/codecs/rt715-sdw.c    | 33 +--------------------------------
>   9 files changed, 14 insertions(+), 120 deletions(-)
> 
