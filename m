Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A8EFC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 019B620720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:46:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731574AbgGUXqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:46:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:44145 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726652AbgGUXqI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:46:08 -0400
IronPort-SDR: aRx+38qnrAlX+7aPJE58xN2WiEinwsSPNAJFGe0h9Hwbk6GN/Hw+x4CaLB6MiPV+YHAMKgSN4J
 NZzOHNwFTRdQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="129815370"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="129815370"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:07 -0700
IronPort-SDR: MMOeo2/Dfs4n33AjN7IWa6gd0dbQP6GDc/LDiygHgeiRJQr7ssztFCvpExHJSdyrfvoo3kiWwF
 YAWsvo7SYnQw==
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="362539381"
Received: from krlloyd-mobl.amr.corp.intel.com (HELO [10.255.231.6]) ([10.255.231.6])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 16:46:07 -0700
Subject: Re: [RFC PATCH v2 1/6] ALSA: compress: move codec parameter check to
 a function
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
References: <20200721170007.4554-1-srinivas.kandagatla@linaro.org>
 <20200721170007.4554-2-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <ce83d990-d00d-5dbc-ddcb-6c3ad48f5483@linux.intel.com>
Date:   Tue, 21 Jul 2020 14:56:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721170007.4554-2-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/21/20 12:00 PM, Srinivas Kandagatla wrote:
> Move codec parameter checking to dedicated function so that other
> callers do not duplicate it. This is in preparedness for adding

preparation?

> snd_compr_set_codec_params() support.
> 

