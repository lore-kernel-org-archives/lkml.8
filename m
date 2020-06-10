Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8639BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BFE2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 02:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgFJCLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 22:11:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:22668 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgFJCLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 22:11:49 -0400
IronPort-SDR: nM5y7RZK5bSpD8d1TnmNuDiPmasDiGudR0eqGDsHzt49DnL/JLK0NKiRiodpk3vcBAJgztEtHb
 zzl8MTfp8URg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 19:11:48 -0700
IronPort-SDR: kN1rgZC1ZwioEDqx8NmY1hE7Oa0mb2fQ/dbSTaRX0EQcKxo1ZH94O0RBWNh9pEYYSSnLgTHqiD
 lzX6Cd9LeO8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,494,1583222400"; 
   d="scan'208";a="259152355"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 09 Jun 2020 19:11:48 -0700
Received: from [10.255.176.176] (vramuthx-MOBL1.gar.corp.intel.com [10.255.176.176])
        by linux.intel.com (Postfix) with ESMTP id 2BEAA580698;
        Tue,  9 Jun 2020 19:11:43 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v1 2/2] usb: phy: Add USB3 PHY support for Intel LGM SoC
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, balbi@kernel.org
Cc:     gregkh@linuxfoundation.org, robh@kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com, yin1.li@intel.com,
        andriy.shevchenko@intel.com
References: <20200609110850.43469-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200609110850.43469-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <d2f30dbde89050e428b61092a1e5bbcf8d257129.camel@pengutronix.de>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <1ed87ef0-170d-4543-5d90-8c8b223c704c@linux.intel.com>
Date:   Wed, 10 Jun 2020 10:11:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <d2f30dbde89050e428b61092a1e5bbcf8d257129.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

    Thanks for the review comments...

On 9/6/2020 8:14 pm, Philipp Zabel wrote:
>> +
>> +	for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++)
>> +		reset_control_deassert(resets[i]);
>> +	/* Need to wait at least 20us before de-assert the PHY */
>> +	usleep_range(20, 100);
> This waits 20us after de-asserting the reset, not before. Is this in the
> correct place?
This is correct place , but the above mentioned comments are wrong, need 
to re-write the comments as below...

/* out-of-band reset of the controller after PHY reset
  * will cause controller malfunctioning, so should use in-bandcontroller
  * reset only and leave the controller de-asserted here.
  */
     for (i = 0; i < ARRAY_SIZE(CTL_RESETS); i++)
             reset_control_deassert(resets[i]);

/* Need to wait at least 20us after de-assert the PHY */
     usleep_range(20, 100);


Regards
Vadivel

> 
