Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84417C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A08921D56
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCISFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:05:24 -0400
Received: from mga11.intel.com ([192.55.52.93]:59940 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726859AbgCISFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:05:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 11:05:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; 
   d="scan'208";a="231020439"
Received: from jdbostic-mobl1.amr.corp.intel.com (HELO [10.251.152.35]) ([10.251.152.35])
  by orsmga007.jf.intel.com with ESMTP; 09 Mar 2020 11:05:22 -0700
Subject: Re: [RFC PATCH] soundwire: bus: Add flag to mark DPN_BlockCtrl1 as
 readonly
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d94fca16-ed61-632a-6f8c-84e3a97869c7@linux.intel.com>
Date:   Mon, 9 Mar 2020 13:05:22 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309173755.955-1-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/9/20 12:37 PM, Srinivas Kandagatla wrote:
> According to SoundWire Specification Version 1.2.
> "A Data Port number X (in the range 0-14) which supports only one
> value of WordLength may implement the WordLength field in the
> DPX_BlockCtrl1 Register as Read-Only, returning the fixed value of
> WordLength in response to reads."

Interesting.

I think it's a spec issue that you want to bring to the MIPI Audio WG 
attention.

The note below says 'the DPx_BlockCtrl1 Register remains as Read-Write, 
but the value written to the Read-Only field is not used'

Ignoring a value and returning an error are two different behaviors indeed.

My recommendation would be to add a DisCo property stating the 
WordLength value can be used by the bus code but not written to the 
Slave device registers.

> 
> As WSA881x interfaces in PDM mode making the only field "WordLength"
> in DPX_BlockCtrl1" fixed and read-only. Behaviour of writing to this
> register on WSA881x soundwire slave with Qualcomm Soundwire Controller
> is throwing up an error. Not sure how other controllers deal with
> writing to readonly registers, but this patch provides a way to avoid
> writes to DPN_BlockCtrl1 register by providing a ro_blockctrl1_reg
> flag in struct sdw_port_runtime.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
> 
> I will send patch for WSA881x to include this change once this patch
> is accepted.
> 
>   drivers/soundwire/bus.h    |  2 ++
>   drivers/soundwire/stream.c | 17 ++++++++++-------
>   2 files changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.h b/drivers/soundwire/bus.h
> index 204204a26db8..791e8d14093e 100644
> --- a/drivers/soundwire/bus.h
> +++ b/drivers/soundwire/bus.h
> @@ -79,6 +79,7 @@ int sdw_find_col_index(int col);
>    * @num: Port number. For audio streams, valid port number ranges from
>    * [1,14]
>    * @ch_mask: Channel mask
> + * @ro_blockctrl1_reg: Read Only flag for DPN_BlockCtrl1 register
>    * @transport_params: Transport parameters
>    * @port_params: Port parameters
>    * @port_node: List node for Master or Slave port_list
> @@ -89,6 +90,7 @@ int sdw_find_col_index(int col);
>   struct sdw_port_runtime {
>   	int num;
>   	int ch_mask;
> +	bool ro_blockctrl1_reg;
>   	struct sdw_transport_params transport_params;
>   	struct sdw_port_params port_params;
>   	struct list_head port_node;
> diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
> index 00348d1fc606..4491643aeb4a 100644
> --- a/drivers/soundwire/stream.c
> +++ b/drivers/soundwire/stream.c
> @@ -167,13 +167,15 @@ static int sdw_program_slave_port_params(struct sdw_bus *bus,
>   		return ret;
>   	}
>   
> -	/* Program DPN_BlockCtrl1 register */
> -	ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
> -	if (ret < 0) {
> -		dev_err(&s_rt->slave->dev,
> -			"DPN_BlockCtrl1 register write failed for port %d\n",
> -			t_params->port_num);
> -		return ret;
> +	if (!p_rt->ro_blockctrl1_reg) {
> +		/* Program DPN_BlockCtrl1 register */
> +		ret = sdw_write(s_rt->slave, addr2, (p_params->bps - 1));
> +		if (ret < 0) {
> +			dev_err(&s_rt->slave->dev,
> +				"DPN_BlockCtrl1 register write failed for port %d\n",
> +				t_params->port_num);
> +			return ret;
> +		}
>   	}
>   
>   	/* Program DPN_SampleCtrl1 register */
> @@ -1195,6 +1197,7 @@ static struct sdw_port_runtime
>   
>   	p_rt->ch_mask = port_config[port_index].ch_mask;
>   	p_rt->num = port_config[port_index].num;
> +	p_rt->ro_blockctrl1_reg = port_config[port_index].ro_blockctrl1_reg;
>   
>   	return p_rt;
>   }
> 
