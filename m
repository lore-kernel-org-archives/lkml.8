Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 167C2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:14:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76C32081A
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgFZBOY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:14:24 -0400
Received: from mga02.intel.com ([134.134.136.20]:36657 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgFZBOX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 21:14:23 -0400
IronPort-SDR: TK1kaDWzE3gvlF7lkTDpReWfU1YkQmty8+AJGyGy3VJvVHSQYFe6um7q1JBaKopl3gcjUhFwXc
 MCavHLBRibkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="133555691"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="133555691"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 18:14:23 -0700
IronPort-SDR: 55HZYR1RCQG97/JMJ/shb9Vxs8ptbAtPjU7r1uxpVAth+m1W/L1ou9OG0tyKHWXHM+tw1MAJGk
 u2IrnMiqR5Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="385632895"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.249.172.117]) ([10.249.172.117])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2020 18:14:18 -0700
Cc:     baolu.lu@linux.intel.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v4 02/12] iommu/vt-d: Change flags type to unsigned int in
 binding mm
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradeed.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
References: <1593116242-31507-1-git-send-email-fenghua.yu@intel.com>
 <1593116242-31507-3-git-send-email-fenghua.yu@intel.com>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <888dc4b1-663e-3c62-c5dd-34167382aec1@linux.intel.com>
Date:   Fri, 26 Jun 2020 09:14:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593116242-31507-3-git-send-email-fenghua.yu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 2020/6/26 4:17, Fenghua Yu wrote:
> "flags" passed to intel_svm_bind_mm() is a bit mask and should be
> defined as "unsigned int" instead of "int".
> 
> Change its type to "unsigned int".

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> 
> Suggested-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> ---
> v2:
> - Add this new patch per Thomas' comment.
> 
>   drivers/iommu/intel/svm.c   | 7 ++++---
>   include/linux/intel-iommu.h | 2 +-
>   2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 778089d198eb..8a0cf2f0dd54 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -427,7 +427,8 @@ int intel_svm_unbind_gpasid(struct device *dev, u32 pasid)
>   
>   /* Caller must hold pasid_mutex, mm reference */
>   static int
> -intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
> +intel_svm_bind_mm(struct device *dev, unsigned int flags,
> +		  struct svm_dev_ops *ops,
>   		  struct mm_struct *mm, struct intel_svm_dev **sd)
>   {
>   	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> @@ -954,7 +955,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
>   {
>   	struct iommu_sva *sva = ERR_PTR(-EINVAL);
>   	struct intel_svm_dev *sdev = NULL;
> -	int flags = 0;
> +	unsigned int flags = 0;
>   	int ret;
>   
>   	/*
> @@ -963,7 +964,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
>   	 * and intel_svm etc.
>   	 */
>   	if (drvdata)
> -		flags = *(int *)drvdata;
> +		flags = *(unsigned int *)drvdata;
>   	mutex_lock(&pasid_mutex);
>   	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
>   	if (ret)
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index 314a95870e47..4d20f93a5e2d 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -759,7 +759,7 @@ struct intel_svm {
>   	struct mm_struct *mm;
>   
>   	struct intel_iommu *iommu;
> -	int flags;
> +	unsigned int flags;
>   	u32 pasid;
>   	int gpasid; /* In case that guest PASID is different from host PASID */
>   	struct list_head devs;
> 
