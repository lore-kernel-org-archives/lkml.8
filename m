Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00831C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFF5620709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0K63WABI";
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="s/M64/S2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgEOPcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:32:39 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:52949 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgEOPci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:32:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589556757; x=1621092757;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3UGkU9INCpCs4uQqebf9qz73OWfkApNrjOXNQedkGro=;
  b=0K63WABIHYxljSoyN8HctjH8lbREY8CrdFLd6iOX25bv5v1iBMFiwlwo
   EKNQfo99it6ltTfbm/mNkWEW31OJg8GLFkVC7p/L4M2YKvIo7qWmtEgQn
   i3n4nfzEAX3TTO/2/5sE+2XAEQ7nFLXzm67akVsGygTrg0HuLajzReEJF
   bsn03omw94zpJ6EIY+1N3q+vwFaeqUhWynkUgZYnncGJKfvE2gpjD/ZmY
   IpsJe6RCJNjhThsLsXnxwnkW4SAnvKdEGg7jwgdh0KD3dqrHsGUEzJdXn
   2vXUsmiONAO/RExouStgshhdz/RdJfEkHUipcfGO3kaDg/URDUsOV1ta3
   Q==;
IronPort-SDR: 6OABlxZLjQvp90cmdYovqmAjXm+KhmVTaZY8cwEO01ojzylrJXp9wKYklwm4x5xb6LO3pgFGBW
 HWqyZI/wfycrWGpSyCSL/CkFF4AuNjx+1Dt+kU1xdCBGnd/xp0B9e+Bc0peFEtEJorhgDL5IKJ
 BVXfqzMYKNZwednIMGouVzl0HXgf75avFdbNgPXe6GmTCM0M5ja17G8i7OuKGS96d9yKcs0s9y
 xAGH5KkHkmZ5mwdK5I/KiVzwc5WRj2wKaczxK2gKy4N+IhEaFQCkGnS1PEJB+5kizbAa51aYKY
 dbA=
X-IronPort-AV: E=Sophos;i="5.73,395,1583218800"; 
   d="scan'208";a="79796117"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 May 2020 08:32:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 15 May 2020 08:32:36 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 15 May 2020 08:32:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxbYqqXbdOMNiu0eWWRgJtTBTLdk1b89MIELycwrEOw6zbEhfvZc+etBOIdTSN+Cm+qCOsmvVjLIXQtFwFb2tzm81Ojq7H0a8yN+g3lpNGiGb/z7s5XDOU+YUX0rgvFvriDVTWy7EeQB7r/7cm5TNpjHz4e1q0gHGuP/7Eh+ZaOSLWlDiBAV3eo2ZGhUPT//+JcrXL1tIffAYn0onGenAuUokR6tnplaOJKIbLMKr5OgLHEUjtDTNoDjOOA/HsG0ccbWiABKRcpL7yqKjqRNOMTyoLIiQ41Xh099i+PbdJFemf11Yl7wnaYCYMVlUNruDeWtOdvoCEaYPhbFzuQMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UGkU9INCpCs4uQqebf9qz73OWfkApNrjOXNQedkGro=;
 b=W4IDyjkxflUOfW1rppssJuBrYeemlH7PGaKUV2VlYZP0wGxvi4Psv+xweNM6Yfb061JAKtCjgSplq9EMdax4n16chjJvyOcTctP5wqeB4GR5Oq7KBFVs13kemWet6x7pLmw+J1168rlVp8HhIvdfPRFfJJZbrZHVeyAfPOpjgrIK3t+hyO19QI6JaKTlhK0SQQ1iZWGLfw9U2rbdi9otp3Pr4FJYVlG6TQXxsQyscJbHWzIAYD5/SddXNQudQfTLpLgHg1szqqgxnv5wVzpmCrCA2oY7MMPmRf6mr0Avannh+R4+Vi112BNGjZpXctWnLgJEqXIvT7DW18Em+Tw0Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3UGkU9INCpCs4uQqebf9qz73OWfkApNrjOXNQedkGro=;
 b=s/M64/S2YXNmDZKCjNJu2xw7pB0FVEXkLCLCrVbaugkHxSjVUHYeenBXIwJoVdphyd6R3yS25F8x9zMMtPboqOYvREaEKEoTnsbowvDYm1ZMo2Th86MY7e1ZeO/PiqJZPmByA9g3P1Dqm8l078xBc7b9gtK2wZVaRiTzIk69tRE=
