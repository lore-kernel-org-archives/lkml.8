Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC186C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C62207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 02:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="E8Lzcn5D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgH1CNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 22:13:52 -0400
Received: from mga06.intel.com ([134.134.136.31]:10596 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgH1CNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 22:13:51 -0400
IronPort-SDR: C+m3Aj+/0+tTNeUDIxcTK+VllGEuR5jTovlc9Ks5v4iweem4KZ8rYUEbxq1QssBRvlQb1PeUG5
 /bKQlbxLwnqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="218146508"
X-IronPort-AV: E=Sophos;i="5.76,362,1592895600"; 
   d="scan'208";a="218146508"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 19:13:50 -0700
IronPort-SDR: LVj307zZz0HuSQ+JgUh5S/dVS+/KFq/casMI+Lo+56LS5SZQce9JefkQj5cqnc6tYfhLs5yRg5
 GAaE0I9uE3sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,362,1592895600"; 
   d="scan'208";a="500860731"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga005.fm.intel.com with ESMTP; 27 Aug 2020 19:13:49 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 19:13:45 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 27 Aug 2020 19:13:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX163.amr.corp.intel.com (10.22.240.88) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 27 Aug 2020 19:13:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 27 Aug 2020 19:13:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3u1xpmlCSW+RkXvmnfXmFlYH76Roh8HyhjZX8geG+5M2xy2awDg51/xjLlGxIouN2x4e8dL0PZUcrJDt2BWKATe+/npLNdDrErskK9tZo1ayot6kxE20TZRTs99nBbkv5WkkFInTa+2MLaK1Wh3J/YdjvM6tWuL8256wSkbMeRZuBbsKZvjYOVGbeDi2AKtnyrLRL4BZz32LHs4K5fgUP5HlL0f0RG+K5B1aiFISTBWA9l4si/7ZWo6VVarulPYp2xd45UH6B9atseFuzAP4XD/UxdyTS+xdvRdXe6SIMC17AiCsFZlwUZJ1GutEnwvqqoN+7GxG9msEvZXzTy6Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd1Cq9mbiMPGJBChGAz+IHXG9f+x55zw/pF3dmAPPKg=;
 b=UlMSjHSrMUQs2lsCqXBlyOUK9mlxeStiGuMIr/0JTJa1ydx46eqe5FouUpjyfN4gEsuC+u9fcSNyNJWI/Hh3xfIxcN/cDt/TLASbNynbLsA2Nf+Y0bQqfAsdxy2L8lfd7WtHEkvapXN5eInGSarZQyzC996x5Pn/mo4WUdXtkG6OH6HK+8m3mC9TADFeEAaoC8o81c+xJjHuNlAWKTcuYoxx+Bs3/ZcMfJ43X39kJeXpFi3BSI3LfNcJ2wG4oSR9iqTgaAv7UqAncfjgLW+j2vddZ6ysieZq6D/XMI1DgB2NL2IBlNGaotG5505wozPL86C4sMEdCbnICkyMg6MWOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fd1Cq9mbiMPGJBChGAz+IHXG9f+x55zw/pF3dmAPPKg=;
 b=E8Lzcn5DYJrGVWU7v7EOwlD6fy9p5bqhPeU24+qXqWWT5L723lA0FS5R3l8BN2MeVS1+Ik2ZbxbwZ8g2q4aKxxvBLRn31uKsgFp5pPt4SHLJg/4O7meSpq3jcFkHO516Fo4dpiHFN+SCADDBbFB48oYrr2J6ahwCBu/tV4+zhfU=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR1101MB2335.namprd11.prod.outlook.com (2603:10b6:300:73::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 28 Aug
 2020 02:13:43 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::6dfe:feb8:25f1:ac9c%7]) with mapi id 15.20.3326.023; Fri, 28 Aug 2020
 02:13:43 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Use device numa domain if RHSA is missing
Thread-Topic: [PATCH 1/1] iommu/vt-d: Use device numa domain if RHSA is
 missing
