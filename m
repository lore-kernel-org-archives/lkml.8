Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B34C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A4622070B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dialogsemiconductor.onmicrosoft.com header.i=@dialogsemiconductor.onmicrosoft.com header.b="nuzBso16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgHJORd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:17:33 -0400
Received: from mail-eopbgr60075.outbound.protection.outlook.com ([40.107.6.75]:44028
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726932AbgHJORb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:17:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7SBL/HABDto8Qa1sUmPlLqVNMDKMfsB8HUnaIGq+B4Yb6gevsm+pzyT6LQd9bs6iuRmXiKT7uWW4t0X/Z5Gyo8krgKQw29VyiOcuLoXywsMIJyNDlIGi2cQF5DesbcDahAja9nI3/U5M+O2LffFUZIBDucuiRpwbJKbm19rXGqSkVcF3IBsq8UQLH+3BfVfVf1S7NruvQlnEnq77ma8TASbNm0cyX1SN6pRxtWvVc/9JuNCOQTuVPvL8tB13CBSmiKHwpfHx33c1f/TEazheQPU1Zyb5Hgzc4jbTpsPHqXr6VEsnQUUTg0J0xugy2SEyCFm2uc0lQbNWrnuFyY+kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDVauhp61OrX82z7RXk+Avd7ByELl4ghyNcuIuZjSh8=;
 b=GHsrs37IHWGOfRpKUdTXpIyesG0a3ODcqf9wYCsFspBo7jH4GdTkW8kkSfLMaDNDP1/sGflijzg5V42stQ6mRtBPPTzX2mbv5c0Lc/yzDd5B4rlD+01BRr3w+irJRR5RoM+wCTuB5P6T18wC3iNTl8hFw3ViBrg1EgNwguYsnWaouIU2ljnt0Ks3Rpn8+EBMpO5SpC2E7qHWfYIerTmjgpJTGmTp+WHnbIzhFlGahmK1n8ABWo1zAcSmpSlwiJSRexCjF6y35Vjer6JIv1mtsAqTX6oPbGJoKE9BByy6nPerxmEsBEKjMcwkRfu52Pw8WfZb9OZuEoVqt6nPLQoUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mDVauhp61OrX82z7RXk+Avd7ByELl4ghyNcuIuZjSh8=;
 b=nuzBso16IznmZHGRfxCTnvhulIAPZMhmpv7JhuDunq6mkGkIahD92s35UCEJJH6+jsBa96fQ+hs7Wv8Xk1/sp/vjEaBPnlzqmTYjc8bQQ4mRKDl9osly+GrK7F9/Hdc/ZgwWY8kKnIPdRkCZAX32PZt/ZGzsMnDzwFQ91N7lU7Q=
Received: from AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:135::13)
 by AM7PR10MB3495.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Mon, 10 Aug
 2020 14:17:28 +0000
Received: from AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7114:8e7f:c0d1:3aad]) by AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7114:8e7f:c0d1:3aad%4]) with mapi id 15.20.3261.024; Mon, 10 Aug 2020
 14:17:28 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     =?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>
Subject: RE: [PATCH 2/3] regulator: remove locking around
 regulator_notifier_call_chain()
Thread-Topic: [PATCH 2/3] regulator: remove locking around
 regulator_notifier_call_chain()
Thread-Index: AQHWbs9pfBzqZHxX2kiz2Hq71hqAGakxYjsw
Date:   Mon, 10 Aug 2020 14:17:28 +0000
Message-ID: <AM7PR10MB36405CC799E436FC66A74E4980440@AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1597032945.git.mirq-linux@rere.qmqm.pl>
 <42393f66dcc4d80dcd9797be45216b4035aa96cb.1597032945.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <42393f66dcc4d80dcd9797be45216b4035aa96cb.1597032945.git.mirq-linux@rere.qmqm.pl>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: rere.qmqm.pl; dkim=none (message not signed)
 header.d=none;rere.qmqm.pl; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.225.80.85]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 16a98f7d-cda5-4958-440a-08d83d381ccc
