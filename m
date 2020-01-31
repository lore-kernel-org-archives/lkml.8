Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6417AC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3053F20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 10:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kpmyHINl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgAaKmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 05:42:11 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:1747 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbgAaKmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 05:42:11 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cCZxNusCWvHyik7PobtKgvspYQRYjdK9Dew06kxUK86DR3BEdUYUy5p52hWCkAglgMC+1ZX3Ou
 8oLgXwYk3V9agtal9a9SP3maexoDYhQoamIDeB1kk2iB3IP2DMJZuv3VQT/JOCt6iS7viE2e1B
 8Dn42kQ5s1jbd/wLzZ52g5wRoBUjMQiGxryd/Ca8DYLOJmbyKq9RzPieuQeOcxrflYBOUQALhh
 9JG1dewCS1hlMQHC12hdzu3QP9yDR7noV7v/2KZfVVlR/VyYLs+UPvOba9NN9RejUy6AN543AS
 +Yk=
X-IronPort-AV: E=Sophos;i="5.70,385,1574146800"; 
   d="scan'208";a="63779480"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2020 03:42:11 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 31 Jan 2020 03:42:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 31 Jan 2020 03:42:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irnAHaR2RbfQoHtT4xLfW1GMnJ879p+yj1L/7Ao8aXkSElfUzBUZkticsw9tQe7Q2AyyXDwQUqZPdG4fByc4Z/HQ354ldMrPn03JA8QTNk1I30NB0IwBJ15mg6fgP36MVa8oJOeIweGTvnc5IhRszEHWBR4ck7BDLpoFBplRvUmFDHl/jmW8orFQ/g8HZikIA+KlZxj1kVwEXFEr7qb0kd3/rQsJYFvtMbfAB9/tFBo+FiJqECeg17l6Q8gWjVF/CSIvd9QGWUQZvYJgw6Uc3Gcp5wdIvcm1fj3qXC68j/HmK7L24w2U2nBw2Rf9zd0oZKl1LGah3vO2KouVCiOlvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaGXC2X9lxY07hM5v8cUn7WHVgzgDy9au2r77LMllUI=;
 b=Mt/UOvcJ5c/qbgRMIWkGvht64YK/YJ4nL0y+r7DybwtKdOtUDRb+MCo3brOSRPBYMk+PQdK4G30dR4aHovGIhCej2zqU+BWT0gzY+EYonVLYVUkLAST6W8dUxMy4wbPB9K7uvl7wJHd68FvXRL5GxsO3dzlDaAvYaGx+i046PSM+HPqoNPOlYXeONO78OnXVJ22aW7CVmlrSSbKDxpzZaaglrPIhQRWPA/6e2Qcpfdnw5LdsAbkmjfbVIez6fU91hG8zLQUAqpKnQe1nwo4mwz028ADfPvV/TW0y3VqDFtkN4xVvd8vjcGmoq45wIR6mdtn2IOzawF+g37sXzuk9ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KaGXC2X9lxY07hM5v8cUn7WHVgzgDy9au2r77LMllUI=;
 b=kpmyHINl0Ix1du9wgCOlTirc+3Z4gnKRqw2z8SVI1HSlvpbXdLWghth4lo2kEQpHy9mZDJYId60mIFMHeEZI8kQ6nD8Tq4KC+gv/Y4yMcRl03U6uWVlYJcMyKFgFWdoP3EUrypWKXAv/EBad+BA90RdlCIytFyqC3in4qjq1fss=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (20.176.120.224) by
 DM6PR11MB3995.namprd11.prod.outlook.com (10.255.61.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Fri, 31 Jan 2020 10:42:06 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a%7]) with mapi id 15.20.2686.028; Fri, 31 Jan 2020
 10:42:06 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Codrin.Ciubotariu@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <sboyd@kernel.org>,
        <Ludovic.Desroches@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: Re: [PATCH] clk: at91: sam9x60: Don't use audio PLL
