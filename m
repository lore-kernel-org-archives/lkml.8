Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC21EC47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C567E20707
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEDTmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:42:52 -0400
Received: from smtprelay0170.hostedemail.com ([216.40.44.170]:45608 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726111AbgEDTmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:42:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id B7990180AA4EE;
        Mon,  4 May 2020 19:42:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cream19_35bf089570f11
X-Filterd-Recvd-Size: 3477
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 May 2020 19:42:49 +0000 (UTC)
Message-ID: <695919ca3010be4f2087c62530cf7b6ee4e01971.camel@perches.com>
Subject: Re: [PATCH 5.6 61/73] iommu/vt-d: Use right Kconfig option name
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sanjay K <sanjay.k.kumar@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu <iommu@lists.linux-foundation.org>
Date:   Mon, 04 May 2020 12:42:48 -0700
In-Reply-To: <20200504165509.860520707@linuxfoundation.org>
References: <20200504165501.781878940@linuxfoundation.org>
         <20200504165509.860520707@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-04 at 19:58 +0200, Greg Kroah-Hartman wrote:
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> commit ba61c3da00f4a5bf8805aeca1ba5ac3c9bd82e96 upstream.
> 
> The CONFIG_ prefix should be added in the code.
> 
> Fixes: 046182525db61 ("iommu/vt-d: Add Kconfig option to enable/disable scalable mode")
> Reported-and-tested-by: Kumar, Sanjay K <sanjay.k.kumar@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Link: https://lore.kernel.org/r/20200501072427.14265-1-baolu.lu@linux.intel.com
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/iommu/intel-iommu.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -371,11 +371,11 @@ int dmar_disabled = 0;
>  int dmar_disabled = 1;
>  #endif /* CONFIG_INTEL_IOMMU_DEFAULT_ON */
>  
> -#ifdef INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
> +#ifdef CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
>  int intel_iommu_sm = 1;
>  #else
>  int intel_iommu_sm;
> -#endif /* INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */
> +#endif /* CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */

Perhaps simpler as

int intel_iommu_sm = IS_BUILTIN(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);

So perhaps:
---
 drivers/iommu/intel-iommu.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 0182cff2c7ac..ab8552c48391 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -365,17 +365,8 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
 static phys_addr_t intel_iommu_iova_to_phys(struct iommu_domain *domain,
 					    dma_addr_t iova);
 
-#ifdef CONFIG_INTEL_IOMMU_DEFAULT_ON
-int dmar_disabled = 0;
-#else
-int dmar_disabled = 1;
-#endif /* CONFIG_INTEL_IOMMU_DEFAULT_ON */
-
-#ifdef CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON
-int intel_iommu_sm = 1;
-#else
-int intel_iommu_sm;
-#endif /* CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON */
+int dmar_disabled = !IS_BUILTIN(CONFIG_INTEL_IOMMU_DEFAULT_ON);
+int intel_iommu_sm = IS_BUILTIN(CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON);
 
 int intel_iommu_enabled = 0;
 EXPORT_SYMBOL_GPL(intel_iommu_enabled);

