Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69B0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A974B2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHXPXD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:23:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:34492 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgHXPUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:20:02 -0400
IronPort-SDR: BHCzELPn3sQja4Eo/UmHVIF4+Lm+MojGH+pDu4uI8zbZFI9IDUkmHpVvS91lCNgQPjiLNnc4XY
 fSwRTPdl8+GQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="217457163"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="217457163"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 08:19:51 -0700
IronPort-SDR: 9P7M4eWmZxuoJaKnYyUUaMLJAsQgat8mmevfLoa+j3rkJJ9TKkyb/0L9R/+VHh6WHX22THXMOM
 9qGQIVoa1AYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; 
   d="scan'208";a="312222974"
Received: from skuppusw-mobl5.amr.corp.intel.com (HELO [10.209.37.204]) ([10.209.37.204])
  by orsmga002.jf.intel.com with ESMTP; 24 Aug 2020 08:19:50 -0700
Subject: Re: [PATCH] lib: pldmfw: delete duplicated words
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
References: <20200823040502.26040-1-rdunlap@infradead.org>
From:   Jacob Keller <jacob.e.keller@intel.com>
Organization: Intel Corporation
Message-ID: <bccf3817-dd89-0a7d-8e4c-ce977caf1ea9@intel.com>
Date:   Mon, 24 Aug 2020 08:19:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200823040502.26040-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/22/2020 9:05 PM, Randy Dunlap wrote:
> Drop the repeated word "header".
> 

Thanks for fixing this!

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jacob Keller <jacob.e.keller@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> ---
>  lib/pldmfw/pldmfw.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200730.orig/lib/pldmfw/pldmfw.c
> +++ linux-next-20200730/lib/pldmfw/pldmfw.c
> @@ -517,7 +517,7 @@ static int pldm_verify_header_crc(struct
>  	u32 calculated_crc;
>  	size_t length;
>  
> -	/* Calculate the 32-bit CRC of the header header contents up to but
> +	/* Calculate the 32-bit CRC of the header contents up to but
>  	 * not including the checksum. Note that the Linux crc32_le function
>  	 * does not perform an expected final XOR.
>  	 */
> 
