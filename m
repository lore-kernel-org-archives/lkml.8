Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B09C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A0922076C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=perex.cz header.i=@perex.cz header.b="mYG4ef51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbgIHTPU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:15:20 -0400
Received: from mail1.perex.cz ([77.48.224.245]:41538 "EHLO mail1.perex.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731184AbgIHQEu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:04:50 -0400
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id BDCF7A0040;
        Tue,  8 Sep 2020 13:58:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz BDCF7A0040
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1599566329; bh=Nbb52axGQkpd+7mzAiOkmvpMt9BrP1xSBJs/FBqExE8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mYG4ef51jfoK/iiwUwq6QRywvsF1C7gp+QbmGLJ7QY/1S7VFLREYoupbZ538Y2YDO
         EfOuQq0alwf2EMcD4NdgbdNM1MTm0R4tL9heDz0ONA1OGf9frBAO0HATCOCSIKVHhA
         fw9OFxfkGqWnLogJ8mTm0Kp/w9DEtP8kl5ouInKQ=
Received: from p1gen2.perex-int.cz (unknown [192.168.100.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Tue,  8 Sep 2020 13:58:33 +0200 (CEST)
Subject: Re: [PATCH] soundwire: cadence: fix race condition between suspend
 and Slave device alerts
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200817222340.18042-1-yung-chuan.liao@linux.intel.com>
 <20200819090637.GE2639@vkoul-mobl>
 <8d60fa6f-bb7f-daa8-5ae2-51386b87ccad@linux.intel.com>
 <20200821050758.GI2639@vkoul-mobl>
 <29ea5a44-b971-770a-519c-ae879557b63f@linux.intel.com>
 <20200828080024.GP2639@vkoul-mobl>
 <77ecb4bc-10d6-8fbd-e97f-923d01a5e555@linux.intel.com>
From:   Jaroslav Kysela <perex@perex.cz>
Message-ID: <3e4dee4b-1309-2d3e-ae20-e2dcbadb2f40@perex.cz>
Date:   Tue, 8 Sep 2020 13:58:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <77ecb4bc-10d6-8fbd-e97f-923d01a5e555@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne 28. 08. 20 v 17:14 Pierre-Louis Bossart napsal(a):
> 
> 
> 
>> Is this timeout for suspend or resume? Somehow I was under the
>> assumption that it is former? Or is the result seen on resume?
>>
>> Rereading the race describe above in steps, I think this should be
>> handled in step c above. Btw is that suspend or runtime suspend which
>> causes this? Former would be bigger issue as we should not have work
>> running when we return from suspend call. Latter should be dealt with
>> anyway as device might be off after suspend.
> 
> This happens with a system suspend. Because we disable the interrupts, 
> the workqueue never completes, and we have a timeout on system resume.
> 
> That's why we want to prevent the workqueue from starting, or let it 
> complete, but not have this zombie state where we suspend but there's 
> still a wait for completion that times out later. The point here is 
> really  making sure the workqueue is not used before suspend.
> 

Vinod, there is no acceptance progress on this. The patch is really straight
and for the Intel controller. They know what they're doing. I would apply
this. The code can be refined at anytime. It's a fix. I tested it and I can
confirm, that it fixes the issue. It's a vital patch for 5.10 to enable
finally SoundWire drivers for the Intel hardware.

Acked-by: Jaroslav Kysela <perex@perex.cz>


-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
