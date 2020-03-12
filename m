Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCDDC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD23B206E7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCLLjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:39:44 -0400
Received: from mga18.intel.com ([134.134.136.126]:29762 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLLjn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:39:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 04:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,544,1574150400"; 
   d="scan'208";a="242995404"
Received: from swaydand-mobl1.amr.corp.intel.com (HELO [10.255.230.33]) ([10.255.230.33])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 04:39:41 -0700
Subject: Re: [PATCH] soundwire: stream: use sdw_write instead of update
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
References: <20200312100105.5293-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b235b88a-acdc-cec4-0c00-2609c3774fa1@linux.intel.com>
Date:   Thu, 12 Mar 2020 05:45:32 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312100105.5293-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/12/20 5:01 AM, Srinivas Kandagatla wrote:
> There is no point in using update for registers with write mask
> as 0xFF, this adds unecessary traffic on the bus.
> Just use sdw_write directly.

well in theory you could have two streams share the same port, that's 
allowed by the specification.

But since it clearly documented as not supported

	/*
	 * Since bus doesn't support sharing a port across two streams,
	 * it is safe to reset this register
	 */

this mask handing is indeed completely overkill.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>   drivers/soundwire/stream.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 00348d1fc606..1b43d03c79ea 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -313,9 +313,9 @@ static int sdw_enable_disable_slave_ports(struct sdw_bus *bus,
>   	 * it is safe to reset this register
>   	 */
>   	if (en)
> -		ret = sdw_update(s_rt->slave, addr, 0xFF, p_rt->ch_mask);
> +		ret = sdw_write(s_rt->slave, addr, p_rt->ch_mask);
>   	else
> -		ret = sdw_update(s_rt->slave, addr, 0xFF, 0x0);
> +		ret = sdw_write(s_rt->slave, addr, 0x0);
>   
>   	if (ret < 0)
>   		dev_err(&s_rt->slave->dev,
> @@ -464,10 +464,9 @@ static int sdw_prep_deprep_slave_ports(struct sdw_bus *bus,
>   		addr = SDW_DPN_PREPARECTRL(p_rt->num);
>   
>   		if (prep)
> -			ret = sdw_update(s_rt->slave, addr,
> -					 0xFF, p_rt->ch_mask);
> +			ret = sdw_write(s_rt->slave, addr, p_rt->ch_mask);
>   		else
> -			ret = sdw_update(s_rt->slave, addr, 0xFF, 0x0);
> +			ret = sdw_write(s_rt->slave, addr, 0x0);
>   
>   		if (ret < 0) {
>   			dev_err(&s_rt->slave->dev,
> 