x-ms-traffictypediagnostic: AM7PR10MB3495:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM7PR10MB349511BAE08E46EEE3CB8041A7440@AM7PR10MB3495.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WUgAaXl5m6QJkffdyvIt1jNgcOrj2MSf5pDG2QfIB1xLQ4CQh2mXcavCkrJddo0dpcIlWpuERXzpFhDh8YP0Wl063eo3WPnluPFpVACG9iSEl0ASV1bD/UcGqw+qoou7Z1+vsvIh/HBv+0UwbhFUkAQo7F61S7cL4XeL501s0sgv+jMX7ehxFDo5cgyfMDSt4snQfB1yBJ/7AwaGE6mu2BWAazXIY0B2/KsOACCVmspRxCIE4+liKchJIbIUkrmt7EFFsVpa3Biq8StzXF3J9Hw1A0sjvaC2XYAA/2rPdpkc5MX5u3YyLD6HJO/SVQJxC6NO6OMEkhymGwmgUPa4MQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(86362001)(66476007)(64756008)(66556008)(66446008)(66946007)(76116006)(52536014)(5660300002)(2906002)(83380400001)(66574015)(71200400001)(478600001)(54906003)(110136005)(186003)(33656002)(26005)(316002)(7696005)(55236004)(55016002)(8676002)(53546011)(6506007)(9686003)(8936002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: vd6vx7y9VmP/rzNlG6b/6spblsi8WSMmIi9LN7xZCbDLk8Q7AXfzGxyiZoA7HEpjhI/dv+95lhDCH/YIxtB7aldKq4preyPCuTM9p4i+kvxbeizMJjFy/BmoksJPa3u91KA6fll8lLGCphphBxCzLr7z6tMZZQhiBSJZup6T6xkh8W02KjJiaqK5Oj/jSvkqQyX9OCmhBPHLO3Q1ChXytnVOy9q9sJrrHGXAibaatjJzvHK7cEoC1va/sUnfFnTDCk73IvSzQ/UZufSH5JXMhQt+z8Emibpobr8eywa3avqon3CEZU72i8JG2F6sG1x3Ljeo3gH/l9Ek3p/sBDBFKFLkylA78FCAZGrBJ/7B5jYHfQnj0mxAKJqYUstp5trH7WcdJd/C3NCqJkgpEk5FT37cVGZfvj563nu5AZJbDH0dKtjhZNXvBGwK3W4ZLAxORaPqMLqbOAtXe7RZ6GfzGtPe9x3HpGWgUW8UlFkku3UDRe0AgTts/26a6BV2AaRLSdH9T6zO/biBLsu/cOTs6Z5QHQtcyeEl8X25+RUTO1bG5DvGdgctbtMVf2fmmUb+C952zqMj6a8ZI/w9jAUFJbJzLeW2jw3RxzzUC3IPT2Et+xXLRCTvSZTNCAnMJr56AR6M0tdJOTboG94mKTAbqg==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3640.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a98f7d-cda5-4958-440a-08d83d381ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2020 14:17:28.2342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WfPDJxZ5GRNwL1HajA3Kwvc7oVkA+bGUauFf68J1aNpBHJ9tu3orizmU8BNlQ+YQ101lO9SfcbGcEJAbTM70StW6GzwffN2AUDQLBQ7tGAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAgQXVndXN0IDIwMjAgMDU6MzQsIE1pY2hhxYIgTWlyb3PFgmF3IHdyb3RlOg0KDQo+IHJl
Z3VsYXRvcl9ub3RpZmllcl9jYWxsX2NoYWluKCkgZG9lc24ndCBuZWVkIHJkZXYgbG9jayBhbmQg
cmRldidzDQo+IGV4aXN0ZW5jZSBpcyBhc3N1bWVkIGluIHRoZSBjb2RlIGFueXdheS4gUmVtb3Zl
IHRoZSBsb2NrcyBmcm9tIGRyaXZlcnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYcWCIE1p
cm9zxYJhdyA8bWlycS1saW51eEByZXJlLnFtcW0ucGw+DQoNCkZvciBkYTkqLXJlZ3VsYXRvci5j
LCBwdjg4Ki1yZWd1bGF0b3IuYyBhbmQgc2xnNTEwMDAtcmVndWxhdG9yLmM6DQoNCkFja2VkLWJ5
OiBBZGFtIFRob21zb24gPEFkYW0uVGhvbXNvbi5PcGVuc291cmNlQGRpYXNlbWkuY29tPg0KDQo+
IC0tLQ0KPiAgZHJpdmVycy9yZWd1bGF0b3IvZGE5MDU1LXJlZ3VsYXRvci5jICAgfCAgMiAtLQ0K
PiAgZHJpdmVycy9yZWd1bGF0b3IvZGE5MDYyLXJlZ3VsYXRvci5jICAgfCAgMiAtLQ0KPiAgZHJp
dmVycy9yZWd1bGF0b3IvZGE5MDYzLXJlZ3VsYXRvci5jICAgfCAgMiAtLQ0KPiAgZHJpdmVycy9y
ZWd1bGF0b3IvZGE5MjEwLXJlZ3VsYXRvci5jICAgfCAgNCAtLS0tDQo+ICBkcml2ZXJzL3JlZ3Vs
YXRvci9kYTkyMTEtcmVndWxhdG9yLmMgICB8ICA0IC0tLS0NCj4gIGRyaXZlcnMvcmVndWxhdG9y
L2xwODc1NS5jICAgICAgICAgICAgIHwgIDYgLS0tLS0tDQo+ICBkcml2ZXJzL3JlZ3VsYXRvci9s
dGMzNTg5LmMgICAgICAgICAgICB8IDEwICsrLS0tLS0tLS0NCj4gIGRyaXZlcnMvcmVndWxhdG9y
L2x0YzM2NzYuYyAgICAgICAgICAgIHwgMTAgKystLS0tLS0tLQ0KPiAgZHJpdmVycy9yZWd1bGF0
b3IvcHY4ODA2MC1yZWd1bGF0b3IuYyAgfCAxMCArKy0tLS0tLS0tDQo+ICBkcml2ZXJzL3JlZ3Vs
YXRvci9wdjg4MDgwLXJlZ3VsYXRvci5jICB8IDEwICsrLS0tLS0tLS0NCj4gIGRyaXZlcnMvcmVn
dWxhdG9yL3B2ODgwOTAtcmVndWxhdG9yLmMgIHwgMTAgKystLS0tLS0tLQ0KPiAgZHJpdmVycy9y
ZWd1bGF0b3Ivc2xnNTEwMDAtcmVndWxhdG9yLmMgfCAgNCAtLS0tDQo+ICBkcml2ZXJzL3JlZ3Vs
YXRvci9zdHBtaWMxX3JlZ3VsYXRvci5jICB8ICA0IC0tLS0NCj4gIGRyaXZlcnMvcmVndWxhdG9y
L3dtODMxeC1kY2RjLmMgICAgICAgIHwgIDQgLS0tLQ0KPiAgZHJpdmVycy9yZWd1bGF0b3Ivd204
MzF4LWlzaW5rLmMgICAgICAgfCAgMiAtLQ0KPiAgZHJpdmVycy9yZWd1bGF0b3Ivd204MzF4LWxk
by5jICAgICAgICAgfCAgMiAtLQ0KPiAgZHJpdmVycy9yZWd1bGF0b3Ivd204MzUwLXJlZ3VsYXRv
ci5jICAgfCAgMiAtLQ0KPiAgMTcgZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNzgg
ZGVsZXRpb25zKC0pDQo=
