Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C344C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C06BA2084D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 06:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="KyWcl2gl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgEGGgD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 02:36:03 -0400
Received: from mga06.intel.com ([134.134.136.31]:47857 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbgEGGgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 02:36:03 -0400
IronPort-SDR: QLNIN9ZA0I4HdN1uEZh6wP+kSLz9MCUwmtgbozrqcEZmzchzfRTk6DA45aHy9d1CoGUgeHDS+r
 3XfGrRs863IQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 23:36:02 -0700
IronPort-SDR: qtPEfbX1SJcUGBTby9EsA6soOk4MJD9AAXZkyXAsrQoETpfRGVbcg1ExdzOR6aX8OC/3YD0iqp
 7vyoNwGvN/EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="435173582"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga005.jf.intel.com with ESMTP; 06 May 2020 23:36:02 -0700
Received: from fmsmsx163.amr.corp.intel.com (10.18.125.72) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 23:36:02 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx163.amr.corp.intel.com (10.18.125.72) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 23:36:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 6 May 2020 23:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jekkCU8bNxcgbVAPwyk+26Y54QTINA5BXu2lbouC/uwThNQo6i+mYaWmSWDXpR6IT0ZBsOeT7sJzbfpdox0CuYGj77OSD43BeFEuQn86JwqlcJ60ng4f2HZqmucji9r/5uNendI0ktH9amlYhfGGxKG5GvWABG9llZHNIGweWI2czDD51Ex+EfwOJssCeWCjkxG9E2l3oDL7HSTY1041XN9s/24fRYFqsSgCknThckEZjfG8q46TTg4+FSdnOmTmpGPgL8AeY84U49YAbH9X48ff+rigZ1NXwEZYxNqYONSK+h0eD3RmYqGKepMOLg/kx4/Ccedp8P8zvA4vWOUa2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd1k+sH2L6Z19JSIq5yA690+n1nqpw703reUInRU0dg=;
 b=jczGPjJx5hMRJJj35nMrO7yIpJiPhOCM4nfdLcc47fqbc06KPLiwoalMSqp1GKiu+gVqs1SDJX1v8NYGfV8/pX7qewnchpS0OoUqFIzhqhGqHDcY0VVGWxo7MxljVqrl9YIabISurSNwzy5+QIxYC07zHAbKmGsvFS9tKQaBpYq2NK2GAhBw2dxTNCgm1AzPcrrgYBCTCH0HYKLvQ7iOOzi1rF8TveYHnfpcvg1At/pkIpBTnnviUSYSWl5txLU4SIo4V+QFda+LvxVzpIhwlAy0m3Y0dSOkuUba78HFPnnHPLw5dx3YJFTwG8fyojne8Brakj1h8iZXMnPlER/h0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qd1k+sH2L6Z19JSIq5yA690+n1nqpw703reUInRU0dg=;
 b=KyWcl2gl2xOwVyT80YM1gdvvSAkkyvJkmRY9aqEPp0gd9GVBPeYTk9G39i2kpXzZfhqCrjnmw7F8fUn3KEH1jfD4/7jSViDl8UkDnsz1sHVwR1KRUPKqnoCAfUw1lLpOCMN0erKDa9TEcz2VdBDY50iea4u2d046dZkLAwd7dtE=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1391.namprd11.prod.outlook.com (2603:10b6:300:23::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Thu, 7 May
 2020 06:35:58 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be%9]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 06:35:58 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v4 4/5] iommu/vt-d: Add page request draining support
