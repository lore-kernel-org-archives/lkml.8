Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 287DBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025C020738
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgGGT0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:26:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:56354 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728100AbgGGT0v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:26:51 -0400
IronPort-SDR: EbAuC6xMfm5ou+G0h0It9J0nzzdkbKklHaQPKe4E4HkmFwW7ppEHKvk7PYV6nTYBreTW+CmHsc
 qEnD9sEgKo8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9675"; a="135925963"
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="135925963"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:26:51 -0700
IronPort-SDR: i8p44p0pWWlOKfP9MwzqRPEQ4Qe8pRdooKE0Tcf3tP5wSyQX1KXMG/fXggJfa7AlYTHeR/pC0m
 ppUTWWAThu1g==
X-IronPort-AV: E=Sophos;i="5.75,324,1589266800"; 
   d="scan'208";a="297493452"
Received: from mrtorger-mobl1.amr.corp.intel.com (HELO [10.254.77.62]) ([10.254.77.62])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2020 12:26:50 -0700
Subject: Re: [PATCH 10/11] ASoC: qdsp6-dai: add gapless support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-11-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <62af11d3-db26-a31b-00c8-9d78b11862cc@linux.intel.com>
Date:   Tue, 7 Jul 2020 12:07:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200707163641.17113-11-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/20 11:36 AM, Srinivas Kandagatla wrote:
> Add support to gapless playback by implementing metadata,
> next_track, drain and partial drain support.
> 
> Gapless on Q6ASM is implemented by opening 2 streams in a single asm stream

What does 'in a single asm stream' means?

> and toggling them on next track.

It really seems to me that you have two streams at the lowest level, 
along with the knowledge of how many samples to remove/insert and hence 
could do a much better job - including gapless support between unrelated 
profiles and cross-fading - without the partial drain and next_track 
mechanism that was defined assuming a single stream/profile.

