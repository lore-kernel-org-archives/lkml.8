Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC0AEC43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DD8A207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732650AbgIHUC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:02:26 -0400
Received: from mga06.intel.com ([134.134.136.31]:24821 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730520AbgIHPen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:34:43 -0400
IronPort-SDR: SOclNfhovdKfRml0GdC1VV/iFCTmI+GUDyIAScNmmJdUuQBHxtneW+4Hj7af5gqb45Uk4Mq+P7
 uWVSbK2m39qg==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="219715477"
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="219715477"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 08:33:23 -0700
IronPort-SDR: vw0zCnDsR3rSALWyjSRKlBGHJJL1ap4kPMjhz/Azq2iirmf8bzzpQaFK6CAeQrc5BskNEvTCo8
 y98Oog5bQdZg==
X-IronPort-AV: E=Sophos;i="5.76,406,1592895600"; 
   d="scan'208";a="448829315"
Received: from mgarber-mobl1.amr.corp.intel.com (HELO [10.212.179.134]) ([10.212.179.134])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 08:33:20 -0700
Subject: Re: [PATCH 1/7] soundwire: bus: use property to set interrupt masks
To:     Mark Brown <broonie@kernel.org>
Cc:     Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org,
        tiwai@suse.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, hui.wang@canonical.com,
        Vinod Koul <vkoul@kernel.org>, srinivas.kandagatla@linaro.org,
        ranjani.sridharan@linux.intel.com, jank@cadence.com,
        mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200818140656.29014-1-yung-chuan.liao@linux.intel.com>
 <20200818140656.29014-2-yung-chuan.liao@linux.intel.com>
 <20200828065125.GI2639@vkoul-mobl>
 <ec5fe867-f2e4-4278-0376-e54bcdd7f94d@perex.cz>
 <20200908121133.GA5551@sirena.org.uk>
 <1950b662-ec59-6603-36c7-7a41d9e8460c@perex.cz>
 <20200908143312.GC5551@sirena.org.uk>
 <ce68a159-de6d-2d8a-c8a2-3e527cb1239e@linux.intel.com>
 <20200908151412.GE5551@sirena.org.uk>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <973b1a09-40a9-1d10-4975-3f6d5a9340b1@linux.intel.com>
Date:   Tue, 8 Sep 2020 10:33:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908151412.GE5551@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>>>>> I don't have this patch and since I seem to get copied on quite a lot of
>>>>> soundwire only serieses I just delete them unread mostly.
> 
>> We now try to use the ASoC/SoundWire prefix for cover letters to highlight
>> that a patchset changes things across two trees, does this help or do we
>> need a different way of flagging these patches?
> 
> I think the issue is mainly where the patch itself touches both, if some
> of the patches mention ASoC I'll generally notice them but Soundwire is
> one of these things I get so many random CCs for I just zone it out so
> highlighting the individual patches would help.

ok, we'll highlight individual patches then and better explain dependencies.
