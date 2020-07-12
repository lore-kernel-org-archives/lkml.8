Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EA0C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 05:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5736920725
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 05:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728234AbgGLFvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 01:51:00 -0400
Received: from mga09.intel.com ([134.134.136.24]:64366 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbgGLFu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 01:50:59 -0400
IronPort-SDR: PqrVqmkYA2Ua5G8qqPBCNGv7WEro90R1EarS04Nwx6v5YHsepxS716QSa0SKfrjZDNCCX3pij5
 7buOec5zd2Cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9679"; a="149932010"
X-IronPort-AV: E=Sophos;i="5.75,342,1589266800"; 
   d="scan'208";a="149932010"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2020 22:50:59 -0700
IronPort-SDR: 6dIdGJ+V6iv5lTF00/dGQIFV7NJ7kgJvEJjz8QW2uFcxlA+MxeRH2jDsmK2S/OVKEYP3RWarmY
 BVAZH/bmq31g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,342,1589266800"; 
   d="scan'208";a="268087447"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 11 Jul 2020 22:50:58 -0700
Received: from [10.255.131.188] (unknown [10.255.131.188])
        by linux.intel.com (Postfix) with ESMTP id D44F65805F0;
        Sat, 11 Jul 2020 22:50:55 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v4 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
To:     Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org,
        robh@kernel.org, p.zabel@pengutronix.de
Cc:     gregkh@linuxfoundation.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, cheol.yong.kim@intel.com,
        qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com
References: <20200617035818.54110-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200617035818.54110-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <87blknrjg6.fsf@kernel.org>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <04a2d471-168f-7769-895e-b390c64e95ad@linux.intel.com>
Date:   Sun, 12 Jul 2020 13:50:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87blknrjg6.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/7/2020 2:08 pm, Felipe Balbi wrote:
> 
> Hi,
> 
> "Ramuthevar,Vadivel MuruganX"
> <vadivel.muruganx.ramuthevar@linux.intel.com> writes:
> 
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add support for USB PHY on Intel LGM SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   drivers/usb/phy/Kconfig       |  11 ++
>>   drivers/usb/phy/Makefile      |   1 +
>>   drivers/usb/phy/phy-lgm-usb.c | 275 ++++++++++++++++++++++++++++++++++++++++++
> 
> new phy drivers should use drivers/phy instead.
Noted, Will move to drivers/phy as per your suggestion, Thanks!

Regards
Vadivel
> 
