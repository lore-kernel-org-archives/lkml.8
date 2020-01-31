Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C97C33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C28320707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 11:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="kBajOvlC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgAaLvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 06:51:55 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:49379 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgAaLvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 06:51:55 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Codrin.Ciubotariu@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="Codrin.Ciubotariu@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Codrin.Ciubotariu@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Codrin.Ciubotariu@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: pCbvZI+pQxvpmKCau0MZ8eSC7D4NWUD6k91O7fmqcOBWE8RyOwCmYEdmOXf6nDB9r2+LUHezG/
 oaZd1v+9niUiiMMevdy34Z1q1Ug9drM4MAGeYEXMQMzpep2TLnLdF2/vX/rMQwAaeBrn0gmhiQ
 NobN6zKPwixVFYTe4i3x4+OJXBD43wEMQWaq5nLtGjC6z3QoeTaLBYKWWx+BxW85+m61BgnFfM
 cMb8asEQEWTyv/9CLUVc737vccMmBXhjkBUlvMJjvFzkKhSPNY4zRVD3RksL5eiwdg2hKEt5D1
 mvQ=
X-IronPort-AV: E=Sophos;i="5.70,385,1574146800"; 
   d="scan'208";a="64373245"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 31 Jan 2020 04:51:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 31 Jan 2020 04:51:53 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 04:51:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2w6GHzWquV2g/KXhEHisbMyZSjHWIaCfgE7MY0j5MWuvMNCAP6yFUO3BgwG/VTfIGnNTbGOWmlQTkhwUfpboKl7jAhJGhFZS/0S2UqBghHfy9b096RaGd8cYMwj+v2GTvllhAowkjY/wnMsyFVTzt3HilULfDNy5w3vO7pwfISD/7Eytvhis0NLkVsxN599Hu/43MbupLPLteFtE8w7t5Nhn2qWxdNMMx3m2mdjIl2szaDseRKoVe5zJolhlnoGeGNA6DUPJaZ2iy+fDF1j3fR3w7vThcHNEiX/Jm8WaanbVNmiVlvEKQieNYuoxlaWdSwdXXyqDArgk9S6X1urlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR9FK1LsKvjX2gKIcxaxFJXj4+xWoVOqu3uEO1yPI4M=;
 b=W4/MuyMnkFMs3SH08gU5Xc09YO2OCMVLNt1pYdxyVU9OCbR4JWIx3ccjQoWCpzgyigGH88PjnQj+hrsXtkI5ibBkYJxqxhqWdKnpAMo6Jk7a3S2IlJcoIoBw+WTNTD9hws9zyXc2DoP3jVeJdqJO+acGITKn2uGXzFFZissfqVxhabIizoCFPwJ16uak0G6NDypsBk9mpRaRR1wwXVEUQePD6wIHUs2BVyHq7hmMqfzj9rmVdqF6DSC2GdhxG/sjYbFIoWGr9DWBGVEzzOKxk+u+pArvEOdNof1+xhj+E0KqR8zDYLt32iGXPeAHVDftIRH9IyIAk5CW9N5mdNYB1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KR9FK1LsKvjX2gKIcxaxFJXj4+xWoVOqu3uEO1yPI4M=;
 b=kBajOvlCib1r+ktXfpKQ/tWoU0I0bLS3XJmHuT44h4p5AS8teTlCbES0re3JW4OL2DV14TShD0eTyGrFtdT6wHPTLsW2mL44mWO/EwKBc7rIXDXhV8EagObinelRsugItLW6Me8knHiwC+Mn5BXAwmMdSuGTT4o2qThd6pvf2wQ=
