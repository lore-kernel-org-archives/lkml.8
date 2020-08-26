Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE29CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8635920707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgHZHuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:50:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:41682 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbgHZHuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:50:17 -0400
IronPort-SDR: EQhA+q6TL6Gw71hXq/2h5rDt3kyuruxgDSrzfLhtCqtbvbg4zmv7M4V8UnvIEdRxu+ikSmKzu1
 xorsy/3YwyfA==
X-IronPort-AV: E=McAfee;i="6000,8403,9724"; a="144021553"
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="144021553"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 00:50:16 -0700
IronPort-SDR: XbHueJ70KqWBIi2Y1h9SwF0JodavQkOtEsVMDOq3LGgr7FkioX4VTezFyif8+/c9lMVHPU0d3A
 LM/1vdSxpa5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,354,1592895600"; 
   d="scan'208";a="331700260"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 26 Aug 2020 00:50:13 -0700
Received: from [10.215.173.55] (vramuthx-MOBL1.gar.corp.intel.com [10.215.173.55])
        by linux.intel.com (Postfix) with ESMTP id BC694580821;
        Wed, 26 Aug 2020 00:50:10 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 3/9] extcon: extcon-ptn5150: Switch to BIT() macro for
 cable attach
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, andriy.shevchenko@intel.com,
        thomas.langer@intel.com, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200818065727.50520-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200818065727.50520-4-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200826065942.GC12271@pi3>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <17f5d1c1-be2c-b6db-a682-b99b57ceadf2@linux.intel.com>
Date:   Wed, 26 Aug 2020 15:50:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200826065942.GC12271@pi3>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26/8/2020 2:59 pm, Krzysztof Kozlowski wrote:
> On Tue, Aug 18, 2020 at 02:57:21PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan<vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Switch to BIT() macro for the cable attach.
> Squash it.
Sure, will squash it and rebase over your patches then send it, thanks!

Best Regards
Vadivel
> 
