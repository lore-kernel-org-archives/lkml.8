Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7A0C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3524920716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="AhSgP4in";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="VEi+2tbR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729307AbgICPLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:11:55 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:9860 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728850AbgICM1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 08:27:54 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083Av2dN020963;
        Thu, 3 Sep 2020 03:59:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=1rOnNc55jcUHlpqNzB8LP+hfmdDSx7+3muLNBvrfYVo=;
 b=AhSgP4inDFgh+oHJtKg7rHIp6KMETENvGi8OoEVwfk47FGANAPmiQAl1X+WhORRRXk8U
 gs28UUu99r0J2kcmFXZlUt+rgZtRaoNUSqWq3xf3A7LSoGdmclpw4wbZjYX2HPBJRnxu
 Z1zWgYRq25JIG4ZWVs9dRL3RxssvHSu5Ef3+JrD+i6NlL7luGP1UVLkrfCDnNljKI/yF
 1jJe1VooMeHV/nnT/31CVhXGgLITSm1Pl/VZ8yQsfJBFs11R+3wgpQSjUnUB1kSkZJxm
 i2TeC3uBV4aEWjcdBUfxa8tqCLHVZhq/CIz2RnXsn4VllKhm0DsBOQtbfyfUjfb70Rj/ hQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-0014ca01.pphosted.com with ESMTP id 337kjxv59s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Sep 2020 03:59:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO8/q+dsvR2t/wcLre8rDTLJPUSg1QnlxNSbX85Cs9VuHOldIHMvQgNiMq9+N9b85DC89rpHqw8oPSh6h84dSbFuG7ImPmmZpOR+TuG2XYTI8QsItD8B5qAyRzMGhu2mEH3xFl8uuUJepBdswyC9ZBl+EAWG7znWbOwBT857K0N7h8A2hrRNWD68PXS4EtVt1CG9kiwOP4ecavmK/iqDdmQ3wup/JlXNQr6Qq9CsafogNGhawPTEnvBIesTrQQ3TenZAzQz/egKpq/TA7T1aURkkuCrq/PlvIk4j9cMMfdEeCetCL/d3Va6HbZy9dU/haxeIhvj/W0vCjoU6Z5ROpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rOnNc55jcUHlpqNzB8LP+hfmdDSx7+3muLNBvrfYVo=;
 b=CKP1m5kaV/014aDpV6/Uem5dqUj0X0QjmGFA9YVp36gC2aQedkFkgNv+iajOUPFxPuINVwzH0MnudstDed8if92VHfLT9vFyFSJB9y8+us6ThMn7eH+4pc1cwVBge/P484x7RRnbomtPM4sy08ZXucqkK3A4nLBz46kH01An2/nqMrqG51Wp2Zag6pLbOi6AyFuzsAcX9CNfvp2+fGLOfGh49Wos3dfMcOU+3epquOYROLRWHwn4qCtnd8mpThDpi+X+cB4sXJxJngsUlmbv5caUUCVuAGYT2M+jY2SgYqZdmFMUeHbtLmr7K9AwfwvmL19dOVzvmh0oAZEFAG2tdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rOnNc55jcUHlpqNzB8LP+hfmdDSx7+3muLNBvrfYVo=;
 b=VEi+2tbRFQI8+r0icXNTAtQWOGao6nL3cQJyKXAsKBQtAIwN5KZ7cvwWDDzX1mK4zBN3GcEzxS99BaZdNs4/1vgJrJ3mnEA8dhx2V+d+a7UUK8/eBHWq+XL1Wpj5o8NSlXA9H1h0rcgPFq+uux3IFUOYpq3J6N6/zBkerpu/iR4=
Received: from DM6PR07MB6154.namprd07.prod.outlook.com (2603:10b6:5:17e::20)
 by DM6PR07MB6025.namprd07.prod.outlook.com (2603:10b6:5:180::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 10:59:35 +0000
Received: from DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6]) by DM6PR07MB6154.namprd07.prod.outlook.com
 ([fe80::c0af:c085:c7a8:4bb6%5]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 10:59:35 +0000
From:   Swapnil Kashinath Jakhade <sjakhade@cadence.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "kishon@ti.com" <kishon@ti.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        Milind Parab <mparab@cadence.com>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v5 2/2] phy: cadence-torrent: Use kernel PHY API to set
 PHY attributes
