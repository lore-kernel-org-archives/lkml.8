Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B715EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9078E2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2SiiPOFX";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="qVnMjZgh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgFRHnt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:43:49 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:9631 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgFRHns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:43:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592466228; x=1624002228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6zBcD/OMQsQAIqopT8RwD1CDsifKqFwdPPPlulh9Q98=;
  b=2SiiPOFXQck9WHpQXo8uuFGl2oK9d7gn427Hg5h9NEhrAqp+bmVQ1GQl
   9SzxNHmSYCbyLSD0vdv6PaWy3N+Q8vgFndwOGNDaGfhtfRgCPXyWKEp44
   ckbTGT/M/Hz8kDzxECsS0+AAhS+/ggpogyA0AAE2K5KLHFxGgGEbc1dTj
   DJWO2cheV69ohVQwU8uHGzmOhwy1ZLdPq8X6XxSN0qdLrs9ylu/0Ed3IB
   ZhO1AwfRf/XIMPhxlQznRLB27TkvfndT3noKOlVgs2MxkAIgR7njelrUz
   i/Nw9KJSywHasfGqhXBS8joU2XrPVJTwD8CrTS2IL/25h8O+zhtrJT5Wb
   Q==;
IronPort-SDR: vr3tecl/zb4toRvmLA8fHEgrgi+0cxVUSA9nAMtaY2ht9Y1h730OQ1dT7LmADJTBJpQO23Bb47
 2PptiQOVFEHPgZuuSxVZTe14WrVeIJCmqTLTZkdlsdBPxBHKm40bjlp1ZFbgcF4PhuONG8uZH/
 yLA1OJpmddakYUjJbj2BeitpBQXrpxUxQcZFiTX2sBkWuR6LB3M47v6nvVAcn4sHvnDA4vMQZe
 TOocZ6PQxp1znBtGfWJJJe2+AkhfIePEukcXtekK2l/SjM8pLFbyAz0n/xEnVc4gxsxZn+53YI
 CIo=
X-IronPort-AV: E=Sophos;i="5.73,525,1583218800"; 
   d="scan'208";a="80592316"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Jun 2020 00:43:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 18 Jun 2020 00:43:44 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Thu, 18 Jun 2020 00:43:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GKaW0MklgpRKKCws6UA4ZrNxfpaoawKQwaSEhvvVU1XZ/sToWN4MJDX4b7TZwbihrTyEKQaGwJdQOya9SLXLOPhDVQOawreaWOp5+cdnifZlPenVG7A9DjBbuHvd/opuqP5h+UA/k4E6qavGd+SBaHhNBiu+A2RZM2SI+0g9crvMFlFJ7kioGxxbpG5u0mbd99Sko1UGBXqoa9f6jF5y5KOu4zOQHmpSdCtpGv8U5AGQQl/ldFb/TiiPcJtkKVLXCehk4adkf5/6GtvTREs3tFjrpAj69BBSZTqTtUHW7fwkxp9j8rnepEnajDRNVZKVw5jdQObg48X0UCmD1fFDYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zBcD/OMQsQAIqopT8RwD1CDsifKqFwdPPPlulh9Q98=;
 b=a/HD9o8dAgk4bSvjeAETiygH88wNDuEmoeNLFdfMgiiKJja0kqfy//Ho+qZgay6z/NRj7IbOX2fwPS3HGpKW+q6CAlDLCsYsloPl8ldAMncJ+t6DqrHMN4woqmLYa6BFWvxRJuZqK+9dD08ptwVyWoXMIA62D7v6/I5/rc/jH29BUQ3S0SyYrlnhTWuWB8nWgQ+Dn6m+JotGEmI8fK9AOts0DSyO73U6EhYDm/0W1j8q6L/wXQI83ncOkUcIKp4UbsQEOeAEy5dfVg9nWp7yz6/HnAbTxUcc26QDVKy+4tX3bGOWfvgDTCbgaWSLuSmmV7YwWbJDPLQNAaHBhsj5UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zBcD/OMQsQAIqopT8RwD1CDsifKqFwdPPPlulh9Q98=;
 b=qVnMjZghl4OCPXnFiMj5/OFhvVW7IWfIQMCZkqvqSCK+pkbsyzGtwztM7DxWpqQIvpqQM9Tzd5zERSCyWXdXPGw4+8gjXx8DVLhhuHdX1ynxOQ7NBLyP79sBeX/aq4x/xzYCh5QOvDjQADIktc0AfD3zkkDoMQ5rCwdXMIWTKZA=
