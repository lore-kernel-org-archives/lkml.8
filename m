Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F5FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE22206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgEUCSc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 22:18:32 -0400
Received: from mga17.intel.com ([192.55.52.151]:25849 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbgEUCSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 22:18:32 -0400
IronPort-SDR: Gxpwy1yShcWG3uUExjEyq0yJFR1jNXJjHChXem5wDy91sFBB1tfTH4AnjobmrFWqOZIfC1gkUE
 Sig3448RAUqg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2020 19:18:31 -0700
IronPort-SDR: ej73RVr5VXW1YFsQO2RnXxS2Gz6PpL1WryA3R0i9OZOzz47haLbA6uGuM5NSc3gblLeTdBhlYP
 ofEnlu51jN9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,416,1583222400"; 
   d="scan'208";a="300642970"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 20 May 2020 19:18:31 -0700
Received: from [10.214.148.54] (vramuthx-MOBL1.gar.corp.intel.com [10.214.148.54])
        by linux.intel.com (Postfix) with ESMTP id 99B9E580613;
        Wed, 20 May 2020 19:18:28 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v2 1/1] dt-bindings: spi: Add schema for Cadence QSPI
 Controller driver
To:     Mark Brown <broonie@kernel.org>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-spi@vger.kernel.org, vigneshr@ti.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
References: <20200520123612.11797-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200520124329.GF4823@sirena.org.uk>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <fd086da7-7e18-83bc-d423-56095b0cff96@linux.intel.com>
Date:   Thu, 21 May 2020 10:18:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520124329.GF4823@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

  Thank you for the review comments...

On 20/5/2020 8:43 pm, Mark Brown wrote:
> On Wed, May 20, 2020 at 08:36:12PM +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add dt-bindings documentation for Cadence-QSPI controller to support
>> spi based flash memories.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> ---
>>   .../devicetree/bindings/mtd/cadence-quadspi.txt    |  67 -----------
>>   .../devicetree/bindings/spi/cdns,qspi-nor.yaml     | 133 +++++++++++++++++++++
> 
> The changelog says this is adding a new binding but the actual change is
> mostly a conversion to YAML.  Please split the additions out into a
> separate change, ideally doing that before the conversion since there is
> a backlog on review of YAML conversions.

Initially was sending the only YAML file alone, then reviewers suggest 
to me do this way so I did, next by split the patches like below...

1. remove the cadence-quadspi.txt (patch1)
2. convert txt to YAML (patch2)

Regards
Vadivel
> 
