Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4A8AC3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA75920674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgBDGLs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:11:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:38538 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgBDGLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:11:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Feb 2020 22:11:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,398,1574150400"; 
   d="scan'208";a="254308213"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.209.105]) ([10.254.209.105])
  by fmsmga004.fm.intel.com with ESMTP; 03 Feb 2020 22:11:46 -0800
Subject: Re: [PATCH] iommu/intel-iommu: set as DUMMY_DEVICE_DOMAIN_INFO if no
 IOMMU
To:     Jian-Hong Pan <jian-hong@endlessm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
References: <20200203091009.196658-1-jian-hong@endlessm.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <aab0948d-c6a3-baa1-7343-f18c936d662d@linux.intel.com>
Date:   Tue, 4 Feb 2020 14:11:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203091009.196658-1-jian-hong@endlessm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/2/3 17:10, Jian-Hong Pan wrote:
> If the device has no IOMMU, it still invokes iommu_need_mapping during
> intel_alloc_coherent. However, iommu_need_mapping can only check the
> device is DUMMY_DEVICE_DOMAIN_INFO or not. This patch marks the device
> is a DUMMY_DEVICE_DOMAIN_INFO if the device has no IOMMU.
> 
> Signed-off-by: Jian-Hong Pan <jian-hong@endlessm.com>
> ---
>   drivers/iommu/intel-iommu.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index 35a4a3abedc6..878bc986a015 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -5612,8 +5612,10 @@ static int intel_iommu_add_device(struct device *dev)
>   	int ret;
>   
>   	iommu = device_to_iommu(dev, &bus, &devfn);
> -	if (!iommu)
> +	if (!iommu) {
> +		dev->archdata.iommu = DUMMY_DEVICE_DOMAIN_INFO;

Is this a DMA capable device? I am afraid some real bugs might be
covered up if we marking the device as IOMMU dummy here.

Best regards,
baolu

>   		return -ENODEV;
> +	}
>   
>   	iommu_device_link(&iommu->iommu, dev);
>   
> 
