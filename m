Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFC0C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26436206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 10:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgDMKqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 06:46:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:4726 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727776AbgDMKqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 06:46:48 -0400
IronPort-SDR: UGbTkBwiCm4AE4CFrSFl76aBolCKu38xqdZwnT/THUrvjWsYGJ2AM3WZiyNDdwD53u0ihbSNBr
 S/KgEWICXKag==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 03:46:48 -0700
IronPort-SDR: YhG4SpOJAtuDhIzfdEXl0XuA2uTQR1KtNec9MqjZLOMdU/k+LJkJqjARAneI13RPWqNDWPO4/p
 60GiSpmBpcPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="243507814"
Received: from ftehrig-mobl.amr.corp.intel.com (HELO [10.209.82.92]) ([10.209.82.92])
  by fmsmga007.fm.intel.com with ESMTP; 13 Apr 2020 03:46:45 -0700
Subject: Re: [PATCH -next] soundwire: intel: Make sdw_intel_init static
To:     YueHaibing <yuehaibing@huawei.com>, vkoul@kernel.org,
        sanyog.r.kale@intel.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200410115708.27708-1-yuehaibing@huawei.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e58ff419-588b-da7b-2e36-6cf568315c57@linux.intel.com>
Date:   Fri, 10 Apr 2020 10:25:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200410115708.27708-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/20 6:57 AM, YueHaibing wrote:
> Fix sparse warning:
> 
> drivers/soundwire/intel_init.c:193:6: warning:
>   symbol 'sdw_intel_init' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>   drivers/soundwire/intel_init.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
> index 4b769409f6f8..ad7053463889 100644
> --- a/drivers/soundwire/intel_init.c
> +++ b/drivers/soundwire/intel_init.c
> @@ -190,7 +190,8 @@ static acpi_status sdw_intel_acpi_cb(acpi_handle handle, u32 level,
>    * This scans the namespace and creates SoundWire link controller devices
>    * based on the info queried.
>    */
> -void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res)
> +static void *sdw_intel_init(acpi_handle *parent_handle,
> +			    struct sdw_intel_res *res)

This declaration has been this way since 2017, there are no users and it 
will be removed with the Intel patchsets, so fixing this warning doesn't 
really add much value. No sustained objection though.

>   {
>   	acpi_status status;
>   
> 
