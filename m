Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58732C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3217E2071B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UklZI0FU";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="I3fIch1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgGOPjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:39:37 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:26093 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgGOPjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594827575; x=1626363575;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=bs1GCJRROT3L+eFiWB7ldF/NSw4SssN96pcj5Hl7GMM=;
  b=UklZI0FURMT4+G9xrYBYrRGOQ4GTREVxDc69Kyc2H4mVaNSOL49EaSWh
   5duOkgXIYvCZAFuDGBNJK+ydxyJbh/CiYypmYlyB3iUgeQpj4M8pFLcvD
   SghiJ8vC60c2nxazRnUeVuA85xBBRK9R23ZXzLXtozL1Sn9sDgG8vMYt+
   50JjRArcV31BKP4B+w6hOcqM2k++jduQLyECugPRGkmUMp//LSsHQDS/Z
   z/5tiXBm7qQc5pZs0Z2gsMwSeDsWhCRHoRfVqSDviOe4Ib5LVqtpfrC4j
   qGrjJ8/jDdptB/EKRT3UwDh/hNV3JZ1OAFhT9A3nMCroW+MZwFcMDFE7E
   Q==;
IronPort-SDR: JNBV6em2FEFPlLBVkAmL/gs2VqZSyUliUQagTuE99021UnOurCPUR4LOg60SiTENxOPMn6OkGO
 cLW4Ifd2xyNNgDIW/FuS6ldxeaDIz1AaxigioKeQtup+4zvxdQXQzEAgJZhez0lo+DhIRNAiDi
 x8lisfVLJV+DbAuA7MT8+GBhDlGWagIwRsxyr6iAxAeaOfZaCilJa9Pcm5YbLXnP+wDwhfGvfL
 2aTJ50mdRF/l22uJw5EcvDFfrYdkVDAHt89D4mHd/4appSZcaMuEhWNwbXhMGYI+52rZKmtdSL
 BlY=
X-IronPort-AV: E=Sophos;i="5.75,355,1589266800"; 
   d="scan'208";a="84010188"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Jul 2020 08:39:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 15 Jul 2020 08:39:01 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Wed, 15 Jul 2020 08:39:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+Bo3pm2VhgwKkHZmmU2VCstsHFvFey/EeDfaHE7nkGS0a99+gLRwxGQ8nhOZTdm84c9BDvApjPpHxwH8Y1bzNsDv8VVakUPjqvFnVAZw5Gh0RG6gyMNEXjTDD+Kvs6sopRj+CSsmA9Ixxm3MPJgfxM4KoC1iFLRiE13Lr8AUG8+S6PG76kpEmNmhL+gZcf0TjdA/CWCuOEFfnv/zFLTlwJGWp2/u8PzTDFTP716Id7RBcL0k3IYY1fohZYTHJ7deYgF0aH8QKEZjZvYVtK6MFIBoLWATAWppA7uzl0BQ3+t/RonnTWszVZ1SgjBLztPy1vyCus4UInwfiCLFC94Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs1GCJRROT3L+eFiWB7ldF/NSw4SssN96pcj5Hl7GMM=;
 b=Zx6TMlwV1TFFXgdJ61On6KQcQSimUn42/wdWZkilpG1dRQgHj69d7hZweWuZCJy9/1MypJQWvhXeQ+nxK+q2vZNYMHFfk2UyE/ayHDwS5vKAUWlSQ8rWxJn8iLHC1N+b0AocsZ9OZwaNk8Irkm5nTxzu0LYm/pyPDK+yOpkfTBZtoXt6ShXpUDrs0k654g6cOCcn03JDgcqMTjyD1f/vYSfrBErsuSEuxRSWVLEUqBZMu2FaPEmtpx7cNNs1BIAxnwLF7xUF6AeMLmNEjD2kgc+HgMwNRpY1rLFEag+TItncGuuVUWsZlm9Bsj0vKbJpSWM/hmVCFHxvD2AIALj4Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bs1GCJRROT3L+eFiWB7ldF/NSw4SssN96pcj5Hl7GMM=;
 b=I3fIch1p3vnxBoJyTRVpzYzvxV4CPXxZ/PyGhHsDEH/ycOnQPi33IZXbw/EfvuGotN4xD0xLdikDmXizvIylx9pMJSr9xddyQ4FrTlurUz0UT2rP+Yceejjv6rFcvBY2UgvrYXWtMSEDvvDW8BbvBn9V12j3fH3DMo6+LOrzMlA=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM6PR11MB3290.namprd11.prod.outlook.com (2603:10b6:5:59::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Wed, 15 Jul 2020 15:39:33 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::e8b2:1d82:49d9:f4b%6]) with mapi id 15.20.3174.026; Wed, 15 Jul 2020
 15:39:33 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>
