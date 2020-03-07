Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339C0C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 11:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 105952070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 11:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgCGLxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 06:53:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:37913 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgCGLxI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 06:53:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Mar 2020 03:53:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,525,1574150400"; 
   d="scan'208";a="388090759"
Received: from blu2-mobl3.ccr.corp.intel.com (HELO [10.254.211.93]) ([10.254.211.93])
  by orsmga004.jf.intel.com with ESMTP; 07 Mar 2020 03:53:06 -0800
Cc:     baolu.lu@linux.intel.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/dmar: silence RCU-list debugging warnings
To:     Qian Cai <cai@lca.pw>, jroedel@suse.de
References: <1583439302-11393-1-git-send-email-cai@lca.pw>
From:   Lu Baolu <baolu.lu@linux.intel.com>
Message-ID: <e70ebe24-d3cb-79c7-9104-f0c3a5b62918@linux.intel.com>
Date:   Sat, 7 Mar 2020 19:53:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1583439302-11393-1-git-send-email-cai@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020/3/6 4:15, Qian Cai wrote:
> Similar to the commit 02d715b4a818 ("iommu/vt-d: Fix RCU list debugging
> warnings"), there are several other places that call
> list_for_each_entry_rcu() outside of an RCU read side critical section
> but with dmar_global_lock held. Silence those false positives as well.
> 
>   drivers/iommu/intel-iommu.c:4288 RCU-list traversed in non-reader section!!
>   1 lock held by swapper/0/1:
>    #0: ffffffff935892c8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x1ad/0xb97
> 
>   drivers/iommu/dmar.c:366 RCU-list traversed in non-reader section!!
>   1 lock held by swapper/0/1:
>    #0: ffffffff935892c8 (dmar_global_lock){+.+.}, at: intel_iommu_init+0x125/0xb97
> 
>   drivers/iommu/intel-iommu.c:5057 RCU-list traversed in non-reader section!!
>   1 lock held by swapper/0/1:
>    #0: ffffffffa71892c8 (dmar_global_lock){++++}, at: intel_iommu_init+0x61a/0xb13
> 
> Signed-off-by: Qian Cai <cai@lca.pw>


Thanks for the fix.

Acked-by: Lu Baolu <baolu.lu@linux.intel.com>

Best regards,
baolu

> ---
>   drivers/iommu/dmar.c | 3 ++-
>   include/linux/dmar.h | 6 ++++--
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index 071bb42bbbc5..7b16c4db40b4 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -363,7 +363,8 @@ static int dmar_pci_bus_notifier(struct notifier_block *nb,
>   {
>   	struct dmar_drhd_unit *dmaru;
>   
> -	list_for_each_entry_rcu(dmaru, &dmar_drhd_units, list)
> +	list_for_each_entry_rcu(dmaru, &dmar_drhd_units, list,
> +				dmar_rcu_check())
>   		if (dmaru->segment == drhd->segment &&
>   		    dmaru->reg_base_addr == drhd->address)
>   			return dmaru;
> diff --git a/include/linux/dmar.h b/include/linux/dmar.h
> index 712be8bc6a7c..d7bf029df737 100644
> --- a/include/linux/dmar.h
> +++ b/include/linux/dmar.h
> @@ -74,11 +74,13 @@ struct dmar_pci_notify_info {
>   				dmar_rcu_check())
>   
>   #define for_each_active_drhd_unit(drhd)					\
> -	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
> +	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
> +				dmar_rcu_check())			\
>   		if (drhd->ignored) {} else
>   
>   #define for_each_active_iommu(i, drhd)					\
> -	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list)		\
> +	list_for_each_entry_rcu(drhd, &dmar_drhd_units, list,		\
> +				dmar_rcu_check())			\
>   		if (i=drhd->iommu, drhd->ignored) {} else
>   
>   #define for_each_iommu(i, drhd)						\
> 