Thread-Index: AQHWfDeoIH2sunow7kWgDxIQlocaualMxVOA
Date:   Fri, 28 Aug 2020 02:13:43 +0000
Message-ID: <MWHPR11MB1645E6D6BD1EFDFA139AA37C8C520@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200827055640.31408-1-baolu.lu@linux.intel.com>
In-Reply-To: <20200827055640.31408-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87a9d1b2-72ca-411f-0def-08d84af7fd01
x-ms-traffictypediagnostic: MWHPR1101MB2335:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2335DFC9B80493C7749186AB8C520@MWHPR1101MB2335.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uDUmTW1TFhzHirh8S0Hpu0mMHcR18bT7Aa6LkwZkTNicnMmAZhKcR25B6t5pmhXNxSkigCGr/jOp3g/ue5kVfM3Drh0Brp+BIpCrtpVDZQIn9Sv38H3AodJD8AoJgTMRx/pp7Z/M6EVTtLloJ7cI337wvaaIhynFam4zrqJies+pt9XSP89qMT4F4Ln3Zzqj0fkhhTCdSCRYMQd5C8vi2EpS26YocOZ9OLc9AF2UG4Fx10fcgV4uIJQDbdQxpasCEWxythnJnwQt1wRn6P+gC9U5gog0tIGiHb6b1hK1vRsh7P6J0E71UU+C1Sw0us8bpcbcpaAsaRhVtjZk7Yy+AA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39860400002)(86362001)(316002)(9686003)(4326008)(8676002)(83380400001)(52536014)(54906003)(71200400001)(110136005)(2906002)(55016002)(8936002)(33656002)(26005)(6506007)(66446008)(186003)(5660300002)(64756008)(66946007)(66556008)(66476007)(76116006)(7696005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Rw+A/lS6RxrIEffG11WQyh3sRAsJK95SLtzcHsDmXlcCo5HLoVZeqWPUN8B9nG/CRzrbrDY91rBvkzbgWn6WAig2onf9o/2l7jWAZb5gQBzdZswE8wv+7WNttJ6hNaGxkHdmA0jmitYpw0cgVyNySeTQts7vNxu+/BioObFJiDJhCeBEnPtOM2Nno1DAF4yYepqvjFiG5ZF7JinFYIml73rg6RxyEzv3RxrHHT7G8LkC2+GAFFZlhSldOFqYjjympWrsD2ApU/B1WmtinVkdH6ZWkPmjLz9TlmvL8bt4SP/uVeOyhSaj1aqZd7YZDac5KagcG4IRkTHE73Li9PJeBjqEoFrywj8U4DmYI446/m6vICH/Qli7b7QmWBnvu8SRxD/lXKuej4+4zWpT5nUGikXpg96NX6WbS268JTVbJLJMQlDB+J02bD/mr7WA2b1YJm72wvJkyfXWT2J2YQy3fFkl2/qIwR8DUIGfiXWG3W11u/1BCetophxL6ZsF4Fs/OeaVGDIbPkyXGgSuOKOY0fC5H+XxeDA5SIyCiEb3rI6AYb3Bu4Snf1poy/n2E2HTzRcZeQ5A56fpjucjqyGv2j/qmJwbXQD/Q7jioPy11g8j2ztrIi8gac6y//vu4rDzoHtL2Xh9gOqEslzaGVEFDA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87a9d1b2-72ca-411f-0def-08d84af7fd01
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 02:13:43.3937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jB7vVmL70MIEDODUdHL/CTzNo9WB143V1g+RZ1kwZX/Uwp0z5QZ0Jp7EThDU3XWPdJnJ3GKy5YQg1yBqeI+pTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2335
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, August 27, 2020 1:57 PM
>=20
> If there are multiple NUMA domains but the RHSA is missing in ACPI/DMAR
> table, we could default to the device NUMA domain as fall back. This also
> benefits the vIOMMU use case where only a single vIOMMU is exposed,
> hence
> no RHSA will be present but device numa domain can be correct.

this benefits vIOMMU but not necessarily only applied to single-vIOMMU
case. The logic still holds in multiple vIOMMU cases as long as RHSA is
not provided.

>=20
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index e0516d64d7a3..bce158468abf 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -700,12 +700,41 @@ static int
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
> +		nid =3D dev_to_node(info->dev);
> +		if (nid !=3D NUMA_NO_NODE)
> +			break;
> +	}

There could be multiple device numa nodes as devices within the
same domain may sit behind different IOMMUs. Of course there
is no perfect answer in such situation, and this patch is still an
obvious improvement on current always-on-node0 policy. But=20
some comment about such implication is welcomed.

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
> @@ -5086,8 +5115,6 @@ static struct iommu_domain
> *intel_iommu_domain_alloc(unsigned type)
>  		if (type =3D=3D IOMMU_DOMAIN_DMA)
>  			intel_init_iova_domain(dmar_domain);
>=20
> -		domain_update_iommu_cap(dmar_domain);
> -

Is it intended or by mistake? If the former, looks it is a separate fix...

>  		domain =3D &dmar_domain->domain;
>  		domain->geometry.aperture_start =3D 0;
>  		domain->geometry.aperture_end   =3D
> --
> 2.17.1

