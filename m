Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9F5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7EEBB206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 01:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="rgXqyGC3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgGFBKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 21:10:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:15213 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbgGFBKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 21:10:15 -0400
IronPort-SDR: PNgjk15fmkfEC2JJLvXjd8gyf9QDQaeZQfEAcyMn8zNYayI5cbXCrcLv1UFLf1a/8zWvI6P7Ot
 DRLVIg8vpXvg==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="127417331"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="127417331"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 18:10:10 -0700
IronPort-SDR: ob+TvhynOIF6f5BdgDutI3Oi85D8qDRUtXcrciZFqcR4S7h2TXJxeweA/9nNxB2QNkLy4NyN7F
 9/ugB8GC0eOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="357293773"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 05 Jul 2020 18:10:10 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 5 Jul 2020 18:10:09 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 5 Jul 2020 18:10:09 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 5 Jul 2020 18:10:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sun, 5 Jul 2020 18:10:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fw8IWvDK06VhtxGc/3rNewatFfg9KdLTF/iiKnQwlePUAcBDWR5sMo9h3oxh56PtVdJvhtjF96fW6BTmaLL5cKkoEXvapk25C6zahOSO2Qq8/fBlTfKjCXvzkyRPYrU2HIzC3a4A46qLQVy7KvdlpfLxOLwzE8WOooP+BkZPvdmogcqYYTjWqLrZPMebo4dgYmz9UJ7nP6acSSFxMqPjZh6ZdUlkjxkyaeSOib9YsPuff1/j+imZBr0erI7OPAhjxggMTY1AVNOf5bQy89bpK3YhuW0wQGL6G5i0th8K35d0dlqifUcQgKwRdzBUEwu29Yx2nDgATFaN8usRO8VhKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJh/VcgSZ/sY4BTmTT/4FAoS11EaTbq6UyBfQRRA/RY=;
 b=ZUNnW72o1dX+febHlgbWtFKfSMLQZWqndzLif7B987JcThZ/nF4Khpp4o6CiTBH47mrh+p28fzgFRhyyRW0NtWFge6c8RgMALh7Qr9lqwzLK57MtY6jhjNX+eigTQ7k/F67BDyA/BabV5/Bzss1W7DxjS1BZ4Mo3bAgmz+7VaWnk8QD8897YMsTIGnuTMKyAqyrMgx/XEsiHp2hsaIQO7S5JZQDjO3zsTvYDHbpCMIo0WK9KdYVGTtK2Rsr51qlj9nEc5Xi//u2+BV7WwgfxyawzH7eA8XDh/J2x+L/GsEfyStGH7QDCmDF4iwrTL8xvUvxFKVNDNLcUrWneZ59Q/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJh/VcgSZ/sY4BTmTT/4FAoS11EaTbq6UyBfQRRA/RY=;
 b=rgXqyGC3bKFc6lvh6LtX+/oeH1yK3EiFrDwoF4ji1lAKssVuNTre4OOAUR6VsNiDh4lOOSfRTzbIBQm7s0e6aiYIBifOCvbnKpLQUj9FCCRNowoUw4X1kqvzpjLVO151I/lPhRD6nOEpiTyb3AHVb9VPg/AfmTt5d48P1y0K2EA=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1871.namprd11.prod.outlook.com (2603:10b6:300:111::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Mon, 6 Jul
 2020 01:10:06 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3153.029; Mon, 6 Jul 2020
 01:10:06 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
CC:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/4] iommu/vt-d: Add a helper to get svm and sdev for
 pasid
Thread-Topic: [PATCH v2 2/4] iommu/vt-d: Add a helper to get svm and sdev for
 pasid
Thread-Index: AQHWUyysE30bjGsbMEqaIQ/06SI3T6j5venw
Date:   Mon, 6 Jul 2020 01:10:06 +0000
Message-ID: <MWHPR11MB16450A38D32CFD746A24512F8C690@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200706002535.9381-1-baolu.lu@linux.intel.com>
 <20200706002535.9381-3-baolu.lu@linux.intel.com>