Thread-Topic: [PATCH v4 4/5] iommu/vt-d: Add page request draining support
Thread-Index: AQHWJArOiNYGTPdmOkGiCX6SVrWYYKicHYew
Date:   Thu, 7 May 2020 06:35:58 +0000
Message-ID: <MWHPR11MB1645726E6EB0D9248BC56DA78CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-5-baolu.lu@linux.intel.com>
In-Reply-To: <20200507005534.3080-5-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a232d7a0-27ee-4a3a-b7f1-08d7f250e749
x-ms-traffictypediagnostic: MWHPR11MB1391:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1391B6D22118EDF79024997A8CA50@MWHPR11MB1391.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7xHuqJLeqSf2ZMzsNZPgTUoXRJPDO5t5C37pGrrL64h9Hf/ZhU17G9NKFMmD5e/ODKz3fU6XCsskQdXVGL+xkRCAHjgB2JfHt4DpOF1xXtpR/QNw4xrp4L7SIlwyscehplJXXxVhRPIiA4diW+hK1186jY9qUDxHX9CYisYnZme946L50/P+wADqc2jaQmALCvlEtqBUeqdqwHdzMlLsn2H/6hB7ZQbk0Ki2Zj3IPkppxOJ860hePbGAsu9hBBXUF32ZN917+4RJD6bXaX83WUswGWHc17C4tXvvbYet/+J10w8tX492rGiJopqfAeEzbihIWMLoZMrmGUwN+rmFJMQbxRuul3EXCjcGRqlX0rurhNFw6OgLkn+OFp6adaQ79/bv3mq9Zx3DBYwpAJfh9A6cVwBjHoU4MjS6O+TAKlOoileZTIgy1yxRvc25H2Nxzjx4yoVqbmEGCuBSkkFJlvZxSK4wm/VbW5BpmIg+Kp0ELYZlI7krXBqkER7Mj8XHvbzUUrJbsN2xC0YMXAEIP5X5ajDoqgmfrV05YWPhdwuG8K6YkXwarnlGr1dckjVMywRQ7vcKImt7tN5uYGIFnV9oEYWyr6xV7IZys8I5Tkg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(136003)(39860400002)(396003)(346002)(33430700001)(7696005)(76116006)(8936002)(52536014)(66446008)(55016002)(316002)(64756008)(66946007)(66556008)(66476007)(9686003)(186003)(71200400001)(33656002)(86362001)(26005)(8676002)(110136005)(54906003)(4326008)(478600001)(5660300002)(2906002)(6506007)(966005)(33440700001)(83320400001)(83280400001)(83300400001)(83310400001)(83290400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ezvXANafiBwNqKkcqm/e+Xz7hETjIlrR/edrkt+cq/+eWo2CugKEnOrj+yYk6ZsHe1gzaJLnnClSSgcXzuN+3Clh79neBKSAi5JXcYFfbY2c9E7Xk+uqEaMHCh+mFhRBniRooVTvIs+2h8HS8J2B9ZPDAKcibqkBr9I1KVp/lpaoBoJtPcw7TXJb59HHcDiIH24ESaboa42IgxvxJ9bVdUsZ4vT3koDC+Iavq+6e6MehuX7cKac4n1ZcNvxyflglImgM3cKs1m+76wrD0ENW+JSl/DLra+Uxa2eZud2uaok7g+G3vBDpOOC9Fbss/zSUtuLzDDWVU/ksN6yDJxb+A233RQEEHAOwLUT+yVOreVd2YeyxP47u67ym1l6YrRiADgmcLGQE6z0R6MVU+ZRlOyIIxY79j7KysDR7sIRxmspKBAVHB+NtUxyGdEkZjzcUXlDIfjo3PYnz+JmqDtNRUCpfS5jlOe9oaTFyDgVV3ziKi5BKmmEaRcQdLAbg7sZNOvjq93yINz0vpAYd0JIdkFN16JL63jYj3Satov5NP2qxaSLbtAyEKDhkc66kSIEkST2KYFlZnDzYhy6fPK8bz8mTO/vvfEOYGq3RsrgvbwbwClUyL0ecs3DWDKkrdYu85eJ+B4LOaVp5HjvFSeN7/SIy/DWfyRBIPl9v3WCpcSc8803B7sZSbgNwNFF5WUUepj5YnN5oZ8HEt30imD2JVpo5A1abWhJrUGLMl37myEoMOH/nLk8204wJbyMkrleYw/gxPcMOGPqGeOpwz5TYXYLKPhkyzQeqA8Jko3i8Rlw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a232d7a0-27ee-4a3a-b7f1-08d7f250e749
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 06:35:58.6678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c6Hkkv5DoXIvClcJUrOaVTr09Y3u68Yc+g+QLDjqDt33u0QVBsLXgdLfOqA31Gg66vyQTSyzAs3e1NZ9abMI/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1391
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu
> Sent: Thursday, May 7, 2020 8:56 AM
>=20
> When a PASID is stopped or terminated, there can be pending PRQs
> (requests that haven't received responses) in remapping hardware.
> This adds the interface to drain page requests and call it when a
> PASID is terminated.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel-svm.c   | 102 ++++++++++++++++++++++++++++++++++-
> -
>  include/linux/intel-iommu.h |   4 ++
>  2 files changed, 101 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index 9561ba59a170..7256eb965cf6 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -23,6 +23,7 @@
>  #include "intel-pasid.h"
>=20
>  static irqreturn_t prq_event_thread(int irq, void *d);
> +static void intel_svm_drain_prq(struct device *dev, int pasid);
>=20
>  #define PRQ_ORDER 0
>=20
> @@ -66,6 +67,8 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
>  	dmar_writeq(iommu->reg + DMAR_PQT_REG, 0ULL);
>  	dmar_writeq(iommu->reg + DMAR_PQA_REG, virt_to_phys(iommu-
> >prq) | PRQ_ORDER);
>=20
> +	init_completion(&iommu->prq_complete);
> +
>  	return 0;
>  }
>=20
> @@ -403,12 +406,8 @@ int intel_svm_unbind_gpasid(struct device *dev, int
> pasid)
>  			list_del_rcu(&sdev->list);
>  			intel_pasid_tear_down_entry(iommu, dev,
>  						    svm->pasid, false);
> +			intel_svm_drain_prq(dev, svm->pasid);
>  			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
> -			/* TODO: Drain in flight PRQ for the PASID since it
> -			 * may get reused soon, we don't want to
> -			 * confuse with its previous life.
> -			 * intel_svm_drain_prq(dev, pasid);
> -			 */
>  			kfree_rcu(sdev, rcu);
>=20
>  			if (list_empty(&svm->devs)) {
> @@ -647,6 +646,7 @@ int intel_svm_unbind_mm(struct device *dev, int
> pasid)
>  			 * hard to be as defensive as we might like. */
>  			intel_pasid_tear_down_entry(iommu, dev,
>  						    svm->pasid, false);
> +			intel_svm_drain_prq(dev, svm->pasid);
>  			intel_flush_svm_range_dev(svm, sdev, 0, -1, 0);
>  			kfree_rcu(sdev, rcu);
>=20
> @@ -725,6 +725,92 @@ static bool is_canonical_address(u64 addr)
>  	return (((saddr << shift) >> shift) =3D=3D saddr);
>  }
>=20
> +/**
> + * intel_svm_drain_prq:
> + *
> + * Drain all pending page requests and responses related to a specific
> + * pasid in both software and hardware.
> + */
> +static void intel_svm_drain_prq(struct device *dev, int pasid)
> +{
> +	struct device_domain_info *info;
> +	struct dmar_domain *domain;
> +	struct intel_iommu *iommu;
> +	struct qi_desc desc[3];
> +	struct pci_dev *pdev;
> +	int head, tail;
> +	u16 sid, did;
> +	int qdep;
> +
> +	info =3D get_domain_info(dev);
> +	if (WARN_ON(!info || !dev_is_pci(dev)))
> +		return;
> +
> +	if (!info->ats_enabled)
> +		return;

ats_enabled -> pri_enabled

> +
> +	iommu =3D info->iommu;
> +	domain =3D info->domain;
> +	pdev =3D to_pci_dev(dev);
> +	sid =3D PCI_DEVID(info->bus, info->devfn);
> +	did =3D domain->iommu_did[iommu->seq_id];
> +	qdep =3D pci_ats_queue_depth(pdev);
> +
> +	memset(desc, 0, sizeof(desc));
> +	desc[0].qw0 =3D QI_IWD_STATUS_DATA(QI_DONE) |
> +			QI_IWD_FENCE |
> +			QI_IWD_TYPE;
> +	desc[1].qw0 =3D QI_EIOTLB_PASID(pasid) |
> +			QI_EIOTLB_DID(did) |
> +			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
> +			QI_EIOTLB_TYPE;
> +	desc[2].qw0 =3D QI_DEV_EIOTLB_PASID(pasid) |
> +			QI_DEV_EIOTLB_SID(sid) |
> +			QI_DEV_EIOTLB_QDEP(qdep) |
> +			QI_DEIOTLB_TYPE |
> +			QI_DEV_IOTLB_PFSID(info->pfsid);
> +
> +	/*
> +	 * Submit an invalidation wait descriptor with fence and page request
> +	 * drain flags set to invalidation queue. This ensures that all request=
s
> +	 * submitted to the invalidation queue ahead of this wait descriptor
> are
> +	 * processed and completed, and all already issued page requests
> from
> +	 * the device are put in the page request queue.
> +	 */

I feel this comment is better moved earlier since it explains the overall=20
flow including all 3 descriptors. Also it is not one wait descriptor which
gets both fence and drain flags set. There are two wait descriptors with
one setting fence and the other setting drain.

> +	qi_submit_sync(iommu, desc, 1, QI_OPT_WAIT_DRAIN);

the count is '3' instead of '1'.

> +
> +	/*
> +	 * Check and wait until all pending page requests in the queue are
> +	 * handled by the intr thread.
> +	 */
> +prq_retry:
> +	tail =3D dmar_readq(iommu->reg + DMAR_PQT_REG) &
> PRQ_RING_MASK;
> +	head =3D dmar_readq(iommu->reg + DMAR_PQH_REG) &
> PRQ_RING_MASK;
> +	while (head !=3D tail) {
> +		struct page_req_dsc *req;
> +
> +		req =3D &iommu->prq[head / sizeof(*req)];
> +		if (!req->pasid_present || req->pasid !=3D pasid) {
> +			head =3D (head + sizeof(*req)) & PRQ_RING_MASK;
> +			continue;
> +		}
> +
> +		wait_for_completion_timeout(&iommu->prq_complete, HZ);
> +		goto prq_retry;
> +	}
> +
> +	/*
> +	 * Perform steps described in VT-d spec CH7.10 to drain page
> +	 * requests and responses in hardware.
> +	 */
> +qi_retry:
> +	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);
> +	if (readl(iommu->reg + DMAR_PRS_REG) & DMA_PRS_PRO) {
> +		wait_for_completion_timeout(&iommu->prq_complete, HZ);
> +		goto qi_retry;
> +	}
> +}
> +
>  static irqreturn_t prq_event_thread(int irq, void *d)
>  {
>  	struct intel_iommu *iommu =3D d;
> @@ -859,6 +945,12 @@ static irqreturn_t prq_event_thread(int irq, void *d=
)
>  	}
>=20
>  	dmar_writeq(iommu->reg + DMAR_PQH_REG, tail);
> +	/*
> +	 * Clear the page request overflow bit and wake up all threads that
> +	 * are waiting for the completion of this handling.
> +	 */
> +	writel(DMA_PRS_PRO, iommu->reg + DMAR_PRS_REG);
> +	complete(&iommu->prq_complete);
>=20
>  	return IRQ_RETVAL(handled);
>  }
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index cca1e5f9aeaa..a0512b401a59 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -292,6 +292,8 @@
>=20
>  /* PRS_REG */
>  #define DMA_PRS_PPR	((u32)1)
> +#define DMA_PRS_PRO	((u32)2)
> +
>  #define DMA_VCS_PAS	((u64)1)
>=20
>  #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)
> 	\
> @@ -333,6 +335,7 @@ enum {
>=20
>  #define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
>  #define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
> +#define QI_IWD_FENCE		(((u64)1) << 6)
>  #define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
>=20
>  #define QI_IOTLB_DID(did) 	(((u64)did) << 16)
> @@ -590,6 +593,7 @@ struct intel_iommu {
>  #ifdef CONFIG_INTEL_IOMMU_SVM
>  	struct page_req_dsc *prq;
>  	unsigned char prq_name[16];    /* Name for PRQ interrupt */
> +	struct completion prq_complete;
>  	struct ioasid_allocator_ops pasid_allocator; /* Custom allocator for
> PASIDs */
>  #endif
>  	struct q_inval  *qi;            /* Queued invalidation info */
> --
> 2.17.1
>=20
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
