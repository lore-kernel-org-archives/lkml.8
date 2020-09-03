Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB2DC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D75C20758
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 06:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="c2bOjkw0";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="HCegChiV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgICGXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 02:23:18 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:12156 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725943AbgICGXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 02:23:13 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0836MsuI004793;
        Wed, 2 Sep 2020 23:22:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=hNnCNFDp/i1S9PNmYINicPJKhq681rs3elmbPfAnm4Q=;
 b=c2bOjkw0StCga4zuW50fF9dSbPLto0EtYikEOEey6awMr3mzXzxMdOASx+S0iTmLtg++
 kCvxAgPZqu7gs2YvoisWCySN0kEknPRMgbN9fl4Nm11NlUiNj7s9QEAtpPCGhslLjzBA
 zg0Z1ifBfByF54Fs8nXGRyZLCYS2MxZ9pDY+QtOtIjnhxEyqXc3svbniRUlYRrZWd2K4
 FIBKDXF7+G7ESzRHzOijmKZCkgZ78JniPcWZUoF807dGN1c5jrK0pyi2iGHVmUfCwjvY
 aL+9FSjHDpsqdOLbVx3JnNc28w1iEjkmFyMoyXArK7VOV8HGR+8Y8PID7dWpaOBD1iTK rg== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by mx0a-0014ca01.pphosted.com with ESMTP id 337kjxuaac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Sep 2020 23:22:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMtlOpyR9e0REaPUFSHbVgUktmnB0lV1w2xsg/7zT7YY/e6lEnERYZ10siRnmIQNpyXvBwsf8FDcD7W9lI0/uZLU+WCa/2/NphOKprEKsvYYdJGhELXc4eLxITxt8NkdgP+0Bv3ziKrowuzu9k3Bzt6UqH37pgRbdOj/C+etex1fkVPbEVdgFzpDPX85nOI0qZ/waExmt1lyNUin9WCVlF1APO9IdY16P/q9qzWAQd9R+r/Kz4Z91FwYknGV1cjt45q5uEmMPUxGgoIFn8AL0y6BVah6MQkiTBHr2aDLv5X1qy+y5pP5RdQqy2sGCWxY6H+sXLnTZhkL4sivPS7ybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNnCNFDp/i1S9PNmYINicPJKhq681rs3elmbPfAnm4Q=;
 b=H7rLx+p111PYN1tGOYJkSSB8SsNbze/q3I1PrdtgZ+CZpmizkAn84twCCmac7UIRDQLB6xuYnbZeOB1x48biAbOgyQDDXYdxCjoalb8sPQLLafNbGsIl2xhxbzFS+8wIMBjQDzGUy3eCTfWzMDr3HxqCI7JZ+PK9gxNw1Q5WgzdaSe8B8niHfBxrFiPnX2w3+K6SL7S9ikK4gQnIyTYetz+vWSx2wYDFWH0tsiA3FQ9gkaRyiadh5zlgN0j3Iqo8SaJHN9DfS17x4ub7KfgwwS1d21RvJSEmKd55VKC00Md9tGtu94EA/gZlfd7+d5xPUAnWFHpLgMg29jfKWIatJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNnCNFDp/i1S9PNmYINicPJKhq681rs3elmbPfAnm4Q=;
 b=HCegChiVXrcgFsAU+O2/GW3bGo5gnl/r3zGpXiuguPDA/AdnEmxLDyanoJeGcsmrxz4Jf8wY15KL/yqdsTvpBpfIgqfVgaZ4tHn5D2EXV/8x/BfO7Gb/NMAcglmR4HaNNNUKJ/RDlMkpmKmn9D/aZzThjDhsTTeR/YGaDBx0dj0=
