Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DF5C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 560E120768
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgHXCsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:48:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:19528 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbgHXCsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:48:40 -0400
IronPort-SDR: n9Dugi8/1XLCreM6P3CP0qZ/jcaNrEer9tlMkdFUIPKJbBpeQr9crZ5vRbqfVRFw3OwO4XIBAK
 MHSpVVsGi1PQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="135896561"
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="135896561"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2020 19:48:40 -0700
IronPort-SDR: QvQrd05CTCm6a18WSN5g52+fKEeZzJw+BZjybGfSwfSIY/837bNnl3ts3+SG+3Z8aXPqt68Nxs
 6o9jE1mGy/Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,347,1592895600"; 
   d="scan'208";a="402124727"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 23 Aug 2020 19:48:38 -0700
Cc:     baolu.lu@linux.intel.com
Subject: Re: [RESEND PATCH 4/5] iommu: intel: Drop kerneldoc marker from
 regular comment
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200819175345.20833-1-krzk@kernel.org>
 <20200819175345.20833-4-krzk@kernel.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <93184b50-d55c-b84a-7563-ffd28de3179e@linux.intel.com>
Date:   Mon, 24 Aug 2020 10:43:11 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200819175345.20833-4-krzk@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/20/20 1:53 AM, Krzysztof Kozlowski wrote:
> Fix W=1 compile warnings (invalid kerneldoc):
> 
>      drivers/iommu/intel/dmar.c:389: warning: Function parameter or member 'header' not described in 'dmar_parse_one_drhd'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Adjust the commit title to "iommu/vt-d: Drop kerneldoc marker from
regular comment",

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel/dmar.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> index 93e6345f3414..ba47edf03941 100644
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -380,7 +380,7 @@ dmar_find_dmaru(struct acpi_dmar_hardware_unit *drhd)
>   	return NULL;
>   }
>   
> -/**
> +/*
>    * dmar_parse_one_drhd - parses exactly one DMA remapping hardware definition
>    * structure which uniquely represent one DMA remapping hardware unit
>    * present in the platform
> 
