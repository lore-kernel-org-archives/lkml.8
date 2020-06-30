Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C803C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2E52067D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Oq8hWvq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgF3GBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:01:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:7987 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgF3GBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:01:22 -0400
IronPort-SDR: Obg15yXPL4bq/9A3D8nuf0HJf11bYKz6bp2SZHhIDVVdYazlm6CFme3yIbpWwvV7ENT8HTByrW
 VlBFpYY7qt7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9666"; a="144338002"
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="144338002"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2020 23:01:17 -0700
IronPort-SDR: SVNmju1c9IGo8ZcnwAKfIv0fsHfXc1TExlQGMpGbiIWFGaFaqCPIfnxABo8DhKfYxgKM7voBIr
 HfEmsPqALAIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,296,1589266800"; 
   d="scan'208";a="425084854"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga004.jf.intel.com with ESMTP; 29 Jun 2020 23:01:17 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 29 Jun 2020 23:01:17 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 29 Jun 2020 23:01:16 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 29 Jun 2020 23:01:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 29 Jun 2020 23:01:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDoUAJe5Y+uBZ4d7mu8rxabocUZM2DbOk8WfvdFFxt55oa5n+4dYyzskCRXXDO/aPKPqoHWNNoBAyDJxoUwdXx4kqNSdn1C5kt9jyWoi9cVhq/BTzJgM+8mNlDphsZEzAowPxFEj6YR5PevVotIFCoELmsvfnM0InFL0FYLs3ZfIGSz3P08cv/Gzy9e5D/0uCb1lJW5mwSvSTVAuVVGaz65N+hG5ahjHqugtCkqq1G68dXsGbbfhZW0hcT8uUqiUeOkSqTgljadwy17JjQapmOnklUiAlPSvDZj/npUMqZdyvpif73ZTspeqQAoCUG/5f48XN5SbgxUzNBcnkrbwYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXwDTbDVal80iOHXg4ln/4vivgxK8YWUDQEJs+uaEEo=;
 b=IpHdGBP/cNiq4vCnxleM7RMRcrHFH+XguTy1u/WOGPEEkDzeYt014kfV0zb+SBD8zQkkusHmJICriKZgCr6qJAxX/HNjAWzZ9MoLUEo9z12vK9abYkxD+T/dcUzKmX7tMcizug99AWiP1oe+xnZOCJygFUu0pGdMGZtJP3f99P5Y23KIun66KGyg0INvZxsX2kVMZxrDj+G3l2Y5fJVjBft/ktLAGXxLBkNGOyHttvkrQGiJF2+UFCqxCh25k7D+nVbMJLHIvLgLjHwdBsI5jR1603AZT94Meap+CEv0I4hMWY5uMeQ/57R6IVNi1vbyrj6iiDhU0q8Up1m8qRu7ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXwDTbDVal80iOHXg4ln/4vivgxK8YWUDQEJs+uaEEo=;
 b=Oq8hWvq5uFXLkyzpj+NfPVQDyXY/IiPP+ERNqG8LxuzR0/DlccFfVqI8+q7w8oLfTQfQoOduPPsfiLcbYS6wTYzNJh9483Q9Tw4jnqqRkkrRLsdRrRGrj1psK5sDkn+vrXYB2SCIkN9yebryjaY04PAI2ORpucEf7+GTMsbno9I=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1600.namprd11.prod.outlook.com (2603:10b6:301:b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Tue, 30 Jun
 2020 06:01:13 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 06:01:13 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/4] iommu/vt-d: Report page request faults for guest SVA
Thread-Topic: [PATCH 3/4] iommu/vt-d: Report page request faults for guest SVA
Thread-Index: AQHWTORmc6i/ZJuiBUa22CGtnx99Najwq+Cg
Date:   Tue, 30 Jun 2020 06:01:13 +0000
Message-ID: <MWHPR11MB16450BD48B3EF42A8E82E5698C6F0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200628003332.5720-1-baolu.lu@linux.intel.com>
 <20200628003332.5720-4-baolu.lu@linux.intel.com>
