Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLACK,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59178C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29EE120814
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 23:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730095AbgEUXkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 19:40:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:44255 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729827AbgEUXkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 19:40:53 -0400
IronPort-SDR: CMP/rHqsP4yxK01NwUrghWpJLhMDwgVzMBmJcCnCFvFUfypSU62o6uL6ccRX9F89hn+bP5UbL0
 g9cKl4qoyoBg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2020 16:40:52 -0700
IronPort-SDR: oMV6pdOLmBBvp2tg/0s2cHXMXmtpef4jgFMpno2H4JRWJDg9h3nQBjoD400muqIm8TlxWhzOzA
 IvQNURBpQYgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,419,1583222400"; 
   d="scan'208";a="283229047"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by orsmga002.jf.intel.com with ESMTP; 21 May 2020 16:40:49 -0700
Cc:     baolu.lu@linux.intel.com, jacob.jun.pan@linux.intel.com,
        yi.l.liu@intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/vt-d: fix a GCC warning
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de
References: <20200521215030.16938-1-cai@lca.pw>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <27cf90e4-57bc-38da-fa30-69244f006f63@linux.intel.com>
Date:   Fri, 22 May 2020 07:37:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521215030.16938-1-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

Thanks!

On 5/22/20 5:50 AM, Qian Cai wrote:
> The commit 6ee1b77ba3ac ("iommu/vt-d: Add svm/sva invalidate function")
> introduced a GCC warning,
> 
> drivers/iommu/intel-iommu.c:5330:1: warning: 'static' is not at beginning of
> declaration [-Wold-style-declaration]
>   const static int
>   ^~~~~
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Fixes: 6ee1b77ba3ac0 ("iommu/vt-d: Add svm/sva invalidate function")
Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index f75d7d9c231f..ff5a30a94679 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5327,7 +5327,7 @@ static void intel_iommu_aux_detach_device(struct iommu_domain *domain,
>    * [IOMMU_CACHE_INV_TYPE_IOTLB][IOMMU_INV_GRANU_ADDR]
>    */
>   
> -const static int
> +static const int
>   inv_type_granu_table[IOMMU_CACHE_INV_TYPE_NR][IOMMU_INV_GRANU_NR] = {
>   	/*
>   	 * PASID based IOTLB invalidation: PASID selective (per PASID),
> 