Received: from DM6PR11MB3082.namprd11.prod.outlook.com (20.177.218.211) by
 DM6PR11MB2937.namprd11.prod.outlook.com (20.177.216.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20; Fri, 15 May 2020 15:32:34 +0000
Received: from DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::b1e1:1148:5130:3e7]) by DM6PR11MB3082.namprd11.prod.outlook.com
 ([fe80::b1e1:1148:5130:3e7%7]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 15:32:34 +0000
From:   <Cristian.Birsan@microchip.com>
To:     <alexandre.belloni@bootlin.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <Nicolas.Ferre@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] usb: gadget: udc: atmel: add usb device support
 for SAM9x60 SoC
Thread-Topic: [PATCH v2 0/7] usb: gadget: udc: atmel: add usb device support
 for SAM9x60 SoC
Thread-Index: AQHWKqpORdPADmPuukOtoWg9fqBzC6ipPl4AgAAIgwA=
Date:   Fri, 15 May 2020 15:32:34 +0000
Message-ID: <81193747-fbdb-4cab-40ad-6cf8af039d75@microchip.com>
References: <20200515111631.31210-1-cristian.birsan@microchip.com>
 <20200515150228.GW34497@piout.net>
In-Reply-To: <20200515150228.GW34497@piout.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: bootlin.com; dkim=none (message not signed)
 header.d=none;bootlin.com; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [2a02:2f01:5104:1a00:68a2:db0:4185:6bd8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bf5ba87d-44f7-4731-fe70-08d7f8e530da
x-ms-traffictypediagnostic: DM6PR11MB2937:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2937139FED33CC42E44831CCEFBD0@DM6PR11MB2937.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sjCcD5wDm8B3LOfylKtzGpOlUSQ2ppwOi8w6ePOe/Ok2WrDxrXIxwBj7nvlL2Nh5mA3IWBdoC+T0KeCWmTiKEuqyD0d24eDfNXU7+1rj7HecI23JwC8KWTrob2RRxxwgZVqgTYUVqBuxp0Gs/Rw33q4F1mqsO0XUezO/h1eimS/yV+bwvUbXbbSNGquUuVYrVjMN8yH4MkpU2dwEatS0w5KOGd+0qoemPHbdOn6SmrdsBFnSDtLshf6lCRUd2Dg9A7b2LIuf6fdRpNgL2msKVNHNIIZUKBp410JJX5xz0W6Y18ascPS4EA7jFidIuhO9l2we5HqPimDKbY4hYEItJh9Q+u7OZ7Qx5YNkjHRIbiZ8S7ba1UIOLSN2RZTCyFVK2X049Kn/BkjHK4Eljjc8wbezsE83GWZcio16i15VW6eZsroICk9OgzS01OLYstRM3TwAjLd2qPQguUyIXqcv6ERc7zaWasqiUOvLcTF7X5IcZ2zVpjnsYY0lEZFUW/MwrjP7wL9WFzW6UYthhSfFl0LgZh5PTcKAZOY4/AAyGSe7ECEq2t8CONX272cwj4bq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3082.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(366004)(136003)(39860400002)(396003)(6506007)(53546011)(316002)(186003)(5660300002)(6486002)(54906003)(6916009)(2616005)(71200400001)(36756003)(66476007)(8936002)(6512007)(478600001)(966005)(2906002)(66446008)(4326008)(64756008)(86362001)(91956017)(31696002)(8676002)(31686004)(66946007)(66556008)(76116006)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: MTdXHAYCg9WXm8sDXp4wuYRo1bRcqUCVkq1jnNtViHCxLVsJDXBxPohmT82lEU4RsNQHK3/9MlybUhLDDQRoIbbZSGpEe4sPRmAGE8VSViSrMypju5vzg8vu3G0e7PBbx8ZmCCg0yjIkUHB7zcEdgN/v4lzTOQQje+Nq72ECQVYAs9alNJGz39puJ+J794R9ML/1cNB2kViI9RyueeNIgYEukPtqInAj1mwXpmtpHo6/5BkUQZSNTsAPY+jq0qjIFBOxJe+rqVN08+Dcw+aAKJaInluSJlF6bYdAoTonynZmKMwbGJCeKSFCBeXWInB3MQ76pAV3r7IMABiXFWYM6wDu8BvVEvASoAN5F3RDumFvAghRqI5OlwjMA2b/8+s08tzx8Vf2nrkro5A1TaJ6nAuBPtjlv3vWUXbXpL+DUW99FyMGvr1VdQBa8sC3Oluwl9Te1fg4yW9YciGHFVOJ61FHn1gvRPcj2WdcjZTX/CJVVmRwBV2gNcX/zPPoTu7j7QHlg1wU6sMwVolYhhnJ1uDMRPY4FnZ157g1jF+njX51dMWV4xqXevIcFyYGcX5R
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C5EB83A57026C47B77A41B8570FA37E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bf5ba87d-44f7-4731-fe70-08d7f8e530da
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 15:32:34.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TFilvHvAIAKbkgL2/pXGFrjvRAwruHKajJjFLWzyltzeR/bucCBzO3JQITFCIXbyNUgaiQPoOwru5q5PSEafg3A64NnqRM90axP8k3AI4N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2937
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDUvMTUvMjAgNjowMiBQTSwgQWxleGFuZHJlIEJlbGxvbmkgd3JvdGU6DQo+IEVYVEVS
TkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3Mg
eW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gSGksDQo+IA0KPiBPbiAxNS8wNS8y
MDIwIDE0OjE2OjI0KzAzMDAsIGNyaXN0aWFuLmJpcnNhbkBtaWNyb2NoaXAuY29tIHdyb3RlOg0K
Pj4gRnJvbTogQ3Jpc3RpYW4gQmlyc2FuIDxjcmlzdGlhbi5iaXJzYW5AbWljcm9jaGlwLmNvbT4N
Cj4+DQo+PiBUaGlzIHBhdGNoIHNldCBhZGRzIHVzYiBkZXZpY2Ugc3VwcG9ydCBmb3IgU0FNOXg2
MCBTb0MuDQo+PiBUaGUgRFBSQU0gbWVtb3J5IGZvciB0aGUgVVNCIEhpZ2ggU3BlZWQgRGV2aWNl
IFBvcnQgKFVEUEhTKSBoYXJkd2FyZQ0KPj4gYmxvY2sgd2FzIGluY3JlYXNlZCBhbmQgdGhlIGFs
bG9jYXRpb24gbWV0aG9kIGlzIGNoYW5nZWQuIFRoaXMgcGF0Y2gNCj4+IHNlcmllcyBzaW1wbGlm
aWVzIHRoZSBlbmRwb2ludCBhbGxvY2F0aW9uIHNjaGVtZSB0byBhY29tb2RhdGUgdGhpcyBTb0MN
Cj4+IGFuZCB0aGUgb2xkIG9uZXMuDQo+Pg0KPj4gQ2hhbmdlcyBpbiB2MjoNCj4+IC0gZHJvcCB0
aGUgcGF0Y2ggdGhhdCBhZGRzIHJlZmVyZW5jZSB0byBwbWMgZm9yIHNhbTl4NjANCj4+IC0gdXNl
IGR0LWJpbmRpbmdzOiB1c2IgcHJlZml4DQo+PiAtIGVuYWJsZSB1c2IgZGV2aWNlIGluIGRldmlj
ZSB0cmVlDQo+Pg0KPj4gQ2xhdWRpdSBCZXpuZWEgKDEpOg0KPj4gICB1c2I6IGdhZGdldDogdWRj
OiBhdG1lbDogdXNlIG9mX2ZpbmRfbWF0Y2hpbmdfbm9kZV9hbmRfbWF0Y2gNCj4+DQo+PiBDcmlz
dGlhbiBCaXJzYW4gKDYpOg0KPj4gICBkdC1iaW5kaW5nczogdXNiOiBhdG1lbDogVXBkYXRlIERU
IGJpbmRpbmdzIGRvY3VtZW50YXRpb24gZm9yIHNhbTl4NjANCj4+ICAgdXNiOiBnYWRnZXQ6IHVk
YzogYXRtZWw6IHNpbXBsaWZ5IGVuZHBvaW50IGFsbG9jYXRpb24NCj4+ICAgdXNiOiBnYWRnZXQ6
IHVkYzogYXRtZWw6IHVzZSAxIGJhbmsgZW5kcG9pbnRzIGZvciBjb250cm9sIHRyYW5zZmVycw0K
Pj4gICB1c2I6IGdhZGdldDogdWRjOiBhdG1lbDogcmVuYW1lIGVycmF0YSBpbnRvIGNhcHMNCj4+
ICAgdXNiOiBnYWRnZXQ6IHVkYzogYXRtZWw6IHVwZGF0ZSBlbmRwb2ludCBhbGxvY2F0aW9uIGZv
ciBzYW05eDYwDQo+PiAgIEFSTTogZHRzOiBhdDkxOiBzYW05eDYwZWs6IGVuYWJsZSB1c2IgZGV2
aWNlDQo+IA0KPiBUaGlzIHNob3VsZCBwcm9iYWJseSBiZSByZWJhc2VkIG9uIHRvcCBvZg0KPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1hcm0ta2VybmVsLzIwMjAwNTA3MTU1NjUxLjEw
OTQxNDItMS1ncmVnb3J5LmNsZW1lbnRAYm9vdGxpbi5jb20vDQo+IHNvIHdlIGF2b2lkIGhhdmlu
ZyB0byBkZWZpbmUgdGhlIGVuZHBvaW50cyBpbiB0aGUgZGV2aWNlIHRyZWUgaW4gdGhlDQo+IGZp
cnN0IHBsYWNlLg0KDQpJIGtub3cgdGhlIHBhdGNoIHNlcmllcyBhbmQgSSBBY2stZWQgaXQgc29t
ZSB0aW1lIGFnby4gT24gdGhlIG90aGVyIGhhbmQsIGl0IHdhcyBub3QgYXBwbGllZCB5ZXQsDQpz
byB0byBiZSBjb25zaXN0ZW50IEkgY3JlYXRlZCB0aGlzIHNlcmllcyBiYXNlZCBvbiB3aGF0IGlz
IGFscmVhZHkgYXZhaWxhYmxlIG9uIHVzYi1uZXh0Lg0KRGVwZW5kaW5nIG9uIHdoaWNoIG9uZSBn
ZXRzIGFwcGxpZWQgZmlyc3QsIHRoZSBvdGhlciB3aWxsIG5lZWQgdG8gcmViYXNlLiBJIGhhdmUg
bm8gcHJvYmxlbSB3aXRoIHRoYXQuDQpUaGUgZW5kIGdvYWwgaXMgdG8gaGF2ZSBib3RoIG9mIHRo
ZW0uDQoNCkNyaXN0aWFuDQoNCj4gDQo+IC0tDQo+IEFsZXhhbmRyZSBCZWxsb25pLCBCb290bGlu
DQo+IEVtYmVkZGVkIExpbnV4IGFuZCBLZXJuZWwgZW5naW5lZXJpbmcNCj4gaHR0cHM6Ly9ib290
bGluLmNvbQ0KPiANCg==