Received: from BY5PR11MB4497.namprd11.prod.outlook.com (52.132.255.220) by
 BY5PR11MB4168.namprd11.prod.outlook.com (10.255.154.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Fri, 31 Jan 2020 11:51:52 +0000
Received: from BY5PR11MB4497.namprd11.prod.outlook.com
 ([fe80::6189:c32:b55b:b3fd]) by BY5PR11MB4497.namprd11.prod.outlook.com
 ([fe80::6189:c32:b55b:b3fd%5]) with mapi id 15.20.2665.027; Fri, 31 Jan 2020
 11:51:51 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <Claudiu.Beznea@microchip.com>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <alexandre.belloni@bootlin.com>, <sboyd@kernel.org>,
        <Ludovic.Desroches@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: Re: [PATCH] clk: at91: sam9x60: Don't use audio PLL
Thread-Topic: [PATCH] clk: at91: sam9x60: Don't use audio PLL
Thread-Index: AQHV15VVIDkmNUG+JUKhk0TyXrfZaKgElv4AgAATfAA=
Date:   Fri, 31 Jan 2020 11:51:51 +0000
Message-ID: <588e7513-4d24-2775-3eb7-271d18cbffaa@microchip.com>
References: <20200130174708.12448-1-codrin.ciubotariu@microchip.com>
 <72d97d68-690b-7f18-0dca-a5aa131e1c29@microchip.com>
In-Reply-To: <72d97d68-690b-7f18-0dca-a5aa131e1c29@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [188.25.143.200]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5584ae9f-952b-4220-3a5a-08d7a643f616
x-ms-traffictypediagnostic: BY5PR11MB4168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4168265A6E5E847CE6395315E7070@BY5PR11MB4168.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 029976C540
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(396003)(376002)(136003)(346002)(199004)(189003)(31696002)(2616005)(26005)(4326008)(186003)(6506007)(53546011)(107886003)(6486002)(6512007)(478600001)(86362001)(91956017)(316002)(76116006)(8936002)(5660300002)(66446008)(64756008)(66556008)(66476007)(66946007)(54906003)(110136005)(8676002)(31686004)(2906002)(71200400001)(81166006)(36756003)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4168;H:BY5PR11MB4497.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9z8nBUUzooZhESRYN/jwYVBthumQ0xnYyclLJAsax3Jj8qfvHeriJF7hYnkoqQ/GmfNF4mvsUyxh3EsztU5LHJMEQJy4tKgOFl3REyK9/csyPFNfLJKrQIz6cibeNLRIFwBEEsYLb2KCwajgzZe2X0KK2LTdmST79FcvuijUKnwtlhdKjF2F3uvuHVtBB/zT1FTxpChaZ3UzAeOx0bSoav6WVsARIm1u1sRCndhnRkg8wdItQsNC8263E8MKpkJOLnc6Zh/PWnwFShKzBt6f/q6jfdhUHjq1cBrFfEBsq5bh4G1lYr4Iun/O59BjPI7s8A+ksz+7t9cSYK/A3P3oj5YwEMB3tkkXC20wSQ5XQNzmHgMqL/haoSnS1MLUiaPbFL7qrb1O+1RqlTdh4e36MYuBA1haDCahAa0rsKGXYvnhMFFSVhzcsDlm1k5fwjpy
x-ms-exchange-antispam-messagedata: nTcswR6ADU3jAoojZAC184jE6ahmLHAF6OWS8OewFyabW7KxH8Bj1FOqoEXJjPDda+on3I4Fsgu5CqLO1wwNHxWC14wdydqVd+tSbh/YykwjPc51u54I0+NqKhDY9PsEDPRYsN+AZ6cinckr7+BOww==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C35DA20027454842AAF237A0F739C193@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5584ae9f-952b-4220-3a5a-08d7a643f616
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2020 11:51:51.6526
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sydoJ/fl2yxgUAiFMi/GoT12Ffsz2D7i98csP3Y9Kgl4B5htlNF2l50ESGA2liydlvOVTVdss2Gvwq8xUP90aAU96Th+3AjqaqZM3GM/azk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzEuMDEuMjAyMCAxMjo0MiwgQ2xhdWRpdSBCZXpuZWEgLSBNMTgwNjMgd3JvdGU6DQo+IEhp
IENvZHJpbiwNCj4gDQo+IE9uIDMwLjAxLjIwMjAgMTk6NDcsIENvZHJpbiBDaXVib3Rhcml1IHdy
b3RlOg0KPj4gT24gc2FtOXg2MCwgdGhlcmUgaXMgbm90IGF1ZGlvIFBMTCBhbmQgc28gSTJTIGFu
ZCBjbGFzc0QgaGF2ZSB0byB1c2Ugb25lDQo+PiBvZiB0aGUgYmVzdCBtYXRjaGluZyBwYXJlbnRz
IGZvciB0aGVpciBnZW5lcmF0ZWQgY2xvY2suDQo+Pg0KPj4gRml4ZXM6IDAxZTIxMTNkZTlhNSAo
ImNsazogYXQ5MTogYWRkIHNhbTl4NjAgcG1jIGRyaXZlciIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBD
b2RyaW4gQ2l1Ym90YXJpdSA8Y29kcmluLmNpdWJvdGFyaXVAbWljcm9jaGlwLmNvbT4NCj4+IC0t
LQ0KPj4gICBkcml2ZXJzL2Nsay9hdDkxL3NhbTl4NjAuYyB8IDYgKystLS0tDQo+PiAgIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL2F0OTEvc2FtOXg2MC5jIGIvZHJpdmVycy9jbGsvYXQ5MS9zYW05
eDYwLmMNCj4+IGluZGV4IDc3Mzk4YWVmZWI2ZC4uMGFlYjQ0ZmVkOWRlIDEwMDY0NA0KPj4gLS0t
IGEvZHJpdmVycy9jbGsvYXQ5MS9zYW05eDYwLmMNCj4+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEv
c2FtOXg2MC5jDQo+PiBAQCAtMTQ0LDExICsxNDQsOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHsN
Cj4+ICAgICAgICAgIHsgLm4gPSAic2RtbWMxX2djbGsiLCAuaWQgPSAyNiwgLnIgPSB7IC5taW4g
PSAwLCAubWF4ID0gMTA1MDAwMDAwIH0sIH0sDQo+PiAgICAgICAgICB7IC5uID0gImZsZXgxMV9n
Y2xrIiwgLmlkID0gMzIsIH0sDQo+PiAgICAgICAgICB7IC5uID0gImZsZXgxMl9nY2xrIiwgLmlk
ID0gMzMsIH0sDQo+PiAtICAgICAgIHsgLm4gPSAiaTJzX2djbGsiLCAgICAuaWQgPSAzNCwgLnIg
PSB7IC5taW4gPSAwLCAubWF4ID0gMTA1MDAwMDAwIH0sDQo+PiAtICAgICAgICAgICAgICAgLnBs
bCA9IHRydWUsIH0sDQo+PiArICAgICAgIHsgLm4gPSAiaTJzX2djbGsiLCAgICAuaWQgPSAzNCwg
LnIgPSB7IC5taW4gPSAwLCAubWF4ID0gMTA1MDAwMDAwIH0sIH0sDQo+PiAgICAgICAgICB7IC5u
ID0gInBpdDY0Yl9nY2xrIiwgLmlkID0gMzcsIH0sDQo+PiAtICAgICAgIHsgLm4gPSAiY2xhc3Nk
X2djbGsiLCAuaWQgPSA0MiwgLnIgPSB7IC5taW4gPSAwLCAubWF4ID0gMTAwMDAwMDAwIH0sDQo+
PiAtICAgICAgICAgICAgICAgLnBsbCA9IHRydWUsIH0sDQo+PiArICAgICAgIHsgLm4gPSAiY2xh
c3NkX2djbGsiLCAuaWQgPSA0MiwgLnIgPSB7IC5taW4gPSAwLCAubWF4ID0gMTAwMDAwMDAwIH0s
IH0sDQo+PiAgICAgICAgICB7IC5uID0gInRjYjFfZ2NsayIsICAgLmlkID0gNDUsIH0sDQo+PiAg
ICAgICAgICB7IC5uID0gImRiZ3VfZ2NsayIsICAgLmlkID0gNDcsIH0sDQo+PiAgIH07DQo+IA0K
PiBQbGVhc2UgcmVtb3ZlIGFsc28gdGhlIHBsbCBtZW1iZXIgb2Y6DQo+IA0KPiBzdGF0aWMgY29u
c3Qgc3RydWN0IHsNCj4gICAgICAgICAgY2hhciAqbjsNCj4gICAgICAgICAgdTggaWQ7DQo+ICAg
ICAgICAgIHN0cnVjdCBjbGtfcmFuZ2UgcjsNCj4gICAgICAgICAgYm9vbCBwbGw7DQo+IH0NCg0K
U3VyZSwgd2lsbCBzZW5kIHYyLg0KDQpUaGFua3MgYW5kIGJlc3QgcmVnYXJkcywNCkNvZHJpbg==
