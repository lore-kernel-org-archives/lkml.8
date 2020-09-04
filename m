Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8107C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F5762075D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 02:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="to0Ux6G2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgIDCQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 22:16:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:64159 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728288AbgIDCQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 22:16:36 -0400
IronPort-SDR: 372zKCy+pGKI+kcEqXq1jgYjsNKf9RHQRVsiRvRkuHVMPKXt/rqSw41VVoXSxaqe4hrvw13nGa
 fjqlpPQofvAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="137735492"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="137735492"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 19:16:32 -0700
IronPort-SDR: 1zW3bsrIErlWrZksla6k1PgPZzo07YRtTNyj46jmLsQ/F1/JehblIZsyUgUNtmKMBCii41Xjx/
 kIWt+bdpZhbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="342013997"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 03 Sep 2020 19:16:32 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 19:16:32 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Sep 2020 19:16:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 3 Sep 2020 19:16:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 3 Sep 2020 19:16:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnq4Rw7USsUEzy2K+35FNuBY5XWWhHd7FyFmW37RaR4c+zEj9hvMpVI3Q0ZsP0rt0w863DjL1U6DZ6pvafCHqRiy9WNFoicx2QAlDWCug5qnWOvHfkIMXnDe7qcBhGfFq4FVDC2E9ddCYXUcj3jXfdqQHININGtV127w+NEgAgAqvvxEAY1VQXiKIGXLHsQIYOGfnciZJtJs075O2+3dmb/5yULqVZAqgmFqA4UwQUCXc+SEicUsvjRvCdexruyJ/YkDc6xB4kjMX2VtN97sBX2UCxBGMUBOj5lS8hJhvigaGHW6ZdbPEPZwgmfcGTSEDYHDCyPatpwwbj3hYaAOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zRHELz8puCzfWtzvkPruH/345zTVhhinclbjkTcpYU=;
 b=mlFPgljYBiI6N8wS52IrKN7+WN2P8nnaQVtlUXatQekTlYpaV3X6QOfqPI2rsE1ZLNtNky3uxbukLdA7hjP3juNGjzgsxOXd7q4a+Bc0UUA7jJJJs5RFRpzkVESo09S+VSYTN0r/6J7zoHL1hKF4aoUlZZ9FFlBEK6EFMoeR0ZwX7eXGCcB4o+HrDpDt/n2ARkIbiI44cFLRiPndfNVyo0pB+pP/hmRfT7yYS+KQPAmNd62tZPdUa6QfibWKwgUtJ9ZHIY8dNP0pXMBFLzmqbguo3lhR7pq85vB4iGdjmaoCD47p6hTqyZHDyHryfOho12etm+KkCgzcO1LPyD7YXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zRHELz8puCzfWtzvkPruH/345zTVhhinclbjkTcpYU=;
 b=to0Ux6G2+6DHkcJ0OLqppsCWYvCIZcP9q2XDj6urnuXbeD0dbeRP47yxYUmlaBLQ0By/3YL9JV8dKVZVjfJb028CSy3p9kC/6LyhAMxvGdWW5Ny43pRUrlWH3ROFI2bhj3MV7PI0oOJ3Wh905XCvoZL0hF7F88fN47LSZF/xNJ4=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR1101MB2205.namprd11.prod.outlook.com (2603:10b6:301:59::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Fri, 4 Sep
 2020 02:16:19 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c%7]) with mapi id 15.20.3348.016; Fri, 4 Sep 2020
 02:16:19 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH v2 1/1] iommu/vt-d: Use device numa domain if RHSA is
 missing
Thread-Topic: [PATCH v2 1/1] iommu/vt-d: Use device numa domain if RHSA is
 missing
