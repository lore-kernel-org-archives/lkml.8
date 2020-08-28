Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC2AC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF1B8208C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgH1PO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:14:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:25221 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726720AbgH1POy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:14:54 -0400
IronPort-SDR: x6oVqprKSPnA3ELfjOWHM7jKVJx6WouuOKb0sDxZy4ECH/dhjGyGHmpph/Ki1N905ZHGM1n+3l
 w3Q6BCpcy0sQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="154094575"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="154094575"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 08:14:53 -0700
IronPort-SDR: lmmOffibLsj9n0W6xaXGeuDfgSX/QKOitxVzhsT/UObzEMYoNNzzUbIzp8LZrJ0NAv1/emfTqf
 00P4tmDuBt8w==
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="300265640"
Received: from lilymao-mobl.amr.corp.intel.com (HELO [10.209.185.175]) ([10.209.185.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 08:14:52 -0700
Subject: Re: [PATCH] soundwire: cadence: fix race condition between suspend
 and Slave device alerts
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200817222340.18042-1-yung-chuan.liao@linux.intel.com>
 <20200819090637.GE2639@vkoul-mobl>
 <8d60fa6f-bb7f-daa8-5ae2-51386b87ccad@linux.intel.com>
 <20200821050758.GI2639@vkoul-mobl>
 <29ea5a44-b971-770a-519c-ae879557b63f@linux.intel.com>
 <20200828080024.GP2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <77ecb4bc-10d6-8fbd-e97f-923d01a5e555@linux.intel.com>
Date:   Fri, 28 Aug 2020 10:14:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828080024.GP2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> Is this timeout for suspend or resume? Somehow I was under the
> assumption that it is former? Or is the result seen on resume?
> 
> Rereading the race describe above in steps, I think this should be
> handled in step c above. Btw is that suspend or runtime suspend which
> causes this? Former would be bigger issue as we should not have work
> running when we return from suspend call. Latter should be dealt with
> anyway as device might be off after suspend.

This happens with a system suspend. Because we disable the interrupts, 
the workqueue never completes, and we have a timeout on system resume.

That's why we want to prevent the workqueue from starting, or let it 
complete, but not have this zombie state where we suspend but there's 
still a wait for completion that times out later. The point here is 
really  making sure the workqueue is not used before suspend.
