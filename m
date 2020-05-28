Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFF4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBC82071A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="S5kLahm/";
	dkim=pass (1024-bit key) header.d=cisco.onmicrosoft.com header.i=@cisco.onmicrosoft.com header.b="uI+dJsKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404798AbgE1QCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:02:37 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:35003 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404631AbgE1QCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:02:35 -0400
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 May 2020 12:02:35 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3750; q=dns/txt; s=iport;
  t=1590681755; x=1591891355;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YLVXVHJeVzWQknm45eYlhtZE7wvfx5O6B+Qbp/X8Oaw=;
  b=S5kLahm/QB4x9X6ni3YcupeowGoQEWQRdIT8FrEc5hWMsesXcAMUZQfE
   r+e9STuJTLVpBGVG2xL5O6A3ecfbWvnRj0A+e9W2goYvfmK0eVA0e+2V2
   KclQU8ZGWnwbcbXVwULFLSMtAzEcuYHPY2YJ444Q34AjmXxM0RzRaTHm5
   4=;
IronPort-PHdr: =?us-ascii?q?9a23=3AhETS5BQpO0qpAYmBRYi2CvYqbtpsv++ubAcI9p?=
 =?us-ascii?q?oqja5Pea2//pPkeVbS/uhpkESQBdWJ9/MCgO3T4OjsWm0FtJCGtn1KMJlBTA?=
 =?us-ascii?q?QMhshemQs8SNWEBkv2IL+PDWQ6Ec1OWUUj8yS9Nk5YS9r/IVbVpy764TsbAB?=
 =?us-ascii?q?6qMw1zK6z8EZLTiMLi0ee09tXTbgxEiSD7b6l1KUC9rB7asY8dho4xJw=3D?=
 =?us-ascii?q?=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0DsBQA73s9e/40NJK1eCBwBAQEBAQE?=
 =?us-ascii?q?HAQESAQEEBAEBQIFKgVBSB4FHLywKhBuDRgONHCWYSIFCgRADVQsBAQEMAQE?=
 =?us-ascii?q?tAgQBAYREAheCBAIkOBMCAwEBCwEBBQEBAQIBBgRthVcMhXMBAQEDEhEEDQw?=
 =?us-ascii?q?BATcBDwIBCBgCAiYCAgIwFRACBAENBSKDBIJMAy0BAaR+AoE5iGF2fzODAQE?=
 =?us-ascii?q?BBYU2GIIOCRR6KoJkiWAagUE/gTgMEIJNPoQVBAENBQEIGReCfTOCLZEvPKF?=
 =?us-ascii?q?TCoJUmGMegmSJBIUMjRmQV51qAgQCBAUCDgEBBYFqImZwcBVlAYI+UBgNkEC?=
 =?us-ascii?q?DcopWdDcCBggBAQMJfIoagTUBgQ8BAQ?=
X-IronPort-AV: E=Sophos;i="5.73,445,1583193600"; 
   d="scan'208";a="516951576"
