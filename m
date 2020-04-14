Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B22CC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E027F2063A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 09:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="OZGEZqvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437382AbgDNJFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 05:05:42 -0400
Received: from mx0b-00128a01.pphosted.com ([148.163.139.77]:46994 "EHLO
        mx0b-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437356AbgDNJFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 05:05:31 -0400
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03E94WCX002460;
        Tue, 14 Apr 2020 05:05:07 -0400
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by mx0b-00128a01.pphosted.com with ESMTP id 30bah6qyjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Apr 2020 05:05:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1qyp9hnOL7aJWlqbZhXcg9xH4p0ytqFxoMS7/6iePE7p6poCjY+brfbXn9oEtJM6KhzMpYt8wpbLWihx3dNcQ4vplXU6K+XggQmRGAyY5p5EbUHvlMiNFP5q3L8JK0Xo1WB0cxYTFVfARR8NWREYGOUHvSKz3GHdhPaCLLDXQADXIcPKDXkRXIv9DSWBSMKnBBYChLOFR4kiy0LEWZGa074TOKqNdj7kIgjJ1e40EtW3rwR/fpwxne8+tf/9ed+u9DxqnUmyOjrrpParRAp4atpXaQQxQUifnW+xdpvZeTKdzkxowOeLqwKD17Btw5aJgFM4k44ilvPNdQozF5cNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/dm5mdDV5tjMn1uXwaY8unOOz6PPKkvE32KdwNQ+HY=;
 b=lY8VQGFCAA3VrJHPYAB9qyhUTOyfktxMDyqNJhpKGhLLdSuHTooH63j0FRSgb/vbtezm62c2XJZlRpq3Luo2yqap1UxYsHzPVM9t/Yg1HA0Z0mA1Tqy4Qdi6Q+Oo7Mc/lBOMnelok1MQIkLF9bWDda1BwB34Obehv3Kvu1mbO2RKcHVzyKp/yfQrWZmyTbvipzsyHPM2VHRvTq6gcXYWZ24CSrkpvXPfckeLCqYB+6yDA77IhJf/8MSYJD+SPpl944sNLvlTIXN9n1z/5o0p67UIy7jj6fqpO7JuThN6QPg5LC01B+scMoXo8mmXmuzwe6D+4JZyZxjfgos2O0n72w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/dm5mdDV5tjMn1uXwaY8unOOz6PPKkvE32KdwNQ+HY=;
 b=OZGEZqvbUKxfDTogdAAjpilLGWsJsp/g+CpwKuZCxtxjAfdM9+FyN6PnNNAdzp3tzU/Alji94H1PA21rGmUuUYWUPZeUM5xfjtNryLqq95zGlQSTyEoVQ+/PHITZRWiUUTvH2VkJLOYjMvbYuFvbZ9t+MvF1E3OuwpcvXyKUqFs=
Received: from CY4PR03MB3350.namprd03.prod.outlook.com (2603:10b6:910:55::24)
 by CY4PR03MB2853.namprd03.prod.outlook.com (2603:10b6:903:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.16; Tue, 14 Apr
 2020 09:05:06 +0000
Received: from CY4PR03MB3350.namprd03.prod.outlook.com
 ([fe80::e483:8557:31ac:d59b]) by CY4PR03MB3350.namprd03.prod.outlook.com
 ([fe80::e483:8557:31ac:d59b%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 09:05:06 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Rob Herring <robh@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: hwmon: Fix incorrect $id paths
Thread-Topic: [PATCH] dt-bindings: hwmon: Fix incorrect $id paths
Thread-Index: AQHWDq0Dmm+awRtDr0C2g6ACFqlOJqh4WZbA
Date:   Tue, 14 Apr 2020 09:05:05 +0000
Message-ID: <CY4PR03MB3350278AE774CC53163A882799DA0@CY4PR03MB3350.namprd03.prod.outlook.com>
References: <20200409202516.25282-1-robh@kernel.org>
In-Reply-To: <20200409202516.25282-1-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE1EWTRPRGs0TXpFdE4yVXlaaTB4TVdWaExUaGhORGt0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGbFhHRnRaUzEwWlhOMFhEQTJPRGc1T0RNekxUZGxNbVl0TVRGbFlTMDRZ?=
 =?utf-8?B?VFE1TFdaak56YzNOREl4Wm1OaFpXSnZaSGt1ZEhoMElpQnplajBpTXpneE15?=
 =?utf-8?B?SWdkRDBpTVRNeU16RXpNamczTURNMk5UVTFORGd5SWlCb1BTSlFaM2h3Umpo?=
 =?utf-8?B?TlpYQnZlVk0xVUU1SE9IVnhTRmsyVGtKR2QwRTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUmhNRTlFU1U5NFRGZEJXR2RRVWxGM01YbDZVSGxsUVRsR1JF?=
 =?utf-8?B?UllURTB2U1VSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVFYxUjBSWFFVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-originating-ip: [2001:a61:24bb:2b01:f194:432c:5da0:8ff4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 828aea14-da1f-4cca-05d0-08d7e052eccf
x-ms-traffictypediagnostic: CY4PR03MB2853:
x-microsoft-antispam-prvs: <CY4PR03MB285343A5A5455119927837ED99DA0@CY4PR03MB2853.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3350.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(346002)(396003)(39840400004)(136003)(366004)(376002)(7696005)(4326008)(86362001)(71200400001)(55016002)(9686003)(52536014)(6506007)(53546011)(8936002)(81156014)(66476007)(66946007)(66446008)(64756008)(66556008)(76116006)(8676002)(478600001)(966005)(5660300002)(33656002)(110136005)(316002)(2906002)(54906003)(186003);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: analog.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LLBg24utq0N7GubkN1crqoK3LEGkbep7k7P32V09z3PkZwF/DY+wmP7iJGZtrbtx2JJ3faKmTrEbt5dJbDdfPWUPV/RwEvcLpMKY33UrvJAs3txNhkOBUVEyER9trvCOvJZfp7tb3OCfAPw6RzpSR99C+0ZNarqvO9R9kvoS3XZ2o6ch7p48zVlcabSHsxJk8QGYkl3rbCk5X4Nnjo4e7JwNk8X6O7GWExoONbkHTni2KlIe1+Qb5/DSVfPq2fXxdYMHVFW2Gzxtj4hMfrFIkM6EQVbe2qTnCkYyOy0ERVjHmrNWhgfaFUiIckVCIbRzwDPxf7osWYusMsyEHWDUFP0M533IbKilWg5J4spLNTWh8YReJLfpmfiiBEQV19wF1VsElHCEy+V6thObJ+2+IcQ95l1AXjKchEIzfBguZQXY5l1lBKJl1W1IkEtpAE03yipCuR7lSjO78W581yDv/Tgy5kgye+oefoHmc5sOLeaA9CTWqTch/xhaqHi1+lQ15mnAKgPbdPh5qA6HkZvNtA==
x-ms-exchange-antispam-messagedata: vTYTYj6YIl+2Ya5Ib8VJx03B7HZ14wftXFpfr9caAfWDauMvl6166Ig1fb7X8QrvxSq1yZoBrzXmeOTNIX0FCeg1HkmNhhFiSmaxQQytXcGdCCx170LWUEgJUw4sCp7X3l3TRvGDOUhEPpeFBD4Ibded/zOPoEHhmlhJ7DGwBHCMzX/CH1p5RzIShti7H008ssFAkL2ZzkyRM9/OjJ1XZA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 828aea14-da1f-4cca-05d0-08d7e052eccf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 09:05:05.9835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pMrFYbpR9jsA+pqVxhlYlIZ2OySlHJzshCh4dDGLLE59h0C539TWd1ScUbCLe2fAMlyJ4HkBnovRtJgS0nognQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2853
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-14_02:2020-04-13,2020-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 clxscore=1011 priorityscore=1501 malwarescore=0
 suspectscore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004140076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBsaW51eC1od21vbi1vd25lckB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWh3bW9uLQ0K
PiBvd25lckB2Z2VyLmtlcm5lbC5vcmc+IE9uIEJlaGFsZiBPZiBSb2IgSGVycmluZw0KPiBTZW50
OiBEb25uZXJzdGFnLCA5LiBBcHJpbCAyMDIwIDIyOjI1DQo+IFRvOiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZw0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgU2EsIE51bm8g
PE51bm8uU2FAYW5hbG9nLmNvbT47IEplYW4NCj4gRGVsdmFyZSA8amRlbHZhcmVAc3VzZS5jb20+
OyBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+OyBsaW51eC0NCj4gaHdtb25Admdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFtQQVRDSF0gZHQtYmluZGluZ3M6IGh3bW9uOiBGaXgg
aW5jb3JyZWN0ICRpZCBwYXRocw0KPiANCj4gDQo+IEZpeCB0aGUgcGF0aCB3YXJuaW5ncyBpbiB0
aGUgYWRpLGF4aS1mYW4tY29udHJvbCBhbmQgYWR0NzQ3NSBiaW5kaW5nczoNCj4gDQo+IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZHQ3NDc1LnlhbWw6ICRpZDoNCj4g
ICByZWxhdGl2ZSBwYXRoL2ZpbGVuYW1lIGRvZXNuJ3QgbWF0Y2ggYWN0dWFsIHBhdGggb3IgZmls
ZW5hbWUNCj4gICBleHBlY3RlZDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2h3bW9uL2FkdDcNCj4gNDc1LnlhbWwqX187SXchIUEz
Tmk4Q1MweTJZIXJoeGdTaWdtSG10YlY1SDllX1RfOTVfR2R4bmhMeUNpUXd2LQ0KPiBpU0Y0Y2lN
MGJRczVEZWE0d2ZFUmVaakJ2dyQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2h3bW9uL2FkaSxheGktZmFuLWNvbnRyb2wueWFtbDogJGlkOg0KPiAgIHJlbGF0aXZlIHBhdGgv
ZmlsZW5hbWUgZG9lc24ndCBtYXRjaCBhY3R1YWwgcGF0aCBvciBmaWxlbmFtZQ0KPiAgIGV4cGVj
dGVkOg0KPiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3Jn
L3NjaGVtYXMvaHdtb24vYWRpLGENCj4geGktZmFuLQ0KPiBjb250cm9sLnlhbWwqX187SXchIUEz
Tmk4Q1MweTJZIXJoeGdTaWdtSG10YlY1SDllX1RfOTVfR2R4bmhMeUNpUQ0KPiB3di1pU0Y0Y2lN
MGJRczVEZWE0d2ZHdUNrbFlBZyQNCj4gDQo+IENjOiAiTnVubyBTw6EiIDxudW5vLnNhQGFuYWxv
Zy5jb20+DQo+IENjOiBKZWFuIERlbHZhcmUgPGpkZWx2YXJlQHN1c2UuY29tPg0KPiBDYzogR3Vl
bnRlciBSb2VjayA8bGludXhAcm9lY2stdXMubmV0Pg0KPiBDYzogbGludXgtaHdtb25Admdlci5r
ZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYtYnk6IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQo+IC0tLQ0KDQpBY2tlZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCg0KPiBX
aWxsIHRha2UgdGhpcyB2aWEgdGhlIERUIHRyZWUuDQo+IA0KPiBSb2INCj4gDQo+ICAuLi4vZGV2
aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZGksYXhpLWZhbi1jb250cm9sLnlhbWwgICAgICAgICAg
fCAyICstDQo+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWR0NzQ3
NS55YW1sICAgICAgICAgICAgfCAyICstDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWRpLGF4aS1mYW4tDQo+IGNvbnRyb2wueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9od21vbi9hZGksYXhpLWZhbi0NCj4gY29u
dHJvbC55YW1sDQo+IGluZGV4IDI5YmIyYzc3OGM1OS4uN2RiNzg3NjdjMDJkIDEwMDY0NA0KPiAt
LS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaHdtb24vYWRpLGF4aS1mYW4t
Y29udHJvbC55YW1sDQo+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9o
d21vbi9hZGksYXhpLWZhbi1jb250cm9sLnlhbWwNCj4gQEAgLTIsNyArMiw3IEBADQo+ICAjIENv
cHlyaWdodCAyMDE5IEFuYWxvZyBEZXZpY2VzIEluYy4NCj4gICVZQU1MIDEuMg0KPiAgLS0tDQo+
IC0kaWQ6DQo+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJlZS5v
cmcvc2NoZW1hcy9iaW5kaW5ncy9odw0KPiBtb24vYWRpLGF4aS1mYW4tDQo+IGNvbnRyb2wueWFt
bCpfXztJdyEhQTNOaThDUzB5Mlkhcmh4Z1NpZ21IbXRiVjVIOWVfVF85NV9HZHhuaEx5Q2lRDQo+
IHd2LWlTRjRjaU0wYlFzNURlYTR3ZkZtUHR3cDJ3JA0KPiArJGlkOg0KPiBodHRwczovL3VybGRl
ZmVuc2UuY29tL3YzL19faHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaHdtb24vYWRpLGEN
Cj4geGktZmFuLQ0KPiBjb250cm9sLnlhbWwqX187SXchIUEzTmk4Q1MweTJZIXJoeGdTaWdtSG10
YlY1SDllX1RfOTVfR2R4bmhMeUNpUQ0KPiB3di1pU0Y0Y2lNMGJRczVEZWE0d2ZHdUNrbFlBZyQN
Cj4gICRzY2hlbWE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwOi8vZGV2aWNldHJl
ZS5vcmcvbWV0YS0NCj4gc2NoZW1hcy9jb3JlLnlhbWwqX187SXchIUEzTmk4Q1MweTJZIXJoeGdT
aWdtSG10YlY1SDllX1RfOTVfR2R4bg0KPiBoTHlDaVF3di1pU0Y0Y2lNMGJRczVEZWE0d2ZIWDRM
UV9IQSQNCj4gDQo+ICB0aXRsZTogQW5hbG9nIERldmljZXMgQVhJIEZBTiBDb250cm9sIERldmlj
ZSBUcmVlIEJpbmRpbmdzDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvaHdtb24vYWR0NzQ3NS55YW1sDQo+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL2h3bW9uL2FkdDc0NzUueWFtbA0KPiBpbmRleCA3Njk4NTAzNGVhNzMuLjQ2YzQ0
MTU3NGY5OCAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L2h3bW9uL2FkdDc0NzUueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvaHdtb24vYWR0NzQ3NS55YW1sDQo+IEBAIC0xLDcgKzEsNyBAQA0KPiAgIyBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KPiAgJVlBTUwgMS4y
DQo+ICAtLS0NCj4gLSRpZDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6Ly9k
ZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2FkdDc0NzUueWFtbA0KPiAqX187SXchIUEzTmk4Q1MweTJZ
IXJoeGdTaWdtSG10YlY1SDllX1RfOTVfR2R4bmhMeUNpUXd2LQ0KPiBpU0Y0Y2lNMGJRczVEZWE0
d2ZGelppaFp5QSQNCj4gKyRpZDoNCj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHA6
Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2h3bW9uL2FkdDcNCj4gNDc1LnlhbWwqX187SXchIUEz
Tmk4Q1MweTJZIXJoeGdTaWdtSG10YlY1SDllX1RfOTVfR2R4bmhMeUNpUXd2LQ0KPiBpU0Y0Y2lN
MGJRczVEZWE0d2ZFUmVaakJ2dyQNCj4gICRzY2hlbWE6IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS0NCj4gc2NoZW1hcy9jb3JlLnlhbWwqX187
SXchIUEzTmk4Q1MweTJZIXJoeGdTaWdtSG10YlY1SDllX1RfOTVfR2R4bg0KPiBoTHlDaVF3di1p
U0Y0Y2lNMGJRczVEZWE0d2ZIWDRMUV9IQSQNCj4gDQo+ICB0aXRsZTogQURUNzQ3NSBod21vbiBz
ZW5zb3INCj4gLS0NCj4gMi4yMC4xDQoNCg==
