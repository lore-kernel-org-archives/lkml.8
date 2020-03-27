Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56249C2D0E8
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 363A720714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:42:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgC0JmD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:42:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:40233 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbgC0JmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:42:03 -0400
IronPort-SDR: L/bvx8oHHSS2zKOk6pZlTdljupUYYTpHVltGMfbPyE5U1HE7ZzZDOo8i3Icn9dG1gw12cFJVsk
 mqWkjrvEmL0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2020 02:42:02 -0700
IronPort-SDR: KQao65mOFi7EgkiDDxwh0udbLC5apBGXs2lMo4Yg7em70OoLWq7BNZhQQHtkaUhSOuc1wZ7ISs
 JOC6GQbqk+kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,311,1580803200"; 
   d="scan'208";a="271515549"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2020 02:42:02 -0700
Received: from fmsmsx114.amr.corp.intel.com (10.18.116.8) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 02:42:01 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX114.amr.corp.intel.com (10.18.116.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 27 Mar 2020 02:42:01 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.206]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.96]) with mapi id 14.03.0439.000;
 Fri, 27 Mar 2020 17:41:57 +0800
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
Subject: RE: [PATCH 05/10] iommu/ioasid: Create an IOASID set for host SVA
 use
Thread-Topic: [PATCH 05/10] iommu/ioasid: Create an IOASID set for host SVA
 use
Thread-Index: AQHWAs3KC1709AUDMEKcaU76snqwOKhcMJxw
Date:   Fri, 27 Mar 2020 09:41:55 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7ED4DA@SHSMSX104.ccr.corp.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1585158931-1825-6-git-send-email-jacob.jun.pan@linux.intel.com>
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
> Bare metal SVA allocates IOASIDs for native process addresses. This
> should be separated from VM allocated IOASIDs thus under its own set.

A curious question. Now bare metal SVA uses the system set and guest
SVA uses dynamically-created set. Then do we still allow ioasid_alloc
with a NULL set pointer?

> 
> This patch creates a system IOASID set with its quota set to PID_MAX.
> This is a reasonable default in that SVM capable devices can only bind
> to limited user processes.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/iommu/intel-iommu.c | 8 +++++++-
>  drivers/iommu/ioasid.c      | 9 +++++++++
>  include/linux/ioasid.h      | 9 +++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> index ec3fc121744a..af7a1ef7b31e 100644
> --- a/drivers/iommu/intel-iommu.c
> +++ b/drivers/iommu/intel-iommu.c
> @@ -3511,8 +3511,14 @@ static int __init init_dmars(void)
>  		goto free_iommu;
> 
>  	/* PASID is needed for scalable mode irrespective to SVM */
> -	if (intel_iommu_sm)
> +	if (intel_iommu_sm) {
>  		ioasid_install_capacity(intel_pasid_max_id);
> +		/* We should not run out of IOASIDs at boot */
> +		if (ioasid_alloc_system_set(PID_MAX_DEFAULT)) {
> +			pr_err("Failed to enable host PASID allocator\n");
> +			intel_iommu_sm = 0;
> +		}
> +	}
> 
>  	/*
>  	 * for each drhd
> diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
> index 6265d2dbbced..9135af171a7c 100644
> --- a/drivers/iommu/ioasid.c
> +++ b/drivers/iommu/ioasid.c
> @@ -39,6 +39,9 @@ struct ioasid_data {
>  static ioasid_t ioasid_capacity;
>  static ioasid_t ioasid_capacity_avail;
> 
> +int system_ioasid_sid;
> +static DECLARE_IOASID_SET(system_ioasid);
> +
>  /* System capacity can only be set once */
>  void ioasid_install_capacity(ioasid_t total)
>  {
> @@ -51,6 +54,12 @@ void ioasid_install_capacity(ioasid_t total)
>  }
>  EXPORT_SYMBOL_GPL(ioasid_install_capacity);
> 
> +int ioasid_alloc_system_set(int quota)
> +{
> +	return ioasid_alloc_set(&system_ioasid, quota, &system_ioasid_sid);
> +}
> +EXPORT_SYMBOL_GPL(ioasid_alloc_system_set);
> +
>  /*
>   * struct ioasid_allocator_data - Internal data structure to hold information
>   * about an allocator. There are two types of allocators:
> diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
> index 8c82d2625671..097b1cc043a3 100644
> --- a/include/linux/ioasid.h
> +++ b/include/linux/ioasid.h
> @@ -29,6 +29,9 @@ struct ioasid_allocator_ops {
>  	void *pdata;
>  };
> 
> +/* Shared IOASID set for reserved for host system use */
> +extern int system_ioasid_sid;
> +
>  #define DECLARE_IOASID_SET(name) struct ioasid_set name = { 0 }
> 
>  #if IS_ENABLED(CONFIG_IOASID)
> @@ -41,6 +44,7 @@ int ioasid_register_allocator(struct ioasid_allocator_ops
> *allocator);
>  void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
>  int ioasid_attach_data(ioasid_t ioasid, void *data);
>  void ioasid_install_capacity(ioasid_t total);
> +int ioasid_alloc_system_set(int quota);
>  int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
>  void ioasid_free_set(int sid, bool destroy_set);
>  int ioasid_find_sid(ioasid_t ioasid);
> @@ -88,5 +92,10 @@ static inline void ioasid_install_capacity(ioasid_t total)
>  {
>  }
> 
> +static inline int ioasid_alloc_system_set(int quota)
> +{
> +	return -ENOTSUPP;
> +}
> +
>  #endif /* CONFIG_IOASID */
>  #endif /* __LINUX_IOASID_H */
> --
> 2.7.4

