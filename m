Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A8CC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1036920714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 08:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgC0IH0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 04:07:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:18552 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgC0IHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 04:07:25 -0400
IronPort-SDR: L9rA6HgRAvFOnKaVEgaoJQVh1BFxUVyalC3oPtDLi4egGdymwcF3X6GvWnccTJM10afgTlaez+
 SqBkE1OVwXjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 01:07:24 -0700
IronPort-SDR: E6GPhtxZBGJH9fdG44S+kJLJlw9eUJMKf8mzJ5FzoBDo8v3PmenRGBKsaUXrAEhI/scpDqg+Po
 n6YdsqRY2FCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="266138292"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga002.jf.intel.com with ESMTP; 27 Mar 2020 01:07:24 -0700
Received: from fmsmsx162.amr.corp.intel.com (10.18.125.71) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 01:07:24 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx162.amr.corp.intel.com (10.18.125.71) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 01:07:23 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.145]) with mapi id 14.03.0439.000;
 Fri, 27 Mar 2020 16:07:20 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH 01/10] iommu/ioasid: Introduce system-wide capacity
Thread-Topic: [PATCH 01/10] iommu/ioasid: Introduce system-wide capacity
Thread-Index: AQHWAs3IIVvMnE2WckG9v0pL1BBdSqhcF3Wg
Date:   Fri, 27 Mar 2020 08:07:20 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED264@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-2-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1585158931-1825-2-git-send-email-jacob.jun.pan@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Sent: Thursday, March 26, 2020 1:55 AM
> 
> IOASID is a limited system-wide resource that can be allocated at
> runtime. This limitation can be enumerated during boot. For example, on
> x86 platforms, PCI Process Address Space ID (PASID) allocation uses
> IOASID service. The number of supported PASID bits are enumerated by
> extended capability register as defined in the VT-d spec.
> 
> This patch adds a helper to set the system capacity, it expected to be
> set during boot prior to any allocation request.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/ioasid.c | 15 +++++++++++++++
>  include/linux/ioasid.h |  5 ++++-
>  2 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 0f8dd377aada..4026e52855b9 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -17,6 +17,21 @@ struct ioasid_data {
>  	struct rcu_head rcu;
>  };
> 
> +static ioasid_t ioasid_capacity;
> +static ioasid_t ioasid_capacity_avail;
> +
> +/* System capacity can only be set once */
> +void ioasid_install_capacity(ioasid_t total)
> +{
> +	if (ioasid_capacity) {
> +		pr_warn("IOASID capacity already set at %d\n",
> ioasid_capacity);
> +		return;
> +	}
> +
> +	ioasid_capacity = ioasid_capacity_avail = total;
> +}
> +EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> +

From all the texts in this patch, looks ioasid_set_capacity might be
a better name?

>  /*
>   * struct ioasid_allocator_data - Internal data structure to hold information
>   * about an allocator. There are two types of allocators:
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 6f000d7a0ddc..9711fa0dc357 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -40,7 +40,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
>  int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_set_data(ioasid_t ioasid, void *data);
> -
> +void ioasid_install_capacity(ioasid_t total);
>  #else /* !CONFIG_IOASID */
>  static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
>  				    ioasid_t max, void *private)
> @@ -72,5 +72,8 @@ static inline int ioasid_set_data(ioasid_t ioasid, void
> *data)
>  	return -ENOTSUPP;
>  }
> 
> +static inline void ioasid_install_capacity(ioasid_t total)
> +{
> +}
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> --
> 2.7.4

