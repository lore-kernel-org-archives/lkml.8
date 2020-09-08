Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89AE7C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:25:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A83A20738
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="V43siraG";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="SlInk8QU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731778AbgIHRZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:25:35 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:60070 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731735AbgIHQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:17:01 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 088EDhSd018505;
        Tue, 8 Sep 2020 07:15:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=proofpoint;
 bh=zq6IJp1chqPXNQso0m0Iaq8PoUvLabSrcB0GNY4gb3M=;
 b=V43siraGpT1giLgRrjxpOCQGMC+tEOleY9cMM3y0+9/d6hSAFMJKF8GU5N2sDMdTDrcQ
 93yvOU69IlkEI+1LZ6QqWpWFKl5ftZxrCPBjv2fqMLxyTCrjWx3nZlexxECfSnv08l1J
 9n3JUEP3mXqeQw3aPdITZbM8k0xw5kGz/cldLBeYw9CugUG9HgepVAtlJ5f6djjaZn9U
 5m9Ylsx2kFykrf6TZDmwJg6Ot5kU56VVi832M73KQzXCB4XXqkqXUrJxfNcbVytaXzqd
 xb+Ktgli6QDzehTtQCzIV9OKxgkK1FEDdih2V4u118iDyu2xLi97aq0VWRYuDTz9UG3Q QQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33c68whs4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Sep 2020 07:15:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UjpYSvCf1RQ+NDdtmR1XM7LYV+1vxp0riZGgww4Zs6APu2LjyvaDRpFn13qp1vds24ByXw29P1Ldtr/yv/ulYFhNXuDrZusb2hNqwP3MM9/nHA/7lz+EVNQzmo5I2tFMGzTu83a715V1FQZ1hSbr2LuBmHHbGnblA71GMNvkGhtjWFkS9HiGFYoJDSLFcLm3nLTfgcU+Ebmubv/rIT4+WK5x4/5qpsssxLiWeTfWGDP9K+5OZZkxwrdrZH5Pg/0GIJj1n/3D8Nw1yIBEDjmUfSnTm1kx7ZxZGA8isq2RDA856VjZhqJ6EbA5xEPr67nxqs7sHmTrPnxZPaxPdoTk4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq6IJp1chqPXNQso0m0Iaq8PoUvLabSrcB0GNY4gb3M=;
 b=iUSY5CBqEsoRi3T+q5ZylFT/QYZoToJh030ZVpS+jXwUnBbe8hSadkVyBXm6DiZndkxBlu3s7gFTD/naNpgombCQpt8Iek4mBN/XvFTA1YDvJZe5UesQYiY7Q44Y+h+FF1Cs1hoahg2Y0Faf2zoWPR215DJSPxAb24jH82uDq2cD/9Z9bHn/O409CNuaEg5O5cS/aeCCCQ2pAC32sHO67RkdA4j6u8A1mu8x5jc1j5em+vOLzReHL2oiN+NZKdshzJDHwl+YIQBGIKRo3EJqYs0qLzhEnmgVRpX7rBWf/F/OKE/Kh2XAC8wIlFyOy0zmKsZB+jWbYW+9I0LP4d95jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq6IJp1chqPXNQso0m0Iaq8PoUvLabSrcB0GNY4gb3M=;
 b=SlInk8QUgp+ADqz48nkxA3nIcV2Ay7Kh1DojhyHeXq/QBUkn2Jqp5n5EBlVclyGOyh3PinAMDGLa5vEYXgorw+U3yuiFTQordctCGaBGDgKJJa7MSrjJOcrPF3rVKaVTuYKvNI/qlY0bj8GqN6+TD4vW5YpqzLzuqekaZNvaQjM=