Received: from DM6PR07MB5531.namprd07.prod.outlook.com (2603:10b6:5:76::15) by
 DM6PR07MB7033.namprd07.prod.outlook.com (2603:10b6:5:1ef::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.16; Thu, 3 Sep 2020 06:22:46 +0000
Received: from DM6PR07MB5531.namprd07.prod.outlook.com
 ([fe80::c451:7f79:5f49:d9f2]) by DM6PR07MB5531.namprd07.prod.outlook.com
 ([fe80::c451:7f79:5f49:d9f2%4]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 06:22:46 +0000
From:   Milind Parab <mparab@cadence.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "a.hajda@samsung.com" <a.hajda@samsung.com>,
        "narmstrong@baylibre.com" <narmstrong@baylibre.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@siol.net" <jernej.skrabec@siol.net>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "jsarha@ti.com" <jsarha@ti.com>, "nsekhar@ti.com" <nsekhar@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>,
        "nikhil.nd@ti.com" <nikhil.nd@ti.com>
Subject: RE: [PATCH v9 2/3] drm: bridge: Add support for Cadence MHDP8546
 DPI/DP bridge
Thread-Topic: [PATCH v9 2/3] drm: bridge: Add support for Cadence MHDP8546
 DPI/DP bridge
Thread-Index: AQHWf3AYzpzGkoZ9706j21VgVUJ0X6lTdp2AgALthcA=
Date:   Thu, 3 Sep 2020 06:22:46 +0000
Message-ID: <DM6PR07MB5531DF749C993423B0A3E746D32C0@DM6PR07MB5531.namprd07.prod.outlook.com>
References: <1598862215-10222-1-git-send-email-sjakhade@cadence.com>
 <1598862215-10222-3-git-send-email-sjakhade@cadence.com>
 <e53e87b0-7e0a-763f-8b8b-0dc278e1f225@ti.com>
In-Reply-To: <e53e87b0-7e0a-763f-8b8b-0dc278e1f225@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [14.142.6.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff76b2dc-d533-4055-4ea9-08d84fd1c65a
x-ms-traffictypediagnostic: DM6PR07MB7033:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB70334036E652E0F702B2A1A2D32C0@DM6PR07MB7033.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xChZ2mJt/uieclQ4hMkm7MES6zg6IvMw+UB/QgUz7d0BVLYf0lxxYj84xVrvRXlr4rS1VEWxC3583pprPA+FPorrElecyalfSLNaNGlep0P7UV6s4EEkHK9j9R4ZGTi3pdLv9TJdAgHF5f8di+Tc1EZlQ/laCE3CfQBVLSgHNzIq+TgkYCLDd/42IE+/noE3Ii+3+wrnbMHRyqWc/Y29lrmHKgacd4N4u8C/A/15UYRg0RivPx2Ai5tbTiwwGBVAlpbtgwopFl+Oys4+2wxfsKnwg/3ft9upqszbB1ROo9quNZokFMjycfhlq+ZPB1Yh2yZq5CbPndOiStynEJPtpisrGSC6nccMpbmeexbQfN8eSFBJf1nAS7I3HwMuG5fXpqbbtTEbRp7HzZ8fkkeM8w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5531.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(39860400002)(136003)(36092001)(2906002)(55016002)(71200400001)(5660300002)(33656002)(76116006)(4326008)(86362001)(55236004)(66446008)(7696005)(7416002)(64756008)(66476007)(66556008)(83380400001)(66946007)(6506007)(52536014)(8936002)(478600001)(26005)(54906003)(316002)(9686003)(110136005)(8676002)(186003)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 9Cdq0c44vA56mJ/qgoxjtTYg7NKOo/ywyJEsewdj9d+Ayof1oMT1D2XZHxvGirSE4j3tDNBeZpPY1MIxE0oflZhB2ZQgC04DAd4AOapnf3uAZT5fKjKjNk+FueOUjhX74gn8MCK1M0Ifbwl2fdOIJcRnss/yyUg+UT5k8ycUD4uS711/NH1hFYMcX9ip1W5kDtwxnFimtOiog1Oy+DK8YhS4kqM1ttMbwMyz3ai1JHis6nDmRc/3B/V5w7mhgpsx54CowU76KuJXMrzV/jX0hf/FEow7pyud++Sg9npJKpw8hsc/GOyR/EU7v7rdmtzKQmf2ILRzRm5HH8N9+IxDp1PWsVCO+04kgUMlPiyz+Y9mF5VPJM9xc4AAQNUNeRGlCpKKwSmuWRpw+2jGyH/sGZKoNygf0V4sMaN6kzGud5eqPTjMYMQQIYY6Mpylfdwhyy/lSv0pYa8ig5hKXD6yP2vQM0ry5riM/S8ULZbP9m3mzENzKJzLAgOO5OIMyYDrb6mSLvKmosY2zs5r5tC6GZuFtZ1G6eZ/3h5M+BFQO91HrmAK9kw4dHR8+peOU17upEPMU1wgWr9+tVchIZSY22YL6KDHzx0FyxF0sGa25BXm1y0BU7QsDi2RqVanlBH/1UqbvPfYk6/tFypMSmN8xg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5531.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff76b2dc-d533-4055-4ea9-08d84fd1c65a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 06:22:46.6871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T7C2Qyu4sNW/lSDNdEpUDM/cghEFBB1UeVmXHBVJaA0CknrHMVhBvapLAg4rLS06ma+Wt45khsaAYGI9n+X4+W8WVxkQBXX6xXAkFXYGED8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7033
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_03:2020-09-02,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1011 mlxlogscore=999 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVG9taSwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogVG9taSBWYWxr
ZWluZW4gPHRvbWkudmFsa2VpbmVuQHRpLmNvbT4NCj5TZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIg
MSwgMjAyMCAyOjA1IFBNDQo+VG86IFN3YXBuaWwgS2FzaGluYXRoIEpha2hhZGUgPHNqYWtoYWRl
QGNhZGVuY2UuY29tPjsgYWlybGllZEBsaW51eC5pZTsNCj5kYW5pZWxAZmZ3bGwuY2g7IExhdXJl
bnQucGluY2hhcnRAaWRlYXNvbmJvYXJkLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPmEuaGFq
ZGFAc2Ftc3VuZy5jb207IG5hcm1zdHJvbmdAYmF5bGlicmUuY29tOyBqb25hc0Brd2lib28uc2U7
DQo+amVybmVqLnNrcmFiZWNAc2lvbC5uZXQ7IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmc7DQo+ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj5DYzogTWlsaW5kIFBhcmFiIDxtcGFyYWJAY2FkZW5jZS5jb20+OyBZdXRpIFN1cmVz
aCBBbW9ua2FyDQo+PHlhbW9ua2FyQGNhZGVuY2UuY29tPjsganNhcmhhQHRpLmNvbTsgbnNla2hh
ckB0aS5jb207DQo+cHJhbmVldGhAdGkuY29tOyBuaWtoaWwubmRAdGkuY29tDQo+U3ViamVjdDog
UmU6IFtQQVRDSCB2OSAyLzNdIGRybTogYnJpZGdlOiBBZGQgc3VwcG9ydCBmb3IgQ2FkZW5jZSBN
SERQODU0Ng0KPkRQSS9EUCBicmlkZ2UNCj4NCj5FWFRFUk5BTCBNQUlMDQo+DQo+DQo+SGkgU3dh
cG5pbCwNCj4NCj5PbiAzMS8wOC8yMDIwIDExOjIzLCBTd2FwbmlsIEpha2hhZGUgd3JvdGU6DQo+
DQo+PiArCWxpbmVfdGhyZXNoMSA9ICgodnMgKyAxKSA8PCA1KSAqIDggLyBicHA7DQo+PiArCWxp
bmVfdGhyZXNoMiA9IChweGxjbG9jayA8PCA1KSAvIDEwMDAgLyByYXRlICogKHZzICsgMSkgLSAo
MSA8PCA1KTsNCj4+ICsJbGluZV90aHJlc2ggPSBsaW5lX3RocmVzaDEgLSBsaW5lX3RocmVzaDIg
LyBtaGRwLT5saW5rLm51bV9sYW5lczsNCj4+ICsJbGluZV90aHJlc2ggPSAobGluZV90aHJlc2gg
Pj4gNSkgKyAyOw0KPg0KPlRoZXNlIGNhbGN1bGF0aW9ucyBkbyBub3Qgc2VlbSB0byBnbyBjb3Jy
ZWN0bHkuIFRoZXJlJ3Mgbm8gY29tbWVudCB3aGF0J3MNCj50aGUgbG9naWMgaGVyZSwgYnV0IGUu
Zy4NCj5mb3IgNjQweDQ4MCAocHhsY2xvY2sgMzE1MDApIHdpdGggMS42MkdicHMgbGluaywgSSBn
ZXQgdnM9NCwgYW5kIHRoZW4gdGhlDQo+c2Vjb25kIGxpbmUgYWJvdmUgY29tZXMgdG86DQo+DQo+
KDMxNTAwIDw8IDUpIC8gMTAwMCAvIDE2MiAqICg0KzEpIC0gKDE8PDUpID0gLTAuODg4ODg4ODg4
ODg4ODg5Mw0KPg0KPlRoZSByZXN1bHQgaXMgbGluZV90aHJlc2ggb2YgMTAwNjYzMjk5Lg0KPg0K
DQpZZXMsIHRoZXJlIGlzIGEgbWlzdGFrZSBpbiB0aGUgYWJvdmUgZXF1YXRpb25zLiBJIHdpbGwg
ZGV0YWlsZWQgaXQgaGVyZQ0KQmVmb3JlIHRoYXQgdGhlcmUgYXJlIG90aGVyIHJlbGF0ZWQgaXNz
dWVzIHdoaWNoIGFsc28gbmVlZHMgY2xhcmlmaWNhdGlvbg0KDQpGaXJzdCBpcyBhYm91dCB0aGUg
VFVfU0laRS4NClRoZSBEUCBzcGVjIHNheXMsIGluIFNTVCBtb2RlIHRoZSBUVV9TSVpFIGNhbiB0
YWtlIGFueSBldmVuIHZhbHVlIGZyb20gMzIgdG8gNjQuDQpUaGUgYWR2YW50YWdlcyBvZiBoYXZp
bmcgYSBzbWFsbGVyIFRVIHNpemUgaXMgbm90IGV4cGxpY2l0bHkgbWVudGlvbmVkLCBob3dldmVy
IGxvZ2ljYWxseSBpdCBoZWxwcyBzdHJlYW0gZG93bi1zcHJlYWRpbmcgYW5kIHdvdWxkIGJlIGJl
bmVmaWNpYWwgaW4gbG93IGJhbmR3aWR0aCBsb3cgYnVmZmVyIGFwcGxpY2F0aW9ucy4NCkhlbmNl
LCB3ZSBjYW4gY29uc2lkZXIgdGhhdCBzZWxlY3RpbmcgYSBsb3dlciBUVSBzaXplIGlzIGFuIG9w
dGltaXphdGlvbiB3ZSBjYW4gY29uc2lkZXIgaW1wbGVtZW50aW5nIGxhdGVyLg0KRm9yIG5vdyBs
ZXQgdXMgZml4IFRVX1NJWkUgPSA2NA0KDQpTZWNvbmQsIGlzIFZhbGlkIFN5bWJvbCBMZW5ndGgg
InZzIg0KRm9yIGEgZml4ZWQgVFUgdmFsaWQgc3ltYm9sIGxlbmd0aCB3aWxsIGRlcGVuZCBpbiB0
aGUgUmF0aW8gb3IgUGl4ZWwgY2xvY2sgYW5kIExpbmsgc3ltYm9sIFJhdGUgKGxhbmVzICogcmF0
ZSkNCnZzID0gNjQgKiByZXF1aXJlZF9iYW5kd2lkdGggIC8gYXZhaWxhYmxlX2JhbmR3aWR0aA0K
DQpXaGVyZSwgDQpyZXF1aXJlZF9iYW5kd2lkdGggPSBweGxjbG9jayAqIChicHAvOCkNCmF2YWls
YWJsZV9iYW5kd2lkdGggPSBtaGRwLT5saW5rLm51bV9sYW5lcyAqIG1oZHAtPmxpbmsucmF0ZQ0K
DQpBbHNvLCBub3RlIHRoYXQgQ0ROUyBNSERQIGltcGxlbWVudHMgRFBfRlJBTUVSX1RVX3Agd2hl
cmUgYml0cyA1OjAgaXMgdHVfdmFsaWRfc3ltYm9scy4gU28gbWF4IHByb2dyYW1tYWJsZSB2YWx1
ZSBpcyA2My4NClJlZ2lzdGVyIGRvY3VtZW50IGdpdmVzIGZvbGxvd2luZyBleHBsYW5hdGlvbiAN
CiJOdW1iZXIgb2YgdmFsaWQgc3ltYm9scyBwZXIgVHJhbnNmZXIgVW5pdCAoVFUpLiBSb3VuZGVk
IGRvd24gdG8gbG93ZXIgaW50ZWdlciB2YWx1ZSAoQWxsb3dlZCB2YWx1ZXMgYXJlIDEgdG8gKFRV
X3NpemUtMSkiDQoNClNvLCBpdCBzYXlzIGluIGNhc2UgdnMgY2FsY3VsYXRlcyB0byA2NCAod2hl
cmUgQXZhaWwgQlcgYW5kIFJlcSBCVyBhcmUgc2FtZSkgd2UgcHJvZ3JhbSB0dV92YWxpZF9zeW1i
b2xzID0gNjMNCg0KVGhpcmQsIGlzIGFib3V0IHRoZSBsaW5lX3RocmVzaG9sZCBjYWxjdWxhdGlv
bg0KVW5saWtlIFRVX1NJWkUgYW5kIFZhbGlkX1N5bWJvbHMsIGxpbmVfdGhyZXNob2xkIGlzIGlt
cGxlbWVudGF0aW9uIGRlcGVuZGVudA0KDQpDRE5TIE1IRFAgcmVnaXN0ZXIgc3BlY3MgZ2l2ZXMg
dGhlIGRlZmluaXRpb24gYXMgIiBWaWRlbyBGSUZPIGxhdGVuY3kgdGhyZXNob2xkIiANCkJpdHMg
NTowLCBOYW1lICJjZmdfYWN0aXZlX2xpbmVfdHJlc2giLCBEZXNjcmlwdGlvbiAiVmlkZW8gRmlm
byBMYXRlbmN5IHRocmVzaG9sZC4gRGVmaW5lcyB0aGUgbnVtYmVyIG9mIEZJRk8gcm93cyBiZWZv
cmUgcmVhZGluZyBzdGFydHMuIFRoaXMgc2V0dGluZyBkZXBlbmRzIG9uIHRoZSB0cmFuc21pdHRl
ZCB2aWRlbyBmb3JtYXQgYW5kIGxpbmsgcmF0ZS4iDQoNClRoaXMgcGFyYW1ldGVyIGlzIHRoZSBU
aHJlc2hvbGQgb2YgdGhlIEZJRk8uIEZvciBvcHRpbWFsIHBlcmZvcm1hbmNlIChjb25zaWRlcmlu
ZyBlcXVhbCB3cml0ZSBhbmQgcmVhZCBjbG9jaykgd2Ugbm9ybWFsbHkgcHV0IHRoZSB0aHJlc2hv
bGQgaW4gdGhlIG1pZCBvZiB0aGUgRklGTy4NCkhlbmNlIHRoZSByZXNldCB2YWx1ZSBpcyBmaXhl
ZCBhcyAzMi4NClNpbmNlIHN5bWJvbCBGSUZPIGlzIGFjY2Vzc2VkIGJ5IFB4bCBjbG9jayBhbmQg
U3ltYm9sIExpbmsgQ2xvY2sgdGhlIFRocmVzaG9sZCBpcyBzZXQgdG8gYSB2YWx1ZSB3aGljaCBp
cyBkZXBlbmRlbnQgb24gdGhlIHJhdGlvIG9mIHRoZXNlIGNsb2Nrcw0KDQpsaW5lX3RocmVzaG9s
ZCA9IGZ1bGxfZmlmbyAtIGZpZm9fcmF0aW9fZHVlX3RvX2Nsb2NrX2RpZmYgKyAyDQp3aGVyZSwN
CmZ1bGxfZmlmbyA9ICh2cysxKSAqICg4L2JwcCkNCmZpZm9fcmF0aW9fZHVlX3RvX2Nsb2NrX2Rp
ZmYgPSAoKHZzKzEpICogcHhsY2xvY2svbWhkcC0+bGluay5yYXRlIC0gMSkgLyBtaGRwLT5saW5r
Lm51bV9sYW5lcyANCg0KTm90ZSB0aGF0IGxpbmVfdGhyZXNob2xkIGNhbiB0YWtlIGEgbWF4IHZh
bHVlIG9mIDYzDQoNCg0KPiBUb21pDQo+DQo+LS0NCj5UZXhhcyBJbnN0cnVtZW50cyBGaW5sYW5k
IE95LCBQb3Jra2FsYW5rYXR1IDIyLCAwMDE4MCBIZWxzaW5raS4NCj5ZLXR1bm51cy9CdXNpbmVz
cyBJRDogMDYxNTUyMS00LiBLb3RpcGFpa2thL0RvbWljaWxlOiBIZWxzaW5raQ0K
