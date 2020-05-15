Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CEFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F3920671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2MbE93ca";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="UODaP4f/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgEOPYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:24:39 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:5191 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727918AbgEOPYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589556250; x=1621092250;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3vJ7XfieW4UfMP3x6zCpbmqeUOMzPH6v3zai5Zr+Yyo=;
  b=2MbE93canImZ88F7vmOpDGu37QE02syueXMdA4mCFV3VegU0UbvBeqEk
   llHCPp+j51oRJBBdKGQfscNxEJ4SfiFMeICOcWeJkUQcDUDU+arGTjkdi
   MqpMqHxs7YL+jGM7hy0kQ9Mz9VVeGS+T3ht1LyhhsPv7K1XlPZHiHBtC4
   8lgENUNIT04gUVjjuj5QnoPvICnUeeiyQgHa3R/OXNaUPz6oZTK/sulyi
   uMAsPqIqEVSdoG85g5dyM7AhdaMhjxWqKPY0mzIDhU/cCFhk8uGmlZUOW
   K7HA4PbEtXvOHPgN6pEn4dgofXBC0AMQLxDa5dfwR9NMk1OOra4BlEene
   Q==;
IronPort-SDR: 8S/64L1Njfvx2WqZeR9p2h0rwegVsomqlalCTiNjb/RSu78LW9EySXh75Jq37PE3OthKnBMjo1
 FiyMDUbFsOfikksSN0JIIbVpTsTFNirY8SYDNIEGDiS+drnx0LudPIeZYUAnWtWq80cOoX+RW1
 JAz8JkYrBRm+RkDjRERRDxqLA7udWreUPmJoJs1941PyEiujDUOfh/7G/uSozmULd/TpDAlJbp
 ATR059kXKQgLjEuMd3N/a6MblEUEZMm+B/9qpxVRnV9pH17DPJWMzZ7Mzu7zl4a3RTkkHL7ndq
 9qg=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="76818086"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 08:24:09 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 08:24:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 15 May 2020 08:24:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nWXM7092rFm67e539SLKEgDLcJK+mlqpfvLgaz8IRHLbCzORtZq4Pv0I1ggEY3tpPTN1u8vpTWj6Ez3ZTsAuX5EMtElpw1sQSCLgxvDc9cyDBC6ZFV8hd9u7yDDRX+kNqSymw72D1/Rx86bzhhDxN2wDFQ/uOWDzmXmVPIVlgR3IhO1WBk37eixekFve4B6AmSH+s5cjnuXTHw9z/Y1FspAsPrrDyF6YzCxqHTNJOnD+LaodkJ5nmsEx730omzIB3/bZNCU3tvaf8/c1uF64j8VIAWecLaZrPtgOjwZyTaWSqJ+eMGIWO+hiEW3gPYJcTLwmsGgHIUrJO5HU+I94dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vJ7XfieW4UfMP3x6zCpbmqeUOMzPH6v3zai5Zr+Yyo=;
 b=PDP1hflQhrtyzq4Y+PmiFehQEX3trTV8IPSn64QPJr0N2HmAOutS+js40NqZpVm2doHFF9h5yK5a7MHbk9jeD4wcMn+N79BzYvevAKOF4+hM4Xg+4GHXH6q31t6o/wXPLCAK8nYIVCcyc9BpRSktW3qv0iQed7R/T9yhckm+UhHBbfiwtWOl3CKRWnmvY87VMYzgOAJU2TxxIpNwZRSCEL+458qNn2ka57Mlm5Js+1+KMm8ybkeH4rwa7s9m5f6mMCiS8A7VRdPsXO4CMJ/U5VxLBRnFxXlXTm4ALW7bf6C/dZYdWlbr/en/O8piBXkaQakH4CJLp1WIdmyHHiaw+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vJ7XfieW4UfMP3x6zCpbmqeUOMzPH6v3zai5Zr+Yyo=;
 b=UODaP4f/UJ/7dRwrsxHj+Wbe/HnxY6jPjyrRmsrIbkj+ywDknhvynrMZ3ozn3WCrSsU8jwgVmXueKzSlm6rA7KSIVjzzR/8BSaLeYZe47BKg3tIQDfOboiOft+rUEiZLlHiM7+xPdZFHV3ufhwItXBmDKGrwsAI3ae4rEV3oHVk=
