Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32207C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B00E20786
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 05:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgH0FTh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 01:19:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:2149 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbgH0FTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 01:19:37 -0400
IronPort-SDR: WYxyrhxR1ecO5UJuDjq0Uq32PltlHralx6dpiiQehvjyg/XsErSVrpQq2x128p2scEi+DXD/+s
 5VFWa25yH1Rg==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="217972617"
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="217972617"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 22:19:36 -0700
IronPort-SDR: mlcmNCs8w3SOR7MeYKvnSIoWGJjhFxTkDd8nCGTVPOIrcEmow1IaW3L/Fv9y3Y4ifWIIO3x2GH
 jDGJmxKSyBVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,358,1592895600"; 
   d="scan'208";a="323459201"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 26 Aug 2020 22:19:36 -0700
Received: from [10.249.76.175] (vramuthx-MOBL1.gar.corp.intel.com [10.249.76.175])
        by linux.intel.com (Postfix) with ESMTP id E7C3658069F;
        Wed, 26 Aug 2020 22:19:33 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v2 1/2] extcon: ptn5150: Switch to GENMASK() and BIT()
 macros
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
Cc:     vijaikumar.kanagarajan@gmail.com, krzk@kernel.org,
        myungjoo.ham@samsung.com, heikki.krogerus@linux.intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200827035633.37348-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <CGME20200827035649epcas1p3eb6c7abbcd8e0ac28df5be19c9ef3a32@epcas1p3.samsung.com>
 <20200827035633.37348-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <8f26c8cb-3f6b-5933-a0f8-eb765ad5016a@samsung.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <957c1c42-d5d9-1bdb-bc71-15c4e916886a@linux.intel.com>
Date:   Thu, 27 Aug 2020 13:19:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <8f26c8cb-3f6b-5933-a0f8-eb765ad5016a@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 27/8/2020 1:26 pm, Chanwoo Choi wrote:
>> -
>> +	vendor_id = FIELD_GET(PTN5150_REG_DEVICE_ID_VENDOR, reg_data);
>> +	version_id = FIELD_GET(PTN5150_REG_DEVICE_ID_VERSION, reg_data);
>>   	dev_dbg(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
>>   		version_id, vendor_id);
>>   
>>
> Applied it. Thanks.
Thank you!

Regards
Vadivel