Received: from DM6PR07MB5531.namprd07.prod.outlook.com (2603:10b6:5:76::15) by
 DM5PR0701MB3655.namprd07.prod.outlook.com (2603:10b6:4:76::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Tue, 8 Sep 2020 14:15:52 +0000
Received: from DM6PR07MB5531.namprd07.prod.outlook.com
 ([fe80::c451:7f79:5f49:d9f2]) by DM6PR07MB5531.namprd07.prod.outlook.com
 ([fe80::c451:7f79:5f49:d9f2%4]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 14:15:52 +0000
From:   Milind Parab <mparab@cadence.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maxime@cerno.tech" <maxime@cerno.tech>,
        Yuti Suresh Amonkar <yamonkar@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "tomi.valkeinen@ti.com" <tomi.valkeinen@ti.com>,
        "jsarha@ti.com" <jsarha@ti.com>,
        "praneeth@ti.com" <praneeth@ti.com>
Subject: RE: [PATCH v5 2/2] phy: cadence-torrent: Use kernel PHY API to set
 PHY attributes
Thread-Topic: [PATCH v5 2/2] phy: cadence-torrent: Use kernel PHY API to set
 PHY attributes
Thread-Index: AQHWekRj5YsNfufc2UCQ3GhxFz8KCqlUi9QAgABvmYCAAFYPAIABfJmAgAAIkACAAELzgIAHxI8w
Date:   Tue, 8 Sep 2020 14:15:52 +0000
Message-ID: <DM6PR07MB55314937E004DCB2BCF9BEB8D3290@DM6PR07MB5531.namprd07.prod.outlook.com>
References: <1598293711-23362-1-git-send-email-sjakhade@cadence.com>
 <1598293711-23362-3-git-send-email-sjakhade@cadence.com>
 <20200902002956.GE14351@pendragon.ideasonboard.com>
 <DM6PR07MB6154CC4A67BC3568A7339CC9C52F0@DM6PR07MB6154.namprd07.prod.outlook.com>
 <20200902121722.GA16811@pendragon.ideasonboard.com>
 <DM6PR07MB6154F54322C38E6D864C7797C52C0@DM6PR07MB6154.namprd07.prod.outlook.com>
 <b7903295-6482-53a5-2f08-3da17ced0c87@ti.com>
 <20200903152951.GE6492@pendragon.ideasonboard.com>
In-Reply-To: <20200903152951.GE6492@pendragon.ideasonboard.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=none action=none
 header.from=cadence.com;
x-originating-ip: [14.142.6.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 606f7e2e-3eae-4f7d-6a3a-08d85401b186
x-ms-traffictypediagnostic: DM5PR0701MB3655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR0701MB3655AA8A2E6CF5EB9FD2E908D3290@DM5PR0701MB3655.namprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OaDLNnot2tCYtab/ZiPN8gkeM59mUgirKMaQquR6CqYZe0bRntKJUfp3Ith904W3hP+yRPa3B9juYc+n84rBol9v1vlu0qcgdkokiQncrws4bdwAzJFX6B/vprFyZ7NKY1xu3US2R7z6MSoly9NyM2HvCjp5x4Y8Uwd73iJOE1WeT4AweT4J44H73sWTqnCgzJOFt1o9zgXsIIANpN4YsLsbmEZDEHeTUERmRlNltzHT/Ja9K16zf5rtZLojBomtRakXa3yVttgNjWmQjSMPe4W7goCX3TAPIEpktVnoGgikP83KpftMhPdVnuQMsXF681T4CFqlQwk7bofPGA18BUxN0hnVxP8+n6vuCTaGNLy1onNkWPz3r07MukZy8TyTxzp+M1cTJSqQoWDe80RgH3Oca3kaU3gXrjD9a4C9cTXQY0NcnzQ/wqbJTs4XV2e+aeWdwcDChN5YyBkw3rpig/QtuIV5Nvd7NOV79QAUlrg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR07MB5531.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(36092001)(66476007)(66556008)(110136005)(83380400001)(54906003)(71200400001)(53546011)(6506007)(7696005)(4326008)(966005)(55236004)(316002)(2906002)(52536014)(9686003)(33656002)(76116006)(66946007)(478600001)(64756008)(55016002)(66446008)(8936002)(5660300002)(86362001)(8676002)(26005)(186003)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fmxzwWjRqCOCeWCntSF+uKQuYXGGtLZgq8bg2XQIWsvAp67JqcdXkkx4CrvYaWhGviSeqFyBq5DQUunVp2OlW/4xp4RxTdrEisodyX8g6N1lk9nSYsYSK0muIBsymy+OsxAeIjgpxA16l6CLQr3nhPZ8Uq8l5rOF2e6QLQW7w+SOYKi16t3Cd4x1TKnieKQVCenFLzlROOAiNgmhaDhUNBT5L0lshK9dyXKUT4KqoF4xFNjOs60T9+finiVTgwl2W1AcdU9YPxafeyIZiK2EHDE7MuR9BWlXNK8SRn18b8vB4FHYoeq6gcIFvmR/kDRb38Oz5RiokuAsCwcZiVjgxX0m5Sb0CezjkfFKI6Or1u7Ng8Esawn+ep/rZeuIsEGAGXtevhWLn5KjR2RkZNW3VnvY3LN1YW2HhTmfAgAjsqNa34xQ6eCrFllKonCQrV5mrryoPdfiNWzEPyCCJ8NGOCxgksXhYeOohFeuVyyyw1bzOmYG9c+03Jl7RQq1YPaFTiCUfyK41h2dgj2omwP5+QzLJTdBtNJvxRRaVIrlOBDW64hHSUAvORt5tyZxRoev3gW8blHWNDL6eXtiLaenSP7ctDSCxi/kzi8nPKtpmOKj0lkC8Hz0dbxWxV3SXWvj1+++m9MOSitufxm/2eaY8Q==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR07MB5531.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 606f7e2e-3eae-4f7d-6a3a-08d85401b186
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 14:15:52.1192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dNVpb0vAiw7CBs8ODLwP1AKNfUHwuBP2M2cPK3ZhadIJ5L/KCYmT2tnLK5rILpfGLSSwlEfoSPLDr8ptSNxKk/hVmKZMVnbj4NA8qsuB6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0701MB3655
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-08_07:2020-09-08,2020-09-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1011
 phishscore=0 mlxlogscore=999 mlxscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009080136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS2lzaG9uLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBMYXVyZW50
IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+DQo+U2VudDogVGh1
cnNkYXksIFNlcHRlbWJlciAzLCAyMDIwIDk6MDAgUE0NCj5UbzogS2lzaG9uIFZpamF5IEFicmFo
YW0gSSA8a2lzaG9uQHRpLmNvbT4NCj5DYzogU3dhcG5pbCBLYXNoaW5hdGggSmFraGFkZSA8c2ph
a2hhZGVAY2FkZW5jZS5jb20+OyB2a291bEBrZXJuZWwub3JnOw0KPmxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IG1heGltZUBjZXJuby50ZWNoOyBNaWxpbmQgUGFyYWINCj48bXBhcmFiQGNh
ZGVuY2UuY29tPjsgWXV0aSBTdXJlc2ggQW1vbmthciA8eWFtb25rYXJAY2FkZW5jZS5jb20+Ow0K
Pm5zZWtoYXJAdGkuY29tOyB0b21pLnZhbGtlaW5lbkB0aS5jb207IGpzYXJoYUB0aS5jb207IHBy
YW5lZXRoQHRpLmNvbQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMi8yXSBwaHk6IGNhZGVuY2Ut
dG9ycmVudDogVXNlIGtlcm5lbCBQSFkgQVBJIHRvIHNldA0KPlBIWSBhdHRyaWJ1dGVzDQo+DQo+
RVhURVJOQUwgTUFJTA0KPg0KPg0KPkhpIEtpc2hvbiwNCj4NCj5PbiBUaHUsIFNlcCAwMywgMjAy
MCBhdCAwNTowMDoxNFBNICswNTMwLCBLaXNob24gVmlqYXkgQWJyYWhhbSBJIHdyb3RlOg0KPj4g
T24gOS8zLzIwMjAgNDoyOSBQTSwgU3dhcG5pbCBLYXNoaW5hdGggSmFraGFkZSB3cm90ZToNCj4+
ID4gT24gV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMiwgMjAyMCA1OjQ3IFBNLCBMYXVyZW50IFBpbmNo
YXJ0IHdyb3RlOg0KPj4gPj4gT24gV2VkLCBTZXAgMDIsIDIwMjAgYXQgMDc6MDk6MjFBTSArMDAw
MCwgU3dhcG5pbCBLYXNoaW5hdGggSmFraGFkZQ0KPndyb3RlOg0KPj4gPj4+IE9uIFdlZG5lc2Rh
eSwgU2VwdGVtYmVyIDIsIDIwMjAgNjowMCBBTSBMYXVyZW50IFBpbmNoYXJ0IHdyb3RlOg0KPj4g
Pj4+PiBPbiBNb24sIEF1ZyAyNCwgMjAyMCBhdCAwODoyODozMVBNICswMjAwLCBTd2FwbmlsIEph
a2hhZGUgd3JvdGU6DQo+PiA+Pj4+PiBVc2UgZ2VuZXJpYyBQSFkgZnJhbWV3b3JrIGZ1bmN0aW9u
IHBoeV9zZXRfYXR0cnMoKSB0byBzZXQgbnVtYmVyDQo+PiA+Pj4+PiBvZiBsYW5lcyBhbmQgbWF4
aW11bSBsaW5rIHJhdGUgc3VwcG9ydGVkIGJ5IFBIWS4NCj4+ID4+Pj4+DQo+PiA+Pj4+PiBTaWdu
ZWQtb2ZmLWJ5OiBTd2FwbmlsIEpha2hhZGUgPHNqYWtoYWRlQGNhZGVuY2UuY29tPg0KPj4gPj4+
Pj4gQWNrZWQtYnk6IEtpc2hvbiBWaWpheSBBYnJhaGFtIEkgPGtpc2hvbkB0aS5jb20+DQo+PiA+
Pj4+PiAtLS0NCj4+ID4+Pj4+ICBkcml2ZXJzL3BoeS9jYWRlbmNlL3BoeS1jYWRlbmNlLXRvcnJl
bnQuYyB8IDcgKysrKysrKw0KPj4gPj4+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMo
KykNCj4+ID4+Pj4+DQo+PiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvY2FkZW5jZS9w
aHktY2FkZW5jZS10b3JyZW50LmMNCj4+ID4+Pj4+IGIvZHJpdmVycy9waHkvY2FkZW5jZS9waHkt
Y2FkZW5jZS10b3JyZW50LmMNCj4+ID4+Pj4+IGluZGV4IDcxMTYxMjczNThlZS4uZWNhNzE0Njdj
NGE4IDEwMDY0NA0KPj4gPj4+Pj4gLS0tIGEvZHJpdmVycy9waHkvY2FkZW5jZS9waHktY2FkZW5j
ZS10b3JyZW50LmMNCj4+ID4+Pj4+ICsrKyBiL2RyaXZlcnMvcGh5L2NhZGVuY2UvcGh5LWNhZGVu
Y2UtdG9ycmVudC5jDQo+PiA+Pj4+PiBAQCAtMTcxMCw2ICsxNzEwLDcgQEAgc3RhdGljIGludCBj
ZG5zX3RvcnJlbnRfcGh5X3Byb2JlKHN0cnVjdA0KPnBsYXRmb3JtX2RldmljZSAqcGRldikNCj4+
ID4+Pj4+ICAJc3RydWN0IGNkbnNfdG9ycmVudF9waHkgKmNkbnNfcGh5Ow0KPj4gPj4+Pj4gIAlz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPj4gPj4+Pj4gIAlzdHJ1Y3QgcGh5X3By
b3ZpZGVyICpwaHlfcHJvdmlkZXI7DQo+PiA+Pj4+PiArCXN0cnVjdCBwaHlfYXR0cnMgdG9ycmVu
dF9hdHRyOw0KPj4gPj4+Pj4gIAljb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkICptYXRjaDsNCj4+
ID4+Pj4+ICAJc3RydWN0IGNkbnNfdG9ycmVudF9kYXRhICpkYXRhOw0KPj4gPj4+Pj4gIAlzdHJ1
Y3QgZGV2aWNlX25vZGUgKmNoaWxkOw0KPj4gPj4+Pj4gQEAgLTE4NTIsNiArMTg1MywxMiBAQCBz
dGF0aWMgaW50IGNkbnNfdG9ycmVudF9waHlfcHJvYmUoc3RydWN0DQo+cGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQ0KPj4gPj4+Pj4gIAkJCQkgY2Ruc19waHktPnBoeXNbbm9kZV0ubnVtX2xhbmVzLA0K
Pj4gPj4+Pj4gIAkJCQkgY2Ruc19waHktPm1heF9iaXRfcmF0ZSAvIDEwMDAsDQo+PiA+Pj4+PiAg
CQkJCSBjZG5zX3BoeS0+bWF4X2JpdF9yYXRlICUgMTAwMCk7DQo+PiA+Pj4+PiArDQo+PiA+Pj4+
PiArCQkJdG9ycmVudF9hdHRyLmJ1c193aWR0aCA9IGNkbnNfcGh5LQ0KPj5waHlzW25vZGVdLm51
bV9sYW5lczsNCj4+ID4+Pj4+ICsJCQl0b3JyZW50X2F0dHIubWF4X2xpbmtfcmF0ZSA9IGNkbnNf
cGh5LQ0KPj5tYXhfYml0X3JhdGU7DQo+PiA+Pj4+PiArCQkJdG9ycmVudF9hdHRyLm1vZGUgPSBQ
SFlfTU9ERV9EUDsNCj4+ID4+Pj4+ICsNCj4+ID4+Pj4+ICsJCQlwaHlfc2V0X2F0dHJzKGdwaHks
ICZ0b3JyZW50X2F0dHIpOw0KPj4gPj4+Pg0KPj4gPj4+PiBXaHkgaXMgdGhpcyBiZXR0ZXIgdGhh
biBhY2Nlc3NpbmcgdGhlIGF0dHJpYnV0ZXMgbWFudWFsbHkgYXMgZm9sbG93cyA/DQo+PiA+Pj4+
DQo+PiA+Pj4+IAkJCWdwaHktPmF0dHJzLmJ1c193aWR0aCA9IGNkbnNfcGh5LQ0KPj5waHlzW25v
ZGVdLm51bV9sYW5lczsNCj4+ID4+Pj4gCQkJZ3BoeS0+YXR0cnMubWF4X2xpbmtfcmF0ZSA9IGNk
bnNfcGh5LQ0KPj5tYXhfYml0X3JhdGU7DQo+PiA+Pj4+IAkJCWdwaHktPmF0dHJzLm1vZGUgPSBQ
SFlfTU9ERV9EUDsNCj4+ID4+Pj4NCj4+ID4+Pj4gVGhpcyBpcyBjYWxsZWQgaW4gY2Ruc190b3Jy
ZW50X3BoeV9wcm9iZSgpLCBiZWZvcmUgdGhlIFBIWQ0KPj4gPj4+PiBwcm92aWRlciBpcyByZWdp
c3RlcmVkLCBzbyBub3RoaW5nIGNhbiBhY2Nlc3MgdGhlIFBIWSB5ZXQuIFdoYXQNCj4+ID4+Pj4g
cmFjZSBjb25kaXRpb24gYXJlIHlvdSB0cnlpbmcgdG8gcHJvdGVjdCBhZ2FpbnN0IHdpdGggdXNh
Z2Ugb2YNCj5waHlfc2V0X2F0dHJzKCkgPw0KPj4gPj4+DQo+PiA+Pj4gSSBhZ3JlZSB0aGF0IGZv
ciBDYWRlbmNlIERQIGJyaWRnZSBkcml2ZXIgYW5kIFRvcnJlbnQgUEhZIGRyaXZlcg0KPj4gPj4+
IHVzZSBjYXNlLCBpdCB3b3VsZCBub3QgbWF0dGVyIGV2ZW4gaWYgd2Ugc2V0IHRoZSBhdHRyaWJ1
dGVzIGluDQo+PiA+Pj4gVG9ycmVudCBQSFkgZHJpdmVyIGluIGEgd2F5IHlvdSBzdWdnZXN0ZWQg
YWJvdmUuDQo+PiA+Pj4gQnV0IGFzIHBlciB0aGUgZGlzY3Vzc2lvbiBpbiBbMV0sIHBoeV9zZXRf
YXR0cnMvcGh5X2dldF9hdHRycyBBUElzDQo+PiA+Pj4gaW4gZnV0dXJlIGNvdWxkIG1heWJlIHVz
ZWQgYnkgb3RoZXIgZHJpdmVycyByZXBsYWNpbmcgZXhpc3RpbmcNCj4+ID4+PiBpbmRpdmlkdWFs
IGZ1bmN0aW9ucyBmb3IgYXR0cmlidXRlcyBidXNfd2lkdGggYW5kIG1vZGUgd2hpY2ggYXJlDQo+
PiA+Pj4gcGh5X3NldF9idXNfd2lkdGgvcGh5X2dldF9idXNfd2lkdGggYW5kDQo+cGh5X3NldF9t
b2RlL3BoeV9nZXRfbW9kZS4NCj4+ID4+PiBTbyB0aGlzIHVzYWdlIGluIFRvcnJlbnQgUEhZIGRy
aXZlciBpcyBhbiBleGFtcGxlIGltcGxlbWVudGF0aW9uIG9mIHRoZQ0KPkFQSS4NCj4+ID4+Pg0K
Pj4gPj4+IFsxXQ0KPj4gPj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczovL2xr
bWwub3JnL2xrbWwvMjAyMC81LzE4LzQ3Ml9fOw0KPj4gPj4+ICEhRUgNCj4+ID4+PiBzY21TMXln
aVUxbEEhUUtUVEk3QlMxUjM1YV96b01mSnNZNEE0eUN0RUtyUU50aUFYVHlJWi0NCj5TWUlFRWli
WWRwQk0NCj4+ID4+PiBKVGxsDQo+PiA+Pj4gWXJkLTAwJA0KPj4gPj4NCj4+ID4+IFRoaXMgZG9l
c24ndCBzZWVtIGEgdmVyeSBnb29kIEFQSSB0byBtZSA6LVMgSXQgd2lsbCByZXF1aXJlIGNhbGxl
cnMNCj4+ID4+IHRvIGFsd2F5cyBjYWxsIHBoeV9nZXRfYXR0cnMoKSBmaXJzdCwgbW9kaWZ5IHRo
ZSBhdHRyaWJ1dGVzIHRoZXkNCj4+ID4+IHdhbnQgdG8gc2V0LCBhbmQgdGhlbiBjYWxsIHBoeV9z
ZXRfYXR0cnMoKS4gTm90IG9ubHkgd2lsbCBiZSBjb3B5DQo+PiA+PiB0aGUgd2hvbGUgcGh5X2F0
dHJzIHN0cnVjdHVyZSBuZWVkbGVzc2x5LCBpdCB3aWxsIGFsc28gbm90IGJlIGFuDQo+PiA+PiBh
dG9taWMgb3BlcmF0aW9uIGFzIHNvbWVvbmUgZWxzZSBjb3VsZCBtb2RpZnkgYXR0cmlidXRlcyBi
ZXR3ZWVuIHRoZQ0KPmdldCBhbmQgc2V0IGNhbGxzLg0KPj4gPj4gVGhlIGxhY2sgb2YgYXRvbWlj
aXR5IG1heSBub3QgYmUgYW4gaXNzdWUgaW4gcHJhY3RpY2UgaWYgdGhlcmUncyBhDQo+PiA+PiBz
aW5nbGUgdXNlciBvZiB0aGUgUEhZIGF0IGFsbCB0aW1lcywgYnV0IGluIHRoYXQgY2FzZSBubyBt
dXRleCBpcyBuZWVkZWQuDQo+Pg0KPj4gV2hhdCBpZiB0aGUgY29uc3VtZXIgdHJpZXMgdG8gc2V0
IGFuIGF0dHJpYnV0ZSBhdCB0aGUgbWlkZGxlIG9mIGENCj4+IHBoeV9wb3dlcl9vbigpIG9wZXJh
dGlvbj8gVGhhdCBpcyBzdGlsbCBhIHZhbGlkIG9wZXJhdGlvbiBhbmQgcGh5IGNvcmUNCj4+IGxh
eWVyIHNob3VsZCB0cnkgdG8gcHJldmVudCBpdCBubz8NCj4NCj5JIHNlZSBtdWx0aXBsZSBxdWVz
dGlvbnMgaGVyZS4NCj4NCj5GaXJzdCBvZiBhbGwsIHVubGVzcyBJJ20gbWlzdGFrZW4sIHRoZSBh
dHRyaWJ1dGVzIHNldCBoZXJlIGFyZSBzdGF0aWMgcHJvcGVydGllcywNCj5zZXQgYnkgdGhlIFBI
WSBkcml2ZXIgYXQgcHJvYmUgdGltZSwgYW5kIG9ubHkgcmVhZCBieSBQSFkgY29uc3VtZXJzLiBU
aGVyZQ0KPnNob3VsZCBiZSBubyBuZWVkIGZvciBhbnkga2luZCBvZiBwcm90ZWN0aW9uIG9yIHNw
ZWNpYWwgQVBJIHRvIGFjY2VzcyB0aGVtLg0KPg0KPlRoZW4sIHRoZXJlJ3MgdGhlIHF1ZXN0aW9u
IG9mIGhvdyB0byBoYW5kbGUgZHluYW1pYyBhdHRyaWJ1dGVzLiBJbiB0aGVvcnkgYQ0KPmR5bmFt
aWMgYXR0cmlidXRlIGNvdWxkIGJlIGNoYW5nZWQgYXQgYW55IHRpbWUsIGFuZCB0aHVzIHJhY2Ug
d2l0LCBmb3INCj5pbnN0YW5jZSBwaHlfcG93ZXJfb24oKS4gSG93ZXZlciwgdGhlIHByb3Bvc2Vk
IEFQSSB3b24ndCBoZWxwIG11Y2gNCj5hZGRyZXNzIHRoaXMgaXNzdWUuIFVzaW5nIGEgbXV0ZXgg
d2lsbCBpbmRlZWQgZW5zdXJlIHRoYXQgdGhlIGF0dHJpYnV0ZSBjaGFuZ2UNCj53aWxsIGJlIHNl
cmlhbGl6ZWQgd2l0aCBvdGhlciBvcGVyYXRpb25zLCBidXQgaXQgd29uJ3QgZ2l2ZSBhbnkgZ3Vh
cmFudGVlIHRvIHRoZQ0KPlBIWSBjb25zdW1lciBvbiB3aGV0aGVyIHRoZSBhdHRyaWJ1dGUgd2ls
bCBiZSBzZXQgYmVmb3JlIG9yIGFmdGVyDQo+cGh5X3Bvd2VyX29uKCkgaXMgcHJvY2Vzc2VkLiBU
aGUgY29uc3VtZXIgd2lsbCBub3Qga25vdyBpZiB0aGUgbmV3IHZhbHVlDQo+b2YgdGhlIGF0dHJp
YnV0ZSBoYXMgYmVlbiB0YWtlbiBpbnRvIGFjY291bnQuDQo+DQo+VGhlIHF1ZXN0aW9uIGlzIHRo
dXMgd2hldGhlciB3ZSB3YW50IHRvIG1ha2UgdGhlIFBIWSBjb25zdW1lciBBUEkgdGhyZWFkLQ0K
PnNhZmUgKG5vdGUgdGhhdCBkdWUgdG8gdGhlIHVzYWdlIG9mIGEgbXV0ZXgsIHdlIGRvbid0IHN1
cHBvcnQgY2FsbGluZyBtb3N0IG9mDQo+dGhlIEFQSSBmdW5jdGlvbnMgZnJvbSBhbiBpbnRlcnJ1
cHQgaGFuZGxlciwgc28gaXQgcmVhbGx5IHJlcXVpcmVzIHRoZSBjb25zdW1lcg0KPnRvIHVzZSBh
IHdvcmsgcXVldWUsIGEgdGhyZWFkLCBvciBwb3NzaWJseSBhIHRocmVhZGVkIGludGVycnVwdCku
IElmIHRoZSBhbnN3ZXINCj5pcyB5ZXMsIHRoZSBBUEkgc2hvdWxkIGRlZmluZSB3aGF0IHVzZSBj
YXNlcyBhcmUgdmFsaWQsIGFuZCBob3cgdGhlIFBIWSBoYXMgdG8NCj5iZWhhdmUuIFRoaXMgaW5j
bHVkZXMgZG9jdW1lbnRpbmcgd2hlbiBuZXcgYXR0cmlidXRlIHZhbHVlcyBjYW4gYmUgc2V0LCBh
bmQNCj53aGVuIHRoZXkgYXJlIHRha2VuIGludG8gYWNjb3VudC4gSWYgd2UgaGFkIHRvIGRvY3Vt
ZW50IHRoaXMgYXMgcGFydCBvZiB0aGlzDQo+cGF0Y2ggc2VyaWVzLCB3ZSB3b3VsZCBoYXZlIHRv
IHN0YXRlIHRoYXQgdGhlIG5ldyB2YWx1ZXMgYXJlIHRha2VuIGludG8NCj5hY2NvdW50IGF0IGFu
IHVuZGVmaW5lZCBwb2ludCBvZiB0aW1lIGlmIHRoZSBhdHRyaWJ1dGUgc2V0IGNhbGwgaXMgY29u
Y3VycmVudA0KPndpdGggb3RoZXIgQVBJIGNhbGxzLCB3aGljaCBtYWtlcyB0aGUgQVBJIGlsbC1k
ZWZpbmVkIGluIG15IG9waW5pb24uIEkgZXhwZWN0DQo+dGhhdCB3ZSB3b3VsZCBuZWVkIHRvIHR1
cm4gYXR0cmlidXRlIHNldHRpbmcgaW50byBhIGNhbGxiYWNrIHRvIHRoZSBQSFkgZHJpdmVyDQo+
aW4gdGhhdCBjYXNlLCBvciBhdCBsZWFzdCBtYWtlIGl0IGEgbW9yZSBjb21wbGV4IG9wZXJhdGlv
biBoYW5kbGVkIGJ5IHRoZSBQSFkNCj5jb3JlIHRoYXQgd291bGQgdXNlIHRoZSBleGlzdGluZyBQ
SFkgb3BzIHRvIHJlY29uZmlndXJlIHRoZSBQSFkuDQo+DQo+SXMgaXQgd29ydGggaXQgYWxsb3dp
bmcgZHJpdmVycyB0byBjYWxsIHRoZSBQSFkgQVBJIGZyb20gZGlmZmVyZW50IHRocmVhZHMgYXMN
Cj5vcHBvc2VkIHRvIHJlcXVpcmluZyBjb25zdW1lcnMgdG8gc2VyaWFsaXplIGNhbGxzIGlmIHRo
ZWlyIHVzZSBjYXNlcyByZXF1aXJlIHNvID8NCj5JIHdvdWxkIGV4cGVjdCBtb3N0IGNvbnN1bWVy
cyB0byBvbmx5IHRyeSB0byByZWNvbmZpZ3VyZSBhIFBIWSB3aGVuIGl0J3MNCj5zdG9wcGVkLCBv
ciB0byBtYW51YWxseSBzdG9wLCByZWNvbmZpZ3VyZSBhbmQgcmVzdGFydCB0aGUgUEhZLg0KPg0K
Pj4gPj4gSSB0aGluayB0aGlzIHNlcmllcyB0cmllcyB0byBmaXggYSBwcm9ibGVtIHRoYXQgZG9l
c24ndCBleGlzdC4NCj4+ID4NCj4+ID4gVGhhbmtzIExhdXJlbnQgZm9yIHlvdXIgY29tbWVudHMu
DQo+PiA+DQo+PiA+IEhpIEtpc2hvbiwNCj4+ID4NCj4+ID4gQ291bGQgeW91IHBsZWFzZSBzdWdn
ZXN0IHdoYXQgd291bGQgYmUgdGhlIGJldHRlciBhcHByb2FjaCByZWdhcmRpbmcNCj4+ID4gdGhp
cyBQSFkgYXR0cmlidXRlcyBzZXJpZXMuIFNob3VsZCB3ZSBhZGQgaW5kaXZpZHVhbCBnZXQvc2V0
DQo+PiA+IGZ1bmN0aW9ucyBmb3IgbmV3IGF0dHJpYnV0ZSBtYXhfbGlua19yYXRlIGp1c3QgbGlr
ZSBtb2RlIGFuZA0KPj4gPiBidXNfd2lkdGgsIG9yIHNob3VsZCB3ZSB1c2UgcGh5X2dldF9hdHRy
cygpIGFuZCBwaHlfc2V0X2F0dHJzKCkNCj5mdW5jdGlvbnMgcmVtb3ZpbmcgbXV0ZXguICBZb3Vy
IHN1Z2dlc3Rpb25zIHdvdWxkIHJlYWxseSBoZWxwLg0KPj4NCj4+IEkgdGhpbmsgTGF1cmVudCdz
IHBvaW50IGlzIG5vdCBoYXZpbmcgYW4gQVBJIGF0IGFsbCBmb3IgY29uZmlndXJpbmcNCj4+IGF0
dHJpYnV0ZXMgYW5kIGFjY2VzcyB0aGVtIG1hbnVhbGx5Pw0KPg0KPklmIHRoZSBhbnN3ZXIgdG8g
dGhlIGFib3ZlIHF1ZXN0aW9uIGlzIHRoYXQgYSB0aHJlYWQtc2FmZSBBUEkgaXNuJ3Qgd29ydGgg
aXQgYXMNCj53ZSB3b3VsZG4ndCBoYXZlIGdvb2QgdXNlIGNhc2VzIGZvciBpdCwgdGhlbiBJIHRo
aW5rIGFjY2Vzc2luZyB0aGUgYXR0cmlidXRlcw0KPm1hbnVhbGx5IGlzIGFsbCB3ZSBuZWVkLg0K
Pg0KDQpTaG91bGQgd2UgcHJvY2VlZCBhY2Nlc3NpbmcgYXR0cmlidXRlIG1hbnVhbGx5DQoNCj4+
ID4+Pj4+ICAJCX0gZWxzZSB7DQo+PiA+Pj4+PiAgCQkJZGV2X2VycihkZXYsICJEcml2ZXIgc3Vw
cG9ydHMgb25seQ0KPlBIWV9UWVBFX0RQXG4iKTsNCj4+ID4+Pj4+ICAJCQlyZXQgPSAtRU5PVFNV
UFA7DQo+DQo+LS0NCj5SZWdhcmRzLA0KPg0KPkxhdXJlbnQgUGluY2hhcnQNCg==