In-Reply-To: <20200628003332.5720-4-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4fa150f1-4311-4896-1fef-08d81cbafe89
x-ms-traffictypediagnostic: MWHPR11MB1600:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB1600567CC31794F270411F6C8C6F0@MWHPR11MB1600.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n7a4oJyBgGKglN7ZHVUTXJ8VK6UnbPrPcz4aVlH6rfe08uou0kkaWnBL/KoseCD2EkZzT3CgL/coXNWzXXoDB0fEXdSGdFUO7eNGrUdo238T+497QIJNpf1INIxDz4zxQaiWHrpDFT+07c+ToP//jWzbaIdW34EM+CJmzP/TMXEUvMau+avLEnr24nFtRHwAPY6Q4mX3NmSEi0WLwMDJ3abnvX2kDIDNj+sajQWIIjiPIE4orx8arrbv7ZPwVlEU9VUvoNTP3SE/t1TXQEOYmQyBkR6SHwawfxAvEwhu1EAOK08iepWwwYSMb1GHtQL118UJYMpKwNO5waZ5sE9BpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(186003)(76116006)(54906003)(8936002)(66946007)(4326008)(66446008)(5660300002)(86362001)(71200400001)(110136005)(52536014)(66476007)(33656002)(2906002)(64756008)(66556008)(8676002)(83380400001)(9686003)(26005)(55016002)(316002)(478600001)(7696005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 2hitLfJYjVw9AT88psEqmmXTu3ahjZVb341Akqj9rA/1VagxrJklVm4fq8HRSno6XtDgqYkBPv1iVaQaV8IV/MFAOmo96bYkUW9Mj6vNYGj+CxyXZG39Q9E9miixEe4R2cv3wKnG99ONzTEvsc54j8LeH4qJ9+tQl1DRlBAA2cU67DTuBUfI1llnKcjP2V2vCymNuQnD8edSH9pVMRhRFsBVGeGvhmO9aBeQ0MLO7R1JuhX5nHAhSIWDq6wNL4wGZ2EDaFfXpfnoh6lz/tqqOnK218qOyhbcCwTRsW3ItRg+P3uER8KCRJIEbvd/TlxhBk0n2pgk0qPishc8S5EG6Wdbe2LBRYoiUojvUomiwcEiDxDNJTQaDqGxH3DnJU923gGkPDjhBYlAYkaJd/uk18xSaMEu68T0S6o9T513onoTVsX+HMQAxc7kFIU4L7GbUbgxvRC3SA0thefw2edPE1fGTTOahMiv4xytxFnPn8RmusFXcFJ7xfE4qRlHyb9s
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa150f1-4311-4896-1fef-08d81cbafe89
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 06:01:13.0670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BZY3w6tIYtY9lpJXZt8f39/9h4h4YPEF+o6B5m2BexQ+7kUKe2BUvxWBLUlagdOAwFIwc1Xh7D77ZwLeLHNFSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1600
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Sunday, June 28, 2020 8:34 AM
>=20
> A pasid might be bound to a page table from a VM guest via the iommu
> ops.sva_bind_gpasid. In this case, when a DMA page fault is detected
> on the physical IOMMU, we need to inject the page fault request into
> the guest. After the guest completes handling the page fault, a page
> response need to be sent back via the iommu ops.page_response().
>=20
> This adds support to report a page request fault. Any external module
> which is interested in handling this fault should regiester a notifier
> callback.
>=20
> Co-developed-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Co-developed-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 83
> +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 80 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index c23167877b2b..4800bb6f8794 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -815,6 +815,69 @@ static void intel_svm_drain_prq(struct device *dev,
> int pasid)
>  	}
>  }
>=20
> +static int prq_to_iommu_prot(struct page_req_dsc *req)
> +{
> +	int prot =3D 0;
> +
> +	if (req->rd_req)
> +		prot |=3D IOMMU_FAULT_PERM_READ;
> +	if (req->wr_req)
> +		prot |=3D IOMMU_FAULT_PERM_WRITE;
> +	if (req->exe_req)
> +		prot |=3D IOMMU_FAULT_PERM_EXEC;
> +	if (req->pm_req)
> +		prot |=3D IOMMU_FAULT_PERM_PRIV;
> +
> +	return prot;
> +}
> +
> +static int
> +intel_svm_prq_report(struct intel_iommu *iommu, struct page_req_dsc
> *desc)
> +{
> +	struct iommu_fault_event event;
> +	struct pci_dev *pdev;
> +	u8 bus, devfn;
> +	int ret =3D 0;
> +
> +	memset(&event, 0, sizeof(struct iommu_fault_event));
> +	bus =3D PCI_BUS_NUM(desc->rid);
> +	devfn =3D desc->rid & 0xff;
> +	pdev =3D pci_get_domain_bus_and_slot(iommu->segment, bus, devfn);

Is this step necessary? dev can be passed in (based on sdev), and more
importantly iommu_report_device_fault already handles the ref counting
e.g. get_device(dev) when fault handler is valid...

> +
> +	if (!pdev) {
> +		pr_err("No PCI device found for PRQ [%02x:%02x.%d]\n",
> +		       bus, PCI_SLOT(devfn), PCI_FUNC(devfn));
> +		return -ENODEV;
> +	}
> +
> +	/* Fill in event data for device specific processing */
> +	event.fault.type =3D IOMMU_FAULT_PAGE_REQ;
> +	event.fault.prm.addr =3D desc->addr;
> +	event.fault.prm.pasid =3D desc->pasid;
> +	event.fault.prm.grpid =3D desc->prg_index;
> +	event.fault.prm.perm =3D prq_to_iommu_prot(desc);
> +
> +	/*
> +	 * Set last page in group bit if private data is present,
> +	 * page response is required as it does for LPIG.
> +	 */
> +	if (desc->lpig)
> +		event.fault.prm.flags |=3D
> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;
> +	if (desc->pasid_present)
> +		event.fault.prm.flags |=3D
> IOMMU_FAULT_PAGE_REQUEST_PASID_VALID;
> +	if (desc->priv_data_present) {
> +		event.fault.prm.flags |=3D
> IOMMU_FAULT_PAGE_REQUEST_LAST_PAGE;

why setting lpig under this condition?=20

> +		event.fault.prm.flags |=3D
> IOMMU_FAULT_PAGE_REQUEST_PRIV_DATA;
> +		memcpy(event.fault.prm.private_data, desc->priv_data,
> +		       sizeof(desc->priv_data));
> +	}
> +
> +	ret =3D iommu_report_device_fault(&pdev->dev, &event);
> +	pci_dev_put(pdev);
> +
> +	return ret;
> +}
> +
>  static irqreturn_t prq_event_thread(int irq, void *d)
>  {
>  	struct intel_iommu *iommu =3D d;
> @@ -874,6 +937,19 @@ static irqreturn_t prq_event_thread(int irq, void *d=
)
>  		if (!is_canonical_address(address))
>  			goto bad_req;
>=20
> +		/*
> +		 * If prq is to be handled outside iommu driver via receiver of
> +		 * the fault notifiers, we skip the page response here.
> +		 */
> +		if (svm->flags & SVM_FLAG_GUEST_MODE) {
> +			int res =3D intel_svm_prq_report(iommu, req);
> +
> +			if (!res)
> +				goto prq_advance;
> +			else
> +				goto bad_req;
> +		}
> +

I noted in bad_req there is another reporting logic:

                if (sdev && sdev->ops && sdev->ops->fault_cb) {
                        int rwxp =3D (req->rd_req << 3) | (req->wr_req << 2=
) |
                                (req->exe_req << 1) | (req->pm_req);
                        sdev->ops->fault_cb(sdev->dev, req->pasid, req->add=
r,
                                            req->priv_data, rwxp, result);
                }

It was introduced in the 1st version of svm.c. It might be unrelated to
this patch, but I wonder whether that one should be replaced with=20
iommu_report_device_fault too?

Thanks
Kevin

>  		/* If the mm is already defunct, don't handle faults. */
>  		if (!mmget_not_zero(svm->mm))
>  			goto bad_req;
> @@ -892,10 +968,10 @@ static irqreturn_t prq_event_thread(int irq, void *=
d)
>  			goto invalid;
>=20
>  		result =3D QI_RESP_SUCCESS;
> -	invalid:
> +invalid:
>  		mmap_read_unlock(svm->mm);
>  		mmput(svm->mm);
> -	bad_req:
> +bad_req:
>  		/* Accounting for major/minor faults? */
>  		rcu_read_lock();
>  		list_for_each_entry_rcu(sdev, &svm->devs, list) {
> @@ -920,7 +996,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  		   and these can be NULL. Do not use them below this point!
> */
>  		sdev =3D NULL;
>  		svm =3D NULL;
> -	no_pasid:
> +no_pasid:
>  		if (req->lpig || req->priv_data_present) {
>  			/*
>  			 * Per VT-d spec. v3.0 ch7.7, system software must
> @@ -945,6 +1021,7 @@ static irqreturn_t prq_event_thread(int irq, void *d=
)
>  			resp.qw3 =3D 0;
>  			qi_submit_sync(iommu, &resp, 1, 0);
>  		}
> +prq_advance:
>  		head =3D (head + sizeof(*req)) & PRQ_RING_MASK;
>  	}
>=20
> --
> 2.17.1

