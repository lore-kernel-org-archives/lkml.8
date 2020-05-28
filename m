Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBB7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43F620776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 23:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391574AbgE1XOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 19:14:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:5243 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391565AbgE1XOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 19:14:51 -0400
IronPort-SDR: BStVdIGtePNH8u1nzpLDtBBL2YoSEpD1GYlWbFoWh8YZSDi6/uZNRFc6amLI+6x/zuptHdUcCf
 nUozDN6Qar5A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 16:14:50 -0700
IronPort-SDR: TvwL7DeSeSBwLFTQjbiZieoXFjg37VhxWHkb8w0qRIB5J8+Z8uLTQgBLmAcyNGfnDLDO3JhB3Q
 ocvCL6XsjVOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="292172452"
Received: from allen-box.sh.intel.com (HELO [10.239.159.139]) ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 28 May 2020 16:14:49 -0700
Cc:     baolu.lu@linux.intel.com, LKML <linux-kernel@vger.kernel.org>,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] iommu/vt-d: Fix compile warning
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1590689031-79318-1-git-send-email-jacob.jun.pan@linux.intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <f3d09e3f-ca4d-3307-21e9-f9b446642517@linux.intel.com>
Date:   Fri, 29 May 2020 07:11:05 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1590689031-79318-1-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/20 2:03 AM, Jacob Pan wrote:
> Make intel_svm_unbind_mm() a static function.
> 
> Fixes: 064a57d7ddfc ("iommu/vt-d: Replace intel SVM APIs with generic
> SVA APIs")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/intel-svm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 3c190c3b90b9..d386853121a2 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -597,7 +597,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
>   }
>   
>   /* Caller must hold pasid_mutex */
> -int intel_svm_unbind_mm(struct device *dev, int pasid)
> +static int intel_svm_unbind_mm(struct device *dev, int pasid)
>   {
>   	struct intel_svm_dev *sdev;
>   	struct intel_iommu *iommu;
> 
