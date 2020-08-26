Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D354EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE68214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHZOkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:40:25 -0400
Received: from mga11.intel.com ([192.55.52.93]:3727 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726734AbgHZOkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:40:20 -0400
IronPort-SDR: nXjjw/d8Vf8jd0NiEb1r3ofsuQDuWCiNSWUCc6b7aChm4Vb61pwxWR0SIO/eK9TX0kH1kavBg+
 M3mWWRhERO6g==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153869856"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="153869856"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 07:40:20 -0700
IronPort-SDR: uwrE/m7OJxY2wgP0ERnHQlSOIMq0Fak51rD/ut8OuryPrAsM34MBNqt2K0CCynweGLzV4+3tDo
 T5go1EsNN8Cw==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="299494855"
Received: from gillelas-mobl1.amr.corp.intel.com (HELO [10.255.231.51]) ([10.255.231.51])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 07:40:18 -0700
Subject: Re: [PATCH 05/11] soundwire: bus: update multi-link definition with
 hw sync details
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-6-yung-chuan.liao@linux.intel.com>
 <20200826094420.GA2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d534afc3-3c38-275e-2f62-0432ffd91a36@linux.intel.com>
Date:   Wed, 26 Aug 2020 09:09:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826094420.GA2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> + * @hw_sync_min_links: Number of links used by a stream above which
>> + * hardware-based synchronization is required. This value is only
>> + * meaningful if multi_link is set. If set to 1, hardware-based
>> + * synchronization will be used even if a stream only uses a single
>> + * SoundWire segment.
> 
> Soundwire spec does not say anything about multi-link so this is left to
> implementer. Assuming that value of 1 would mean hw based sync will
> be used even for single stream does not make sense in generic terms.
> Maybe yes for Intel but may not be true for everyone?

hw-based sync is required for Intel even for single stream. It's been 
part of the recommended programming flows since the beginning but 
ignored so far.

That said, this value is set by each master implementation, no one 
forces non-Intel users to implement an Intel-specific requirement.

> We already use m_rt_count in code for this, so the question is why is
> that not sufficient?

Because as you rightly said above, Intel requires the hw_sync to be used 
even for single stream, but we didn't want others to be forced to use 
the hw-sync for single stream. the m_rt_count is not sufficient for Intel.

I think we are in agreement on not forcing everyone to follow what is 
required by Intel, and that's precisely why we added this setting. If 
you set it to two you would only use hw_sync when two masters are used.
