Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C939DC352A4
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96AEA20708
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 00:24:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgBKAY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 19:24:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:19108 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727496AbgBKAY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 19:24:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 16:24:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,426,1574150400"; 
   d="scan'208";a="227343794"
Received: from yxu42x-mobl.ccr.corp.intel.com (HELO [10.254.210.203]) ([10.254.210.203])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2020 16:24:25 -0800
Subject: Re: [PATCH] iommu/vt-d: Fix compile warning from intel-svm.h
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <jroedel@suse.de>, CQ Tang <cq.tang@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-kernel@vger.kernel.org
References: <20200210093656.8961-1-joro@8bytes.org>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <723094c4-1c4c-7d52-d737-d0f201e634d6@linux.intel.com>
Date:   Tue, 11 Feb 2020 08:24:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200210093656.8961-1-joro@8bytes.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

On 2020/2/10 17:36, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The intel_svm_is_pasid_valid() needs to be marked inline, otherwise it
> causes the compile warning below:
> 
>    CC [M]  drivers/dma/idxd/cdev.o
> In file included from drivers/dma/idxd/cdev.c:9:0:
> ./include/linux/intel-svm.h:125:12: warning: ‘intel_svm_is_pasid_valid’ defined but not used [-Wunused-function]
>   static int intel_svm_is_pasid_valid(struct device *dev, int pasid)
>              ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> Reported-by: Borislav Petkov <bp@alien8.de>
> Fixes: 15060aba71711 ('iommu/vt-d: Helper function to query if a pasid has any active users')
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   include/linux/intel-svm.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/intel-svm.h b/include/linux/intel-svm.h
> index 94f047a8a845..d7c403d0dd27 100644
> --- a/include/linux/intel-svm.h
> +++ b/include/linux/intel-svm.h
> @@ -122,7 +122,7 @@ static inline int intel_svm_unbind_mm(struct device *dev, int pasid)
>   	BUG();
>   }
>   
> -static int intel_svm_is_pasid_valid(struct device *dev, int pasid)
> +static inline int intel_svm_is_pasid_valid(struct device *dev, int pasid)
>   {
>   	return -EINVAL;
>   }
> 