Received: from alln-core-8.cisco.com ([173.36.13.141])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 28 May 2020 15:55:24 +0000
Received: from XCH-ALN-003.cisco.com (xch-aln-003.cisco.com [173.36.7.13])
        by alln-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 04SFtNYj026556
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 28 May 2020 15:55:24 GMT
Received: from xhs-aln-001.cisco.com (173.37.135.118) by XCH-ALN-003.cisco.com
 (173.36.7.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 28 May
 2020 10:55:23 -0500
Received: from xhs-aln-003.cisco.com (173.37.135.120) by xhs-aln-001.cisco.com
 (173.37.135.118) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 28 May
 2020 10:55:23 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (173.37.151.57)
 by xhs-aln-003.cisco.com (173.37.135.120) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 28 May 2020 10:55:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QF7OsWuSA6iYGTkx2KI7u1U99N075uM/FEw9ijj/jDSYR/2XmRx9hZde609GKhZ+bJUMcJQA8biVvaSO6MHGXz2T385vbarkDeh49hcr1mWPbeVbfKhWfNZzcFvLA3qxsC9A/BTuGwh96WYHEMz9rCwDa3ViXycNv1TVRA9NeqaPkaR/IEYcEFBVW2Pb9E5WHFThVpfloHHMvj2L+u/eO931wCcQCTrVypie+3TAZm17RhNZO0WzYbBi/n7e3Cu4Z4LgKD2CInWWDsP/5xcVynJtAqcjQr4GS+waBMRo1Pv7HAeY4BE3el3Y4PvWzPDqshZPaAsPRTQldkmSbBjptg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLVXVHJeVzWQknm45eYlhtZE7wvfx5O6B+Qbp/X8Oaw=;
 b=Js/4xW2k5BSICJg4ID2mfEeFPgi/tfMHFL8EthiEhy51GWi5RG0QH8NWAy4h5l8qVbInVkwmmCCxCdSmq8GiM5xXi2k39BVGGAz9fr5Hq0+zfzoYJTUQySX/93TnUfdHPg0EDnRMaZSsMgPMSN/b3a6x06U0lp2SJqwnv6do11yM1fqN9Ew6X2M5igGlY8pta8MKaYx/yRnaDBbOdtUv8A5UuhaHtSIJYO/xumnhqyNScFZXP2bYgZrFXbB4RcXGJmBMu1zKp+O8hy/H4xQlboZxMnYo40mnEDekijRv9Ms3nIKcXhOiYaovV+pk+oQ8csoNFGwzm1/v+u4uXkjsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLVXVHJeVzWQknm45eYlhtZE7wvfx5O6B+Qbp/X8Oaw=;
 b=uI+dJsKwkAZuzLH40J3xjTdQOQvPeWN3F5jfH16INQtyiz4cb583wGQJGag/Yu2js4mw2Q3N6oVKXAxQ6+HpX3+cN+XCLRF6nst6d47eX2gehVDFZfXq6tFFm/w6uqbZVco5WoUGyZFsCKh2j1DmJHcr7U4uOFbpG7OUxBz6QN8=
Received: from BYAPR11MB3574.namprd11.prod.outlook.com (2603:10b6:a03:b1::27)
 by BYAPR11MB3526.namprd11.prod.outlook.com (2603:10b6:a03:88::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Thu, 28 May
 2020 15:55:21 +0000
Received: from BYAPR11MB3574.namprd11.prod.outlook.com
 ([fe80::352e:4256:d09:ebc0]) by BYAPR11MB3574.namprd11.prod.outlook.com
 ([fe80::352e:4256:d09:ebc0%6]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 15:55:21 +0000
From:   "Jinhua Wu (jinhwu)" <jinhwu@cisco.com>
To:     Vignesh Raghavendra <vigneshr@ti.com>,
        "Daniel Walker (danielwa)" <danielwa@cisco.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 2/2] mtd: spi-nor: intel-spi: fix forced writable option
Thread-Topic: [PATCH 2/2] mtd: spi-nor: intel-spi: fix forced writable option
Thread-Index: AQHWLT4e+9wwuj9x1UGlQ413F39RPqi9ZEIAgADYI4A=
Date:   Thu, 28 May 2020 15:55:21 +0000
Message-ID: <190F24BF-EE4C-4C40-9101-C0AE6C9CEF53@cisco.com>
References: <20200518175930.10948-2-danielwa@cisco.com>
 <73a475fa-3c26-89ab-aac6-54f9b5b15936@ti.com>
In-Reply-To: <73a475fa-3c26-89ab-aac6-54f9b5b15936@ti.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.36.20041300
authentication-results: ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [112.65.8.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 87e45d6e-6686-47f1-f4be-08d8031f86c5
x-ms-traffictypediagnostic: BYAPR11MB3526:
x-ld-processed: 5ae1af62-9505-4097-a69a-c1553ef7840e,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3526E2147BF7B2E2EE2AFFACC78E0@BYAPR11MB3526.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WGFFmX1jJiwVeSvsjB8kqgFC+I/Rg/bU3EO3h8uZwNRktbSM2qNP4ceJMEljvrvpCR5OnbkLKfM2PbONju3YI/+I4KqjkgR5cRu2ccYL/ZiZgB2bMJaTauG/sVy8zNvDCpLbpU2RjsjIon6rHCzH3qBwujGL/hqPvaH8g0N4imgDK0ZmikX2Ylda37cGi4GvzSsbIo294B/ywYBbkgEN1oR3u788dsQTMV8Y1dPx4nQyIVlDH5OHbxfbgVQQlrDi+Z3DqM37VSPYudZu+icAOyjhdeJoggbHSIAz8UqZLpSC0tetwjvyXH8ZR3jf32Wg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3574.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(396003)(39860400002)(376002)(366004)(66556008)(2616005)(316002)(110136005)(53546011)(6506007)(76116006)(8936002)(66476007)(91956017)(54906003)(66446008)(8676002)(66946007)(26005)(64756008)(2906002)(186003)(4326008)(6486002)(36756003)(71200400001)(478600001)(86362001)(33656002)(83380400001)(5660300002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: +Pa8cnV4nRmrXmsJWpjlGMN3fM3AohH+B6O73gIcbkEopFsjS70bC8vn8852T92gHdeo2wgqFflzd5Tq108g1wAP9s9LBjhWsoXmJQTjT2ciY35GrZdEHm7rppi61/3vcbRSDEWOih4rC23GFijF8Gkm0P2/8oRVCOhFrhNkY5TTMko1LY3xHl3IgDEHB0hNyaKxtrJgr6dYE4duPmNorVMKZOkxL5/r1akYaJ0krZNG8xTK0vbF5ZyPghYo0KD6kZsaYq4RSmTuqgdGtYElBP1qm29FW89B/2jKFb7Ts+kC+y9vzSHwf6yxFyoPlbNqErc4NJXdSV224b7/1NrTF91cLxiA9baie3lbP4KSe1tWDvbyd/xt/ZhlfEMoSy2HI5w6g58vfeA+YTmWthLe/m80KarVHfg+d+/jQ50voZob5pZ8ZIgUW3Dkd5Y+SYbmZrsTixiDzipPxnwkgmMgmhKGiZ1YlE2MH0BY+zoX4jU=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B668EF02BCF49A4397CFB1659A79E1CC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e45d6e-6686-47f1-f4be-08d8031f86c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 15:55:21.1495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LjOz3Cf4M5rsCPv937WgE2rf66AhyJrj57pI3youWEcqUGL/rPWvGkm0v0GVAMB80y87E39VR2uo3nnIGejTrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3526
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.36.7.13, xch-aln-003.cisco.com
X-Outbound-Node: alln-core-8.cisco.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMC81LzI4LCAxMTo0OCBQTSwgIkppbmh1YSBXdSIgPGppbmh3dUBjaXNjby5jb20+IHdy
b3RlOg0KSGkgVmlnbmVzaCwNCkJJT1MganVzdCBsb2NrZWQgZG93biBwYXJ0cyBvZiBmbGFzaCAo
c3VjaCBhcywgY29kZSByZWdpb24pLCBvdGhlcnMgYXJlIHN0aWxsIA0Kd3JpdGVhYmxlLiBPbmNl
IHRoZSBTUEkgbG9ja2VkIGRvd24saXQgY2FuJ3QgYmUgb3ZlcnJpZGUgdW5sZXNzIHBsYXRmcm9t
IHJlc2V0IA0KYW5kIHNldCBXUEQgKHdyaXRlIHByb3RlY3QgZGlzYWJsZSkgd2lsbCBmYWlsLCBz
byBpc3BpLT53cml0ZWFibGUgd2lsbCBhbHdheXMNCmJlIDAsIHRoZW4gdGhlIGRyaXZlciB3aWxs
IGFsd2F5cyBtYWtlIHRoZSB3aG9sZSBmbGFzaCByZWFkIG9ubHksIGV2ZW4gaWYgd2UNCmhhdmUg
c2V0IHRoZSBwYXJhbWV0ZXIgd3JpdGFibGUgPSAxLiANCk5vdyB0aGUgZmxhc2ggaXMgdG90YWxs
eSBub3Qgd3JpdGVhYmxlLCBqdXN0IHBhcnQgb2YgaXQgaXMgcmVhZCBvbmx5LiBXaHkgbm90ICBt
YWtpbmcNCid3cml0ZWFibGUnIHdvcmtpbmcgd2hlbiBleHBsaWNpdGx5IGVuYWJsZWQ/DQoNCj5P
biAyMDIwLzUvMjgsIDc6MDIgUE0sICJWaWduZXNoIFJhZ2hhdmVuZHJhIiA8dmlnbmVzaHJAdGku
Y29tPiB3cm90ZToNCj4gICAgT24gMTgvMDUvMjAgMTE6MjkgcG0sIERhbmllbCBXYWxrZXIgd3Jv
dGU6DQo+ICAgID4gVGhpcyBvcHRpb24gY3VycmVudGx5IGRvZXNuJ3Qgd29yayBhcyBleHBlY3Rl
ZC4gSWYgdGhlIEJJT1MgaGFzIHRoaXMNCj4gICAgPiBmbGFzaCBhcyByZWFkLW9ubHkgdGhlcmUg
aXMgbm8gd2F5IHRvIGNoYW5nZSB0aGlzIHRocnUgdGhlIGRyaXZlci4NCj4gICAgPiBUaGVyZSBp
cyBhIHBhcmFtZXRlciB3aGljaCBhbGxvd3MgdGhlIGZsYXNoIHRvIGJlY29tZSB3cml0YWJsZSB3
aXRoIHRoZQ0KPiAgICA+ICJ3cml0YWJsZSIgb3B0aW9uIHRvIHRoZSBtb2R1bGUsIGJ1dCBpdCBk
b2VzIG5vdGhpbmcgaWYgdGhlIEJJT1MgaGFzIGl0DQo+ICAgID4gc2V0IHRvIHJlYWQtb25seS4N
Cj4gICAgPiANCj4gICAgPiBJIHdvdWxkIGV4cGVjdCB0aGlzIG9wdGlvbiB3b3VsZCBtYWtlIHRo
ZSBmbGFzaCB3cml0YWJsZSByZWdhcmRsZXNzIG9mDQo+ICAgID4gdGhlIEJJT1Mgc2V0dGluZ3Mu
IFRoaXMgcGF0Y2ggY2hhbmdlcyB0aGlzIG9wdGlvbiBzbyB0aGUgQklPUyBzZXR0aW5nDQo+ICAg
ID4gZG9lc24ndCBzdG9wIHRoZSB3cml0YWJsZSBvcHRpb24gZnJvbSBlbmFibGluZyByZWFkIHdy
aXRlIG9uIHRoZSBmbGFzaC4NCj4gICAgPiANCj4NCj4gICAgSSBhbSBjb25mdXNlZCB5b3Ugc2F5
ICJJZiB0aGUgQklPUyBoYXMgdGhpcyBmbGFzaCBhcyByZWFkLW9ubHkgdGhlcmUgaXMNCj4gICAg
bm8gd2F5IHRvIGNoYW5nZSB0aGlzIHRocnUgdGhlIGRyaXZlciIsIHNvIGlzIGl0IHBvc3NpYmxl
IHRvIG92ZXJyaWRlDQo+ICAgIEJJT1Mgc2V0dGluZz8gSWYgeWVzLCB3aGVyZSBpcyB0aGUgY29k
ZSBpbiB0aGUgZHJpdmVyPw0KPg0KPiAgICBXaGF0IGhhcHBlbnMgaWYgQklPUyBpcyBzZXQgdG8g
YWxsb3cgd3JpdGVzIGJ1dCB3cml0ZWFibGUgaXMgc2V0IHRvIDA/DQo+DQo+ICAgIEFsc28gcGxl
YXNlIHNlbmQgcGF0Y2ggc2VyaWVzIGFzIHRocmVhZCAoMi8yIGluIHJlcGx5IHRvIDEvMikuIFlv
dSBjYW4NCj4gICAgdXNlIHRvb2wgbGlrZSBnaXQgc2VuZC1lbWFpbA0KPg0KPiAgICA+IE9yaWdp
bmFsIHBhdGNoIGJ5IEppbmh1YSBXdSA8amluaHd1QGNpc2NvLmNvbT4NCj4gICAgPiANCj4gICAg
PiBDYzogSmluaHVhIFd1IDxqaW5od3VAY2lzY28uY29tPg0KPiAgICA+IENjOiB4ZS1saW51eC1l
eHRlcm5hbEBjaXNjby5jb20NCj4gICAgPiBTaWduZWQtb2ZmLWJ5OiBEYW5pZWwgV2Fsa2VyIDxk
YW5pZWx3YUBjaXNjby5jb20+DQo+ICAgID4gLS0tDQo+ICAgID4gIGRyaXZlcnMvbXRkL3NwaS1u
b3IvY29udHJvbGxlcnMvaW50ZWwtc3BpLmMgfCAyICstDQo+ICAgID4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiAgICA+IA0KPiAgICA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvbnRyb2xsZXJzL2ludGVsLXNwaS5jIGIvZHJpdmVy
cy9tdGQvc3BpLW5vci9jb250cm9sbGVycy9pbnRlbC1zcGkuYw0KPiAgICA+IGluZGV4IGU1YTNk
NTFhMmU0ZC4uNjhhNTg3N2JmYzBiIDEwMDY0NA0KPiAgICA+IC0tLSBhL2RyaXZlcnMvbXRkL3Nw
aS1ub3IvY29udHJvbGxlcnMvaW50ZWwtc3BpLmMNCj4gICAgPiArKysgYi9kcml2ZXJzL210ZC9z
cGktbm9yL2NvbnRyb2xsZXJzL2ludGVsLXNwaS5jDQo+ICAgID4gQEAgLTk1NCw3ICs5NTQsNyBA
QCBzdHJ1Y3QgaW50ZWxfc3BpICppbnRlbF9zcGlfcHJvYmUoc3RydWN0IGRldmljZSAqZGV2LA0K
PiAgICA+ICAJaW50ZWxfc3BpX2ZpbGxfcGFydGl0aW9uKGlzcGksICZwYXJ0KTsNCj4gICAgPiAg
DQo+ICAgID4gIAkvKiBQcmV2ZW50IHdyaXRlcyBpZiBub3QgZXhwbGljaXRseSBlbmFibGVkICov
DQo+ICAgID4gLQlpZiAoIWlzcGktPndyaXRlYWJsZSB8fCAhd3JpdGVhYmxlKQ0KPiAgICA+ICsJ
aWYgKCFpc3BpLT53cml0ZWFibGUgJiYgIXdyaXRlYWJsZSkNCj4gICAgPiAgCQlpc3BpLT5ub3Iu
bXRkLmZsYWdzICY9IH5NVERfV1JJVEVBQkxFOw0KPiAgICA+ICANCj4gICAgPiAgCXJldCA9IG10
ZF9kZXZpY2VfcmVnaXN0ZXIoJmlzcGktPm5vci5tdGQsICZwYXJ0LCAxKTsNCj4gICAgPiAgDQoN
Cg==
