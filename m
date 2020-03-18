Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE01C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 094C82076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XllAKd1A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgCRMlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:41:50 -0400
Received: from mail-co1nam11on2042.outbound.protection.outlook.com ([40.107.220.42]:18241
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726546AbgCRMls (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:41:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f16G5FZwtgVCaycGRhDvbFG12FGkFEXfNIGVsXqFNKOzk6v1EQzG9Xn6ieSpaqQBE8m09zLsP7zvgtSk4MeBcadojpg9geLv0ByQ17R2JW4oosbmvRKx87H+OVeQJv8BSObO+8E/5peHTqgkKuIjCy13+zA+n/YJkAYc/XYE/W+QYdiGXmSWvYaUMes6m3O9NFhc25xpwe5JD8NZv6ZH3zlekj8jS4lKMKNkiEjPM1F+AfPBAbTOB/ApbSywdXi8v+0XZwX2a2Gxo0npk+uSdLUUNRJrupjU3kGU54LZyWrGxchBHEarHUl/Jeaewn7mreG8+8Z4qjwO9APnYRH7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wklSEwCh7Z++PhsUWILX8ZZMasUGSvnN+TK1vFnGagg=;
 b=mmb3ik0KvhZEHv+6DqAhjNG9L6fLejxt7RcbkAprYIsS7MPU0AT6hdq2TqHaQDflJGqQSPw+yvNqp8a9ykRprMqcTRVq6xvV3a7pWBPEMWx5MDA6j42vrCDpCasnwbQwtSNcJyBszs3+LWeLrdw1jHRWmDx5VKkt7Y4h+AacGlQP65kbd97gPVfbMom/y4KUjcNCE4MCdo51VKDjD+yBQ2+POV9h827b9d/gwp1Q/IiUZwzvnhF0KZ8liaguJbhHfUKz0pPt7NVs3eEvgV9oxbA6KwV+v4ALeaZZlKSsgAWisVSRz/ScZl6AlX/G9KrbdMSpHNViBBTuaABTs2Uzrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wklSEwCh7Z++PhsUWILX8ZZMasUGSvnN+TK1vFnGagg=;
 b=XllAKd1A9+TKC7qRzNKEBNy4rIyrWgWspEn1JsFWPadCJOQf6+6mJrRzBcbia7NhMXgFfM3wSCAcPw9Zkk9EbaxCADaUEnb85r1PFl/eR63UVU+2Kj/SMlleJkWBMcslLfuF3TQ1AqrCDzcu0USX0gHpTk+qMEf11eSY/TIeY1s=
Received: from BYAPR02MB4055.namprd02.prod.outlook.com (2603:10b6:a02:f5::15)
 by BYAPR02MB4583.namprd02.prod.outlook.com (2603:10b6:a03:12::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Wed, 18 Mar
 2020 12:41:46 +0000
Received: from BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::1cf1:f69e:a6bb:396]) by BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::1cf1:f69e:a6bb:396%3]) with mapi id 15.20.2814.021; Wed, 18 Mar 2020
 12:41:46 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Jolly Shah <JOLLYS@xilinx.com>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 20/24] firmware: xilinx: Add APIs to read/write
 GGS/PGGS registers
Thread-Topic: [PATCH v3 20/24] firmware: xilinx: Add APIs to read/write
 GGS/PGGS registers
Thread-Index: AQHV9BGwe7XIvkYhqkmdxkZpTY3znqhOTwmAgAAMVuA=
Date:   Wed, 18 Mar 2020 12:41:46 +0000
Message-ID: <BYAPR02MB4055DE6560EFDCFD0EBFD8E2B7F70@BYAPR02MB4055.namprd02.prod.outlook.com>
References: <1583538452-1992-1-git-send-email-jolly.shah@xilinx.com>
 <1583538452-1992-21-git-send-email-jolly.shah@xilinx.com>
 <20200318115141.GB2472686@kroah.com>
