Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96850C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5708F207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="pWfMRRoY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgAPNGI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:06:08 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8606 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726018AbgAPNGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:06:08 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00GD06CQ001642;
        Thu, 16 Jan 2020 08:05:39 -0500
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by mx0a-00128a01.pphosted.com with ESMTP id 2xf93b5rut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jan 2020 08:05:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEU2jext2I58s0c++fnA5G3py+C80LM1p5Vr3nulsLJPQkL2HBHn7S0/v/mHWCXeGQbg96swuGlbg0jNiPcNWoZiGa6R+l0A5iOtRc6GUXa39L3PuhG0xs+s8osw0jzt+eGaHltH6vF6Ev0RVHWHnX2miNOeswfKa3Q+/Tky/LY/6WwuU+Dxo+zBpYs6/L5B4efd8POuIYmttj+XQAjvg+MKmwr0z5gmb1ZeLm+f9fcWdhAjYsIg0Kniq99mmOAqaLIHBm+wrusba7OPToD4gszLyyIZDL4mRi/V5cLKRAHVmvIsGzdi+IXmJjr40K6o1zqT0H8hhO5eoBVhaUeqNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwsH6qUAWOEm40XDwmBJZolLNgw8emMljUUgMsP+brI=;
 b=mMyubQbUDTjhGvFwFvWvrYLAWv5ZcvLDDaEVzjMtkwQBZx5lE4jOTvWyEFfQKDoW7BcbMpj5CZsUE7cynk+ZU1FfRVyFz0ksQ6tq7Xm9PNKV01ZbdtU7BPYmYsiPj0x647gI8z//GfkfstgznFVTw6t4dDCxSFeG9qhYM5sow46eUASugNzP6LmZKqsTt2CXc/AeAAN+f+khIAB4f2ADmD0V4F8lSqHqc6XfaBIQIHnhIEgHuDZ+nUDmp/9h87I0Vcp9Jsn4JXI1f905i3RAYLRHQTj7Fq1+ovqszIc3T4zpE19SiogW26aA2/yMUyU5+8Q3O70BgCjCLmbENB/+tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IwsH6qUAWOEm40XDwmBJZolLNgw8emMljUUgMsP+brI=;
 b=pWfMRRoYDOee5DQoujA19WTf6NhaIKIoz6+FinkREoJ+xBPDCu+HkXDSyvI3h6M87pph2n9j92WcpyN0kaktoRYjDiZ7lv6KZj61xkkBGvjXm/W8zNusBcFtnFnaGuvUeYrNDemn1FTzjdth9iKoaGk9/mqfTMdZU7hhbhBDP3I=
Received: from CH2PR03MB5192.namprd03.prod.outlook.com (20.180.12.152) by
 CH2PR03MB5367.namprd03.prod.outlook.com (20.180.15.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Thu, 16 Jan 2020 13:05:38 +0000
Received: from CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39]) by CH2PR03MB5192.namprd03.prod.outlook.com
 ([fe80::dce7:7fec:f33f:ad39%7]) with mapi id 15.20.2644.021; Thu, 16 Jan 2020
 13:05:37 +0000
From:   "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mina86@mina86.com" <mina86@mina86.com>,
        "lars@metafoo.de" <lars@metafoo.de>
Subject: Re: [PATCH] usb: gadget: ffs: ffs_aio_cancel(): Save/restore IRQ
 flags
Thread-Topic: [PATCH] usb: gadget: ffs: ffs_aio_cancel(): Save/restore IRQ
 flags
Thread-Index: AQHVlJoPRhMSTshV10KJVpaiJ2qsxKftk2wAgAAebwCAAADVgA==
Date:   Thu, 16 Jan 2020 13:05:37 +0000
Message-ID: <9943963591465db81be57d4e1bb98ac4cd16d9b2.camel@analog.com>
References: <20191106120219.15028-1-alexandru.ardelean@analog.com>
         <f3f8e2a6480da78ba23ddedb68beee71f47e178f.camel@analog.com>
         <87imlb5z7z.fsf@kernel.org>
