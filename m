Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DDEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B44662078D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgHUHv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:51:29 -0400
Received: from mga18.intel.com ([134.134.136.126]:59609 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727846AbgHUHv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:51:26 -0400
IronPort-SDR: 9Tx6wnEmslE4sFm2fZnnK0nk+wn04qZD8YI1ncCVbF9Xu0H5KueAxQ3vTT8LLfduPBY4ewCWDf
 GpnCWS51r/Jg==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="143119158"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="143119158"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 00:51:25 -0700
IronPort-SDR: If98b8/s7kduG3CE2pUTKpwUC5swudFLNuRksqTdhyWOu3sn3Fd5p/3pXjY6v0hqTi7ttCy+Su
 e0g0fUOZOpdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; 
   d="scan'208";a="280210579"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 21 Aug 2020 00:51:25 -0700
Received: from [10.226.38.22] (unknown [10.226.38.22])
        by linux.intel.com (Postfix) with ESMTP id 998D258045A;
        Fri, 21 Aug 2020 00:51:22 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v8 0/2] phy: Add USB PHY support on Intel LGM SoC
To:     linux-kernel@vger.kernel.org, kishon@ti.com, vkoul@kernel.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, p.zabel@pengutronix.de,
        andriy.shevchenko@intel.com, balbi@kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com
References: <20200817031249.36795-1-vadivel.muruganx.ramuthevar@linux.intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <bf2301f3-7c70-06b1-898c-f18284babe75@linux.intel.com>
Date:   Fri, 21 Aug 2020 15:51:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817031249.36795-1-vadivel.muruganx.ramuthevar@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon, Vinod,

Gentle reminder!, kindly can you please merge this series of patches, as 
those patches got Reviewed-By Philipp Zabel and Rob Herring, Thanks!

Please do the needful.

Regards
Vadivel

On 17/8/2020 11:12 am, Ramuthevar,Vadivel MuruganX wrote:
> The USB PHY provides the optimized for low power dissipation while active, idle, or on standby.
> Requires minimal external components, a single resistor, for best operation.
> Supports 10/5-Gbps high-speed data transmission rates through 3-m USB 3.x cable
> ---
> v8:
>    - Rebase to V5.9-rc1