CC:     <bbrezillon@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 09/19] clk: at91: sckc: register slow_rc with accuracy
 option
Thread-Topic: [PATCH 09/19] clk: at91: sckc: register slow_rc with accuracy
 option
Thread-Index: AQHWWr4hHbdIy9PUz0W5KlN9iMKsng==
Date:   Wed, 15 Jul 2020 15:39:33 +0000
Message-ID: <a0728969-dcb7-7702-a4fb-58ca1b2260c1@microchip.com>
References: <1594812267-6697-1-git-send-email-claudiu.beznea@microchip.com>
 <1594812267-6697-10-git-send-email-claudiu.beznea@microchip.com>
In-Reply-To: <1594812267-6697-10-git-send-email-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: baylibre.com; dkim=none (message not signed)
 header.d=none;baylibre.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [82.76.227.81]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e40926b-2ba9-4a38-90db-08d828d545c5
x-ms-traffictypediagnostic: DM6PR11MB3290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB329046A8CF87DB02505354C5877E0@DM6PR11MB3290.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:1107;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GQPVvk+x/zYu9cb0X5KinmcWEuCHYnqShAoDJW/Ad9PKDxjuDb/MCGkt5fVTltsZsSKfRkmUPdZHLKjJ8BzFmpHMr8ES+C1io13N4g4DNXEugZTRa5/Auo9dw3FvOcXVH42crJDxR1G0dg+YMiH+sQgzSe6erpuliYggOIH6JipoNDiUTmVNqX4HwV/vHVFm4IQSg/XbX8YUGAJvx9rgDmDa2daSCyHqopwXKUbg751/AayzYITdblYoW3LSH3ratx9BeT4p+9U/l2SYNHzFQlRzmjMN9bD4v3/qY+R6KZVGQEoF6rL6RFgRNDi4/lF69E5vsoE1IQO9d/NuFCZEb6E+2OhPtyIBRwxyXn+u1LjWZaY6MWeFj0lw3wdXcovJwe0vPxMqJZ4dMbqOYgeG6tkSMLxoOV4EPtCe74E+zmp6+5HxXyTvEa66pucCdD19hQHtLx6oZ+trMhkn6tgLjA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(346002)(376002)(366004)(136003)(396003)(6486002)(8936002)(4326008)(8676002)(83080400001)(54906003)(110136005)(478600001)(71200400001)(6512007)(31696002)(66946007)(316002)(6636002)(86362001)(66446008)(2616005)(83380400001)(53546011)(16799955002)(186003)(31686004)(6506007)(64756008)(91956017)(966005)(36756003)(26005)(2906002)(76116006)(5660300002)(66476007)(66556008)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zuQdiXmeoKb5ZjcRAT+W6Kql+8w0loxV3L/6uDWgbFXfGIdZFowryaBnRRzfrS8O1obrXopkLYhWizV1RoIHNcEu3QQDieXoY6IWoPSQ2Vdsdx90xpwbWQ1YyPzqtDSKvozaiRrdymmxJBpE1kU5Mup8+UukZ1AoyQ+9nM7E9/eUDc1wViWDtEQ5FG2VKjQVAT2UvrW6F+l0zgXoafZinZmboufQbWQ1/7aK0PjC1HyylP8NxJFLJoBhi/V98uY36a+O92YeWtJl9raWSBiJYUS/R5pW9eu0KWPSM+9uNXLNnkcvABnpuiFRnLYXAP2BHKn0JN9E/tKQgqaMpTsATRL9+zx9OJxKwvhUARlrJsxobd/aGSHSg4EQB6nLj6i/dFoaNe7lW7VJvcxbJurWu1NgYK5HYO3Igp8YXLuJgToIwlaQz4SsDAgdISMDQRnui6MVfDhl4taON0zOchlHZ7bsdGV08LuyPZAIlasz4i4=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEBF733E7A1CFE439EB0AFB0B0B5ED56@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e40926b-2ba9-4a38-90db-08d828d545c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2020 15:39:33.5456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30DbM7F7EGYU+0zVeiKQhJTxXZZBuEyf9lYFqRdjCH1yydUDJA/jOEM2eWxHHadTmioDblhd6xnhLEOyDcljQT97aad82pRIpnW96Xhp0+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE1LjA3LjIwMjAgMTQ6MjQsIENsYXVkaXUgQmV6bmVhIHdyb3RlOg0KPiBSZWdpc3Rl
ciBzbG93IHJjIHdpdGggYWNjdXJhY3kgb3B0aW9uLg0KPiANCj4gRml4ZXM6IDA0YmNjNDI3NWU2
MDEgKCJjbGs6IGF0OTE6IHNja2M6IGFkZCBzdXBwb3J0IGZvciBTQU05WDYwIikNCj4gU2lnbmVk
LW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMgfCA1ICsrKy0tDQo+ICAxIGZpbGUgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jIGIvZHJpdmVycy9jbGsvYXQ5MS9zY2tjLmMNCj4gaW5k
ZXggMTVkYzRjZDg2ZDc2Li4yZDY1NzcwZDg2NjUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xr
L2F0OTEvc2NrYy5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2F0OTEvc2NrYy5jDQo+IEBAIC00NzEs
OCArNDcxLDkgQEAgc3RhdGljIHZvaWQgX19pbml0IG9mX3NhbTl4NjBfc2NrY19zZXR1cChzdHJ1
Y3QgZGV2aWNlX25vZGUgKm5wKQ0KPiAgCWlmICghcmVnYmFzZSkNCj4gIAkJcmV0dXJuOw0KPiAg
DQo+IC0Jc2xvd19yYyA9IGNsa19od19yZWdpc3Rlcl9maXhlZF9yYXRlKE5VTEwsIHBhcmVudF9u
YW1lc1swXSwgTlVMTCwgMCwNCj4gLQkJCQkJICAgICAzMjc2OCk7DQo+ICsJc2xvd19yYyA9IGNs
a19od19yZWdpc3Rlcl9maXhlZF9yYXRlX3dpdGhfYWNjdXJhY3koTlVMTCwgcGFyZW50X25hbWVz
WzBdLA0KPiArCQkJCQkJCSAgIE5VTEwsIDAsIDMyNzY4LA0KPiArCQkJCQkJCSAgIDkzNzUwMDAw
KTsNCg0KSSBmb3Jnb3QgdG8gbWVudGlvbiBpbiBjb21taXQgbWVzc2FnZSAoSSdsbCBkbyBpdCBp
biB2MiBvbmNlIEknbGwNCmdhdGhlciBtb3JlIGNvbW1lbnRzIG9uIHRoaXMgc2VyaWVzKToNCg0K
Q2hhcHRlciA1Ny43LjUgb2YgU0FNOVg2MCBkYXRhc2hlZXQgc3BlY2lmaWVzIHRoYXQgdGhlIG1h
eGltdW0gZHJpZnQgb2YNCnRoaXMgb3NjaWxsYXRvciBpcyArLSAzS0h6LiBJIHVzZWQgdGhhdCB2
YWx1ZSBhbmQgdGhlIGZvcm11bGEgYXQgWzFdDQpvciB0aGUgY2FsY3VsYXRvciBhdCBbMl0gdG8g
Y29tcHV0ZSB0aGUgUFBCIHZhbHVlLg0KDQpbMV0gaHR0cHM6Ly93d3cuZXZlcnl0aGluZ3JmLmNv
bS9yZi1jYWxjdWxhdG9ycy9wcG0tdG8taHotY2FsY3VsYXRvcg0KWzJdIGh0dHBzOi8vd3d3LmNo
YW5ncHVhay5jaC9lbGVjdHJvbmljcy9wcG1fdG9fSHpfY29udmVydGVyLnBocA0KDQoNClRoYW5r
IHlvdSwNCkNsYXVkaXUgQmV6bmVhDQoNCj4gIAlpZiAoSVNfRVJSKHNsb3dfcmMpKQ0KPiAgCQly
ZXR1cm47DQo+ICANCj4g
