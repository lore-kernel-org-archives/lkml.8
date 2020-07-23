Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D326C433EA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5119120714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgGWQds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:33:48 -0400
Received: from mga07.intel.com ([134.134.136.100]:47545 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729861AbgGWQdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:33:47 -0400
IronPort-SDR: SPLolfwaW0pMePHFimKVbg68ckSN4X/Ln2o13EOYCroEEs6BSGaF8nxXKmtR+TO9OsaBgxlA2W
 dbJtKYRkYv5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="215174077"
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="215174077"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 09:33:47 -0700
IronPort-SDR: uxbbcmOH8X6UoRMwUM2pCJBbvc29r6y1UNtzbJh7tJMnjPBu6igJrwKusApscKuKWGDc4/b+H0
 Bt+N/ONNiU5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,387,1589266800"; 
   d="scan'208";a="432795769"
Received: from tthayer-hp-z620.an.intel.com (HELO [10.122.105.146]) ([10.122.105.146])
  by orsmga004.jf.intel.com with ESMTP; 23 Jul 2020 09:33:45 -0700
Reply-To: thor.thayer@linux.intel.com
Subject: Re: [PATCH v4 03/10] net: eth: altera: fix altera_dmaops declaration
To:     "Ooi, Joyce" <joyce.ooi@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dalon Westergreen <dalon.westergreen@linux.intel.com>,
        Tan Ley Foon <ley.foon.tan@intel.com>,
        See Chin Liang <chin.liang.see@intel.com>,
        Dinh Nguyen <dinh.nguyen@intel.com>,
        Dalon Westergreen <dalon.westergreen@intel.com>
References: <20200708072401.169150-1-joyce.ooi@intel.com>
 <20200708072401.169150-4-joyce.ooi@intel.com>
From:   Thor Thayer <thor.thayer@linux.intel.com>
Message-ID: <6804ff2a-7322-4c77-cae0-9ed7837b7afb@linux.intel.com>
Date:   Thu, 23 Jul 2020 11:33:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200708072401.169150-4-joyce.ooi@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/8/20 2:23 AM, Ooi, Joyce wrote:
> From: Dalon Westergreen <dalon.westergreen@intel.com>
> 
> The declaration of struct altera_dmaops does not have
> identifier names.  Add identifier names to confrom with
> required coding styles.
> 
> Signed-off-by: Dalon Westergreen <dalon.westergreen@intel.com>
> Signed-off-by: Joyce Ooi <joyce.ooi@intel.com>
> ---
> v2: no change
> v3: no change
> v4: no change
> ---
>   drivers/net/ethernet/altera/altera_tse.h | 30 ++++++++++++++++--------------
>   1 file changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/net/ethernet/altera/altera_tse.h b/drivers/net/ethernet/altera/altera_tse.h
> index f17acfb579a0..7d0c98fc103e 100644
> --- a/drivers/net/ethernet/altera/altera_tse.h
> +++ b/drivers/net/ethernet/altera/altera_tse.h
> @@ -385,20 +385,22 @@ struct altera_tse_private;
>   struct altera_dmaops {
>   	int altera_dtype;
>   	int dmamask;
> -	void (*reset_dma)(struct altera_tse_private *);
> -	void (*enable_txirq)(struct altera_tse_private *);
> -	void (*enable_rxirq)(struct altera_tse_private *);
> -	void (*disable_txirq)(struct altera_tse_private *);
> -	void (*disable_rxirq)(struct altera_tse_private *);
> -	void (*clear_txirq)(struct altera_tse_private *);
> -	void (*clear_rxirq)(struct altera_tse_private *);
> -	int (*tx_buffer)(struct altera_tse_private *, struct tse_buffer *);
> -	u32 (*tx_completions)(struct altera_tse_private *);
> -	void (*add_rx_desc)(struct altera_tse_private *, struct tse_buffer *);
> -	u32 (*get_rx_status)(struct altera_tse_private *);
> -	int (*init_dma)(struct altera_tse_private *);
> -	void (*uninit_dma)(struct altera_tse_private *);
> -	void (*start_rxdma)(struct altera_tse_private *);
> +	void (*reset_dma)(struct altera_tse_private *priv);
> +	void (*enable_txirq)(struct altera_tse_private *priv);
> +	void (*enable_rxirq)(struct altera_tse_private *priv);
> +	void (*disable_txirq)(struct altera_tse_private *priv);
> +	void (*disable_rxirq)(struct altera_tse_private *priv);
> +	void (*clear_txirq)(struct altera_tse_private *priv);
> +	void (*clear_rxirq)(struct altera_tse_private *priv);
> +	int (*tx_buffer)(struct altera_tse_private *priv,
> +			 struct tse_buffer *buffer);
> +	u32 (*tx_completions)(struct altera_tse_private *priv);
> +	void (*add_rx_desc)(struct altera_tse_private *priv,
> +			    struct tse_buffer *buffer);
> +	u32 (*get_rx_status)(struct altera_tse_private *priv);
> +	int (*init_dma)(struct altera_tse_private *priv);
> +	void (*uninit_dma)(struct altera_tse_private *priv);
> +	void (*start_rxdma)(struct altera_tse_private *priv);
>   };
>   
>   /* This structure is private to each device.
> 
Reviewed-by: Thor Thayer <thor.thayer@linux.intel.com>
