Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958B1C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5669120857
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="L4VQRpD3";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="b2YYl2sd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgGNHom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:44:42 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:53424 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725780AbgGNHol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:44:41 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06E7i8FB030157;
        Tue, 14 Jul 2020 00:44:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=kdtiUK9K9SpdkbsG0C+5JlftLUhkE61Bdg88er2N9cI=;
 b=L4VQRpD3sHa25z1aYjI1IZqYL3XAtB8jqMfCQizniVxleKIUk1ERVBeUEnuYsFd2jfSD
 +5TuOoZ6c7Fg7e03XDhxaVsTxUI0lqtTdMBmSnaoRCuIxHRMekkKT+sivfkyRZBO1Ckt
 QZupyjBtscou87O/WgERQRxhE8FzrPDwNyHdYKb83iZaki8I86LYpLMYlRDBnmeu/LMM
 leMAtb3qIoWxTRGldJ7scf6VbBzedoiDS2fkV3VnjJmlUSBeJTc40mqG5Le7rdRFv7Bh
 prJ1w8T7A7d/lD8mRkbajhX3hiti4EWNYofjkknSg7Jn8f20HkjJFtfkzq5olEM8UHcJ OQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by mx0b-0014ca01.pphosted.com with ESMTP id 328ftumsgd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Jul 2020 00:44:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJMA2umATaYv8hmdkGxylJgmk3rF4VSZ4RGGOHUS1uGOlMkOwk/0HDM6novXXx223QI9mKe1W+2TR5jMf8lO0Fd8ogdrc1N2BFaZ8iljh1WNB9IPUycGX3NzSLED9nlJpmfrnsNb7jAjsxFjFFXE2ZmQ0tMr6SzgFGQkeLcnjzAjdfglpNFV5iiHA6F7F1luEY/AHoVhHzj3rlk6E6+17x9g0Hn4u4qYY7fWx5AB5VHuwqeL+ClTIjvUMD5d5Pg9Dl+L/E3znwE0WMgwnQ7AFu/YeJkVi8lw8ZCmjwD3UDVAVJ5yXOAgObCZ0V7DHMc/pNJ/iNuSWZccj3QQpe111w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdtiUK9K9SpdkbsG0C+5JlftLUhkE61Bdg88er2N9cI=;
 b=ZW5Kp5AA8PEydQ2TROsIOdBAmbbozGILfOVLAFumY4s4jOb68713C5gtlqCzPMESQqj3S3A/lntHpSFEprVQL0X0jW/krh0zXijHexea2aAboRiU83JcyIMAUVQiugDFimyhL6Nk1UthThiyPhYGMfxrK8qMYyWHPjJbsrqTVp+5mQUV/3kl7CX2jYatGJBae04hre2QjScfLNjH8k/PKUgaxcumOXTJWTNwGvdnnWNREjTorQPbuCMLMj+XCWcfdTbTC9Pn+Gc5R9wryn3lETHVzWxZ/OVcyYWwrf5BOHxrCMoToY/ZZ/WymBiGXJ1X1Tq1wugTjpGODDPzoz0ubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdtiUK9K9SpdkbsG0C+5JlftLUhkE61Bdg88er2N9cI=;
 b=b2YYl2sdji38lk6hpU8SjfCDRom89/si0o4RhzrdzxQTtBA8JhV6eh8ZN+xoy1EGbqJT2lLRzHvJ4AHeTM+A70eg4G+IaNVyZhaOH7VYK+oKxI90a5k0/WrnAAhQBzY5uejJ95SjaxfQdlWWR+3PtgTU5qJcvJDTxi9AzlQLUvk=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM6PR07MB4635.namprd07.prod.outlook.com (2603:10b6:5:9a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Tue, 14 Jul
 2020 07:44:27 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::88e7:2025:120f:97f]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::88e7:2025:120f:97f%7]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 07:44:26 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v3 1/2] phy: Add new PHY attribute max_link_rate and APIs
 to get/set PHY attributes
Thread-Topic: [PATCH v3 1/2] phy: Add new PHY attribute max_link_rate and APIs
 to get/set PHY attributes
Thread-Index: AQHWWPljhmYIAnOvrUGcIRrCaQUaMakFWrkAgAANIICAAUi28A==
Date:   Tue, 14 Jul 2020 07:44:26 +0000
Message-ID: <DM6PR07MB6154EB848939DBC2DFB40D7BC5610@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <1594633112-4155-1-git-send-email-sjakhade@cadence.com>
 <1594633112-4155-2-git-send-email-sjakhade@cadence.com>
 <20200713111120.GI34333@vkoul-mobl>
 <67fcecf5-7be3-518f-ce3e-095dcddd5bc9@ti.com>
