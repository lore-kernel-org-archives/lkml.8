Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF507C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2ED206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="K1yHIoly";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="gI2joURC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgF2TMd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:12:33 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:33140 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730698AbgF2TMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1593457949; x=1624993949;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GnVIoudxxpPUAy/Qggd3q7WYEmNb7juB0T+9hb4bZfg=;
  b=K1yHIoly2V4d1IXVIbfHB8ELosBbkhs81WyRWhtvky0MS5PJNVRsuT42
   HpEIG442wgfuxSLeAI5zBNGeU9VXzf0irWYAl5DjsM12L50ncvQuw+ylu
   fnq+NJiQIYETZene48OQPdpwzhuufJNYRMM91EB4yOWxV9tFPa40Umhmi
   SXqGaFSsQ2hZBGlc+4vYApWydExlGYwGnvIZ5Iqzex2r72ZWj6eN83Ijm
   0lhRON9Y4jNGCXUiZel8YfQ4gpFCIxWPuJmUr5keyhWsotbEQr+L8xgR6
   rxV2cHME98g97L3T7U3VSAR7D1bzbqwPq3mVDHypDoGklSyAaEL+/biLi
   w==;
IronPort-SDR: 5/uzyBTK3q7CPhrquWh9tBV+vuFV6W1Ut+U1TlzHQtmaSFwc4VK8xIdlPmrtfwHtF/RCuhJ8Fk
 xjmLSzzbbvnXG46Jb2o9FRKQ6Em8worEhSdEl7j+01YvjSDUbClQ+IIR6Z0cDFbUMBQw8LISFQ
 eQhbpLUypdBuBnrPot8O8reqSV+UdKmSnBR0m0k2wOM7jV5HYb6svzTBkCx3Wr9GnqMXsgS44X
 FMozOce1Kij282XIOVk2Zz69/oP3EC2rGfd6EogOb9m0h4O3L8zjp4p6lCga8rLe5QbedagHea
 fHI=
X-IronPort-AV: E=Sophos;i="5.75,294,1589266800"; 
   d="scan'208";a="81218094"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2020 05:50:14 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 29 Jun 2020 05:50:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Mon, 29 Jun 2020 05:50:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=knaCBreFspZkMWfcSsdhM0+zUFPa+64jFROECdRuDQy7Wrm94HMqTEl26Db3ot5v0clvyl6psgQHEVowZF+eH8w0mLJWvltIQp9v5p3Qdy53kF2zhbYwEwjFbKrbJc57MlWL3T0f37G9dPBgdN1YiDMGlGxGt1KnUCYp4bjQgGZyYytToi4pLNCGT30KfeIgh4211/tUqDjW1kkGFtYz9+1KofpVG8RpBR7ZV5+wElNBrkXANIrMFQibjkbekRtcQuoJTiQ8lWb6qBcQvmmpgqDNwULTbAnnjKkOtuu4tCC0OHENZn83x/nkNrs9jHMZEhxrO1TaFEYdDnL57ghPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnVIoudxxpPUAy/Qggd3q7WYEmNb7juB0T+9hb4bZfg=;
 b=XlcnbQEhs/iqIvg6d4lmvtgkAPjp0GV+uIAppLKrWr+o2AkVFCUoLRrJALo8p/rMZTQPI0JUagc6qXOOgfxzspMYMIx3ImRI9fBIA+/dv+JkUDmijBAOGRHbBJrw7tU9NNTUO5hPYhcAXjsY43S7jHz15fBlo5tb0gfW1cyBnYl+KavwVz6QkgzaZWIFTy21XcgEjuKD8U4eVFHPEFaMkGsIiv/T/umHwC9zhzuVDlFMC1blrjfrPM/Lcffnx7ahGS4lNSlUsR1iSd4x8zk6KmwEaD+5lFONuAAe2wP+50x1Zu99Wt1WaXIOEH3EpANj5FnoB3mbdebRhXkHaVnNhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GnVIoudxxpPUAy/Qggd3q7WYEmNb7juB0T+9hb4bZfg=;
 b=gI2joURCAVI5ilk9BydaN/sUY1aJmcqJJTI0KoZfHUkkNTXJknAX7hJKTp11U8dS9gpxYTzsI+IuLkFSJfmY50P8kYRE9KvP//dd3w2r6gsmGbe0FLZ+CQDfHKwsQpelqW5GxlfNFu/y9UklfP3lU4i52zlB4M+6/x1rIkYpEYY=
Received: from BYAPR11MB2856.namprd11.prod.outlook.com (2603:10b6:a02:bd::11)
 by BYAPR11MB3333.namprd11.prod.outlook.com (2603:10b6:a03:19::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Mon, 29 Jun
 2020 12:50:11 +0000
Received: from BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3]) by BYAPR11MB2856.namprd11.prod.outlook.com
 ([fe80::f1d5:60ca:d163:c1b3%3]) with mapi id 15.20.3131.027; Mon, 29 Jun 2020
 12:50:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <thesven73@gmail.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] mtd: spi-nor: Add support for Winbond w25q64jv spi
 flash
