Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C136CC47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95029207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 05:35:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="QGTGHWc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEGFfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 01:35:14 -0400
Received: from mga09.intel.com ([134.134.136.24]:18871 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgEGFfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 01:35:14 -0400
IronPort-SDR: rPWMVeFI72HDGFbvTJqbKCp227E5x0ng+GK15ro1VBAX03Ufxz46G/EV3MJ1iZB6hmfYGPRqH8
 hpm/fd6oK+dw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2020 22:35:13 -0700
IronPort-SDR: 4cieicAh2mepeQiAlG8m9J10BbbqaEoRZaSIx8SxMdm8rHJVLN4SSdSaJNKrjokItknMN23DGP
 bkdH7X64PMkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,362,1583222400"; 
   d="scan'208";a="461723396"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga005.fm.intel.com with ESMTP; 06 May 2020 22:35:13 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 22:35:12 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 6 May 2020 22:35:12 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 6 May 2020 22:35:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 6 May 2020 22:35:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSBiEqU7f3GPFtFHYcrAL4+3ni9mpQshgP1SQVj1Kc+vMmC3YrhsoTaZjP3KqdwJAzHaq/OUyMzxpHh/zsgXqG1nLZbDX3FoxHR1B5S2TXm0hLmQnZeDFO7ZnRGfScIh+FhBVU/tG+9+0B3PCfcVi5CddESbVsCZuvsBk4cYQyZE7JCnnByBfBR3+F7siMHnMY+TYtr0NKhl4X1dlEYcJwDZK/FGwUINPmwMeC+xezo3c1KQEHb1dlhtCte3UGVdCEgqTba1GmnaL6xup0Tq6oJk8MJcTEo63iz5XCKUkC4uRHg/a8S6Pvs8rGwMgncyP4ZH1ULW9uEaexX/hoxRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6xsjAk27yzNE049dGs64/wdh/2aL7kfiXQbCxNgjOs=;
 b=CpiG2l+3MjBSl7rv9oHSw4loe8pDSnX7CrSEF3x93/bEUgQ3t3xpkVTPUAkI1EOEjYgIhxLewWpx5pXXWbKAIFGKnSDU4dNBTAm6nEI0B9DVoM/6XNxUadM7gBNJfYT0Kio16qr9dCvPH5pOXYn0Sybz9OUf6B/Z2z00UwuaRPu2+mmyh5WAZZELHdLKdK0YtiL/7KWIK9KYOVENSLmbdOVePNG8r5/CUV8y1yeC6ayCnqljUqga4BEBjpif2SNlqDZrHQCX0gaGV/WkL1xRPfxSqSL7HF+XX9fKAIjQgzfxgLB8e1cHYCzYXYMV0UUq/xcsCGOPkIjoPYDSBP1WoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6xsjAk27yzNE049dGs64/wdh/2aL7kfiXQbCxNgjOs=;
 b=QGTGHWc9p2X8Rw45rt0rsonHx5noutPilkA4IN9KqTFxQIkOlfmIWCR7/GcDklwO3sytsbyfmaOtUskW1MgOINtKVXRQwlSvtbWDJbcF2iUkX7usKt+c02pHopctqg/eIgBEkkbd9y0nIQckzabKOpsaX43HP8YpnIU8L/LMqw4=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1824.namprd11.prod.outlook.com (2603:10b6:300:110::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Thu, 7 May
 2020 05:34:31 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::bc06:71a6:1cdd:59be%9]) with mapi id 15.20.2979.028; Thu, 7 May 2020
 05:34:31 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 1/5] iommu/vt-d: Multiple descriptors per
 qi_submit_sync()
Thread-Topic: [PATCH v4 1/5] iommu/vt-d: Multiple descriptors per
 qi_submit_sync()
Thread-Index: AQHWJArHYhcmnX3HpkWl2s/s/v+n1KicGiwQ
Date:   Thu, 7 May 2020 05:34:31 +0000
Message-ID: <MWHPR11MB1645E6B0CB46F0EF18D0FAB78CA50@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <20200507005534.3080-1-baolu.lu@linux.intel.com>
 <20200507005534.3080-2-baolu.lu@linux.intel.com>