In-Reply-To: <87imlb5z7z.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [137.71.226.54]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3d8bc602-ede7-4f10-a9f6-08d79a84c81a
x-ms-traffictypediagnostic: CH2PR03MB5367:
x-microsoft-antispam-prvs: <CH2PR03MB536735DE989D5757D3D1A8EAF9360@CH2PR03MB5367.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 02843AA9E0
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(366004)(39860400002)(376002)(189003)(199004)(966005)(110136005)(54906003)(5660300002)(71200400001)(6512007)(4326008)(6506007)(186003)(26005)(316002)(76116006)(36756003)(66476007)(66556008)(6486002)(66446008)(4744005)(66946007)(2616005)(478600001)(64756008)(86362001)(8936002)(81166006)(81156014)(8676002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:CH2PR03MB5367;H:CH2PR03MB5192.namprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YJa8gKIDP8GMUYnre+3vWqf8JrFMCu0haklnLzBrN1W1u1dGKqCPLQwllFGKSU3GGT3ywsMIrAxsERXcgHg7jfVO+YQZp0Dk8D/E0EYKmp/qgQ5XZcppHpMHLg8iYXZxcgEkiNb4bCJ4vxg7xqdnXTmNlsbWa+GNUh/skJIxS2Rggu/33WcOLuURDEYznVeviW7z4O4Nfk7nnY5KyTFrlpBMOfnsLV6H5yAKKZTIBgvdgZizE1NZJG7YSTOJhNJhrdbCaDFAeEle3dQFjYbRtB6nMuN0kKyAYWmb7wsC7EF9JYSnVGiMervMNwVZUVR5j4oXttSEBXbeDTTRNP7pqa70Hz3oig54W4niCAxQUe+Ex+MabXTWeOTUnlgwegoZFrYaucsHzauPTVU5xxqF6BZ1H+LFYtgdSHexvJscaS2M1kZM35Nn8LcLXKKzmZS6JmGJwXsdPUyTA9fj7rn6vTwlzgiEviYcJGKAg9tOWAFOJWgfJ97B/nRidRlgwXbUtZtMAOOmBjPiM9c0JrIVZQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CB7CA755C5C384E924F9B02AD2AAD36@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8bc602-ede7-4f10-a9f6-08d79a84c81a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2020 13:05:37.7963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /T4vfcXqblKa/sCIjAHxdSRopTXJiVOMGU3AgAyw9WmwYimmM8JnBPoVVN4z1YyoE6HTsMkc/vwrVAHvuGmlJafL/l+GNqL3mIceghDqeN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5367
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-16_04:2020-01-16,2020-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 mlxlogscore=628 bulkscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 phishscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001160110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTE2IGF0IDE1OjA0ICswMjAwLCBGZWxpcGUgQmFsYmkgd3JvdGU6DQo+
IFtFeHRlcm5hbF0NCj4gDQo+IA0KPiBIaSwNCj4gDQo+ICJBcmRlbGVhbiwgQWxleGFuZHJ1IiA8
YWxleGFuZHJ1LkFyZGVsZWFuQGFuYWxvZy5jb20+IHdyaXRlczoNCj4gDQo+ID4gT24gV2VkLCAy
MDE5LTExLTA2IGF0IDE0OjAyICswMjAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3JvdGU6DQo+ID4g
PiBGcm9tOiBMYXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT4NCj4gPiA+IA0KPiA+
ID4gZmZzX2Fpb19jYW5jZWwoKSBjYW4gYmUgY2FsbGVkIGZyb20gYm90aCBpbnRlcnJ1cHQgYW5k
IHRocmVhZA0KPiA+ID4gY29udGV4dC4NCj4gPiA+IE1ha2UNCj4gPiA+IHN1cmUgdGhhdCB0aGUg
Y3VycmVudCBJUlEgc3RhdGUgaXMgc2F2ZWQgYW5kIHJlc3RvcmVkIGJ5IHVzaW5nDQo+ID4gPiBz
cGluX3t1bix9bG9ja19pcnF7c2F2ZSxyZXN0b3JlfSgpLg0KPiA+ID4gDQo+ID4gPiBPdGhlcndp
c2UgdW5kZWZpbmVkIGJlaGF2aW9yIG1pZ2h0IG9jY3VyLg0KPiA+IA0KPiA+IEhleSwNCj4gPiAN
Cj4gPiBUaGlzIGlzIGEgcGF0Y2gtcGluZy4NCj4gDQo+IFBsZWFzZSByZWFkOg0KPiANCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzg3NXpoZDZwdzAuZnNmQGtlcm5lbC5vcmcv
VC8jdQ0KPiANCj4gV2UncmUgZ29ubmEgbmVlZCBhIHJlc2VuZCwgc29ycnkNCj4gDQoNCkFjay4N
Cg0KVGhhbmtzIGZvciB0aGUgcmVwbHkuDQpXaWxsIHJlLXNlbmQuDQo=
