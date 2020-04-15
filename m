Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A18C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4CB20775
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 08:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635796AbgDOISo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 04:18:44 -0400
Received: from mga07.intel.com ([134.134.136.100]:36970 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635665AbgDOISh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 04:18:37 -0400
IronPort-SDR: HBSlQfIIlwJY9rNH0DxsWLGY3DBKQxDoHmC2VATRX5e+ebjDjn5skvfUC91JRaLW2gPf1ur07N
 NQapzJxzNFtQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2020 01:18:36 -0700
IronPort-SDR: gwWDdwSqeSnRgrdW55EGTBDjMzuAxvnW9kJaJ3WB9sQLpa46TC5Uk2meU4OWfudziIrw08EP8z
 Np+V5N5n/BeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,386,1580803200"; 
   d="scan'208";a="245634191"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by fmsmga008.fm.intel.com with ESMTP; 15 Apr 2020 01:18:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 15 Apr 2020 01:18:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 15 Apr 2020 01:18:36 -0700
Received: from shsmsx107.ccr.corp.intel.com (10.239.4.96) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 15 Apr 2020 01:18:35 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX107.ccr.corp.intel.com ([169.254.9.191]) with mapi id 14.03.0439.000;
 Wed, 15 Apr 2020 16:18:33 +0800
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/7] iommu/vt-d: Multiple descriptors per
 qi_submit_sync()
Thread-Topic: [PATCH v2 2/7] iommu/vt-d: Multiple descriptors per
 qi_submit_sync()
Thread-Index: AQHWEubNcojyloGV5kG0IsggcRYC46h50o9A
Date:   Wed, 15 Apr 2020 08:18:33 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D82055A@SHSMSX104.ccr.corp.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
 <20200415052542.30421-3-baolu.lu@linux.intel.com>
In-Reply-To: <20200415052542.30421-3-baolu.lu@linux.intel.com>
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

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, April 15, 2020 1:26 PM
> 
> Extend qi_submit_sync() function to support multiple descriptors.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/dmar.c        | 39 +++++++++++++++++++++++--------------
>  include/linux/intel-iommu.h |  1 +
>  2 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index bb42177e2369..61d049e91f84 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1157,12 +1157,11 @@ static inline void reclaim_free_desc(struct
> q_inval *qi)
>  	}
>  }
> 
> -static int qi_check_fault(struct intel_iommu *iommu, int index)
> +static int qi_check_fault(struct intel_iommu *iommu, int index, int
> wait_index)
>  {
>  	u32 fault;
>  	int head, tail;
>  	struct q_inval *qi = iommu->qi;
> -	int wait_index = (index + 1) % QI_LENGTH;
>  	int shift = qi_shift(iommu);
> 
>  	if (qi->desc_status[wait_index] == QI_ABORT)
> @@ -1234,12 +1233,12 @@ static int qi_check_fault(struct intel_iommu
> *iommu, int index)
>  int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
>  		   unsigned int count, unsigned long options)
>  {
> -	int rc;
>  	struct q_inval *qi = iommu->qi;
> -	int offset, shift, length;
>  	struct qi_desc wait_desc;
>  	int wait_index, index;
>  	unsigned long flags;
> +	int offset, shift;
> +	int rc, i;
> 
>  	if (!qi)
>  		return 0;
> @@ -1248,32 +1247,41 @@ int qi_submit_sync(struct intel_iommu *iommu,
> struct qi_desc *desc,
>  	rc = 0;
> 
>  	raw_spin_lock_irqsave(&qi->q_lock, flags);
> -	while (qi->free_cnt < 3) {
> +	/*
> +	 * Check if we have enough empty slots in the queue to submit,
> +	 * the calculation is based on:
> +	 * # of desc + 1 wait desc + 1 space between head and tail
> +	 */
> +	while (qi->free_cnt < count + 2) {
>  		raw_spin_unlock_irqrestore(&qi->q_lock, flags);
>  		cpu_relax();
>  		raw_spin_lock_irqsave(&qi->q_lock, flags);
>  	}
> 
>  	index = qi->free_head;
> -	wait_index = (index + 1) % QI_LENGTH;
> +	wait_index = (index + count) % QI_LENGTH;
>  	shift = qi_shift(iommu);
> -	length = 1 << shift;
> 
> -	qi->desc_status[index] = qi->desc_status[wait_index] = QI_IN_USE;
> +	for (i = 0; i < count; i++) {
> +		offset = ((index + i) % QI_LENGTH) << shift;
> +		memcpy(qi->desc + offset, &desc[i], 1 << shift);
> +		qi->desc_status[(index + i) % QI_LENGTH] = QI_IN_USE;
> +	}

what about doing one memcpy and leave the loop only for updating
qi status?

> +	qi->desc_status[wait_index] = QI_IN_USE;
> 
> -	offset = index << shift;
> -	memcpy(qi->desc + offset, desc, length);
>  	wait_desc.qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
>  			QI_IWD_STATUS_WRITE | QI_IWD_TYPE;
> +	if (options & QI_OPT_WAIT_DRAIN)
> +		wait_desc.qw0 |= QI_IWD_PRQ_DRAIN;
>  	wait_desc.qw1 = virt_to_phys(&qi->desc_status[wait_index]);
>  	wait_desc.qw2 = 0;
>  	wait_desc.qw3 = 0;
> 
>  	offset = wait_index << shift;
> -	memcpy(qi->desc + offset, &wait_desc, length);
> +	memcpy(qi->desc + offset, &wait_desc, 1 << shift);
> 
> -	qi->free_head = (qi->free_head + 2) % QI_LENGTH;
> -	qi->free_cnt -= 2;
> +	qi->free_head = (qi->free_head + count + 1) % QI_LENGTH;
> +	qi->free_cnt -= count + 1;
> 
>  	/*
>  	 * update the HW tail register indicating the presence of
> @@ -1289,7 +1297,7 @@ int qi_submit_sync(struct intel_iommu *iommu,
> struct qi_desc *desc,
>  		 * a deadlock where the interrupt context can wait
> indefinitely
>  		 * for free slots in the queue.
>  		 */
> -		rc = qi_check_fault(iommu, index);
> +		rc = qi_check_fault(iommu, index, wait_index);
>  		if (rc)
>  			break;
> 
> @@ -1298,7 +1306,8 @@ int qi_submit_sync(struct intel_iommu *iommu,
> struct qi_desc *desc,
>  		raw_spin_lock(&qi->q_lock);
>  	}
> 
> -	qi->desc_status[index] = QI_DONE;
> +	for (i = 0; i < count; i++)
> +		qi->desc_status[(index + i) % QI_LENGTH] = QI_DONE;
> 
>  	reclaim_free_desc(qi);
>  	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index ee2d5cdd8339..cca1e5f9aeaa 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -333,6 +333,7 @@ enum {
> 
>  #define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
>  #define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
> +#define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
> 
>  #define QI_IOTLB_DID(did) 	(((u64)did) << 16)
>  #define QI_IOTLB_DR(dr) 	(((u64)dr) << 7)
> --
> 2.17.1