In-Reply-To: <67fcecf5-7be3-518f-ce3e-095dcddd5bc9@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kNDEyY2I5Yi1jNWE1LTExZWEtODUyMy1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcZDQxMmNiOWQtYzVhNS0xMWVhLTg1MjMtYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSI0OTI2IiB0PSIxMzIzOTE4NjI2MTY3MTk5MTQiIGg9InJ0MW5COXNLc25YSC9sUVJHR0pyd0ZKcndaST0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 20d46937-5a7a-4ba3-6cb6-08d827c9bc05
x-ms-traffictypediagnostic: DM6PR07MB4635:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB4635A0833B04558CA3361F0FC5610@DM6PR07MB4635.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qvskmo80zaEthubGSg5V5KTjHFLRux+kwWcLJzDpXvNQ4FM3wRTATindRKIWygBtQVNVvqIisb85vVt+zmDOp6j34e+buLGc9RTHEiE7GuMXO/a++KlaKOR0K1Jd8iATyuKEU80vcv0FOfafn7OAFKodp8wvS+T8zO9cCffDgsL9A60/dOKhF4ydhrvq5+/aN3lKBbi3ui622+hLSmajkOZhi8lvjZIV1nYerjJxd4iTYBZcqYfiwOl5pHqNnLKCnDxkyQLCh/W/STmDFSEES0DrCKgCZ5h6kxOp7KTzS6GinoyBXxzqPWYCTSk9ueCOa0g6oWCVTJ/t2jZqGgN8GGrShAzVK4wszSxLzbPetgKQI44nqz5WdKqq4gcfgU5Uv0P527v7ODQAiLOhdGNLK9nhmP9HmBcVPtwh0X9GDZ9Bp/VPkq/BWtTfDiMzyNQlc0JMi5AXVKTrUNOSatpO4A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(376002)(346002)(396003)(36092001)(64756008)(52536014)(478600001)(5660300002)(8676002)(55016002)(71200400001)(8936002)(2906002)(7696005)(86362001)(53546011)(6506007)(26005)(9686003)(66446008)(4326008)(54906003)(66476007)(66946007)(110136005)(76116006)(186003)(316002)(966005)(66556008)(83380400001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: c/JNRkXI/hKXMkutmgERCzZtS+2rTOFAvlfh/nT1x/Sc+NkUzm9IxZ/g3o3mFJyDv5IUNypLwK02PC8wCOJSN0n7w/TzHL/kSJ0oObayEvNsicikmraq2w55UqaTI5EkY2uhq1fHOkDJJSBbAhAYGyAmBRlnS1Luh46XFXapRc1XoNSDuIMhd5w305+bGhwnBZ9ym2QAufGiGkhMer0M+vPQGHtX/KQVT++RPp/cHs2bMN/fvzkiJfg6eHm2FzSXELubcmENqMQZ0BhJNo2vmue4EoflqXBxsoO48yvJKsoZE3i7Hi56fXfXCkVS73QGfhVBNnqymAdutwTLS23umWidLusMj/ZOjcvnE4P1kIG7FazCiWQ346RHPKhWVzz0DU33sSVej7ahgjOqR1RTUO1ErmnCgda0shJDxGwfP4KRttTUjjUgnUD0XMjiSLNF+fqjz2LNllP+8tPrRDtfDbKSwEY80YZ9VBZ912SdVU0=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d46937-5a7a-4ba3-6cb6-08d827c9bc05
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 07:44:26.8387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L//WbTiX1dKBGgXR+zQFAxHvQcZfwquZlV5tdhyoKfAp0ek0gJxRonz63aPUu4umGXeEuFoKeooxwbR1d7Bw6tUGPLO500UZhNK7+ZYTRAg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4635
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-14_01:2020-07-13,2020-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007140060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPiBGcm9tOiBLaXNob24gVmlqYXkgQWJyYWhhbSBJIDxraXNob25AdGkuY29tPg0K
PiBTZW50OiBNb25kYXksIEp1bHkgMTMsIDIwMjAgNToyOCBQTQ0KPiBUbzogVmlub2QgS291bCA8
dmtvdWxAa2VybmVsLm9yZz47IFN3YXBuaWwgS2FzaGluYXRoIEpha2hhZGUNCj4gPHNqYWtoYWRl
QGNhZGVuY2UuY29tPg0KPiBDYzogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgbWF4aW1l
QGNlcm5vLnRlY2g7IE1pbGluZCBQYXJhYg0KPiA8bXBhcmFiQGNhZGVuY2UuY29tPjsgWXV0aSBT
dXJlc2ggQW1vbmthciA8eWFtb25rYXJAY2FkZW5jZS5jb20+Ow0KPiBuc2VraGFyQHRpLmNvbTsg
dG9taS52YWxrZWluZW5AdGkuY29tOyBqc2FyaGFAdGkuY29tOyBwcmFuZWV0aEB0aS5jb20NCj4g
U3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzJdIHBoeTogQWRkIG5ldyBQSFkgYXR0cmlidXRlIG1h
eF9saW5rX3JhdGUgYW5kDQo+IEFQSXMgdG8gZ2V0L3NldCBQSFkgYXR0cmlidXRlcw0KPiANCj4g
RVhURVJOQUwgTUFJTA0KPiANCj4gDQo+IA0KPiANCj4gT24gNy8xMy8yMDIwIDQ6NDEgUE0sIFZp
bm9kIEtvdWwgd3JvdGU6DQo+ID4gT24gMTMtMDctMjAsIDExOjM4LCBTd2FwbmlsIEpha2hhZGUg
d3JvdGU6DQo+ID4+IEFkZCBuZXcgUEhZIGF0dHJpYnV0ZSBtYXhfbGlua19yYXRlIHRvIHN0cnVj
dCBwaHlfYXR0cnMuDQo+ID4+IEFkZCBhIHBhaXIgb2YgUEhZIEFQSXMgdG8gZ2V0L3NldCBhbGwg
dGhlIFBIWSBhdHRyaWJ1dGVzLg0KPiA+PiBVc2UgcGh5X3NldF9hdHRycygpIHRvIHNldCBhdHRy
aWJ1dGUgdmFsdWVzIGluIHRoZSBQSFkgcHJvdmlkZXIgZHJpdmVyLg0KPiA+PiBVc2UgcGh5X2dl
dF9hdHRycygpIHRvIGdldCBhdHRyaWJ1dGUgdmFsdWVzIGluIHRoZSBjb250cm9sbGVyIGRyaXZl
ci4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogWXV0aSBBbW9ua2FyIDx5YW1vbmthckBjYWRl
bmNlLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogU3dhcG5pbCBKYWtoYWRlIDxzamFraGFkZUBj
YWRlbmNlLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBpbmNsdWRlL2xpbnV4L3BoeS9waHkuaCB8IDIy
ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRp
b25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3BoeS9waHkuaCBi
L2luY2x1ZGUvbGludXgvcGh5L3BoeS5oIGluZGV4DQo+ID4+IGJjZWU4ZWJhNjJiMy4uN2ZiNTkz
NTlhYjdiIDEwMDY0NA0KPiA+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3BoeS9waHkuaA0KPiA+PiAr
KysgYi9pbmNsdWRlL2xpbnV4L3BoeS9waHkuaA0KPiA+PiBAQCAtMTE1LDEwICsxMTUsMTIgQEAg
c3RydWN0IHBoeV9vcHMgew0KPiA+PiAgLyoqDQo+ID4+ICAgKiBzdHJ1Y3QgcGh5X2F0dHJzIC0g
cmVwcmVzZW50cyBwaHkgYXR0cmlidXRlcw0KPiA+PiAgICogQGJ1c193aWR0aDogRGF0YSBwYXRo
IHdpZHRoIGltcGxlbWVudGVkIGJ5IFBIWQ0KPiA+PiArICogQG1heF9saW5rX3JhdGU6IE1heGlt
dW0gbGluayByYXRlIHN1cHBvcnRlZCBieSBQSFkgKGluIE1icHMpDQo+ID4+ICAgKiBAbW9kZTog
UEhZIG1vZGUNCj4gPj4gICAqLw0KPiA+PiAgc3RydWN0IHBoeV9hdHRycyB7DQo+ID4+ICAJdTMy
CQkJYnVzX3dpZHRoOw0KPiA+PiArCXUzMgkJCW1heF9saW5rX3JhdGU7DQo+ID4+ICAJZW51bSBw
aHlfbW9kZQkJbW9kZTsNCj4gPj4gIH07DQo+ID4+DQo+ID4+IEBAIC0yMzEsNiArMjMzLDE2IEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBwaHlfc2V0X2J1c193aWR0aChzdHJ1Y3QgcGh5DQo+ID4+ICpw
aHksIGludCBidXNfd2lkdGgpICB7DQo+ID4+ICAJcGh5LT5hdHRycy5idXNfd2lkdGggPSBidXNf
d2lkdGg7DQo+ID4+ICB9DQo+ID4+ICsNCj4gPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBwaHlfZ2V0
X2F0dHJzKHN0cnVjdCBwaHkgKnBoeSwgc3RydWN0IHBoeV9hdHRycw0KPiA+PiArKmF0dHJzKSB7
DQo+ID4+ICsJbWVtY3B5KGF0dHJzLCAmcGh5LT5hdHRycywgc2l6ZW9mKHN0cnVjdCBwaHlfYXR0
cnMpKTsgfQ0KPiA+PiArDQo+ID4+ICtzdGF0aWMgaW5saW5lIHZvaWQgcGh5X3NldF9hdHRycyhz
dHJ1Y3QgcGh5ICpwaHksIHN0cnVjdCBwaHlfYXR0cnMNCj4gPj4gK2F0dHJzKSB7DQo+ID4+ICsJ
bWVtY3B5KCZwaHktPmF0dHJzLCAmYXR0cnMsIHNpemVvZihzdHJ1Y3QgcGh5X2F0dHJzKSk7IH0N
Cj4gPg0KPiA+IHdlIGFscmVhZHkgaGF2ZSBBUElzIGZvciBtb2RlIGFuZCBidXNfd2lkdGggc28g
d2h5IG5vdCBhZGQgb25lIGZvcg0KPiA+IGxpbmtfcmF0ZSBhbmQgY2FsbCB0aGVtPw0KDQpGaXJz
dCB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggc2VyaWVzIFsxXSB3YXMgYmFzZWQgb24gdGhpcyBhcHBy
b2FjaC4gQnV0IGFzIHBlciB0aGUgZnVydGhlciBkaXNjdXNzaW9uIGluIHRoZSBzYW1lIHRocmVh
ZCBbMl0sIHBoeV9nZXRfYXR0cnMvcGh5X3NldF9hdHRycyBhcmUgaW1wbGVtZW50ZWQuDQpbMV0g
aHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvNC8yOC8xMzkNCg0KWzJdIGh0dHBzOi8vbGttbC5v
cmcvbGttbC8yMDIwLzUvMTgvNDcyDQoNCj4gPg0KPiA+IEFsc28gSSBzZWUgeW91IGFyZSB1c2lu
ZyBwaHlfc2V0X2F0dHJzKCkgaW4gc2Vjb25kIHBhdGNoLCB3aHkgYWRkDQo+ID4gcGh5X2dldF9h
dHRycygpIHdoZW4gd2UgaGF2ZSBubyB1c2VyPw0KDQpBcyBtZW50aW9uZWQgaW4gY292ZXIgbGV0
dGVyLCBwaHlfZ2V0X2F0dHJzKCkgaXMgcGxhbm5lZCB0byBiZSB1c2VkIGluIENhZGVuY2UgTUhE
UCBEUk0gYnJpZGdlIGRyaXZlciBmb3IgRGlzcGxheVBvcnQuIE5leHQgdmVyc2lvbiBvZiB0aGlz
IGRyaXZlciBwYXRjaCBzZXJpZXMgWzNdIHdpbGwgdXNlIHRoaXMgQVBJLg0KDQpbM10gaHR0cHM6
Ly9sa21sLm9yZy9sa21sLzIwMjAvMi8yNi8yNjMNCg0KPiANCj4gT25lIG9mIHRoZSBmYWN0b3Jz
IHRvIGNvbnNpZGVyIGlzIHdobyB3aWxsIHNldCB0aGUgYXR0cmlidXRlczsgaXQgY291bGQgZWl0
aGVyIGJlDQo+IHBoeSBwcm92aWRlciAobGlrZSAyLzIgb2YgdGhpcyBzZXJpZXMpIG9yIHBoeSBj
b25zdW1lciAoZmFjdG9ycyBsaWtlIFBDSWUgc3BlZWQsDQo+IGxhbmUgYXJlIHVzdWFsbHkgbmVn
b3RpYXRlZCB3aXRoIHRoZSBwaHkgY29uc3VtZXIpLg0KPiANCj4gTm93IGlmIHBoeSBwcm92aWRl
ciBpcyBzZXR0aW5nL2dldHRpbmcgdGhlIGF0dHJpYnV0ZXMsIHRoZW4NCj4gcGh5X3NldF9hdHRy
cy9waHlfZ2V0X2F0dHJzIHNob3VsZCBiZSBwcm90ZWN0ZWQgYnkgbXV0ZXguIFdlIGRvbid0IHdh
bnQNCj4gdG8gYmUgdXBkYXRpbmcgYXR0cmlidXRlcyB3aGVuIHBoeSBjb25zdW1lciBpcyBkb2lu
ZyBzb21lIHBoeSBvcHMuDQo+IA0KPiBJZiBwaHlfY29uc3VtZXIgaXMgdXBkYXRpbmcgYXR0cmli
dXRlcywgaXQgY291bGQgZGlyZWN0bHkgYWNjZXNzIHRoZSBwaHkNCj4gYXR0cmlidXRlcyBpZiBp
dCdzIHVwZGF0aW5nIHdpdGhpbiBvbmUgb2YgdGhvc2UgcGh5IG9wcy4gRG9uJ3QgcmVhbGx5IHNl
ZSBhIG5lZWQNCj4gZm9yIHVzaW5nIGFuIEFQSSB0byB1cGRhdGUgdGhlIGF0dHJpYnV0ZXMgdGhl
bi4NCj4gDQo+IEhvd2V2ZXIgaWYgaXQncyB1cGRhdGluZyBvdXRzaWRlIHRoZSBwaHlfb3BzLCB0
aGVuIGl0IHdvdWxkIHN0aWxsIG1ha2Ugc2Vuc2UNCj4gdG8gdXNlIHRoZSBBUElzIHRvIHVwZGF0
ZSBhdHRyaWJ1dGVzIHdpdGggYWxsIHRob3NlIG11dGV4IHByb3RlY3Rpb24uDQoNCk9rLiBQbGVh
c2UgY2hlY2sgaWYgZm9sbG93aW5nIGltcGxlbWVudGF0aW9uIGlzIGNvcnJlY3QgaW4gcGh5X2dl
dF9hdHRycy9waHlfc2V0X2F0dHJzICBBUElzIGZvciB0aGUgYWJvdmUgY2FzZS4NCg0KbXV0ZXhf
bG9jaygmcGh5LT5tdXRleCk7DQptZW1jcHkoLi4uLik7DQptdXRleF91bmxvY2soJnBoeS0+bXV0
ZXgpOw0KDQoNClRoYW5rcyAmIHJlZ2FyZHMsDQpTd2FwbmlsDQo+IA0KPiBSZWdhcmRzDQo+IEtp
c2hvbg0KPiA+DQo+ID4+ICBzdHJ1Y3QgcGh5ICpwaHlfZ2V0KHN0cnVjdCBkZXZpY2UgKmRldiwg
Y29uc3QgY2hhciAqc3RyaW5nKTsgIHN0cnVjdA0KPiA+PiBwaHkgKnBoeV9vcHRpb25hbF9nZXQo
c3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpzdHJpbmcpOw0KPiA+PiBzdHJ1Y3QgcGh5
ICpkZXZtX3BoeV9nZXQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyICpzdHJpbmcpOyBA
QA0KPiA+PiAtMzg5LDYgKzQwMSwxNiBAQCBzdGF0aWMgaW5saW5lIHZvaWQgcGh5X3NldF9idXNf
d2lkdGgoc3RydWN0IHBoeSAqcGh5LA0KPiBpbnQgYnVzX3dpZHRoKQ0KPiA+PiAgCXJldHVybjsN
Cj4gPj4gIH0NCj4gPj4NCj4gPj4gK3N0YXRpYyBpbmxpbmUgdm9pZCBwaHlfZ2V0X2F0dHJzKHN0
cnVjdCBwaHkgKnBoeSwgc3RydWN0IHBoeV9hdHRycw0KPiA+PiArKmF0dHJzKSB7DQo+ID4+ICsJ
cmV0dXJuOw0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICtzdGF0aWMgaW5saW5lIHZvaWQgcGh5X3Nl
dF9hdHRycyhzdHJ1Y3QgcGh5ICpwaHksIHN0cnVjdCBwaHlfYXR0cnMNCj4gPj4gK2F0dHJzKSB7
DQo+ID4+ICsJcmV0dXJuOw0KPiA+PiArfQ0KPiA+PiArDQo+ID4+ICBzdGF0aWMgaW5saW5lIHN0
cnVjdCBwaHkgKnBoeV9nZXQoc3RydWN0IGRldmljZSAqZGV2LCBjb25zdCBjaGFyDQo+ID4+ICpz
dHJpbmcpICB7DQo+ID4+ICAJcmV0dXJuIEVSUl9QVFIoLUVOT1NZUyk7DQo+ID4+IC0tDQo+ID4+
IDIuMjYuMQ0KPiA+DQo=
