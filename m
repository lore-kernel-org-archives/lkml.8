Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2806EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBFC921D81
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 04:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=renesasgroup.onmicrosoft.com header.i=@renesasgroup.onmicrosoft.com header.b="ko4W9NOA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgIKE6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 00:58:02 -0400
Received: from mail-eopbgr1410130.outbound.protection.outlook.com ([40.107.141.130]:48864
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbgIKE56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 00:57:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SeTjNov9LyV/9ObV7OqWRShjAwP/aJJjoyLEejMuy43LrFqBHmNg3SpUSz4ZAE71Ftr1zmUkqhfGE/rsobOLLEgkv/GueLUb+rpGMOhjQ5P/fIp2KWbOx2g6UJFkLBeM1Dk5zUY22OgMokQC4eC7ZsaG0T8E1ckxPI6Tysb4cBlk2S0K+gMzrJB/+lucQdALj9WeHFSKqQJdewuXX+t6WBDHQ/ExlhVJ9jCDmc+Es7MAmhqPNDUCfyJWWoV1SVh0yt07nG601x+KjZufXPrzTN4Im7nyDqPaMFviziKpZYu9lcHP7AxdqwTzDRoTexKVEwALYXo4hGWfiFy2VeLdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEF6dGwO+207cnJ2FOxUQiGpHsiQF0rItikYz+sirnA=;
 b=Of9oOGN9kxRfgXFHG4TfhJ1dUl2BKSrAvAkVQ0kmKP4+c55DvuCTqxnCbiw6pOBDM+q0P+Am8iidAgdABBiBwvtwXBJKAfvpaIWhnkiUhwjFG8mzYOC0UPTLjP08Knjp1cBExPCpySuqGAJ98MqMeMyoo0TknMQDhUy9D5b3NXpRRiLHNZsm/70+5cb04TdpcEIQpWT9AvzaKFsfYpdOxiJETWhT471bdMe9SGCcb0+xGu13UY5IeA1zngLs5/pCK9AzRNWAwrO/HegFP1z+lBQerk/dYIrZRNG83tpdCnDXejVeJq6PcWxy7oS2OU5UFe60YSnef7cb+PzJoUmCbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEF6dGwO+207cnJ2FOxUQiGpHsiQF0rItikYz+sirnA=;
 b=ko4W9NOAL0nzAj9pWusRax00cDtRkpBHxFtWBf8OkZXEARBNBPDJp4+bAJnz+Lf6Bt02oeGkv7BOEJrXuH1I8VBA/qXLdfK8PPt3tpR4D99Wbu/usvRTydGaVvePn2RK7k59m2xj11lnQFJNvnVG34h3caJ+U/JGQX3wmPBbrFg=
Received: from OSAPR01MB3683.jpnprd01.prod.outlook.com (2603:1096:604:33::12)
 by OSYPR01MB5429.jpnprd01.prod.outlook.com (2603:1096:604:80::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.17; Fri, 11 Sep
 2020 04:57:53 +0000
Received: from OSAPR01MB3683.jpnprd01.prod.outlook.com
 ([fe80::1d16:3e99:8fb2:84e1]) by OSAPR01MB3683.jpnprd01.prod.outlook.com
 ([fe80::1d16:3e99:8fb2:84e1%7]) with mapi id 15.20.3370.016; Fri, 11 Sep 2020
 04:57:53 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     Daniel Thompson <daniel.thompson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Lee Jones <lee.jones@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Jason Yan <yanaijie@huawei.com>,
        Chuhong Yuan <hslester96@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: RE: [PATCH RESEND v3 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
Thread-Topic: [PATCH RESEND v3 04/11] usb: xhci-rcar: convert to
 readl_poll_timeout_atomic()
Thread-Index: AQHWh0vD+aj1y+DFoU+XUmXRM8L6jalh2WYAgADf1oCAAAetsIAAFCEAgAAJHUA=
Date:   Fri, 11 Sep 2020 04:57:52 +0000
Message-ID: <OSAPR01MB3683A8CE38F900DC0CA5D472D8240@OSAPR01MB3683.jpnprd01.prod.outlook.com>
References: <1599726112-4439-1-git-send-email-chunfeng.yun@mediatek.com>
         <1599726112-4439-4-git-send-email-chunfeng.yun@mediatek.com>
         <20200910131212.wm7zskxvcesl652c@holly.lan>
         <1599791601.24609.5.camel@mhfsdcap03>
         <OSAPR01MB3683CA015AB25BC00D8459EBD8240@OSAPR01MB3683.jpnprd01.prod.outlook.com>
 <1599797572.24609.8.camel@mhfsdcap03>
In-Reply-To: <1599797572.24609.8.camel@mhfsdcap03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mediatek.com; dkim=none (message not signed)
 header.d=none;mediatek.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:64a2:c8a4:9548:6c30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5eab771e-80fc-463c-79c4-08d8560f3d9b
x-ms-traffictypediagnostic: OSYPR01MB5429:
x-microsoft-antispam-prvs: <OSYPR01MB54293D438397CA2A0E87FC9BD8240@OSYPR01MB5429.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tj1B7A4ahgoU7n+otrqAIaP1XGmyVAwj3cd/1YbPGc2xwXQmx7CqIK8KU2kVTBHMrJ8AKfre8lSJvqyaoED0TBAx8ENgn8Nr0NZ5UQnyfA9QQt2d2yS/mboUH2Jq+xhvsjMQ1rh4fRgJsl2FX1iVHm1gzaKQaWjzCLbPUGjnMb7c87KK4SsK03wDgRv15D2toX6dJZTS3MzxuEV046RxpVQllOkMZZXfk7iR3AjX8ZqOqPut+qPRZZvYdYcxYnBxecDYI+W6nL7KGEJDJ+1vOqBNNcS4nHf0rJYi4P3IC5AOZXzASTn7VwCk745TVs1g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB3683.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(7696005)(6506007)(86362001)(4326008)(316002)(8676002)(186003)(7416002)(8936002)(478600001)(9686003)(2906002)(54906003)(6916009)(55016002)(76116006)(5660300002)(66556008)(64756008)(66446008)(66476007)(66946007)(52536014)(71200400001)(83380400001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /xxCQp41MnvIsDQ9gXWBpG8gBLT449vlQLYRypWoUJHhoID4hPuUTuMoUNlcX+GGypk1Qvg0xOhUxAn+BXl6MLK7ALBgAvGu7Tg5ZMfhZhp/JpA8w8NAoIec4hOsVv9aaEbsBPPjEsCsEce+uph7rkI5ssIySp5yiandzqarnR4vgQHslXpnf7J/9gPFjf66vTRKR6OOZ0ZP8RzD02t4gOwEv7UWrjvHPQk0tqIM14IqP1jkR0B3d2GvKR8ADAwH+jDPOez2AaQsxxKSW3XfaHNVouwWhlRlBmxOK6PRTXjSr2y8xUeUmuu67x2bA9PWCYNHlvqpi8FADZxGBAbIJ3J6ZveMqjT1K2y3hMpXxot2czMNlqIvWyUqSDLPOC3klY6Ixt47q8uX9Zm1I1FpILj6H7AuQF0xj5BdDzJfYRUi+J1JAgctTu0CIuwLbpMECMctrQMAyFlqEwBU7AtS7HgAjZiyjMz3IbwQhuCjzRpxHt6Tjgwel+0IeOORTpFguAI06qCyvPGfapX8EkPErGYvc8Khv4MXbVgHuvT0R/plYprjscVyY+/7uChGbUYbNO7xqpHjl+nZNaSi/Q7bTZ792OaxyDVAqTesL4fDA2MnV8UsEuCd+DJwKqNoqfnyRSy+uxjPXtNNJpRPHNb643nxMJswPhsKeH8YohMOK7hcN7PZDWT7OTISrbQDoXlTZNyQBdmbW59amb0hjX3qAg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB3683.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eab771e-80fc-463c-79c4-08d8560f3d9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2020 04:57:52.7774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: paIBQnmnPcjhnj9MJQO17Ysp2/ICaIWnnhVlx47WhInNEpeKrXf8FJJ1ZUNk4W+N6xUFFXVDFAmSR8utjJAT96OEPznMOLvn/Cg0Dls9MXH1HYd/DZ/cinorUXLbDcB5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5429
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2h1bmZlbmcsDQoNCj4gRnJvbTogQ2h1bmZlbmcgWXVuLCBTZW50OiBGcmlkYXksIFNlcHRl
bWJlciAxMSwgMjAyMCAxOjEzIFBNDQo+IA0KPiBPbiBGcmksIDIwMjAtMDktMTEgYXQgMDM6MTMg
KzAwMDAsIFlvc2hpaGlybyBTaGltb2RhIHdyb3RlOg0KPiA+IEhpIERhbmllbCwgQ2h1bmZlbmcs
DQo+ID4NCj4gPiA+IEZyb206IENodW5mZW5nIFl1biwgU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIg
MTEsIDIwMjAgMTE6MzMgQU0NCj4gPiA+DQo+ID4gPiBPbiBUaHUsIDIwMjAtMDktMTAgYXQgMTQ6
MTIgKzAxMDAsIERhbmllbCBUaG9tcHNvbiB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCBTZXAgMTAs
IDIwMjAgYXQgMDQ6MjE6NDVQTSArMDgwMCwgQ2h1bmZlbmcgWXVuIHdyb3RlOg0KPiA+ID4gPiA+
IFVzZSByZWFkbF9wb2xsX3RpbWVvdXRfYXRvbWljKCkgdG8gc2ltcGxpZnkgY29kZQ0KPiA+ID4g
PiA+DQo+ID4gPiA+ID4gQ2M6IE1hdGhpYXMgTnltYW4gPG1hdGhpYXMubnltYW5AbGludXguaW50
ZWwuY29tPg0KPiA+ID4gPiA+IENjOiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1v
ZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogQ2h1bmZlbmcgWXVu
IDxjaHVuZmVuZy55dW5AbWVkaWF0ZWsuY29tPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IHYy
fnYzOiBubyBjaGFuZ2VzDQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4gIGRyaXZlcnMvdXNiL2hv
c3QveGhjaS1yY2FyLmMgfCA0MyArKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAzMSBk
ZWxldGlvbnMoLSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Vz
Yi9ob3N0L3hoY2ktcmNhci5jIGIvZHJpdmVycy91c2IvaG9zdC94aGNpLXJjYXIuYw0KPiA+ID4g
PiA+IGluZGV4IGMxMDI1ZDMuLjc0ZjgzNmYgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVy
cy91c2IvaG9zdC94aGNpLXJjYXIuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdXNiL2hvc3Qv
eGhjaS1yY2FyLmMNCj4gPiA+ID4gPiBAQCAtNiw2ICs2LDcgQEANCj4gPiA+ID4gPiAgICovDQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L2Zpcm13YXJlLmg+DQo+ID4gPiA+
ID4gKyNpbmNsdWRlIDxsaW51eC9pb3BvbGwuaD4NCj4gPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4
L21vZHVsZS5oPg0KPiA+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+
DQo+ID4gPiA+ID4gICNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ID4gPiA+IEBAIC0xMjcsOCAr
MTI4LDcgQEAgc3RhdGljIGludCB4aGNpX3JjYXJfZG93bmxvYWRfZmlybXdhcmUoc3RydWN0IHVz
Yl9oY2QgKmhjZCkNCj4gPiA+ID4gPiAgCXZvaWQgX19pb21lbSAqcmVncyA9IGhjZC0+cmVnczsN
Cj4gPiA+ID4gPiAgCXN0cnVjdCB4aGNpX3BsYXRfcHJpdiAqcHJpdiA9IGhjZF90b194aGNpX3By
aXYoaGNkKTsNCj4gPiA+ID4gPiAgCWNvbnN0IHN0cnVjdCBmaXJtd2FyZSAqZnc7DQo+ID4gPiA+
ID4gLQlpbnQgcmV0dmFsLCBpbmRleCwgaiwgdGltZTsNCj4gPiA+ID4gPiAtCWludCB0aW1lb3V0
ID0gMTAwMDA7DQo+ID4gPiA+ID4gKwlpbnQgcmV0dmFsLCBpbmRleCwgajsNCj4gPiA+ID4gPiAg
CXUzMiBkYXRhLCB2YWwsIHRlbXA7DQo+ID4gPiA+ID4gIAl1MzIgcXVpcmtzID0gMDsNCj4gPiA+
ID4gPiAgCWNvbnN0IHN0cnVjdCBzb2NfZGV2aWNlX2F0dHJpYnV0ZSAqYXR0cjsNCj4gPiA+ID4g
PiBAQCAtMTY2LDMyICsxNjYsMTkgQEAgc3RhdGljIGludCB4aGNpX3JjYXJfZG93bmxvYWRfZmly
bXdhcmUoc3RydWN0IHVzYl9oY2QgKmhjZCkNCj4gPiA+ID4gPiAgCQl0ZW1wIHw9IFJDQVJfVVNC
M19ETF9DVFJMX0ZXX1NFVF9EQVRBMDsNCj4gPiA+ID4gPiAgCQl3cml0ZWwodGVtcCwgcmVncyAr
IFJDQVJfVVNCM19ETF9DVFJMKTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IC0JCWZvciAodGltZSA9
IDA7IHRpbWUgPCB0aW1lb3V0OyB0aW1lKyspIHsNCj4gPiA+ID4gPiAtCQkJdmFsID0gcmVhZGwo
cmVncyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCj4gPiA+ID4gPiAtCQkJaWYgKCh2YWwgJiBSQ0FS
X1VTQjNfRExfQ1RSTF9GV19TRVRfREFUQTApID09IDApDQo+ID4gPiA+ID4gLQkJCQlicmVhazsN
Cj4gPiA+ID4gPiAtCQkJdWRlbGF5KDEpOw0KPiA+ID4gPiA+IC0JCX0NCj4gPiA+ID4gPiAtCQlp
ZiAodGltZSA9PSB0aW1lb3V0KSB7DQo+ID4gPiA+ID4gLQkJCXJldHZhbCA9IC1FVElNRURPVVQ7
DQo+ID4gPiA+ID4gKwkJcmV0dmFsID0gcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhyZWdzICsg
UkNBUl9VU0IzX0RMX0NUUkwsDQo+ID4gPiA+ID4gKwkJCQl2YWwsICEodmFsICYgUkNBUl9VU0Iz
X0RMX0NUUkxfRldfU0VUX0RBVEEwKSwNCj4gPiA+ID4gPiArCQkJCTEsIDEwMDAwKTsNCj4gPiA+
ID4gPiArCQlpZiAocmV0dmFsIDwgMCkNCj4gSG93IGFib3V0IGZyZWUgZmlybXdhcmUgYW5kIHJl
dHVybiBlcnJvciBudW1iZXIgaGVyZSA/IGluc3RlYWQgb2YgYnJlYWsNCg0KSSB0aGluayBjbGVh
cmluZyBDVFJMX0VOQUJMRSBjb2RlIGJlbG93IGlzIG5lZWRlZC4NCkFuZCwgSSB0aGluayB0aGlz
IHBhdGNoIHNob3VsZCBub3QgY2hhbmdlIGEgbG90IG9mIHRoaW5ncy4uLg0KDQo+ID4gPiA+ID4g
IAkJCWJyZWFrOw0KPiA+ID4gPiA+IC0JCX0NCj4gPiA+ID4gPiAgCX0NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+ICAJdGVtcCA9IHJlYWRsKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCk7DQo+ID4gPiA+
ID4gIAl0ZW1wICY9IH5SQ0FSX1VTQjNfRExfQ1RSTF9FTkFCTEU7DQo+ID4gPiA+ID4gIAl3cml0
ZWwodGVtcCwgcmVncyArIFJDQVJfVVNCM19ETF9DVFJMKTsNCj4gPiA+ID4gPg0KPiA+ID4gPiA+
IC0JZm9yICh0aW1lID0gMDsgdGltZSA8IHRpbWVvdXQ7IHRpbWUrKykgew0KPiA+ID4gPiA+IC0J
CXZhbCA9IHJlYWRsKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RSTCk7DQo+ID4gPiA+ID4gLQkJaWYg
KHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NFU1MpIHsNCj4gPiA+ID4gPiAtCQkJcmV0
dmFsID0gMDsNCj4gPiA+ID4gPiAtCQkJYnJlYWs7DQo+ID4gPiA+ID4gLQkJfQ0KPiA+ID4gPiA+
IC0JCXVkZWxheSgxKTsNCj4gPiA+ID4gPiAtCX0NCj4gPiA+ID4gPiAtCWlmICh0aW1lID09IHRp
bWVvdXQpDQo+ID4gPiA+ID4gLQkJcmV0dmFsID0gLUVUSU1FRE9VVDsNCj4gPiA+ID4gPiArCXJl
dHZhbCA9IHJlYWRsX3BvbGxfdGltZW91dF9hdG9taWMoKHJlZ3MgKyBSQ0FSX1VTQjNfRExfQ1RS
TCksDQo+ID4gPiA+ID4gKwkJCXZhbCwgKHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NVQ0NF
U1MpLCAxLCAxMDAwMCk7DQo+ID4gPiA+DQo+ID4gPiA+IERpcmVjdGx5IGFzc2lnbmluZyB0byBy
ZXR2YWwgYXQgdGhpcyBwb2ludCB3aWxsIGNsb2JiZXIgYSBwcmV2aW91cw0KPiA+ID4gPiAtRVRJ
TUVET1VUIGVycm9yLg0KPiA+ID4gPg0KPiA+ID4gPiBJbiBvdGhlciB3b3JkcyBpZiB0aGVyZSBp
cyBhIHRpbWVvdXQgd2FpdGluZyBmb3IgRldfU0VUX0RBVEEwLCBidXQgbm90IGZvcg0KPiA+ID4g
PiBEV19TVUNDRVNTLCB0aGVuIHdlIHdpbGwgcmV0dXJuIHRoZSB3cm9uZyByZXR1cm4gdmFsdWUu
DQo+ID4NCj4gPiBUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudCEgSSBkaWRuJ3QgcmVhbGl6ZWQg
dGhpcy4NCj4gPg0KPiA+ID4gWWVzLCBhZ3JlZSB3aXRoIHlvdSwgYnV0IHNlZW1zIEkga2VlcCBp
dHMgb3JpZ2luYWwgbG9naWMgdW5jaGFuZ2VkLg0KPiA+ID4gSGkgWW9zaGloaXJvLA0KPiA+ID4N
Cj4gPiA+ICAgV2hhdCBkbyB0aGluayBhYm91dCBEYW5pZWwncyBzdWdnZXN0aW9uPyBzaG91bGQg
SSBmaXggaXQgdXA/DQo+ID4NCj4gPiBJIHRoaW5rIHlvdSBzaG91bGQgZml4IGl0IHVwIGxpa2Ug
YmVsb3c6DQo+ID4NCj4gPiBpZiAocmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhyZWdzICsgUkNB
Ul9VU0IzX0RMX0NUUkwsDQo+ID4gCQl2YWwsIHZhbCAmIFJDQVJfVVNCM19ETF9DVFJMX0ZXX1NV
Q0NFU1MsIDEsIDEwMDAwKSA8IDApDQo+ID4gCXJldHZhbCA9IC1FVElNRU9VVDsJLyogT3Zlcndy
aXRlIHJldHZhbCBpZiB0aW1lb3V0IG9jY3VycmVkICovDQo+IA0KPiByZWFkbF9wb2xsX3RpbWVv
dXRfYXRvbWljKCkgb25seSByZXR1cm4gLUVUSU1FT1VUIGVycm9yIG51bWJlciwgc28gdGhpcw0K
PiBsaWtlcyB3aGF0IEkgZGlkLCBkb2Vzbid0IGZpeCBpdC4NCg0KcmVhZGxfcG9sbF90aW1lb3V0
X2F0b21pYygpIHJldHVybnMgMCBpZiB0aW1lb3V0IGRvZXNuJ3QgaGFwcGVuLg0KU28sIHdoZW4g
bXkgc3VnZ2VzdGlvbiBjb2RlIHJ1bnMsIHRoZSByZXR2YWwgaXMgbm90IG92ZXJ3cml0dGVuIGlm
DQp0aGUgcmVhZGxfcG9sbF90aW1lb3V0X2F0b21pYyhyZWdzICsgUkNBUl9VU0IzX0RMX0NUUkwu
Li4pIHJldHVybnMgMC4NCg0KQmVzdCByZWdhcmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0K
