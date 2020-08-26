Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723DBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5210E20707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgHZPLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:11:25 -0400
Received: from mga04.intel.com ([192.55.52.120]:9758 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgHZPLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:11:21 -0400
IronPort-SDR: H1Yipx6mPrnOIvHMmy0IHteadnYW3ANZaBEFkUjkAP595VDcoWnWfg6Pi7uJGqJwBykTL4Kdy8
 BvlNEqNAo1Rg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153729687"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="153729687"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:11:21 -0700
IronPort-SDR: Kqzb7ZXAZ8xX5SlEi/WxQq5DXzfNtH2AFLCDJqB4ItflV1I+fWFym6ZPnOZw0sYNJuGfbTurLm
 4y58MMJou79A==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="299505099"
Received: from gillelas-mobl1.amr.corp.intel.com (HELO [10.255.231.51]) ([10.255.231.51])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 08:11:19 -0700
Subject: Re: [PATCH 3/4] soundwire: SDCA: add helper macro to access controls
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
 <20200825171656.75836-4-pierre-louis.bossart@linux.intel.com>
 <20200826085540.GY2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <9c078341-7e90-a4e8-da30-19e9720d93e4@linux.intel.com>
Date:   Wed, 26 Aug 2020 10:00:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826085540.GY2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> +/* v1.2 device - SDCA address mapping */
> 
> Can you please add description of bits used by each field here,
> something like we have done for DevId

were you referring to something like this?

  * Spec definition
  *   Register		Bit	Contents
  *   DevId_0 [7:4]	47:44	sdw_version
  *   DevId_0 [3:0]	43:40	unique_id
  *   DevId_1		39:32	mfg_id [15:8]
  *   DevId_2		31:24	mfg_id [7:0]
  *   DevId_3		23:16	part_id [15:8]
  *   DevId_4		15:08	part_id [7:0]
  *   DevId_5		07:00	class_id

> 
>> +#define SDW_SDCA_CTL(fun, ent, ctl, ch)		(BIT(30) |			\
>> +						 (((fun) & 0x7) << 22) |	\
>> +						 (((ent) & 0x40) << 15) |	\
>> +						 (((ent) & 0x3f) << 7) |	\
>> +						 (((ctl) & 0x30) << 15) |	\
>> +						 (((ctl) & 0x0f) << 3) |	\
>> +						 (((ch) & 0x38) << 12) |	\
>> +						 ((ch) & 0x07))
> 
> GENMASK() for the bitmaps here please. Also it would look very neat by
> using FIELD_PREP() here, you can skip the bit shifts and they would be
> done by FIELD_PREP() for you.

ok.