Thread-Index: AQHWglgENUnpmhIE202gYc2HK/EdM6lXvO3A
Date:   Fri, 4 Sep 2020 02:16:18 +0000
Message-ID: <MWHPR11MB1645A817E0C928BA83002B4C8C2D0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200904010303.2961-1-baolu.lu@linux.intel.com>
In-Reply-To: <20200904010303.2961-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.212]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6390988c-0206-4f8c-56e4-08d8507882a9
x-ms-traffictypediagnostic: MWHPR1101MB2205:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB220514262660F60ECA25D0FD8C2D0@MWHPR1101MB2205.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2jn6D+fYXHQlWbqSDoxEY8GK96pnCzgtFbDtzK51GBHz5yrx0RN4xXqFW8XLrVRs/URhCLqyf0J6nsLodu5kizbXodQOBLA9V2XMByNsxphG7qSJoQ6GtJoaH5DateJj3FkBkrZ0R+AtuCpsVxopmEPss4prKqvpuaA7QxawklqYnROXdZdXNqr+axian6sAxt/HgO8P8wKVYVmIlDrdEFNss7tgkT8xHUPCpALErlvoSHhmGQlmafxsdOoFOiv5GxLgiNxbODS6WFKMRe/R/xkxufJx5n0S/EWxrPb//PMraQl+VJznctbNtphoEl3q+BUOPZn+ok23U4PvOFFBJdDLa/U/7hFNpwqC28NA2iM/P+T6ftysvz9pSBam1Fx0vrBHmd2uaqm2rK279XIU5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(316002)(86362001)(9686003)(33656002)(8676002)(2906002)(83380400001)(110136005)(26005)(66476007)(66446008)(186003)(66946007)(76116006)(966005)(54906003)(55016002)(8936002)(4326008)(66556008)(64756008)(478600001)(5660300002)(45080400002)(52536014)(6506007)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +BTcBxuUwxM1ja0OKYnCd15UmeN3B8YR7vTL+wXdgTZD2Ly4lRntZ/f5mY2LYvg83RkMrnWENI1FDxzFNwkzZ49pSzsL8KeBkVZiI6bt+VqOPGAF9tmD07cJ+oDckmC8hvUmEBvfrdfGVkmRm9g+gEcEGfPmjOkre8V5WHHAYwgGa2EvBlU0E9ibgmrbaNh5K+pDY0VWRMNbPpaHPoGJ9gZaVU4IY/0YE5qAIxuQq4XGCxjE1Sj4u3sghkoAouvzeBTYt3+kOvO8hUeEB8LghYGa6plpO/MhfiXPlnEJZSvnR+VKQSN8AL3ldWJN2PLlEaCIpQbWxUxyfjebQGvU9xB9CO8JDcioeK3dxLPmSBxSqwZxyFGHCGnvBbX/ZneTdmVgbSzfWEnPxyojT2luC7grWzwcYMP/oD9DYdFmsyMBqOzmXxzMp+6ej+ALP1/wiSoVtj4Bas6TvnzYqX2+kk41a5ohWNZP9QFcMejJfPNuuZpWrKkcGBfTEcVXqZ2DGb0VTnovhinLhdCmznRQeLKlpldNXnuB8RM/Bfthh3rv0jeUwncQAZKDVahtV1sWq2uV1y8z8Ak+tKIat/Y2AubvS4A/RqX7gq3RSprMa7Vy+RzVYRyGSF5COasjToDv7pkdx5IqRGpNydS9+COlvw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6390988c-0206-4f8c-56e4-08d8507882a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 02:16:19.0119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwVuFLRxlkIkvb3iLAHNavrb0mDHrc9acc/F8bVJMafFPlJ49DwygnB/lC5+DRDb9XtoJ//mYFpX6pM4Q1eJ1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2205
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu
> Sent: Friday, September 4, 2020 9:03 AM
>=20
> If there are multiple NUMA domains but the RHSA is missing in ACPI/DMAR
> table, we could default to the device NUMA domain as fall back. This coul=
d
> also benefit a vIOMMU use case where only single vIOMMU is exposed,
> hence
> no RHSA will be present but device numa domain can be correct.

My comment on this is not fixed. It is not restricted to single-vIOMMU situ=
ation.
and actually this may also happen on physical platform if some FW doesn't
provide RHSA information.

with that being fixed:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

>=20
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 37
> +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>=20
> Change log:
> v1->v2:
>   - Add a comment as suggested by Kevin.
>     https://lore.kernel.org/linux-
> iommu/MWHPR11MB1645E6D6BD1EFDFA139AA37C8C520@MWHPR11MB1
> 645.namprd11.prod.outlook.com/
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 7f844d1c8cd9..69d5a87188f4 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -698,12 +698,47 @@ static int
> domain_update_iommu_superpage(struct dmar_domain *domain,
>  	return fls(mask);
>  }
>=20
> +static int domain_update_device_node(struct dmar_domain *domain)
> +{
> +	struct device_domain_info *info;
> +	int nid =3D NUMA_NO_NODE;
> +
> +	assert_spin_locked(&device_domain_lock);
> +
> +	if (list_empty(&domain->devices))
> +		return NUMA_NO_NODE;
> +
> +	list_for_each_entry(info, &domain->devices, link) {
> +		if (!info->dev)
> +			continue;
> +
> +		/*
> +		 * There could possibly be multiple device numa nodes as
> devices
> +		 * within the same domain may sit behind different IOMMUs.
> There
> +		 * isn't perfect answer in such situation, so we select first
> +		 * come first served policy.
> +		 */
> +		nid =3D dev_to_node(info->dev);
> +		if (nid !=3D NUMA_NO_NODE)
> +			break;
> +	}
> +
> +	return nid;
> +}
> +
>  /* Some capabilities may be different across iommus */
>  static void domain_update_iommu_cap(struct dmar_domain *domain)
>  {
>  	domain_update_iommu_coherency(domain);
>  	domain->iommu_snooping =3D
> domain_update_iommu_snooping(NULL);
>  	domain->iommu_superpage =3D
> domain_update_iommu_superpage(domain, NULL);
> +
> +	/*
> +	 * If RHSA is missing, we should default to the device numa domain
> +	 * as fall back.
> +	 */
> +	if (domain->nid =3D=3D NUMA_NO_NODE)
> +		domain->nid =3D domain_update_device_node(domain);
>  }
>=20
>  struct context_entry *iommu_context_addr(struct intel_iommu *iommu, u8
> bus,
> @@ -5096,8 +5131,6 @@ static struct iommu_domain
> *intel_iommu_domain_alloc(unsigned type)
>  		if (type =3D=3D IOMMU_DOMAIN_DMA)
>  			intel_init_iova_domain(dmar_domain);
>=20
> -		domain_update_iommu_cap(dmar_domain);
> -
>  		domain =3D &dmar_domain->domain;
>  		domain->geometry.aperture_start =3D 0;
>  		domain->geometry.aperture_end   =3D
> --
> 2.17.1
>=20
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
