Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4775AC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A06321473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 20:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bBmpwu3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDVU3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:29:46 -0400
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:6095
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbgDVU3p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 16:29:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxha90fovEWKZeCRF/8DF4mVOmXk4EDq09P3nQBQL8qCwtQo9za5NW2/WLsB5wAmE4QTkNSkSBWtd0rknrTieEoJ/07nLTNQ8gUdnJ/3vg0SXJu3JFUjlfaoa637KEXKU6RNC37uXhz/D8wOKFRTJBc2sqgZ+E5Tj/RU1QLwl4lJoLD6FNC/BjLH7jCSq4Oj58KglPIbgvY/KdJWxxezdct2IwuIS/hM3wW2LJEqBhXBmqliH5nA40JPmB14zaDsQ3PluDoZgINCmA5hK3a5clKn3whuwb8T2s4mSbL45/KPYJyoFcsMXbI1bCNDHhy6OCCW8ALNsYqgvHIXB4VfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfo8yVd87PTERktSQ/mfKzMU/zlm2Ull6Zu1VGWVIRo=;
 b=kMBfrbakJNscm1mdunNduLULaxoyHB559YG2V8dr/N4i3rbWT2k7rrNjNUIpKM4lz+Az2NpiFnGxXUpW/vnzz5vODQDDmsLIFE7XPrqdK0rA4vNoMeE7u49STAkno+ZJsDxAyWTjfC8QFQ9E+gRs2KdgpxOkQmvUoKSJ16ogzF/py3RMN3+Dv4RdJZlbwslW0G/VokJKnXRXDgfQ/VkgMQvbGN5nn4YsO0fsMvTuXhgi3vpydUPQtzVfYD1bkcBSDijDFIDrCR1ib395kbMuz+UZIfqWk8d2GQ/3vNmZ24LVS0n46q7wrCyVOmoh3+oBMRZfez2uyuw45pyBSB570w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfo8yVd87PTERktSQ/mfKzMU/zlm2Ull6Zu1VGWVIRo=;
 b=bBmpwu3HcBBk6D8t6QyPt9hUrTeUPHIPH7KbnE1jPGmxIs7BU527PA8kE9PN3YM5Zy6KYl0LE/rWUAaa6u8oZ/Bh2klM7wh+KA6iz6kJigPHoWavTqZFShNYo7wOZVZ61IBAzyr79hBET5YQPSEPupGYLVgjA1d4CPr2WHzsUZ0=