Thread-Topic: [PATCH v5 2/2] phy: cadence-torrent: Use kernel PHY API to set
 PHY attributes
Thread-Index: AQHWekRjWakk5bsmRUWo+B0jwwHPTalUi9QAgABtITCAAFiHAIABes0g
Date:   Thu, 3 Sep 2020 10:59:35 +0000
Message-ID: <DM6PR07MB6154F54322C38E6D864C7797C52C0@DM6PR07MB6154.namprd07.prod.outlook.com>
References: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
 <1598293711-23362-3-git-send-email-sjakhade@cadence.com>
 <20200902002956.GE14351@pendragon.ideasonboard.com>
 <DM6PR07MB6154CC4A67BC3568A7339CC9C52F0@DM6PR07MB6154.namprd07.prod.outlook.com>
 <20200902121722.GA16811@pendragon.ideasonboard.com>
In-Reply-To: <20200902121722.GA16811@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcc2pha2hhZGVcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy04OTU0OTRlZS1lZGQ0LTExZWEtODUyOS1jOGY3NTA0NDIyZDhcYW1lLXRlc3RcODk1NDk0ZWYtZWRkNC0xMWVhLTg1MjktYzhmNzUwNDQyMmQ4Ym9keS50eHQiIHN6PSI0OTA4IiB0PSIxMzI0MzYwNDM2OTE1NzEyMzgiIGg9IlpDRTlvZFlVaCsrZ0ZPMEJ0N1ZIazBET0VQdz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [59.145.174.78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bfa212a2-1c39-4f70-db50-08d84ff871cf
x-ms-traffictypediagnostic: DM6PR07MB6025:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR07MB60250456442497D9D037CD79C52C0@DM6PR07MB6025.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KdFv6nu+p7SJ9/TfTYhpKBbnrKDkHeqSE2BPEyPdNLxm9cyObi9BAl833YFzyrDvYdzV8TjobfkMS0++ftHzWAuBop9WEgW9TgnY85bBFmrBb1YwUW//hlkQOflgQVIBUAh+Z5BDaq6/ebFqAb9j3g0veg8w3VsxYp3cx4lPjqgFcnviycWExYUCEgI3C66NXqGTZmaHLdbCuabPm81cAbVXzsKdC+O1LCnhy32nSGBuaxxAm3VeeUJRGOaRTsj8RQmY9PVei+kBlQ9TvgprUiSt2xt/IBjlp835+G36dTRIV/UGkFr8QaV8qM0g1uC7L5I9LppEmRi6YXUUuKZ1u4KlukFFlaazlZw5IP/NNlqCfEoigtUIZR1VFeD3vdcI4/j13qPvU7Zn02DnC95m0e66EHgikYS332fOvlw1WO+eu23HlBHJNliAolNxTSh7aO4pIcgRAe97gI4Ps9rFPw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB6154.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(36092001)(110136005)(54906003)(478600001)(33656002)(86362001)(316002)(71200400001)(66446008)(66556008)(66946007)(76116006)(64756008)(66476007)(5660300002)(4326008)(186003)(83380400001)(6506007)(55016002)(53546011)(9686003)(26005)(8936002)(2906002)(52536014)(966005)(8676002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Z40RL8puheSW6XcEqXmMHgxpjqsb5q3sHJ4CiEjcukMtscyRh3BTfFzMQSZssHWu8wuUFvMJR7VnTo6IhpeleTlx1ZQBiurh4AC382FQGyDdVlEmiC4QiDyM9CfGBZX3PrVu15SCKuzMOYAVGHUAfv0WakiO0seDgYaJOa3zjS1O9N6TGsdgV6ILPX3IP0LUtFCwAxlD9JBp25p2g9YRoiOKyGgk5sQMh/bC6hTeXivIt1n5qdD9mT7f1Voy0Wo52D3WQsQuL/sn9dWbhxEpOIIFRGN7bZtrdKzjLTivG7Shk2vAsa0k5CYN7XuiKFQw+w6OxeASOHKshFRlmeWz+BrG7dp9+a9grYJ2j/r+3D+WCZtyKTXq5rruy06qOZutqtm/1hlCJPaSJ2mNXIl5yviy4PBX+2R3RZMIRhfHw2tA6g1Y0OHQJp7yGhyxeGdHIeNCIdysFx3PtOCMGxJpVhobOiRt7JPeHmwZ36VkwKP3U6ZEIexM/8gBf7nRNE+gDegOLvOTfrumwYoC3LubRELGETOhDzgnwbBFUFv5BDH0Sd3FhY2lzIVFWWVi8oShuEZLxlHbsJB+2bZCAH0nuyNrXM/UmhfyKwDTKVpagjanwNBT+0su4kMoaeI6emh6L/WOCqmMJfkLlMQ/FnwqYA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB6154.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa212a2-1c39-4f70-db50-08d84ff871cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 10:59:35.0967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VeQbTyfRSeacU3z5vUtGG0WSn28ILTuxIRkJaqYILvzg1zwspTHiyoP6ztw73tpJDxeywZwDU6nxn9Nc4HLOTOxI4Y6TEUaEEfyve8Stio=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6025
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_05:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009030101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGF1cmVudCBQaW5jaGFy
dCA8bGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29tPg0KPiBTZW50OiBXZWRuZXNkYXks
IFNlcHRlbWJlciAyLCAyMDIwIDU6NDcgUE0NCj4gVG86IFN3YXBuaWwgS2FzaGluYXRoIEpha2hh
ZGUgPHNqYWtoYWRlQGNhZGVuY2UuY29tPg0KPiBDYzogdmtvdWxAa2VybmVsLm9yZzsga2lzaG9u
QHRpLmNvbTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gbWF4aW1lQGNlcm5vLnRl
Y2g7IE1pbGluZCBQYXJhYiA8bXBhcmFiQGNhZGVuY2UuY29tPjsgWXV0aSBTdXJlc2gNCj4gQW1v
bmthciA8eWFtb25rYXJAY2FkZW5jZS5jb20+OyBuc2VraGFyQHRpLmNvbTsNCj4gdG9taS52YWxr
ZWluZW5AdGkuY29tOyBqc2FyaGFAdGkuY29tOyBwcmFuZWV0aEB0aS5jb20NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NSAyLzJdIHBoeTogY2FkZW5jZS10b3JyZW50OiBVc2Uga2VybmVsIFBIWSBB
UEkgdG8gc2V0DQo+IFBIWSBhdHRyaWJ1dGVzDQo+IA0KPiBFWFRFUk5BTCBNQUlMDQo+IA0KPiAN
Cj4gSGkgU3dhcG5pbCwNCj4gDQo+IE9uIFdlZCwgU2VwIDAyLCAyMDIwIGF0IDA3OjA5OjIxQU0g
KzAwMDAsIFN3YXBuaWwgS2FzaGluYXRoIEpha2hhZGUNCj4gd3JvdGU6DQo+ID4gT24gV2VkbmVz
ZGF5LCBTZXB0ZW1iZXIgMiwgMjAyMCA2OjAwIEFNIExhdXJlbnQgUGluY2hhcnQgd3JvdGU6DQo+
ID4gPiBPbiBNb24sIEF1ZyAyNCwgMjAyMCBhdCAwODoyODozMVBNICswMjAwLCBTd2FwbmlsIEph
a2hhZGUgd3JvdGU6DQo+ID4gPiA+IFVzZSBnZW5lcmljIFBIWSBmcmFtZXdvcmsgZnVuY3Rpb24g
cGh5X3NldF9hdHRycygpIHRvIHNldCBudW1iZXINCj4gPiA+ID4gb2YgbGFuZXMgYW5kIG1heGlt
dW0gbGluayByYXRlIHN1cHBvcnRlZCBieSBQSFkuDQo+ID4gPiA+DQo+ID4gPiA+IFNpZ25lZC1v
ZmYtYnk6IFN3YXBuaWwgSmFraGFkZSA8c2pha2hhZGVAY2FkZW5jZS5jb20+DQo+ID4gPiA+IEFj
a2VkLWJ5OiBLaXNob24gVmlqYXkgQWJyYWhhbSBJIDxraXNob25AdGkuY29tPg0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gIGRyaXZlcnMvcGh5L2NhZGVuY2UvcGh5LWNhZGVuY2UtdG9ycmVudC5jIHwg
NyArKysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4g
PiA+DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9jYWRlbmNlL3BoeS1jYWRlbmNl
LXRvcnJlbnQuYw0KPiA+ID4gPiBiL2RyaXZlcnMvcGh5L2NhZGVuY2UvcGh5LWNhZGVuY2UtdG9y
cmVudC5jDQo+ID4gPiA+IGluZGV4IDcxMTYxMjczNThlZS4uZWNhNzE0NjdjNGE4IDEwMDY0NA0K
PiA+ID4gPiAtLS0gYS9kcml2ZXJzL3BoeS9jYWRlbmNlL3BoeS1jYWRlbmNlLXRvcnJlbnQuYw0K
PiA+ID4gPiArKysgYi9kcml2ZXJzL3BoeS9jYWRlbmNlL3BoeS1jYWRlbmNlLXRvcnJlbnQuYw0K
PiA+ID4gPiBAQCAtMTcxMCw2ICsxNzEwLDcgQEAgc3RhdGljIGludCBjZG5zX3RvcnJlbnRfcGh5
X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gPiA+ICAJc3RydWN0
IGNkbnNfdG9ycmVudF9waHkgKmNkbnNfcGh5Ow0KPiA+ID4gPiAgCXN0cnVjdCBkZXZpY2UgKmRl
diA9ICZwZGV2LT5kZXY7DQo+ID4gPiA+ICAJc3RydWN0IHBoeV9wcm92aWRlciAqcGh5X3Byb3Zp
ZGVyOw0KPiA+ID4gPiArCXN0cnVjdCBwaHlfYXR0cnMgdG9ycmVudF9hdHRyOw0KPiA+ID4gPiAg
CWNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgKm1hdGNoOw0KPiA+ID4gPiAgCXN0cnVjdCBjZG5z
X3RvcnJlbnRfZGF0YSAqZGF0YTsNCj4gPiA+ID4gIAlzdHJ1Y3QgZGV2aWNlX25vZGUgKmNoaWxk
Ow0KPiA+ID4gPiBAQCAtMTg1Miw2ICsxODUzLDEyIEBAIHN0YXRpYyBpbnQgY2Ruc190b3JyZW50
X3BoeV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4gPiAgCQkJ
CSBjZG5zX3BoeS0+cGh5c1tub2RlXS5udW1fbGFuZXMsDQo+ID4gPiA+ICAJCQkJIGNkbnNfcGh5
LT5tYXhfYml0X3JhdGUgLyAxMDAwLA0KPiA+ID4gPiAgCQkJCSBjZG5zX3BoeS0+bWF4X2JpdF9y
YXRlICUgMTAwMCk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwkJCXRvcnJlbnRfYXR0ci5idXNfd2lk
dGggPSBjZG5zX3BoeS0NCj4gPnBoeXNbbm9kZV0ubnVtX2xhbmVzOw0KPiA+ID4gPiArCQkJdG9y
cmVudF9hdHRyLm1heF9saW5rX3JhdGUgPSBjZG5zX3BoeS0NCj4gPm1heF9iaXRfcmF0ZTsNCj4g
PiA+ID4gKwkJCXRvcnJlbnRfYXR0ci5tb2RlID0gUEhZX01PREVfRFA7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKwkJCXBoeV9zZXRfYXR0cnMoZ3BoeSwgJnRvcnJlbnRfYXR0cik7DQo+ID4gPg0KPiA+
ID4gV2h5IGlzIHRoaXMgYmV0dGVyIHRoYW4gYWNjZXNzaW5nIHRoZSBhdHRyaWJ1dGVzIG1hbnVh
bGx5IGFzIGZvbGxvd3MgPw0KPiA+ID4NCj4gPiA+IAkJCWdwaHktPmF0dHJzLmJ1c193aWR0aCA9
IGNkbnNfcGh5LQ0KPiA+cGh5c1tub2RlXS5udW1fbGFuZXM7DQo+ID4gPiAJCQlncGh5LT5hdHRy
cy5tYXhfbGlua19yYXRlID0gY2Ruc19waHktDQo+ID5tYXhfYml0X3JhdGU7DQo+ID4gPiAJCQln
cGh5LT5hdHRycy5tb2RlID0gUEhZX01PREVfRFA7DQo+ID4gPg0KPiA+ID4gVGhpcyBpcyBjYWxs
ZWQgaW4gY2Ruc190b3JyZW50X3BoeV9wcm9iZSgpLCBiZWZvcmUgdGhlIFBIWSBwcm92aWRlcg0K
PiA+ID4gaXMgcmVnaXN0ZXJlZCwgc28gbm90aGluZyBjYW4gYWNjZXNzIHRoZSBQSFkgeWV0LiBX
aGF0IHJhY2UNCj4gPiA+IGNvbmRpdGlvbiBhcmUgeW91IHRyeWluZyB0byBwcm90ZWN0IGFnYWlu
c3Qgd2l0aCB1c2FnZSBvZiBwaHlfc2V0X2F0dHJzKCkgPw0KPiA+DQo+ID4gSSBhZ3JlZSB0aGF0
IGZvciBDYWRlbmNlIERQIGJyaWRnZSBkcml2ZXIgYW5kIFRvcnJlbnQgUEhZIGRyaXZlciB1c2UN
Cj4gPiBjYXNlLCBpdCB3b3VsZCBub3QgbWF0dGVyIGV2ZW4gaWYgd2Ugc2V0IHRoZSBhdHRyaWJ1
dGVzIGluIFRvcnJlbnQgUEhZDQo+ID4gZHJpdmVyIGluIGEgd2F5IHlvdSBzdWdnZXN0ZWQgYWJv
dmUuDQo+ID4gQnV0IGFzIHBlciB0aGUgZGlzY3Vzc2lvbiBpbiBbMV0sIHBoeV9zZXRfYXR0cnMv
cGh5X2dldF9hdHRycyBBUElzIGluDQo+ID4gZnV0dXJlIGNvdWxkIG1heWJlIHVzZWQgYnkgb3Ro
ZXIgZHJpdmVycyByZXBsYWNpbmcgZXhpc3RpbmcgaW5kaXZpZHVhbA0KPiA+IGZ1bmN0aW9ucyBm
b3IgYXR0cmlidXRlcyBidXNfd2lkdGggYW5kIG1vZGUgd2hpY2ggYXJlDQo+ID4gcGh5X3NldF9i
dXNfd2lkdGgvcGh5X2dldF9idXNfd2lkdGggYW5kDQo+IHBoeV9zZXRfbW9kZS9waHlfZ2V0X21v
ZGUuIFNvDQo+ID4gdGhpcyB1c2FnZSBpbiBUb3JyZW50IFBIWSBkcml2ZXIgaXMgYW4gZXhhbXBs
ZSBpbXBsZW1lbnRhdGlvbiBvZiB0aGUgQVBJLg0KPiA+DQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly91
cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzUvMTgvNDcyX187
ISFFSA0KPiA+IHNjbVMxeWdpVTFsQSFRS1RUSTdCUzFSMzVhX3pvTWZKc1k0QTR5Q3RFS3JRTnRp
QVhUeUlaLQ0KPiBTWUlFRWliWWRwQk1KVGxsDQo+ID4gWXJkLTAwJA0KPiANCj4gVGhpcyBkb2Vz
bid0IHNlZW0gYSB2ZXJ5IGdvb2QgQVBJIHRvIG1lIDotUyBJdCB3aWxsIHJlcXVpcmUgY2FsbGVy
cyB0byBhbHdheXMNCj4gY2FsbCBwaHlfZ2V0X2F0dHJzKCkgZmlyc3QsIG1vZGlmeSB0aGUgYXR0
cmlidXRlcyB0aGV5IHdhbnQgdG8gc2V0LCBhbmQgdGhlbiBjYWxsDQo+IHBoeV9zZXRfYXR0cnMo
KS4gTm90IG9ubHkgd2lsbCBiZSBjb3B5IHRoZSB3aG9sZSBwaHlfYXR0cnMgc3RydWN0dXJlDQo+
IG5lZWRsZXNzbHksIGl0IHdpbGwgYWxzbyBub3QgYmUgYW4gYXRvbWljIG9wZXJhdGlvbiBhcyBz
b21lb25lIGVsc2UgY291bGQNCj4gbW9kaWZ5IGF0dHJpYnV0ZXMgYmV0d2VlbiB0aGUgZ2V0IGFu
ZCBzZXQgY2FsbHMuDQo+IFRoZSBsYWNrIG9mIGF0b21pY2l0eSBtYXkgbm90IGJlIGFuIGlzc3Vl
IGluIHByYWN0aWNlIGlmIHRoZXJlJ3MgYSBzaW5nbGUgdXNlciBvZg0KPiB0aGUgUEhZIGF0IGFs
bCB0aW1lcywgYnV0IGluIHRoYXQgY2FzZSBubyBtdXRleCBpcyBuZWVkZWQuDQo+IA0KPiBJIHRo
aW5rIHRoaXMgc2VyaWVzIHRyaWVzIHRvIGZpeCBhIHByb2JsZW0gdGhhdCBkb2Vzbid0IGV4aXN0
Lg0KDQpUaGFua3MgTGF1cmVudCBmb3IgeW91ciBjb21tZW50cy4NCg0KSGkgS2lzaG9uLA0KDQpD
b3VsZCB5b3UgcGxlYXNlIHN1Z2dlc3Qgd2hhdCB3b3VsZCBiZSB0aGUgYmV0dGVyIGFwcHJvYWNo
IHJlZ2FyZGluZyB0aGlzIFBIWQ0KYXR0cmlidXRlcyBzZXJpZXMuIFNob3VsZCB3ZSBhZGQgaW5k
aXZpZHVhbCBnZXQvc2V0IGZ1bmN0aW9ucyBmb3IgbmV3IGF0dHJpYnV0ZQ0KbWF4X2xpbmtfcmF0
ZSBqdXN0IGxpa2UgbW9kZSBhbmQgYnVzX3dpZHRoLCBvciBzaG91bGQgd2UgdXNlIHBoeV9nZXRf
YXR0cnMoKQ0KYW5kIHBoeV9zZXRfYXR0cnMoKSBmdW5jdGlvbnMgcmVtb3ZpbmcgbXV0ZXguICBZ
b3VyIHN1Z2dlc3Rpb25zIHdvdWxkIHJlYWxseSBoZWxwLg0KDQpUaGFua3MgJiByZWdhcmRzLA0K
U3dhcG5pbA0KDQo+IA0KPiA+ID4gPiAgCQl9IGVsc2Ugew0KPiA+ID4gPiAgCQkJZGV2X2Vycihk
ZXYsICJEcml2ZXIgc3VwcG9ydHMgb25seQ0KPiBQSFlfVFlQRV9EUFxuIik7DQo+ID4gPiA+ICAJ
CQlyZXQgPSAtRU5PVFNVUFA7DQo+IA0KPiAtLQ0KPiBSZWdhcmRzLA0KPiANCj4gTGF1cmVudCBQ
aW5jaGFydA0K