Received: from CY4PR11MB1688.namprd11.prod.outlook.com (2603:10b6:903:25::23)
 by CY4PR11MB1880.namprd11.prod.outlook.com (2603:10b6:903:120::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.25; Fri, 15 May
 2020 15:24:08 +0000
Received: from CY4PR11MB1688.namprd11.prod.outlook.com
 ([fe80::d414:b3d8:74c7:7488]) by CY4PR11MB1688.namprd11.prod.outlook.com
 ([fe80::d414:b3d8:74c7:7488%9]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 15:24:08 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: Configure I2C SCL gpio as open drain
Thread-Topic: [PATCH] ARM: dts: at91: Configure I2C SCL gpio as open drain
Thread-Index: AQHWKsEy8Em+dk2FY0a9pR0JyO0gxqipPSuAgAAHDgA=
Date:   Fri, 15 May 2020 15:24:08 +0000
Message-ID: <e99e9473-6dd2-1a27-975e-e49ad5413b02@microchip.com>
References: <20200515140001.287932-1-codrin.ciubotariu@microchip.com>
 <20200515145849.GV34497@piout.net>
In-Reply-To: <20200515145849.GV34497@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [84.232.220.208]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31b11705-8939-40be-29a5-08d7f8e402ed
x-ms-traffictypediagnostic: CY4PR11MB1880:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB188062E3027EDF6149C0574DE7BD0@CY4PR11MB1880.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lNjbCu3WVq67mpeZK9yjnFgb+8wCvxo8/D43H3kbdJuefFFuc3NtFtiDpW67enXv64MIAVEob25vEMzxLz5IPvBVdoX/hh1mnO8oKl+S+6KUQGg1gorEC6H8zezEYEIcVZnGnMEZup03UdZlnsR6ajuYPd32r9YqDbHPoGUbYWC6//b2lYVZW1hUXtEgqAaZnklXmvXtZEz0JhsPKOC9uddjC0H5hpqpZIldO4bApdH8/sFxlU9d0LPG0/9Sf3SCH4PQyjviZHglovB4W2o2eTdhrS+HOd1ts78CStcoa9yM3qrPN8fznBceIldz4X8jAhh6yLe/6Dm+GeJvjWy/eqqXwONDp+uEnTfgMEYsIypcOtDDiHvwdSSg2Yn15orG/k8NCegn8wYainpAJgfbIhIpbq2R9NmtxKS4ZrrIuIMjSRlXGVnLRP44GPvs3RiHN1zws1aHJ/eIxSQNDpwpYiwOdySGVnUnahUJpR209ZkS3UAh/4HQsL/iZCrOrwPlVH7ptFwQQkVHMyOiK6gg1RxQoYPsbb8VckIi5pAGjTL9sx4vRwJsKT1SqGSfr8QxLw6Faa+RljZMWXTJYcSdbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1688.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(396003)(346002)(366004)(376002)(39860400002)(8676002)(966005)(5660300002)(478600001)(6506007)(8936002)(6916009)(91956017)(66946007)(66476007)(64756008)(186003)(76116006)(54906003)(66556008)(26005)(53546011)(2616005)(66446008)(36756003)(316002)(6512007)(31686004)(107886003)(31696002)(2906002)(86362001)(4326008)(6486002)(71200400001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PEpaJ+3DhMZlx7VvBg86PRNrIoz3LE5cJr8nCnfkNXVny9DRFODtxkHo6cPAMEyUKY5gqj7t370itYsmqO5acCZRqQ0W6XCHYR8wOsArdDR5+vEWQi4WRZw4sHjKR9Pdg4tWPlCB3xWqvPRE5fBYsVG4CsJ44PgplDhVbta4OPFaWuLWMDk9TTj7yLhuIUJqF7UK4U/0pnwb0TfnRZIbnQCE2P66Jk8HE8aR7Y8M6cO5W5l4qaD84SdY0XxQ3kFYCNjUv0zFGuNW+jT8qrMZh+UwdF93La84Lw1cBP1NO+8iIRBDdyVWJyi7mZo4suWCnN7fzwnVeob0kt76H+5YFat5BZsV5PYb4hNUR9TUH6kuwlK0ILIC7xi55qKK3SIUuB0tg174dbSbF+NTzMtNINhZTo1vBVqeRgnXS7k3dxQVj9UKEA2PCIB0a2i1In5k352r4sxxxvp2wIpnstJeDEHFVmzrJq7XqjebigVtFJWDaU3Zu8cyoMCNgK2cmwO2
Content-Type: text/plain; charset="utf-8"
Content-ID: <6FA3E4CADE28CC4DBD1294FF2BD1E88B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b11705-8939-40be-29a5-08d7f8e402ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 15:24:08.0504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GSlJG3PKkP9RHrOABsE9giR+kPpP0Pw2bvMMay/ogCIeHMD6LPxVJdYTuL9kp5Uxg+pDJpfC6fBDN7waWO1sYvP4+cBzVPoX7iQMzLsZDiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1880
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTUuMDUuMjAyMCAxNzo1OCwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IE9uIDE1LzA1
LzIwMjAgMTc6MDA6MDErMDMwMCwgQ29kcmluIENpdWJvdGFyaXUgd3JvdGU6DQo+PiBUaGUgU0NM
IGdwaW8gcGluIHVzZWQgYnkgSTJDIGJ1cyBmb3IgcmVjb3ZlcnkgbmVlZHMgdG8gYmUgY29uZmln
dXJlZCBhcw0KPj4gb3BlbiBkcmFpbi4NCj4+DQo+PiBGaXhlczogNDU1ZmVjOTM4YmJiICgiQVJN
OiBkdHM6IGF0OTE6IHNhbWE1ZDI6IGFkZCBpMmMgZ3BpbyBwaW5jdHJsIikNCj4+IEZpeGVzOiBh
NGJkOGRhODkzYTMgKCJBUk06IGR0czogYXQ5MTogc2FtYTVkMzogYWRkIGkyYyBncGlvIHBpbmN0
cmwiKQ0KPj4gRml4ZXM6IDhmYjgyZjA1MGNmNiAoIkFSTTogZHRzOiBhdDkxOiBzYW1hNWQ0OiBh
ZGQgaTJjIGdwaW8gcGluY3RybCIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBDb2RyaW4gQ2l1Ym90YXJp
dSA8Y29kcmluLmNpdWJvdGFyaXVAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gICBhcmNoL2Fy
bS9ib290L2R0cy9hdDkxLXNhbWE1ZDJfcHRjX2VrLmR0cyAgIHwgNiArKystLS0NCj4+ICAgYXJj
aC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQyX3hwbGFpbmVkLmR0cyB8IDYgKysrLS0tDQo+PiAg
IGFyY2gvYXJtL2Jvb3QvZHRzL3NhbWE1ZDMuZHRzaSAgICAgICAgICAgICAgfCA2ICsrKy0tLQ0K
Pj4gICBhcmNoL2FybS9ib290L2R0cy9zYW1hNWQ0LmR0c2kgICAgICAgICAgICAgIHwgNiArKyst
LS0NCj4+ICAgNCBmaWxlcyBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlvbnMo
LSkNCj4+DQo+IA0KPiBBcHBsaWVkLCB0aGFua3MuIFRoZXJlIHdhcyBhIHNtYWxsIGNvbmZsaWN0
IGluIHRoZSBzYW1hNWQyIGJvYXJkIGR0cywNCj4gcGxlYXNlIGNoZWNrLg0KDQpJdCBpcyBvaywg
d2l0aCB0aGUgZXhjZXB0aW9uIHRoYXQgaXQgc2hvdWxkIGFsc28gYmUgYWRkZWQgZm9yIHRoZSAN
CnNjbC1ncGlvcyBwcm9wZXJ0eSBmcm9tIHRoZSBpMmMyIG5vZGUuIEkgYW0gbWFraW5nIGEgcGF0
Y2guDQoNCj4gDQo+IC0tDQo+IEFsZXhhbmRyZSBCZWxsb25pLCBCb290bGluDQo+IEVtYmVkZGVk
IExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9ib290bGluLmNvbQ0KPiAN
Cg0K