Thread-Topic: [PATCH] clk: at91: sam9x60: Don't use audio PLL
Thread-Index: AQHV2CMUTS9+vTc4bU+e0LC8TLKFlA==
Date:   Fri, 31 Jan 2020 10:42:06 +0000
Message-ID: <72d97d68-690b-7f18-0dca-a5aa131e1c29@microchip.com>
References: <20200130174708.12448-1-codrin.ciubotariu@microchip.com>
In-Reply-To: <20200130174708.12448-1-codrin.ciubotariu@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81b3ab8f-1ed0-4d9a-e06c-08d7a63a377f
x-ms-traffictypediagnostic: DM6PR11MB3995:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3995700FDF7AC95EBE975DCE87070@DM6PR11MB3995.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;SFS:(10001)(10009020)(366004)(189003)(199004)(966005)(5660300002)(53546011)(66476007)(66556008)(26005)(107886003)(76116006)(66946007)(2616005)(186003)(66446008)(64756008)(6506007)(91956017)(36756003)(498600001)(86362001)(71200400001)(31686004)(4326008)(2906002)(6486002)(54906003)(31696002)(6512007)(8936002)(8676002)(110136005)(81166006)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB3995;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m1yaoiMbVYDcnKlO0N5tUZfPPIh9pRf4C3xkpIuYMf4l8MXlsvq6NjVtNngReZvnJdxgkisn/DEDTLmzM8IuGYuw3ZxE+cWpUxvCxHsTT9onWYK4FlAXl5MNEJzfAZOfyNGNh9JyCS+w+Kb1V2oEi/a5wFubDWZX1h98c4Mu5mtLAxyEhds3xX0EnRKBMJ4CbQY0txT4AGot+1LZqKtzcesaFa7bDKNNE3baWJqQM8DDUnW9gATbezkeNy6DYl84Ob9av677cIl5sVVel3waXnrdnSah0TVNFgF0GB3fLU3ElDs3pHF4wPJuXGwh6hEvi31ppQRTkp0SnOo4R+ekKhvUyH8WfjUkezbepdodt/PK+ZlvSQebkex0q4cLDy2aZDPOTw3ub85umGB2kFf19Q5ztvQa6ykE/J3Vs0DA1GwKhNFe9NnBdCAFr9Pf5ZnKXcjnX/iRbnoxAD8NNr5ycpj7xPd/AD+N8RtoOON4eXsxh3DCmuiyGLxBNc2b14a1IqovswseD39b3O6BYYcuKaweY3WBlnyJbGzDy8cZaBnnwjJPh52uevZnihgAojDRy46cH769Go+esSkOoEGth4uryocBf5hw9fMxgBj5HAhVO9rEWpzAKNRLU1B59ajqDoteCMSEb6hIvrgTvnHqVtTB1gFgLtyumo5KmSlJb637Xq45HkiJya+afKoGx+St7Yyjy23uvMVv3Sxc1bajePN/l3qCzgoJaHfDUa1+WDI=
x-ms-exchange-antispam-messagedata: VY8x0AQnzVvLf3HHwbRibd+la7xm9Ch3yFM0oJcgRMFuy4/0nZqzhcEYInVIZ/n0furTKy0SYu4E8FPItODBJ0hUsNJXg5mv5q3GEQk+vhQaMhQ7hGC+SziO7jHA0RfPqAnsowGuniL1C/5bhw6V3w==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8DCE96E21A9E4943A93D07954D23D9C5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 81b3ab8f-1ed0-4d9a-e06c-08d7a63a377f
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 10:42:06.4186
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fajoQ4Ad2PPdMqxBtap6egqLWltMRxqVNSCenjfBCwvt+XQo5fJf+8dnB9FV9u4RgK1//sTBu52gAGrQP8sW/3XR7hd7GlBXbXfbSVlBlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3995
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ29kcmluLA0KDQpPbiAzMC4wMS4yMDIwIDE5OjQ3LCBDb2RyaW4gQ2l1Ym90YXJpdSB3cm90
ZToNCj4gT24gc2FtOXg2MCwgdGhlcmUgaXMgbm90IGF1ZGlvIFBMTCBhbmQgc28gSTJTIGFuZCBj
bGFzc0QgaGF2ZSB0byB1c2Ugb25lDQo+IG9mIHRoZSBiZXN0IG1hdGNoaW5nIHBhcmVudHMgZm9y
IHRoZWlyIGdlbmVyYXRlZCBjbG9jay4NCj4gDQo+IEZpeGVzOiAwMWUyMTEzZGU5YTUgKCJjbGs6
IGF0OTE6IGFkZCBzYW05eDYwIHBtYyBkcml2ZXIiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBDb2RyaW4g
Q2l1Ym90YXJpdSA8Y29kcmluLmNpdWJvdGFyaXVAbWljcm9jaGlwLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL2Nsay9hdDkxL3NhbTl4NjAuYyB8IDYgKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2xrL2F0OTEvc2FtOXg2MC5jIGIvZHJpdmVycy9jbGsvYXQ5MS9zYW05eDYwLmMNCj4gaW5k
ZXggNzczOThhZWZlYjZkLi4wYWViNDRmZWQ5ZGUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xr
L2F0OTEvc2FtOXg2MC5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvc2FtOXg2MC5jDQo+IEBA
IC0xNDQsMTEgKzE0NCw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgew0KPiAgICAgICAgIHsgLm4g
PSAic2RtbWMxX2djbGsiLCAuaWQgPSAyNiwgLnIgPSB7IC5taW4gPSAwLCAubWF4ID0gMTA1MDAw
MDAwIH0sIH0sDQo+ICAgICAgICAgeyAubiA9ICJmbGV4MTFfZ2NsayIsIC5pZCA9IDMyLCB9LA0K
PiAgICAgICAgIHsgLm4gPSAiZmxleDEyX2djbGsiLCAuaWQgPSAzMywgfSwNCj4gLSAgICAgICB7
IC5uID0gImkyc19nY2xrIiwgICAgLmlkID0gMzQsIC5yID0geyAubWluID0gMCwgLm1heCA9IDEw
NTAwMDAwMCB9LA0KPiAtICAgICAgICAgICAgICAgLnBsbCA9IHRydWUsIH0sDQo+ICsgICAgICAg
eyAubiA9ICJpMnNfZ2NsayIsICAgIC5pZCA9IDM0LCAuciA9IHsgLm1pbiA9IDAsIC5tYXggPSAx
MDUwMDAwMDAgfSwgfSwNCj4gICAgICAgICB7IC5uID0gInBpdDY0Yl9nY2xrIiwgLmlkID0gMzcs
IH0sDQo+IC0gICAgICAgeyAubiA9ICJjbGFzc2RfZ2NsayIsIC5pZCA9IDQyLCAuciA9IHsgLm1p
biA9IDAsIC5tYXggPSAxMDAwMDAwMDAgfSwNCj4gLSAgICAgICAgICAgICAgIC5wbGwgPSB0cnVl
LCB9LA0KPiArICAgICAgIHsgLm4gPSAiY2xhc3NkX2djbGsiLCAuaWQgPSA0MiwgLnIgPSB7IC5t
aW4gPSAwLCAubWF4ID0gMTAwMDAwMDAwIH0sIH0sDQo+ICAgICAgICAgeyAubiA9ICJ0Y2IxX2dj
bGsiLCAgIC5pZCA9IDQ1LCB9LA0KPiAgICAgICAgIHsgLm4gPSAiZGJndV9nY2xrIiwgICAuaWQg
PSA0NywgfSwNCj4gIH07DQoNClBsZWFzZSByZW1vdmUgYWxzbyB0aGUgcGxsIG1lbWJlciBvZjoN
Cg0Kc3RhdGljIGNvbnN0IHN0cnVjdCB7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgY2hhciAqbjsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAg
ICAgIHU4IGlkOyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIA0KICAgICAgICBzdHJ1Y3QgY2xrX3JhbmdlIHI7ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgYm9v
bCBwbGw7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgDQp9ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgDQoNCj4gLS0NCj4gMi4yMC4xDQo+IA0KPiANCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0K
PiA=
