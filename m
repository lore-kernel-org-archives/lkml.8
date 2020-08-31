Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 842CFC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 607D420719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 14:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgHaOMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 10:12:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:5894 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgHaOMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 10:12:32 -0400
IronPort-SDR: 8UntdQLScuNyLFKNGMBtfe3NV0cZ0ZqqFyjnckZbU5KkaD+S2MpyWz9dlK85EnynrB7QmqFZQR
 UHnqjLnxtsag==
X-IronPort-AV: E=McAfee;i="6000,8403,9729"; a="156230018"
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="156230018"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 07:12:31 -0700
IronPort-SDR: mXpLa4BRUA8wo1zDpwvJXond5em8FPLQB7G7icZGH+/kZVQwbcbjdK30HqEUdS/mtKFiJULbUX
 27zhVKmbZrsg==
X-IronPort-AV: E=Sophos;i="5.76,375,1592895600"; 
   d="scan'208";a="296939746"
Received: from jgu-mobl2.amr.corp.intel.com (HELO [10.209.129.34]) ([10.209.129.34])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2020 07:12:30 -0700
Subject: Re: [PATCH] regmap: soundwire: remove unsed header mod_devicetable.h
To:     Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200829103939.4007097-1-vkoul@kernel.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d329c295-b2d1-68d9-79bf-278f7af4bb58@linux.intel.com>
Date:   Mon, 31 Aug 2020 09:12:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200829103939.4007097-1-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

typo in commit message?

On 8/29/20 5:39 AM, Vinod Koul wrote:
> mod_devicetable.h does not seem to be required for this file, so
> remove it.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   drivers/base/regmap/regmap-sdw.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/regmap-sdw.c b/drivers/base/regmap/regmap-sdw.c
> index 50a66382d87d..c92d614b4943 100644
> --- a/drivers/base/regmap/regmap-sdw.c
> +++ b/drivers/base/regmap/regmap-sdw.c
> @@ -2,7 +2,6 @@
>   // Copyright(c) 2015-17 Intel Corporation.
>   
>   #include <linux/device.h>
> -#include <linux/mod_devicetable.h>
>   #include <linux/module.h>
>   #include <linux/soundwire/sdw.h>
>   #include "internal.h"
> 
