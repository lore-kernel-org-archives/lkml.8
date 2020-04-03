Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4DBC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B2C20719
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eJke8NWJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="T8+6EFVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbgDCUaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:30:00 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23046 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCUaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:30:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585945801; x=1617481801;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sUQsZE3e2/1Hyte3CchJEgrdHY5tsedbTcdWhgl42Ik=;
  b=eJke8NWJ1kmLj8NeaXKNeMR962BUYkTPbzc/3wSz1s2YR4puCHdatzuP
   4or2HNmfhzZbJ0CmpYxlFRYef52Z7KIbC+6lgJFaDIbO0DiROR+zlPXMD
   EEQpgnXOrhyGFw3MlkVeIHCZeXY+87XRayTd2IyTlwIhIfNQObgepBArJ
   c2TPS88ZvJB+ULi2qfmlFkmY5Vwmm0q1mjc5ED2zBNFaHbbMDuVKzE7R8
   0Ghup36gM462avz80kdW8NHuwkuVWlQ1CONSuMJivKkdqa9Txmq+0l0kd
   JQ/VWUPjCe/Wik3COUcAuUBscdzmeXeP85HVWUWf7fEGEi3xtt4O3zMeV
   g==;
IronPort-SDR: r8CV7x0ZEMgtpnQLUnQd2siESHJnH4DW39haGHbGVbxpBil/LhwFKxfYHNK3WFyb5GoS2O2Tn2
 0pe9c9KQBlPgyrGRpRB79BYvJ3a5OCBAMOiXEfYbz5MuqK1jsJ0uR4OPm3uRJOKtuh91cU7+sR
 L+vq98mJKK4j0ejiEE6asN7rYHdi0EYOcZqZ4wkR6yfz1qDP3sskLAFCu3wCyKeOaP7WDsH+lb
 16zXfDTDg6LdprAfz53EbsIhkJmcHrlGOZp8a60RRkaWIjulXSvRTuOCB+DtgBtwSAuQngyPjr
 zN8=
X-IronPort-AV: E=Sophos;i="5.72,341,1580745600"; 
   d="scan'208";a="236837677"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2020 04:30:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyTN092D1Ffh37YDqvUrUvMO5RS+x1/81lVRV20ZxlelUIdrZirzG9b/+qVwGlgv6JRxs7FK9lzO2jFlBenpurACZUHHLyN1bkVbhKptvoXYVlNtsv/HOSno56O5d7IDsQGyAcjjXjziocGLXXuzaRukJGF2nR7Fc+HrTN9xw0UJXd2uFDHGZB3rVJBnXuhIYmkMLZFXtzAiq8O7mOFr8KXhp3LS6EAOJmMsfYoppTvgBF4leDA3c0xAW6WOw5vUF0ApUGTB9DzJsJmz7IfdyW+pK1XIPZQHfH3upV8Nr58jUUQifQeK1Gs66dg8LZ8wQzSwwv64Gl3RvYcNLGA+Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7ZZpApCIGTzS1XeLIlFWk6Dr81eJNVpakh35bui6as=;
 b=M3DnK1NXEIO8THWRe39x1pClDsifJRHJTKWkRB4Ns7mB7faFPEV3BcB2o9S8o6DVgdtPw7xV/aHJOOwbREtmwz1jx6/I7OAYsyQh+tsp/2651tskKaxsSxTDZDlhGH6dpazMvQi78nUT7gR1UPRPmJVVG8184mk4/2itvfaaMTllSdOoeGq72TyvornbSIJ5V/4hyxOoLOdwrZxRtYFHbNwy8D3BvHg/LnmcISoNgZjFMGBkfH26oJmNl1l3pMuWRm+nPSAcqAao8GJV87kzEiDwZL93yksJCWGVir2bjsP0QfyqHstdYwCm0/EuQOBdxikU+Ojtzj2A2zqhM3eqLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O7ZZpApCIGTzS1XeLIlFWk6Dr81eJNVpakh35bui6as=;
 b=T8+6EFVeZb9qaYmCxFPdoEzlQx9zyzLw/C0xPrT+iatkBMo7i5oetSugY35RNIIPa0BRBD+4Mbo8f4SLKAmlhQHeuPF94JP03PaAdUtD1e+hIlphGzPsoqWCdkoSHF7W6CaCK7OM6IAPEkCypAh/0AUEQyUxz5wFNZRDWIxAG1M=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Fri, 3 Apr
 2020 20:29:57 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 20:29:57 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Anthony Iliopoulos <ailiop@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Thread-Topic: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Thread-Index: AQHWCSVL06kuVSKmBEqONSGslHKI9A==