In-Reply-To: <20200706002535.9381-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.214]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ef22942-22ed-4388-69dc-08d8214951d9
x-ms-traffictypediagnostic: MWHPR11MB1871:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB18717011001814FCEB0482088C690@MWHPR11MB1871.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04569283F9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6qJzn5KknbHYRwFfc3Mp7BImx5xBKN3LuHWbZoINRWUqkO7ibnoai/6+PBrs7ovF/veelt8fH9+48CmVaQr63Ytnv5uC6UaEgTRkylxwltYPUxQuiyFCcx1nHBu0pfphejcL9SVvz7B9ETL/zfAd5IFZ8USJzFggc7ek0esnXXjRYDBeRJAAgU4BYkYJrjtaYftv1dLKyPcIexw7a82id6H15U2jbPGnckp4cmesZoESfG2AwKWirTktBW+tiHeuiSQ10e8AkK3nL7pk48NVcDFrxzB7nwRxb7g37w5q9o/0UMxN4jbkZcGyBkJa0tdj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(346002)(136003)(366004)(39860400002)(396003)(478600001)(9686003)(316002)(26005)(83380400001)(55016002)(33656002)(2906002)(71200400001)(8936002)(186003)(110136005)(8676002)(5660300002)(66446008)(64756008)(66556008)(52536014)(7696005)(6506007)(54906003)(4326008)(86362001)(76116006)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ClLr4qHJwDoiDlJz62Jkimy8fktoa4elSCLXdfpqfrQ6NcRVPiA0YzG/zFhZPwEgkOl4D1ajqdcITGzeYUS8k+ACtzhlonrQ+y0c3XJatReR9qxYNiGW92udgMKQyIdbcsa7zZfUFvGHTgfjvDh+kq4jdNAT85rgWDsS5CU/QD1Bb36D9GgbH3T4eRpG7x+6WkwGHBnO38o5lUKQJBbwghlikwj8GADaMCFaffkajzn0In8cEc1ndlkx7Wmov5pzj0Ax878dklPyGldinG+sT0WkD+83K7SonI59f1rDS/uRK4rU1EVjyqYtfuQ5EgpJjXiX47N1AMRyiQY6V+DcV4xOXxqyd9ut+GE/nURjfCVCFGsamzlGtNKfadQ96n+VHWCL7UJJ+0jVJbpDydgcGZrxSmwSPLkHOO9uZsiX6NYCSuD7i6bxVWukswXNlq2e1OORcHPwC/nf7GyZhzxK0upiOkXxtHgUnLpECQBx1UjSUThUzRcoSX8x3cPGSlYP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef22942-22ed-4388-69dc-08d8214951d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2020 01:10:06.1787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mL2BF9NGp6qGNh27VKCQS3ByN5Td3AGDTwUUrAgAgQQOld8cafM4MWk0Ml+mlALDwon503Quvjoz/ienSQzx2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1871
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, July 6, 2020 8:26 AM
>=20
> There are several places in the code that need to get the pointers of
> svm and sdev according to a pasid and device. Add a helper to achieve
> this for code consolidation and readability.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/svm.c | 121 +++++++++++++++++++++-----------------
>  1 file changed, 68 insertions(+), 53 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 25dd74f27252..c23167877b2b 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -228,6 +228,50 @@ static LIST_HEAD(global_svm_list);
>  	list_for_each_entry((sdev), &(svm)->devs, list)	\
>  		if ((d) !=3D (sdev)->dev) {} else
>=20
> +static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
> +			     struct intel_svm **rsvm,
> +			     struct intel_svm_dev **rsdev)
> +{
> +	struct intel_svm_dev *d, *sdev =3D NULL;
> +	struct intel_svm *svm;
> +
> +	/* The caller should hold the pasid_mutex lock */
> +	if (WARN_ON(!mutex_is_locked(&pasid_mutex)))
> +		return -EINVAL;
> +
> +	if (pasid =3D=3D INVALID_IOASID || pasid >=3D PASID_MAX)
> +		return -EINVAL;
> +
> +	svm =3D ioasid_find(NULL, pasid, NULL);
> +	if (IS_ERR(svm))
> +		return PTR_ERR(svm);
> +
> +	if (!svm)
> +		goto out;
> +
> +	/*
> +	 * If we found svm for the PASID, there must be at least one device
> +	 * bond.
> +	 */
> +	if (WARN_ON(list_empty(&svm->devs)))
> +		return -EINVAL;
> +
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(d, &svm->devs, list) {
> +		if (d->dev =3D=3D dev) {
> +			sdev =3D d;
> +			break;
> +		}
> +	}
> +	rcu_read_unlock();
> +
> +out:
> +	*rsvm =3D svm;
> +	*rsdev =3D sdev;
> +
> +	return 0;
> +}
> +
>  int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device
> *dev,
>  			  struct iommu_gpasid_bind_data *data)
>  {
> @@ -261,39 +305,27 @@ int intel_svm_bind_gpasid(struct iommu_domain
> *domain, struct device *dev,
>  	dmar_domain =3D to_dmar_domain(domain);
>=20
>  	mutex_lock(&pasid_mutex);
> -	svm =3D ioasid_find(NULL, data->hpasid, NULL);
> -	if (IS_ERR(svm)) {
> -		ret =3D PTR_ERR(svm);
> +	ret =3D pasid_to_svm_sdev(dev, data->hpasid, &svm, &sdev);
> +	if (ret)
>  		goto out;
> -	}
>=20
> -	if (svm) {
> +	if (sdev) {
>  		/*
> -		 * If we found svm for the PASID, there must be at
> -		 * least one device bond, otherwise svm should be freed.
> +		 * For devices with aux domains, we should allow
> +		 * multiple bind calls with the same PASID and pdev.
>  		 */
> -		if (WARN_ON(list_empty(&svm->devs))) {
> -			ret =3D -EINVAL;
> -			goto out;
> +		if (iommu_dev_feature_enabled(dev,
> IOMMU_DEV_FEAT_AUX)) {
> +			sdev->users++;
> +		} else {
> +			dev_warn_ratelimited(dev,
> +					     "Already bound with PASID %u\n",
> +					     svm->pasid);
> +			ret =3D -EBUSY;
>  		}
> +		goto out;
> +	}
>=20
> -		for_each_svm_dev(sdev, svm, dev) {
> -			/*
> -			 * For devices with aux domains, we should allow
> -			 * multiple bind calls with the same PASID and pdev.
> -			 */
> -			if (iommu_dev_feature_enabled(dev,
> -						      IOMMU_DEV_FEAT_AUX))
> {
> -				sdev->users++;
> -			} else {
> -				dev_warn_ratelimited(dev,
> -						     "Already bound with
> PASID %u\n",
> -						     svm->pasid);
> -				ret =3D -EBUSY;
> -			}
> -			goto out;
> -		}
> -	} else {
> +	if (!svm) {
>  		/* We come here when PASID has never been bond to a
> device. */
>  		svm =3D kzalloc(sizeof(*svm), GFP_KERNEL);
>  		if (!svm) {
> @@ -376,25 +408,17 @@ int intel_svm_unbind_gpasid(struct device *dev,
> int pasid)
>  	struct intel_iommu *iommu =3D device_to_iommu(dev, NULL, NULL);
>  	struct intel_svm_dev *sdev;
>  	struct intel_svm *svm;
> -	int ret =3D -EINVAL;
> +	int ret;
>=20
>  	if (WARN_ON(!iommu))
>  		return -EINVAL;
>=20
>  	mutex_lock(&pasid_mutex);
> -	svm =3D ioasid_find(NULL, pasid, NULL);
> -	if (!svm) {
> -		ret =3D -EINVAL;
> -		goto out;
> -	}
> -
> -	if (IS_ERR(svm)) {
> -		ret =3D PTR_ERR(svm);
> +	ret =3D pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
> +	if (ret)
>  		goto out;
> -	}
>=20
> -	for_each_svm_dev(sdev, svm, dev) {
> -		ret =3D 0;
> +	if (sdev) {
>  		if (iommu_dev_feature_enabled(dev,
> IOMMU_DEV_FEAT_AUX))
>  			sdev->users--;
>  		if (!sdev->users) {
> @@ -418,7 +442,6 @@ int intel_svm_unbind_gpasid(struct device *dev, int
> pasid)
>  				kfree(svm);
>  			}
>  		}
> -		break;
>  	}
>  out:
>  	mutex_unlock(&pasid_mutex);
> @@ -596,7 +619,7 @@ intel_svm_bind_mm(struct device *dev, int flags,
> struct svm_dev_ops *ops,
>  	if (sd)
>  		*sd =3D sdev;
>  	ret =3D 0;
> - out:
> +out:
>  	return ret;
>  }
>=20
> @@ -612,17 +635,11 @@ static int intel_svm_unbind_mm(struct device *dev,
> int pasid)
>  	if (!iommu)
>  		goto out;
>=20
> -	svm =3D ioasid_find(NULL, pasid, NULL);
> -	if (!svm)
> -		goto out;
> -
> -	if (IS_ERR(svm)) {
> -		ret =3D PTR_ERR(svm);
> +	ret =3D pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
> +	if (ret)
>  		goto out;
> -	}
>=20
> -	for_each_svm_dev(sdev, svm, dev) {
> -		ret =3D 0;
> +	if (sdev) {
>  		sdev->users--;
>  		if (!sdev->users) {
>  			list_del_rcu(&sdev->list);
> @@ -651,10 +668,8 @@ static int intel_svm_unbind_mm(struct device *dev,
> int pasid)
>  				kfree(svm);
>  			}
>  		}
> -		break;
>  	}
> - out:
> -
> +out:
>  	return ret;
>  }
>=20
> --
> 2.17.1

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