Received: from BYAPR02MB4856.namprd02.prod.outlook.com (2603:10b6:a03:51::28)
 by BYAPR02MB4951.namprd02.prod.outlook.com (2603:10b6:a03:51::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 20:29:41 +0000
Received: from BYAPR02MB4856.namprd02.prod.outlook.com
 ([fe80::d8e6:e16e:4a44:3e4f]) by BYAPR02MB4856.namprd02.prod.outlook.com
 ([fe80::d8e6:e16e:4a44:3e4f%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 20:29:41 +0000
From:   Ben Levinsky <BLEVINSK@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "Ed T. Mooring" <emooring@xilinx.com>
Subject: RE: [PATCH v3 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
Thread-Topic: [PATCH v3 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
Thread-Index: AQHWF2LzW/qPWa5cD0yVrqMFCa5VQqiFjGCAgAANlvA=
Date:   Wed, 22 Apr 2020 20:29:41 +0000
Message-ID: <BYAPR02MB4856EDC95308C0F91C4413C7B5D20@BYAPR02MB4856.namprd02.prod.outlook.com>
References: <1587421629-914-1-git-send-email-ben.levinsky@xilinx.com>
 <1587421629-914-5-git-send-email-ben.levinsky@xilinx.com>
 <20200422193819.GA1685@bogus>
In-Reply-To: <20200422193819.GA1685@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=BLEVINSK@xilinx.com; 
x-originating-ip: [98.207.156.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1dcdafc3-affc-4df9-c044-08d7e6fbe2e0
x-ms-traffictypediagnostic: BYAPR02MB4951:|BYAPR02MB4951:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4951A6D383233156696B379FB5D20@BYAPR02MB4951.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 03818C953D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4856.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(55016002)(5660300002)(966005)(54906003)(71200400001)(76116006)(81156014)(107886003)(33656002)(186003)(7696005)(6506007)(26005)(4326008)(53546011)(6916009)(2906002)(316002)(66946007)(52536014)(86362001)(478600001)(8676002)(66556008)(64756008)(9686003)(8936002)(66476007)(66446008);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7W8yABIymukmOg9wC9g5/4etSKoQ3b93nfDa2vUUeYpv8o/JwhGokt3NxlYYVJLZx3GmdRLkGRe6R/r7fTiWTiDgNMWgqysfDSB2/7D9+y3QIaXt+9Vod7VIEnF1zzq+qOft8DrsAVCxUT95xva0p130+cuEOp6U4bP/EFs4srdER+NaGgKIQjM01rR3ie+2g981Yxv3XVOQLL9oW9oqcWltc01M3d/KHIzl2WSsQ+xqlPIfzMfLNjqcIqKKkMTn1wUv/Tje/opNOiB9BvkJMpdw+rLr/gkjJOQEYzSZDUNBzUiB1JAbpj1w2MUaUqH1JYWNm/bIZ1CMPTnxVxfpXbOGVXEvPE/vtVm5etcFAnuvkJ611XBjNqItZ7R4pbvui3nyXf9TLozdxmiaNF+LB4EEG4vJI2kj1YStIafQh6cgJIo4/QMQisNN6r002z4y5Q28v305n0U/CtiL+itP2OerJS/iP/bpnmJyT36G5TwQqaVKhQk+w0eVdcSf8xNxjWzi3DlPUBAM/RmA9kOpEw==
x-ms-exchange-antispam-messagedata: eX9kWsdmey+puAwgAv0/egMBpU9HIovI7EJtmwKsJdKiG9tky8ytSx7FjV79P2fQcdq3TPnDLtuosYoaq3Pz3w2PJUGW0ig7GeQPu2sKXothtMlt4pQwerBeouwL7egq9f9f0LMYLmVLXNfYiw461pNJzx7XUOnyYcWjjwriLtv0f05sobZzCxS+TfjfRuW8DBxB1dRWKCV8V2jNU2JNbnZl33zbFk7GvWiUBqFUzgDP0RQmpaMVkX8HaMlXS+Sb2FD1R9JKLXp9ecPeAt2wlMT6mdGGLRPJxQTK8MyXrCgDUJ9mZm72wDBT8/UsT/uMBuHkYdNO+36acCatxSz/qBqa3YVxru5tCOdpC8RAVRI8VRaKEuCEt3zXikVoWXXZZn6XQbMfmwgBJIigGNV9iDr6JV5Ul+8qC2HLy42MB9+dM6MZaPnYkyrQRSdADqVbhV6MFw77Rq1a3RQfi8pDwEbMdU2GMk3/MngTnBOSdV7PQ6+LXanPa4MaiTsCHskMdg8xH9d4/7J/axcb3RLATGhhFkyCo+m3xZBADdQ3HPLajaJDsgkbesW/wxlajI8WVMbFAAAMccp4GBFpKX23qM1+gSTBeWPanTTNvjnok3WpYdkHuuClWGGnhC0M8mtcS3HeRHlpF5rXQUMEZPoeMJ4Gld9IrtkSGsldhRA/8hR4gK0J6FRpCyTC2KHBQNT3LHZKmwdWZ2/EeMzpcKYv+w26vAIUNpSgVIyIz+CSGhucWwUY3tc6FzD0Q8zQUEEtHkKlSqKhZuY4IR7k+Tg7kA2C5ON4po3UoyFlvyYZJNk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dcdafc3-affc-4df9-c044-08d7e6fbe2e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2020 20:29:41.2635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AOPONj0WWr8s5Eo69Uz/qsGH6yAWBeMKVGpAiN2JdY26LVZb0hgzVBo0kJu4VPbOtrK/8U3F5MEDrnztCROE3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4951
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Please see my replies inline.

Best Regards
Ben

-----Original Message-----
From: Rob Herring <robh@kernel.org>=20
Sent: Wednesday, April 22, 2020 12:38 PM
To: Ben Levinsky <BLEVINSK@xilinx.com>
Cc: ohad@wizery.com; bjorn.andersson@linaro.org; Michal Simek <michals@xili=
nx.com>; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>; ro=
bh+dt@kernel.org; mark.rutland@arm.com; linux-remoteproc@vger.kernel.org; l=
inux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org; linux-kern=
el@vger.kernel.org; Jason Wu <j.wu@xilinx.com>; Jiaying Liang <jliang@xilin=
x.com>
Subject: Re: [PATCH v3 4/5] dt-bindings: remoteproc: Add documentation for =
ZynqMP R5 rproc bindings

On Mon, 20 Apr 2020 15:27:08 -0700, Ben Levinsky wrote:
> Add binding for ZynqMP R5 OpenAMP.
>=20
> Represent the RPU domain resources in one device node. Each RPU=20
> processor is a subnode of the top RPU domain node.
>=20
> Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> Signed-off-by: Jason Wu <j.wu@xilinx.com>
> Signed-off-by: Wendy Liang <jliang@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> Changes since v2:
> 	- update zynqmp_r5 yaml parsing to not raise warnings for extra
> 	 information in children of R5 node. The warning "node has a unit
> 	 name, but no reg or ranges property" will still be raised though=20
> 	 as this particular node is needed to describe the
> 	 '#address-cells' and '#size-cells' information.
> ---
>  .../remoteproc/xilinx,zynqmp-r5-remoteproc.yaml    | 126 +++++++++++++++=
++++++
>  1 file changed, 126 insertions(+)
>  create mode 100644=20
> Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remotepr
> oc.yaml
>=20

My bot found errors running 'make dt_binding_check' on your patch:

Documentation/devicetree/bindings/remoteproc/xilinx,zynqmp-r5-remoteproc.ex=
ample.dts:45.25-65.16: Warning (unit_address_vs_reg): /example-0/rpu@ff9a00=
00/r5@0: node has a unit name, but no reg or ranges property
[Ben Levinsky] Yes the following warning is expected. As the node in questi=
on has to describe the address-cells and size-cells. As these are needed fo=
r its children to then also have address-cells, size-cells and reg values w=
ithout raising more warnings.

See https://patchwork.ozlabs.org/patch/1273784

If you already ran 'make dt_binding_check' and didn't see the above error(s=
), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --u=
pgrade

Please check and re-submit.