Date:   Fri, 3 Apr 2020 20:29:56 +0000
Message-ID: <BYAPR04MB49656549926DDB70C95620B986C70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200402193052.19935-1-ailiop@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 46d63de7-3c7f-4ca6-a2ca-08d7d80dc65b
x-ms-traffictypediagnostic: BYAPR04MB4296:
x-microsoft-antispam-prvs: <BYAPR04MB4296AD4F34D2616A149CC48A86C70@BYAPR04MB4296.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(478600001)(4744005)(55016002)(110136005)(4326008)(54906003)(316002)(186003)(7696005)(66556008)(86362001)(53546011)(33656002)(52536014)(8936002)(66446008)(5660300002)(8676002)(66946007)(66476007)(76116006)(6506007)(81166006)(71200400001)(64756008)(26005)(9686003)(2906002)(81156014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zbB4oxFcYY8YKWJJpXfdbr6jU9PbK+yh125ixQQ2rK130y5UBPnyLlhZC2/KFYZlr0B2Femv0TKbEfHLnQspO6hWTxVNHFCdY8itX8jfKwz3TfmOPQuZSdI8LnRSV+QjzmcLDIToX32mT83fcH/psh67IvU6El6es7Yym6iHuZw+CfbJc2cOu0I+pXHE0XxpAhYnllQrmzJq6bj++NA9Ex23tw/8KxSK5e/pZ3rXlmy+cD+/Z23HEliBQROgSoQ0rlzIc6DJJXgRFL3EJTrwKg5O9xv44hA2ZBbB8DwBFrGAoMbp/vPGSHxqkn0xks69gMI2tA54PEFaRpX7YZbi7LryO9P/ym654VBnPi3rrC2rTwi08X044BKxy0SduY7a4QuHmogbKMhy4U5SiExZq4yPU9qDQ2c39akN8VjCGMnLH2AgqgcQHaLRIBmq7XR8
x-ms-exchange-antispam-messagedata: iof/TNc8ycS+WIUTC2NF7ZjHDmScNbWgrgbfJ1u+MaPj0cfU2om6y0t41xIIxtjnpIEKp3dyBmrlhbd4DduoR+L+NZ/PvhRiNg4xckcylDj0YUGarKUJRj1tAbLTKGsIkdLFAcHWW4dzO6b1cRHxKg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d63de7-3c7f-4ca6-a2ca-08d7d80dc65b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 20:29:56.9023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /YU0EkC8JZSHKBVVKt0Oo/TaJN7dH5Z1xZYpJGsiqge26cTrQ74W+u0zG2VNr3EOqFwf+wlyAn6YOWHeUNxelaq+tkzgoX/t1Cfg2ON3nco=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2020 12:31 PM, Anthony Iliopoulos wrote:=0A=
> +void nvmet_file_ns_revalidate(struct nvmet_ns *ns)=0A=
> +{=0A=
> +	struct kstat stat;=0A=
> +=0A=
> +	if (!ns->file)=0A=
> +		return;=0A=
No need for the above check.=0A=
> +=0A=
> +	if (vfs_getattr(&ns->file->f_path,=0A=
> +			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC))=0A=
> +		return;=0A=
=0A=
Error handling needed ? What should we set ns->size if vfs_getattr=0A=
fails ? in case of error what nvmet_identify_ns() report success or a=0A=
failure ?=0A=
> +=0A=
> +	ns->size =3D stat.size;=0A=
bdev checks the ns->size !=3D size, why the same check is not here ?=0A=
=0A=
Just remove the check from bdev and see my comment there.=0A=
> +}=0A=
=0A=