Received: from SN6PR11MB3504.namprd11.prod.outlook.com (2603:10b6:805:d0::17)
 by SN6PR11MB2766.namprd11.prod.outlook.com (2603:10b6:805:53::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.24; Thu, 18 Jun
 2020 07:43:41 +0000
Received: from SN6PR11MB3504.namprd11.prod.outlook.com
 ([fe80::40f4:d52a:5ca3:d94a]) by SN6PR11MB3504.namprd11.prod.outlook.com
 ([fe80::40f4:d52a:5ca3:d94a%2]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 07:43:41 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <Claudiu.Beznea@microchip.com>
Subject: Re: [PATCH 3/3] Revert "ARM: at91/dt: sama5d2 Xplained: add pdmic
 node"
Thread-Topic: [PATCH 3/3] Revert "ARM: at91/dt: sama5d2 Xplained: add pdmic
 node"
Thread-Index: AQHWQvsltRwqmvwlWECdTj/YRpFtOKjdWD0AgACqK4A=
Date:   Thu, 18 Jun 2020 07:43:41 +0000
Message-ID: <92a22b2e-f710-c8fd-04a7-68a09d71e570@microchip.com>
References: <20200615095525.43414-1-codrin.ciubotariu@microchip.com>
 <20200615095525.43414-3-codrin.ciubotariu@microchip.com>
 <20200617213438.GF3675@piout.net>
In-Reply-To: <20200617213438.GF3675@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [84.232.220.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 368296ec-ac2f-4b13-c72f-08d8135b525d
x-ms-traffictypediagnostic: SN6PR11MB2766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB276686267C4C6038B650DD5BE79B0@SN6PR11MB2766.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:404;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ArqDseejJ3Tak1g5A8PsBdbXmXdYXveYc4lahoAkTeFEC6+IW1f+8BTGbUG+Qbmosl/x3yJlcEGmgxhIqeKUwNayWE4cWbHiNcj1J0BXM1RCFXCesfcDKsU9aKDaKukBEcuKbUFShYFKSAdlyF+MaKlZr7Uke/vfaNbLO+6ftUMlx3O3nWcnCmtqcDQ314t/38tlcYeyn4xHmSPklQHL6+ULZrHOrzZgx0HuLchz5x2QOHqGK7e2gv8XR643vJBhJ9MGOFhuLq4Y5t9Ukv2+BL1MZ5FPp61xxr7/grICX1aW0PKzaMhP3c0gkOEuZxXaHpHOpr7CqKGYDR9DwGIS77M0XWmAXkR07hBP5U0rPIdF4noJt2lCrJF7tpPlcKbXlEjNmfAm81TSjlJuaQVPDSQuB92/1UokEMmKjnXOQIv4mpP4njhNYJqfLuF0bi9fCUYM7L57dSGZ3hyqhfc83w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3504.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(376002)(39860400002)(346002)(66446008)(6506007)(53546011)(6916009)(6486002)(107886003)(31686004)(83380400001)(66946007)(76116006)(2906002)(8676002)(8936002)(66476007)(966005)(71200400001)(26005)(5660300002)(66556008)(31696002)(64756008)(6512007)(186003)(86362001)(316002)(478600001)(2616005)(4326008)(91956017)(36756003)(54906003)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: fyp0v9Dq62Ui/3FuNamqn9NmaKW7kMEYZM5RHQCNZ4wF+nI8Qmr7tY+jiHRxfkJUjugwGSqXSiZB218NHyQ6GGDLHQnxWFpfEbsJNEt/NMPr7oCkQrxmzMAAP1DEzreNsa+aoTutUzr1YATCLFLtYd9Kn76F8OR9c7YOHjE423vd/GcgTNWI1aTNAwhujjDwkwc23Fgo8Scb79Dir5YlIe/ijnWEDJhUVofV4/wxnQhheZvI5b6p/lAQ2O/6sZKtAT98dbngIbCWcZAAqLnLW7hZkTL8bd3RZpun7yNvVE2ehjqhkTOd8OUl7ugvUtR1iT7JNSW3mIEmYR54MWJCnBUTaXPDz8r2YiNocyIoBdO6cvgwTGKs7ZRjoeaHBNv70ZuIt74d36iM90a0HNzJABANWHikKOuZsuJIG184/oXRgzA9R/ZjrWbR7e4cUFl2RftpoSwrwfzRHy03p7V/COz/sLFgCuIgzv2UIRmItvvc7iIrKdSeUvegbbRytYj1
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A1B5FC81242C346B047C581D02D9457@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 368296ec-ac2f-4b13-c72f-08d8135b525d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 07:43:41.6357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jNMnjIYVzkjtdWS8zZ4gYbtKKoLwIFN7JorZoXzan0SoX8ZN+12jMa1k7ZDtPVcvWq7nltto1Tc1/PshBSkCz2CdHR+Cwqt8zGzZlkTwdnw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTguMDYuMjAyMCAwMDozNCwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IEhpLA0KPiAN
Cj4gVGhlIGNvcnJlY3Qgc3ViamVjdCBsaW5lIHByZWZpeCBpcyAiQVJNOiBkdHM6IGF0OTE6Ig0K
DQpJIGp1c3QgcmV2ZXJ0ZWQgdGhlIG9yaWdpbmFsIHBhdGNoLiBJIGNhbiBtYWtlIGl0IGEgbm9y
bWFsIGNvbW1pdCBpZiB5b3UgDQp3YW50Lg0KDQo+IA0KPiBPbiAxNS8wNi8yMDIwIDEyOjU1OjI1
KzAzMDAsIENvZHJpbiBDaXVib3Rhcml1IHdyb3RlOg0KPj4gVGhlcmUgYXJlIG5vIFBETSBtaWNy
b3Bob25lcyBvbiBTQU1BNUQyIFhwbGFpbmVkLCB0byBleGVyY2l6ZSB0aGUNCj4+IFBETUlDLg0K
Pj4NCj4+IFRoaXMgcmV2ZXJ0cyBjb21taXQgY2E2MzQ5YThjNTFmMmUzZDZmMmFjZGIzNjQzMWU3
ZDczMjgyNjFmNy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDb2RyaW4gQ2l1Ym90YXJpdSA8Y29k
cmluLmNpdWJvdGFyaXVAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL2FybS9ib290
L2R0cy9hdDkxLXNhbWE1ZDJfeHBsYWluZWQuZHRzIHwgMTYgLS0tLS0tLS0tLS0tLS0tLQ0KPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMTYgZGVsZXRpb25zKC0pDQo+Pg0KPiANCj4gVGhpcyBwYXRjaCBk
b2Vzbid0IGFwcGx5IGFuZCBJIHRoaW5rIHlvdSdsbCBoYXZlIHRvIG1vdGl2YXRlIHRoZSByZW1v
dmFsDQo+IGEgYml0IG1vcmUgYmVjYXVzZSB0aGlzIHNlZW1zIGxpa2UgYSBjaGFuZ2Ugb2YgcG9s
aWN5IHRvIG1lLg0KDQpUaGUgUERNSUMgbmVlZHMgUERNIG1pY3JvcGhvbmVzIHRvIHdvcmsuIHNh
bWE1ZDIgeHBsYWluZWQgZG9lc24ndCBoYXZlIA0Kc3VjaCBtaWNyb3Bob25lcywgc28gdGhlcmUg
aXMgbm8gcmVhc29uIHRvIGVuYWJsZSBQRE1JQyBhbmQgdGFrZSBzb21lIA0KcGlucyBzaW5jZSB0
aGVyZSBpcyBuby1vbmUgdXNpbmcgdGhlbS4gSXNuJ3QgaXQgdGhlIHBvbGljeSB0byBlbmFibGUg
DQpvbmx5IHdoYXQgaXMgcHJlc2VudCBvbiBhIGJvYXJkPw0KDQo+IA0KPj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkMl94cGxhaW5lZC5kdHMgYi9hcmNoL2FybS9i
b290L2R0cy9hdDkxLXNhbWE1ZDJfeHBsYWluZWQuZHRzDQo+PiBpbmRleCA1NGQ5NjY0OWRhNzcu
LmMwYTI1NWJkYTQ3NyAxMDA2NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2Ft
YTVkMl94cGxhaW5lZC5kdHMNCj4+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVk
Ml94cGxhaW5lZC5kdHMNCj4+IEBAIC0xMDksMTYgKzEwOSw2IEBAIHRpbWVyMTogdGltZXJAMSB7
DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfTsNCj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgfTsNCj4+DQo+PiAtICAgICAgICAgICAgICAgICAgICAgcGRtaWNAZjgwMTgwMDAg
ew0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZh
dWx0IjsNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBpbmN0cmwtMCA9IDwmcGlu
Y3RybF9wZG1pY19kZWZhdWx0PjsNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIGF0
bWVsLG1vZGVsID0gIlBETUlDIEAgc2FtYTVkMl94cGxhaW5lZCI7DQo+PiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBhdG1lbCxtaWMtbWluLWZyZXEgPSA8MTAwMDAwMD47DQo+PiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBhdG1lbCxtaWMtbWF4LWZyZXEgPSA8MzI0NjAwMD47
DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhdG1lbCxtaWMtb2Zmc2V0ID0gPDB4
MD47DQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+
PiAtICAgICAgICAgICAgICAgICAgICAgfTsNCj4+IC0NCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgdWFydDE6IHNlcmlhbEBmODAyMDAwMCB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfdWFydDFfZGVmYXVsdD47DQo+PiBAQCAt
NTMzLDEyICs1MjMsNiBAQCBwaW5jdHJsX21hY2IwX3BoeV9pcnE6IG1hY2IwX3BoeV9pcnEgew0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYmlhcy1kaXNhYmxlOw0K
Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+Pg0KPj4gLSAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcGluY3RybF9wZG1pY19kZWZhdWx0OiBwZG1pY19kZWZhdWx0IHsN
Cj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGlubXV4ID0gPFBJTl9Q
QjI2X19QRE1JQ19EQVQ+LA0KPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDxQSU5fUEIyN19fUERNSUNfQ0xLPjsNCj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYmlhcy1kaXNhYmxlOw0KPj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfTsNCj4+IC0NCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwaW5j
dHJsX3NkbW1jMF9kZWZhdWx0OiBzZG1tYzBfZGVmYXVsdCB7DQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBjbWRfZGF0YSB7DQo+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBpbm11eCA9IDxQSU5fUEExX19TRE1NQzBfQ01E
PiwNCj4+IC0tDQo+PiAyLjI1LjENCj4+DQo+IA0KPiAtLQ0KPiBBbGV4YW5kcmUgQmVsbG9uaSwg
Qm9vdGxpbg0KPiBFbWJlZGRlZCBMaW51eCBhbmQgS2VybmVsIGVuZ2luZWVyaW5nDQo+IGh0dHBz
Oi8vYm9vdGxpbi5jb20NCj4gDQoNCg==