In-Reply-To: <20200318115141.GB2472686@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4938c931-14cb-4821-ba7c-08d7cb39b85b
x-ms-traffictypediagnostic: BYAPR02MB4583:|BYAPR02MB4583:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4583EB667E6D482EF41B6800B7F70@BYAPR02MB4583.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1443;
x-forefront-prvs: 03468CBA43
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(199004)(66946007)(76116006)(110136005)(64756008)(66556008)(66446008)(66476007)(2906002)(53546011)(54906003)(71200400001)(81156014)(55016002)(4326008)(9686003)(86362001)(81166006)(8676002)(52536014)(7696005)(8936002)(7416002)(6506007)(5660300002)(186003)(26005)(478600001)(316002)(33656002)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4583;H:BYAPR02MB4055.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3aiU8bvZjBRkzOkDOnne3pbmjRfBKDhCAzxlGDfXMeeRqSrzjpIH5kniErCq9Tiz0NyWvGWbdku+7kcXM+F2cuBudI2B2xDdQbkq9mCF9QdZFpQN/Of8a14/YJiqv/j/BhdbqzD+vAj2ybXxTsbkIFnfdaEx1HQyYlYXRFo6QJ4RyTC9iyvN7HPN/Tr/h+ngA2NW0IHVIpgKP31uwHJugTKBlKu0jDuuHJMwVBXzZ4h2AzUh1jBkT1UzyeW1EHGzBCFltgZVtZk4jMAviQq4owRPqHXRQTU1r5DrB/az6g/qS2IMTNndkxqwmqd4629iQ9rKZ2+DDLq+A+6qu7RVpjvWImQVVlLTIWwnmrof1OQ536nEZRFV8IMF1hQIlpMF1NCNz+SkRraXWYGXJp4D/Hv9FUpT7cW2lpi7nndMMAynt4RIx2RoDvErumUHfHVt
x-ms-exchange-antispam-messagedata: xzZQb2gYyXAjsJYdkS4ETcI0gBcdwNi0u1FjiT7lGeAZIZ9OchofPqjbn/+YDH1WBRXh6H/UdKeofX1cAO0scIGZH8MAafnWlzdpZf8rplUpF8xAEvYBPo+nz8IOyENDksQf8TozTrrZo+Ee2+kFug==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4938c931-14cb-4821-ba7c-08d7cb39b85b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2020 12:41:46.1658
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vk+OyeZsANPEuW9IrSIp6V/b6Tc6z4NY8u2gkS4Gq4SyNjmyiSNLDEjFWjSaF9UMtbLpkrpT3NtLrrZ4VWLjbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4583
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Thanks for applying patches and review.

Please see my comment inline.

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: 18 March 2020 05:22 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org; matt@codeblueprint.co.uk=
;
> sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Rajan Vaja <RAJANV@xilinx.com>
> Subject: Re: [PATCH v3 20/24] firmware: xilinx: Add APIs to read/write GG=
S/PGGS
> registers
>=20
> CAUTION: This message has originated from an External Source. Please use
> proper judgment and caution when opening attachments, clicking links, or
> responding to this email.
>=20
>=20
> On Fri, Mar 06, 2020 at 03:47:28PM -0800, Jolly Shah wrote:
> > --- a/include/linux/firmware/xlnx-zynqmp.h
> > +++ b/include/linux/firmware/xlnx-zynqmp.h
> > @@ -105,6 +105,10 @@ enum pm_ioctl_id {
> >       IOCTL_GET_PLL_FRAC_MODE,
> >       IOCTL_SET_PLL_FRAC_DATA,
> >       IOCTL_GET_PLL_FRAC_DATA,
> > +     IOCTL_WRITE_GGS,
> > +     IOCTL_READ_GGS,
> > +     IOCTL_WRITE_PGGS,
> > +     IOCTL_READ_PGGS,
>=20
> You do not have explicit numbers here?  Bold :)
[Rajan] Here new IOCTL IDs are continuous so didn't mention explicit number=
.
Are asking for adding numbers like below:
enum pm_ioctl_id {
      ...
      IOCTL_GET_PLL_FRAC_DATA =3D 11,
      IOCTL_WRITE_GGS =3D 12,
      ....
}

Thanks,
Rajan
> greg k-h