Thread-Topic: [PATCH v1] mtd: spi-nor: Add support for Winbond w25q64jv spi
 flash
Thread-Index: AQHWThPSolCxrzN8IU2HXo+YK1EHpg==
Date:   Mon, 29 Jun 2020 12:50:11 +0000
Message-ID: <4b0f2a2d-66be-4cdd-8384-a80f6b729d74@microchip.com>
References: <20200613235331.24678-1-TheSven73@gmail.com>
In-Reply-To: <20200613235331.24678-1-TheSven73@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [86.127.52.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baf87540-f74c-467d-3f96-08d81c2af5f4
x-ms-traffictypediagnostic: BYAPR11MB3333:
x-microsoft-antispam-prvs: <BYAPR11MB33333FF21A72D7CAC083A177F06E0@BYAPR11MB3333.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 044968D9E1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S88ckQ9j26WOaT9YGOTg3C6jYH35+/Zl615LZZpKrWTQXcBby2P+8sYQPmAbnNIogLb7yBJCMOIzY1kspbrhDqIDORqH5lUC/F28obtbk8D6Ldq6KbxFsdXSgUm8omz+s3CrJU5myUav/LNGXVH26WpVaKt/lYVa/R5TC7e3D2BgP1WSKD7IzsupLXaL6i7jdcc5FLx0xblX7cN0FCl0JT8W8WqHbQA2a8tlfZl4NhROsgazKXMrSUxWtLYSWn2LP7q6QZNZkErOZOkuQ0YW5Mf4dsP4adM5c9/x2Da5sfGGXAWZaOxhcGgK7P9yAiRhSYQFBNm1DeOBZ3HbD/QjVJ45eKZ9gnJPuX7eW8NYaPU+s1gYwFvsVe3v/BSG6eyrqLLu7U7wbZ8+wg2a8X+02r67sKc0CLs9j/ZHcbUT8dpWu54+zXPYw6qYYK0tpK1xvwgbtuOOFFsSjP28SZiFxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2856.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(396003)(366004)(346002)(136003)(39860400002)(5660300002)(8936002)(26005)(53546011)(91956017)(6506007)(31696002)(2906002)(76116006)(4326008)(6486002)(66946007)(64756008)(66446008)(66476007)(66556008)(54906003)(71200400001)(31686004)(83380400001)(2616005)(966005)(6512007)(86362001)(8676002)(316002)(110136005)(478600001)(36756003)(186003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 4ohRnFnYRNbffe5NN2DQxWJecNtJ1tfqG3b6f+6QRlcv+1+a+PDBdQCZgjbzKe5+zfh7Gf7VrGlD41xgj/ZQhGGKVPXzMF9q+5QUwzYEAVXsRve1285g8jn4/UeXml0HJM7b3eUOiY+51MpW3GtMDGtUeYKuqrdALukznTEMEYSypyjzd/M79/+qsWeHD3NXvjM3o5hgkroDqk4vXe18a2eyr7jsJPN4CpXRwVirjGHfwfrcMFnn20Xp6mIdmblweGqSg9CVDoKBLHH2wvnlZHfesrZyS47W++ZNL6n6NlWUUHMJDfzm48WzJNGqidzx1p7TanCAoJhijUgAbdmkyPQRbXb7G929A0q5GWO0cMG+QFAbYpVz3Ahw5td7QKKqFpePhhSef/mku0t0kBw3+57AvuvZTWBgel3vRzf2tezVBoMwPU8jZ+SHuQ1dQngbLTHY+ILIdwjBPLpU93890z0srM5nk9IsrGZ0SmdHXX4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1766E21CF4042D488B1214C520A4B3B4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2856.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf87540-f74c-467d-3f96-08d81c2af5f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2020 12:50:11.0915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHCMXnVUfwWpkYM1+LtKZpmkDzqUOu40hurXgJFHN2a5H3U0GqEQj4ynirU11d5QhowzEldydu0n0/tPqkE1dQHRvVH9pz3WzfZjv+lGoGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3333
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFN2ZW4sDQoNCk9uIDYvMTQvMjAgMjo1MyBBTSwgU3ZlbiBWYW4gQXNicm9lY2sgd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gVGhpcyBjaGlwIGlz
IChuZWFybHkpIGlkZW50aWNhbCB0byB0aGUgV2luYm9uZCB3MjVxNjQgd2hpY2ggaXMNCj4gYWxy
ZWFkeSBzdXBwb3J0ZWQgYnkgTGludXguIENvbXBhcmVkIHRvIHRoZSB3MjVxNjQsIHRoZSAnanYn
DQo+IGRvZXMgbm90IHN1cHBvcnQgUXVhZCBTUEkgbW9kZSwgYW5kIGhhcyBhIGRpZmZlcmVudCBK
RURFQyBJRC4NCg0KSSdtIHJlYWRpbmcgdGhlIGZvbGxvd2luZyBkYXRhc2hlZXQ6DQpodHRwczov
L3d3dy53aW5ib25kLmNvbS9yZXNvdXJjZS1maWxlcy93MjVxNjRqdiUyMHJldmolMjAwMzI3MjAx
OCUyMHBsdXMucGRmDQoNCncyNXE2NGp2bSAoMHhlZjcwMTcpIGNvbWVzIHdpdGggUUUgYml0IHNl
dCB0byBhIDAgc3RhdGUsIGJ1dCBjYW4gYmUNCnNldCB0byAxLCBzbyBRdWFkIG1vZGUgY2FuIGJl
IHN1cHBvcnRlZC4gV291bGQgeW91IHBsZWFzZSBzZXQgU1BJX05PUl9EVUFMX1JFQUQNCmFuZCBT
UElfTk9SX1FVQURfUkVBRCBmbGFncyBhbmQgdGVzdCBhbmQgc2VlIGlmIFF1YWQgd29ya3M/IElm
IGFsbCBnb29kLA0KcGxlYXNlIHNwZWNpZnkgaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHdpdGggd2hp
Y2ggY29udHJvbGxlciB5b3UgZGlkIHRoZSB0ZXN0cy4NCg0KPiANCj4gVG86IFR1ZG9yIEFtYmFy
dXMgPHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCj4gVG86IE1pcXVlbCBSYXluYWwgPG1p
cXVlbC5yYXluYWxAYm9vdGxpbi5jb20+DQo+IFRvOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hh
cmRAbm9kLmF0Pg0KPiBUbzogVmlnbmVzaCBSYWdoYXZlbmRyYSA8dmlnbmVzaHJAdGkuY29tPg0K
PiBDYzogbGludXgtbXRkQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmcNCg0KQXJlIHRoZXNlIHRhZ3MgcmVhbGx5IG5lY2Vzc2FyeT8gV291bGQg
eW91IGRyb3AgdGhlbT8NCg0KPiBTaWduZWQtb2ZmLWJ5OiBTdmVuIFZhbiBBc2Jyb2VjayA8VGhl
U3ZlbjczQGdtYWlsLmNvbT4NCj4gLS0tDQo+IA0KPiBUcmVlOiBuZXh0LTIwMjAwNjEzDQo+IA0K
PiAgZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
d2luYm9uZC5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMNCj4gaW5kZXggNTA2MmFm
MTBmMTM4Li4xOGJkZmYwMmY1N2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
d2luYm9uZC5jDQo+ICsrKyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5jDQo+IEBAIC02
NSw2ICs2NSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZmxhc2hfaW5mbyB3aW5ib25kX3BhcnRz
W10gPSB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX0hBU19MT0NLIHwg
U1BJX05PUl9IQVNfVEIpIH0sDQo+ICAgICAgICAgeyAidzI1eDY0IiwgSU5GTygweGVmMzAxNywg
MCwgNjQgKiAxMDI0LCAxMjgsIFNFQ1RfNEspIH0sDQo+ICAgICAgICAgeyAidzI1cTY0IiwgSU5G
TygweGVmNDAxNywgMCwgNjQgKiAxMDI0LCAxMjgsIFNFQ1RfNEspIH0sDQo+ICsgICAgICAgeyAi
dzI1cTY0anYiLCBJTkZPKDB4ZWY3MDE3LCAwLCA2NCAqIDEwMjQsIDEyOCwgU0VDVF80SykgfSwN
Cg0KSSB3b3VsZCBuYW1lIGl0ICJ3MjVxNjRqdm0iLiBDaGVjayAiMTEuT1JERVJJTkcgSU5GT1JN
QVRJT04iLiBBbHRob3VnaCB0aGUNCmRhdGFzaGVldCByZWZlcnMgdG8gdGhlc2UgZmxhc2hlcyBh
cyAiVzI1UTY0SlYtSVEvSlEiIGFuZCAiVzI1UTY0SlYtSU0vSk0iLA0KSSBmaW5kIHRoYXQgdGhl
IHRlbXBlcmF0dXJlIHJhbmdlIGlzIG5vdCBhIGRpZmZlcmVudGlhdG9yIGluIHRoZSBmbGFzaCBJ
RCwNCnNvIEkgd291bGQgZHJvcCBpdC4NCg0KQ2hlZXJzLA0KdGENCg==
