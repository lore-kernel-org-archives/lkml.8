Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1621EC7619C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1A892072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 04:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727910AbgBQEIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 23:08:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:61578 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgBQEIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 23:08:17 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Feb 2020 20:08:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,451,1574150400"; 
   d="scan'208";a="258141212"
Received: from unknown (HELO buildpc-HP-Z230) ([10.223.89.131])
  by fmsmga004.fm.intel.com with ESMTP; 16 Feb 2020 20:08:13 -0800
Date:   Mon, 17 Feb 2020 09:39:21 +0530
From:   Sanyog Kale <sanyog.r.kale@intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v3 0/5] soundwire: intel: add DAI callbacks
Message-ID: <20200217040921.GA19766@buildpc-HP-Z230>
References: <20200215014740.27580-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215014740.27580-1-pierre-louis.bossart@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 07:47:35PM -0600, Pierre-Louis Bossart wrote:
> The existing mainline code is missing most of the DAI callbacks needed
> for a functional implementation, and the existing ones need to be
> modified to provide the relevant information to ASoC/SOF drivers.
> 
> As suggested by Vinod, these patches are shared first - with the risk
> that they are separated from the actual DAI enablement, so reviewers
> might wonder why they are needed in the first place.
> 
> For reference, the complete set of 90+ patches required for SoundWire
> on Intel platforms is available here:
> 
> https://github.com/thesofproject/linux/pull/1692
> 
> Changes since v2:
> Add missing kfree for stream name (feedback from Vinod)
> 
> changes since v1:
> Fix string allocation (only feedback from Vinod)
> 
> Pierre-Louis Bossart (2):
>   soundwire: intel: rename res field as link_res
>   soundwire: intel: free all resources on hw_free()
> 
> Rander Wang (3):
>   soundwire: intel: add prepare support in sdw dai driver
>   soundwire: intel: add trigger support in sdw dai driver
>   soundwire: intel: add sdw_stream_setup helper for .startup callback
> 
>  drivers/soundwire/intel.c | 198 ++++++++++++++++++++++++++++++++++----
>  1 file changed, 178 insertions(+), 20 deletions(-)
> 

Acked-by: Sanyog Kale <sanyog.r.kale@intel.com>

Thanks,
Sanyog

> -- 
> 2.20.1
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