In-Reply-To: <20200507005534.3080-2-baolu.lu@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: 48a40758-798b-45d8-a95e-08d7f248519f
x-ms-traffictypediagnostic: MWHPR11MB1824:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB182407CA20DEDED816AA5C358CA50@MWHPR11MB1824.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 03965EFC76
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xIU+58aRJNFAI/moKPLtJiBnvvPwfloMeMxwPW0a/C0w5MFRvtxZl0wqB6ELeMZIQgaAexNisMd6p2uwJaXOdFH2KiOZJje2Z6bstzM5KsKQPYByNQHVe0Ij30MfHho8fcmuvM2/LoPc2hhizQYjQydDBkFVs1TzZRO9xIlC1DRrmkOWzAPVIgz/I0w95AErsUNg+5uL/Zm6g3Dp8mq4jluV4asAaCZ+pAo9PDjrQCKoztI8Q7LtB3C6GzDc05LF7GObrKuIQ+OVNpXylxflaZOANv7ytyfjivjLGyiv7D75kCQNy2w3lFIYDdHfOYxWVqI9j8JlZQzLBNp5xO1Cg1VwyNoZAy4YSogVwOEatRZNALMwmxNiym6pF0CAvT+jR0j509jIYhQI4kngrIpPBpku1BnUgocwZnhSvBB7cDOGdf5ZuLc1A+RlyHinAHlltijeO6nAftpFFCfoo2kkT2vaC3zBR4PkDWumF36Tww1XsGmPKMcLAouyzAXhzVNPa+hQA5GZkXBd83cbnn2TVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(346002)(376002)(136003)(39860400002)(366004)(33430700001)(2906002)(9686003)(478600001)(33656002)(55016002)(4326008)(52536014)(8936002)(76116006)(8676002)(86362001)(26005)(316002)(64756008)(66476007)(186003)(66946007)(33440700001)(71200400001)(7696005)(6506007)(66446008)(5660300002)(110136005)(66556008)(83320400001)(83280400001)(83300400001)(83310400001)(83290400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5nR7jqCqfkw9p6b7gqdXAsXM/iOZoui2AbE3wqr84T7vOEpwc6ZKCfITDp5MuuP+UmccjXraBZBqW5dCODq/pUGQvx9abmpY1RpaV7GMsWv2iDk7AU50k/6dS6z2tASOoldzJ4Hm2jw2hFTpjkACqugpe8g6+b2vH2QuKolWIgf07CNgkFf9iFMmOZBzXxoaPpl2mrWDo87Zr7qeNOA13fRPWuvwZrko+xH5uRrbW4qUhfsvY42VlRGV63433R7iFKfkROl42SztBMvBKr2GZ6cLZd6y3gm49fKSFXWdWKwE+wSwLUtmnsIqxWJ7FPXKdsb9xrEAeOB248av39W+OKPfY9u2sWW24f061N24SEh8jAdIXTucOFjNN4VaJFs9Y/j6PWsjSVgIZ08A1JnNlQ2Z8kMk5r0UH4yAHwe3QQA2Zg1h+RJn7EiLjpLNkKzO48qrKWmVBPP0rRiCZ1bNPPt0YP3l8KhI0lXBPDq2fspvdPts/9f170o5mo9vv6JRNnFVFLx0CjmkZjlypiRPK68E8hETNOzR8pZaObZpUFGKI9nYHMIjGhwaqW4Fes8EyC4874FBSyrmilOl5kEgi0a0w0/wm4j7qOGUBKTvD8XM2oShoUpULMW5e+WuMZbbvDdY+aXw1FFx2F1MQ/iLhKzjZucFcJ1vPDA+gjKOUKwQgQNRTpePSHw4zhxeNJKlpQbIdX/UdIsJf13eJMzU1210KBZczkvT2LItCHj7WghVSiAUR1HHgvjE8zNqnnvo9kdG6Mfy5H5eynz0vYPN3fTcc9G7kVunq2KvuSWdvWs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 48a40758-798b-45d8-a95e-08d7f248519f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2020 05:34:31.6070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCXoGiZBoxpP+vNWj12kS3C43ZGbo9ICs+yXiIGlKag5ofBncF4Kxy+s9/ZTrGWpxJT/FKvVSRdbLdZ2yWV0Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1824
X-OriginatorOrg: intel.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Thursday, May 7, 2020 8:56 AM
>=20
> Current qi_submit_sync() only supports single invalidation descriptor
> per submission and appends wait descriptor after each submission to
> poll the hardware completion. This extends the qi_submit_sync() helper
> to support multiple descriptors, and add an option so that the caller
> could specify the Page-request Drain (PD) bit in the wait descriptor.
>=20
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/dmar.c                | 63 +++++++++++++++++------------
>  drivers/iommu/intel-pasid.c         |  4 +-
>  drivers/iommu/intel-svm.c           |  6 +--
>  drivers/iommu/intel_irq_remapping.c |  2 +-
>  include/linux/intel-iommu.h         |  9 ++++-
>  5 files changed, 52 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/iommu/dmar.c b/drivers/iommu/dmar.c
> index d9dc787feef7..61d049e91f84 100644
> --- a/drivers/iommu/dmar.c
> +++ b/drivers/iommu/dmar.c
> @@ -1157,12 +1157,11 @@ static inline void reclaim_free_desc(struct
> q_inval *qi)
>  	}
>  }
>=20
> -static int qi_check_fault(struct intel_iommu *iommu, int index)
> +static int qi_check_fault(struct intel_iommu *iommu, int index, int
> wait_index)
>  {
>  	u32 fault;
>  	int head, tail;
>  	struct q_inval *qi =3D iommu->qi;
> -	int wait_index =3D (index + 1) % QI_LENGTH;
>  	int shift =3D qi_shift(iommu);
>=20
>  	if (qi->desc_status[wait_index] =3D=3D QI_ABORT)
> @@ -1225,17 +1224,21 @@ static int qi_check_fault(struct intel_iommu
> *iommu, int index)
>  }
>=20
>  /*
> - * Submit the queued invalidation descriptor to the remapping
> - * hardware unit and wait for its completion.
> + * Function to submit invalidation descriptors of all types to the queue=
d
> + * invalidation interface(QI). Multiple descriptors can be submitted at =
a
> + * time, a wait descriptor will be appended to each submission to ensure
> + * hardware has completed the invalidation before return. Wait descripto=
rs
> + * can be part of the submission but it will not be polled for completio=
n.
>   */
> -int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iommu)
> +int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
> +		   unsigned int count, unsigned long options)
>  {
> -	int rc;
>  	struct q_inval *qi =3D iommu->qi;
> -	int offset, shift, length;
>  	struct qi_desc wait_desc;
>  	int wait_index, index;
>  	unsigned long flags;
> +	int offset, shift;
> +	int rc, i;
>=20
>  	if (!qi)
>  		return 0;
> @@ -1244,32 +1247,41 @@ int qi_submit_sync(struct qi_desc *desc, struct
> intel_iommu *iommu)
>  	rc =3D 0;
>=20
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
>=20
>  	index =3D qi->free_head;
> -	wait_index =3D (index + 1) % QI_LENGTH;
> +	wait_index =3D (index + count) % QI_LENGTH;
>  	shift =3D qi_shift(iommu);
> -	length =3D 1 << shift;
>=20
> -	qi->desc_status[index] =3D qi->desc_status[wait_index] =3D QI_IN_USE;
> +	for (i =3D 0; i < count; i++) {
> +		offset =3D ((index + i) % QI_LENGTH) << shift;
> +		memcpy(qi->desc + offset, &desc[i], 1 << shift);
> +		qi->desc_status[(index + i) % QI_LENGTH] =3D QI_IN_USE;
> +	}
> +	qi->desc_status[wait_index] =3D QI_IN_USE;
>=20
> -	offset =3D index << shift;
> -	memcpy(qi->desc + offset, desc, length);
>  	wait_desc.qw0 =3D QI_IWD_STATUS_DATA(QI_DONE) |
>  			QI_IWD_STATUS_WRITE | QI_IWD_TYPE;
> +	if (options & QI_OPT_WAIT_DRAIN)
> +		wait_desc.qw0 |=3D QI_IWD_PRQ_DRAIN;
>  	wait_desc.qw1 =3D virt_to_phys(&qi->desc_status[wait_index]);
>  	wait_desc.qw2 =3D 0;
>  	wait_desc.qw3 =3D 0;
>=20
>  	offset =3D wait_index << shift;
> -	memcpy(qi->desc + offset, &wait_desc, length);
> +	memcpy(qi->desc + offset, &wait_desc, 1 << shift);
>=20
> -	qi->free_head =3D (qi->free_head + 2) % QI_LENGTH;
> -	qi->free_cnt -=3D 2;
> +	qi->free_head =3D (qi->free_head + count + 1) % QI_LENGTH;
> +	qi->free_cnt -=3D count + 1;
>=20
>  	/*
>  	 * update the HW tail register indicating the presence of
> @@ -1285,7 +1297,7 @@ int qi_submit_sync(struct qi_desc *desc, struct
> intel_iommu *iommu)
>  		 * a deadlock where the interrupt context can wait
> indefinitely
>  		 * for free slots in the queue.
>  		 */
> -		rc =3D qi_check_fault(iommu, index);
> +		rc =3D qi_check_fault(iommu, index, wait_index);
>  		if (rc)
>  			break;
>=20
> @@ -1294,7 +1306,8 @@ int qi_submit_sync(struct qi_desc *desc, struct
> intel_iommu *iommu)
>  		raw_spin_lock(&qi->q_lock);
>  	}
>=20
> -	qi->desc_status[index] =3D QI_DONE;
> +	for (i =3D 0; i < count; i++)
> +		qi->desc_status[(index + i) % QI_LENGTH] =3D QI_DONE;
>=20
>  	reclaim_free_desc(qi);
>  	raw_spin_unlock_irqrestore(&qi->q_lock, flags);
> @@ -1318,7 +1331,7 @@ void qi_global_iec(struct intel_iommu *iommu)
>  	desc.qw3 =3D 0;
>=20
>  	/* should never fail */
> -	qi_submit_sync(&desc, iommu);
> +	qi_submit_sync(iommu, &desc, 1, 0);
>  }
>=20
>  void qi_flush_context(struct intel_iommu *iommu, u16 did, u16 sid, u8 fm=
,
> @@ -1332,7 +1345,7 @@ void qi_flush_context(struct intel_iommu *iommu,
> u16 did, u16 sid, u8 fm,
>  	desc.qw2 =3D 0;
>  	desc.qw3 =3D 0;
>=20
> -	qi_submit_sync(&desc, iommu);
> +	qi_submit_sync(iommu, &desc, 1, 0);
>  }
>=20
>  void qi_flush_iotlb(struct intel_iommu *iommu, u16 did, u64 addr,
> @@ -1356,7 +1369,7 @@ void qi_flush_iotlb(struct intel_iommu *iommu,
> u16 did, u64 addr,
>  	desc.qw2 =3D 0;
>  	desc.qw3 =3D 0;
>=20
> -	qi_submit_sync(&desc, iommu);
> +	qi_submit_sync(iommu, &desc, 1, 0);
>  }
>=20
>  void qi_flush_dev_iotlb(struct intel_iommu *iommu, u16 sid, u16 pfsid,
> @@ -1378,7 +1391,7 @@ void qi_flush_dev_iotlb(struct intel_iommu
> *iommu, u16 sid, u16 pfsid,
>  	desc.qw2 =3D 0;
>  	desc.qw3 =3D 0;
>=20
> -	qi_submit_sync(&desc, iommu);
> +	qi_submit_sync(iommu, &desc, 1, 0);
>  }
>=20
>  /* PASID-based IOTLB invalidation */
> @@ -1419,7 +1432,7 @@ void qi_flush_piotlb(struct intel_iommu *iommu,
> u16 did, u32 pasid, u64 addr,
>  				QI_EIOTLB_AM(mask);
>  	}
>=20
> -	qi_submit_sync(&desc, iommu);
> +	qi_submit_sync(iommu, &desc, 1, 0);
>  }
>=20
>  /* PASID-based device IOTLB Invalidate */
> @@ -1448,7 +1461,7 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu
> *iommu, u16 sid, u16 pfsid,
>  	if (size_order)
>  		desc.qw1 |=3D QI_DEV_EIOTLB_SIZE;
>=20
> -	qi_submit_sync(&desc, iommu);
> +	qi_submit_sync(iommu, &desc, 1, 0);
>  }
>=20
>  void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did,
> @@ -1458,7 +1471,7 @@ void qi_flush_pasid_cache(struct intel_iommu
> *iommu, u16 did,
>=20
>  	desc.qw0 =3D QI_PC_PASID(pasid) | QI_PC_DID(did) |
>  			QI_PC_GRAN(granu) | QI_PC_TYPE;
> -	qi_submit_sync(&desc, iommu);
> +	qi_submit_sync(iommu, &desc, 1, 0);
>  }
>=20
>  /*
> diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
> index 48cc9ca5f3dc..7969e3dac2ad 100644
> --- a/drivers/iommu/intel-pasid.c
> +++ b/drivers/iommu/intel-pasid.c
> @@ -498,7 +498,7 @@ pasid_cache_invalidation_with_pasid(struct
> intel_iommu *iommu,
>  	desc.qw2 =3D 0;
>  	desc.qw3 =3D 0;
>=20
> -	qi_submit_sync(&desc, iommu);
> +	qi_submit_sync(iommu, &desc, 1, 0);
>  }
>=20
>  static void
> @@ -512,7 +512,7 @@ iotlb_invalidation_with_pasid(struct intel_iommu
> *iommu, u16 did, u32 pasid)
>  	desc.qw2 =3D 0;
>  	desc.qw3 =3D 0;
>=20
> -	qi_submit_sync(&desc, iommu);
> +	qi_submit_sync(iommu, &desc, 1, 0);
>  }
>=20
>  static void
> diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel-svm.c
> index e9f4e979a71f..83dc4319f661 100644
> --- a/drivers/iommu/intel-svm.c
> +++ b/drivers/iommu/intel-svm.c
> @@ -138,7 +138,7 @@ static void intel_flush_svm_range_dev (struct
> intel_svm *svm, struct intel_svm_d
>  	}
>  	desc.qw2 =3D 0;
>  	desc.qw3 =3D 0;
> -	qi_submit_sync(&desc, svm->iommu);
> +	qi_submit_sync(svm->iommu, &desc, 1, 0);
>=20
>  	if (sdev->dev_iotlb) {
>  		desc.qw0 =3D QI_DEV_EIOTLB_PASID(svm->pasid) |
> @@ -162,7 +162,7 @@ static void intel_flush_svm_range_dev (struct
> intel_svm *svm, struct intel_svm_d
>  		}
>  		desc.qw2 =3D 0;
>  		desc.qw3 =3D 0;
> -		qi_submit_sync(&desc, svm->iommu);
> +		qi_submit_sync(svm->iommu, &desc, 1, 0);
>  	}
>  }
>=20
> @@ -850,7 +850,7 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>  				       sizeof(req->priv_data));
>  			resp.qw2 =3D 0;
>  			resp.qw3 =3D 0;
> -			qi_submit_sync(&resp, iommu);
> +			qi_submit_sync(iommu, &resp, 1, 0);
>  		}
>  		head =3D (head + sizeof(*req)) & PRQ_RING_MASK;
>  	}
> diff --git a/drivers/iommu/intel_irq_remapping.c
> b/drivers/iommu/intel_irq_remapping.c
> index 81e43c1df7ec..a042f123b091 100644
> --- a/drivers/iommu/intel_irq_remapping.c
> +++ b/drivers/iommu/intel_irq_remapping.c
> @@ -151,7 +151,7 @@ static int qi_flush_iec(struct intel_iommu *iommu, in=
t
> index, int mask)
>  	desc.qw2 =3D 0;
>  	desc.qw3 =3D 0;
>=20
> -	return qi_submit_sync(&desc, iommu);
> +	return qi_submit_sync(iommu, &desc, 1, 0);
>  }
>=20
>  static int modify_irte(struct irq_2_iommu *irq_iommu,
> diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
> index cfe720f10112..cca1e5f9aeaa 100644
> --- a/include/linux/intel-iommu.h
> +++ b/include/linux/intel-iommu.h
> @@ -333,6 +333,7 @@ enum {
>=20
>  #define QI_IWD_STATUS_DATA(d)	(((u64)d) << 32)
>  #define QI_IWD_STATUS_WRITE	(((u64)1) << 5)
> +#define QI_IWD_PRQ_DRAIN	(((u64)1) << 7)
>=20
>  #define QI_IOTLB_DID(did) 	(((u64)did) << 16)
>  #define QI_IOTLB_DR(dr) 	(((u64)dr) << 7)
> @@ -710,7 +711,13 @@ void qi_flush_dev_iotlb_pasid(struct intel_iommu
> *iommu, u16 sid, u16 pfsid,
>  void qi_flush_pasid_cache(struct intel_iommu *iommu, u16 did, u64 granu,
>  			  int pasid);
>=20
> -extern int qi_submit_sync(struct qi_desc *desc, struct intel_iommu *iomm=
u);
> +int qi_submit_sync(struct intel_iommu *iommu, struct qi_desc *desc,
> +		   unsigned int count, unsigned long options);
> +/*
> + * Options used in qi_submit_sync:
> + * QI_OPT_WAIT_DRAIN - Wait for PRQ drain completion, spec 6.5.2.8.
> + */
> +#define QI_OPT_WAIT_DRAIN		BIT(0)
>=20
>  extern int dmar_ir_support(void);
>=20
> --
> 2.17.1

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
