Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0ABC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C38420717
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 10:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgC1KSw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 06:18:52 -0400
Received: from mga03.intel.com ([134.134.136.65]:48320 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbgC1KSv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 06:18:51 -0400
IronPort-SDR: CDetSSF5pgytrTelfsbOuOfJKVpi6NA0xvpXIL0yoFI2OsofkHsu8FUAwwilTRTNAp3Dha+WX0
 71AjI7aadXPQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2020 03:18:51 -0700
IronPort-SDR: 6TLXjdCgJm76oiGhIztihN1Zcus13c+IQlK4rKUh+9hyDIydlM9113zuPmVNdIMPJwq2tskEHU
 kNL4eCVKi8Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,316,1580803200"; 
   d="scan'208";a="248132943"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga003.jf.intel.com with ESMTP; 28 Mar 2020 03:18:50 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 28 Mar 2020 03:18:50 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 28 Mar 2020 03:18:49 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 28 Mar 2020 03:18:49 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.191]) with mapi id 14.03.0439.000;
 Sat, 28 Mar 2020 18:08:52 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        "Alex Williamson" <alex.williamson@redhat.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>
Subject: RE: [PATCH V10 10/11] iommu/vt-d: Enlightened PASID allocation
Thread-Topic: [PATCH V10 10/11] iommu/vt-d: Enlightened PASID allocation
Thread-Index: AQHV/w5iiZKRdi7L1UuU5LlV/2W3nKhd0n8A
Date:   Sat, 28 Mar 2020 10:08:52 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FA10F@SHSMSX104.ccr.corp.intel.com>
References: <1584746861-76386-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1584746861-76386-11-git-send-email-jacob.jun.pan@linux.intel.com>
In-Reply-To: <1584746861-76386-11-git-send-email-jacob.jun.pan@linux.intel.com>
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
> Sent: Saturday, March 21, 2020 7:28 AM
> 
> From: Lu Baolu <baolu.lu@linux.intel.com>
> 
> Enabling IOMMU in a guest requires communication with the host
> driver for certain aspects. Use of PASID ID to enable Shared Virtual
> Addressing (SVA) requires managing PASID's in the host. VT-d 3.0 spec
> provides a Virtual Command Register (VCMD) to facilitate this.
> Writes to this register in the guest are trapped by QEMU which
> proxies the call to the host driver.

Qemu -> vIOMMU

> 
> This virtual command interface consists of a capability register,
> a virtual command register, and a virtual response register. Refer
> to section 10.4.42, 10.4.43, 10.4.44 for more information.
> 
> This patch adds the enlightened PASID allocation/free interfaces
> via the virtual command interface.
> 
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>  drivers/iommu/intel-pasid.c | 57
> +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/iommu/intel-pasid.h | 13 ++++++++++-
>  include/linux/intel-iommu.h |  1 +
>  3 files changed, 70 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 9f6d07410722..e87ad67aad36 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -27,6 +27,63 @@
>  static DEFINE_SPINLOCK(pasid_lock);
>  u32 intel_pasid_max_id = PASID_MAX;
> 
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
> +{
> +	unsigned long flags;
> +	u8 status_code;
> +	int ret = 0;
> +	u64 res;
> +
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +	dmar_writeq(iommu->reg + DMAR_VCMD_REG,
> VCMD_CMD_ALLOC);
> +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> +		      !(res & VCMD_VRSP_IP), res);
> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +
> +	status_code = VCMD_VRSP_SC(res);
> +	switch (status_code) {
> +	case VCMD_VRSP_SC_SUCCESS:
> +		*pasid = VCMD_VRSP_RESULT_PASID(res);
> +		break;
> +	case VCMD_VRSP_SC_NO_PASID_AVAIL:
> +		pr_info("IOMMU: %s: No PASID available\n", iommu->name);
> +		ret = -ENOSPC;
> +		break;
> +	default:
> +		ret = -ENODEV;
> +		pr_warn("IOMMU: %s: Unexpected error code %d\n",
> +			iommu->name, status_code);
> +	}
> +
> +	return ret;
> +}
> +
> +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
> +{
> +	unsigned long flags;
> +	u8 status_code;
> +	u64 res;
> +
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
> +	dmar_writeq(iommu->reg + DMAR_VCMD_REG,
> +		    VCMD_CMD_OPERAND(pasid) | VCMD_CMD_FREE);
> +	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
> +		      !(res & VCMD_VRSP_IP), res);
> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +
> +	status_code = VCMD_VRSP_SC(res);
> +	switch (status_code) {
> +	case VCMD_VRSP_SC_SUCCESS:
> +		break;
> +	case VCMD_VRSP_SC_INVALID_PASID:
> +		pr_info("IOMMU: %s: Invalid PASID\n", iommu->name);
> +		break;
> +	default:
> +		pr_warn("IOMMU: %s: Unexpected error code %d\n",
> +			iommu->name, status_code);
> +	}
> +}
> +
>  /*
>   * Per device pasid table management:
>   */
> diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
> index 698015ee3f04..cd3d63f3e936 100644
> --- a/drivers/iommu/intel-pasid.h
> +++ b/drivers/iommu/intel-pasid.h
> @@ -23,6 +23,16 @@
>  #define is_pasid_enabled(entry)		(((entry)->lo >> 3) & 0x1)
>  #define get_pasid_dir_size(entry)	(1 << ((((entry)->lo >> 9) & 0x7) + 7))
> 
> +/* Virtual command interface for enlightened pasid management. */
> +#define VCMD_CMD_ALLOC			0x1
> +#define VCMD_CMD_FREE			0x2
> +#define VCMD_VRSP_IP			0x1
> +#define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
> +#define VCMD_VRSP_SC_SUCCESS		0
> +#define VCMD_VRSP_SC_NO_PASID_AVAIL	1
> +#define VCMD_VRSP_SC_INVALID_PASID	1
> +#define VCMD_VRSP_RESULT_PASID(e)	(((e) >> 8) & 0xfffff)
> +#define VCMD_CMD_OPERAND(e)		((e) << 8)
>  /*
>   * Domain ID reserved for pasid entries programmed for first-level
>   * only and pass-through transfer modes.
> @@ -113,5 +123,6 @@ int intel_pasid_setup_nested(struct intel_iommu
> *iommu,
>  			int addr_width);
>  void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
>  				 struct device *dev, int pasid);
> -
> +int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
> +void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
>  #endif /* __INTEL_PASID_H */
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ccbf164fb711..9cbf5357138b 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -169,6 +169,7 @@
>  #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
>  #define ecap_flts(e)		(((e) >> 47) & 0x1)
>  #define ecap_slts(e)		(((e) >> 46) & 0x1)
> +#define ecap_vcs(e)		(((e) >> 44) & 0x1)
>  #define ecap_smts(e)		(((e) >> 43) & 0x1)
>  #define ecap_dit(e)		((e >> 41) & 0x1)
>  #define ecap_pasid(e)		((e >> 40) & 0x1)
> --
> 2.7.4

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

