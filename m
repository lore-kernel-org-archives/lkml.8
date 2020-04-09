Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F12C2BBC7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65FC7212CC
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="bcuczVG0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="PiT1r0Xe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgDIIeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:34:46 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:38222 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgDIIeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:34:46 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9795FC0096;
        Thu,  9 Apr 2020 08:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1586421285; bh=aPvWWoQPPbWz3eEHamlJxtStGFNMMOx6llPM2vKOieY=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=bcuczVG0Q96JnmFO5qkI93IArA0p7h+lFFNjMUPS3wdXEct6qP3CS+m+nkSRKpSEk
         p+78ITtBGkqSyHblIYlFrmUxCCupc2PLNoceY92HBt+LPVK7vM397nUXjZyGYd3G+e
         tZDtzR/PJEitE1+IlXLiERH4CbXFYjkvv265s7XJgKesQKNfyIZWwUvlpEn5grVwjO
         hvHFU3JJALtwoTa/n5DVr3eeZnMzA5KrbJi5oYWZoTWQqVvyFJzueQAtrpiLBkli6m
         qjVYLsKATIUQh4tibPpp/+dm1i9+vPYO2nbEfOVzoT/HsOT3g/qF9jSgHa/sMkhTyf
         ampwTiy/dg9gg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id B1653A0085;
        Thu,  9 Apr 2020 08:34:43 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Thu, 9 Apr 2020 01:34:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Thu, 9 Apr 2020 01:34:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUdFS2h7KDzCvNZ8if+ajeuw2K7CjWHl6KyZKhqZQ/POVI7B/Rs8Ju3TydukVUNxyCZvSapwyogsDo2wiBlxLuuVpL1AkeyqtscCC2Wa2oQsm9gMJ00JeeJ4v2f3yhM9fimyqwU84W6ixhgMsupHoX8222un0T/+3MbCzx8Oc3KRpnhC/INjTfWMbDmc6wSbHVWkydGsLxiFc5KBrGW6pEjpcHi1D2dh9rsLbFxcSaa/3SLhOQlIF7g/X+E5Oxms9w3oyMokknfJQlz5dg+QjXS8uoAYcmN+s3B/2w3DKGgBGPmsftPKMn4e+04B7a4vwYaKuGw4RkEWnsFMsKdpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPvWWoQPPbWz3eEHamlJxtStGFNMMOx6llPM2vKOieY=;
 b=cwaDgKgdz6/L+5nVfBazAnPGpdQrA/RuWIteQInHaJg8N/Kd1yNNQ4MQzxTijpWuUyXYq4lfdpowEIQo9Y1JcG4d86K9RFIOh+OO9KkBvPXN2YejPn8LY4NULvgUMzFMzcDk+eKShdIIWbWWM2COB/0st/tAap84O04DepTCY/dYBvN2Ce6+ACakehkc9rmSgNbBEgMlZZAeWMWhPzPFgEVqIhUgTYJhXXiYtOGFz9K48ozh3VDg0jWz0UHziQOn1VswA04ZGRwAN3I+RftciOzLANqR9YsHBESEwfvfXmvOIMjDKHLGJmeh77S7Pcvab88GhmBYE30Ut63ZGJ3eGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPvWWoQPPbWz3eEHamlJxtStGFNMMOx6llPM2vKOieY=;
 b=PiT1r0Xe9+NTSF43kMef5RNHAhLS3f2CjafbR8O7Pa0HuMBXPLVajpITDizacZFkIyTWXCr69EMF+F3OnjXWk1bF0K7xHbFGDWh0d6ZQOO6hl9CjAdxra+pKcP3MyK2sCjgqfmeZ4BLySmGB39zNn4ADGcT++zWwzWQJA4YQSTo=
Received: from SN1PR12MB2557.namprd12.prod.outlook.com (2603:10b6:802:22::15)
 by SN1PR12MB2477.namprd12.prod.outlook.com (2603:10b6:802:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 9 Apr
 2020 08:34:38 +0000
Received: from SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d]) by SN1PR12MB2557.namprd12.prod.outlook.com
 ([fe80::20d2:fe98:5580:932d%7]) with mapi id 15.20.2900.015; Thu, 9 Apr 2020
 08:34:38 +0000
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Nishad Kamdar <nishadkamdar@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Joe Perches <joe@perches.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: dwc2: Use the correct style for SPDX License
 Identifier
Thread-Topic: [PATCH] USB: dwc2: Use the correct style for SPDX License
 Identifier
Thread-Index: AQHWBOYaswZ3iHR0EUe/0qe1zJ1nB6hwiZuA
Date:   Thu, 9 Apr 2020 08:34:38 +0000
Message-ID: <878f972e-211d-f51d-66f9-5b12602f15c3@synopsys.com>
References: <20200328094828.GA5016@nishad>
In-Reply-To: <20200328094828.GA5016@nishad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=hminas@synopsys.com; 
x-originating-ip: [149.117.75.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd35d39f-c1e1-48ac-d10c-08d7dc60d75c
x-ms-traffictypediagnostic: SN1PR12MB2477:
x-microsoft-antispam-prvs: <SN1PR12MB2477B6A4450C74D395DA5444A7C10@SN1PR12MB2477.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2150;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(39860400002)(376002)(366004)(346002)(136003)(66446008)(26005)(66556008)(66946007)(2906002)(5660300002)(6512007)(53546011)(71200400001)(2616005)(478600001)(64756008)(966005)(110136005)(36756003)(6506007)(76116006)(186003)(8936002)(66476007)(6486002)(4326008)(81166007)(31696002)(86362001)(316002)(81156014)(54906003)(8676002)(31686004);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MTYRSa582XJ0W6g6ypteh21BaGtR8FIAp0XEFmXhmq7O0ZrHG4/Z5rQSvzwE+4HXgYO+cewoDC7rkS8cCV569RXjeEGWVm1+LTAbwiJASrFo4Iz0BDwPs7hDcYIUhrX56+r+t3vWPiPa0YWdmfjvm13RbgIw/NoA3VGT1+WXuae9LZHeMc6IfS2K/3IL1Wqz0D3csiMnnxToVHdDooFor+J+N95wWJ5Ghl/WnVDOAC80CS9tKraqncn8GLurba+Wn0ZbJn4ZE3qzx+4hAVfx5Cd5Otyb9czGVNpG63C12gUS8MWxOmjYgWFO2ardkgqGu2X7KYtDtSSNwPdIex/T2phpPw6S/nGPcGUaDv1mI8yFY3B+7GOFw6nm+ZwaZVMHaShacs8UI2f85l4XdLOHKQCeVQvSj8Y0Yhsf/CDdj9/WcTReHss8Op3vAL33GiHETmiRKCMKbMlO7iPC0fZejroM60YQVT6r09BNkvOYSfvRFTHafYyiLcSJvv2WFpeEaxVISyXeNOzAVz9wSIhBsQ==
x-ms-exchange-antispam-messagedata: 5xHnY+PP/kU5Ecrm2g+tN8pMuDQ1a0yzg3aaODJ5ZBMehjQxrTo+OurKAYpczUWiC8+u3YXtybRh9qWNhzWjUKxYPZMw40gZewkaylrLstDoW1rwb/0h2AZdGXidUjbWyubHuCh6jbEwdVjEZlzd3g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EB8F7C91304A944BFD73B28CD14C488@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bd35d39f-c1e1-48ac-d10c-08d7dc60d75c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 08:34:38.2860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9slbLqI5+C3mqjnPmem/roKBou61iO3Dyrp6XQd1sDCvnOfG2ta6qnJ/+v4AqUw1pBb5chdLwNjMPrnpUbZOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2477
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDMvMjgvMjAyMCAxOjQ4IFBNLCBOaXNoYWQgS2FtZGFyIHdyb3RlOg0KPiBUaGlzIHBh
dGNoIGNvcnJlY3RzIHRoZSBTUERYIExpY2Vuc2UgSWRlbnRpZmllciBzdHlsZSBpbg0KPiBoZWFk
ZXIgZmlsZXMgcmVsYXRlZCB0byBEZXNpZ25XYXJlIFVTQjIgRFJEIENvcmUgU3VwcG9ydC4NCj4g
Rm9yIEMgaGVhZGVyIGZpbGVzIERvY3VtZW50YXRpb24vcHJvY2Vzcy9saWNlbnNlLXJ1bGVzLnJz
dA0KPiBtYW5kYXRlcyBDLWxpa2UgY29tbWVudHMgKG9wcG9zZWQgdG8gQyBzb3VyY2UgZmlsZXMg
d2hlcmUNCj4gQysrIHN0eWxlIHNob3VsZCBiZSB1c2VkKS4NCj4gDQo+IENoYW5nZXMgbWFkZSBi
eSB1c2luZyBhIHNjcmlwdCBwcm92aWRlZCBieSBKb2UgUGVyY2hlcyBoZXJlOg0KPiBodHRwczov
L3VybGRlZmVuc2UucHJvb2Zwb2ludC5jb20vdjIvdXJsP3U9aHR0cHMtM0FfX2xrbWwub3JnX2xr
bWxfMjAxOV8yXzdfNDYmZD1Ed0lCQWcmYz1EUEw2X1hfNkprWEZ4N0FYV3FCMHRnJnI9Y1FCS3Q0
cS1xek5WQzUzck5Bd3V3cGxIMjNWNjFySFFoaFVMdmRMQTBVOCZtPTBqOU1zaWdMMngyQUtrOUhQ
Yk1DLWRJUmhmZTItVGVqbG5GaXlnLWhqTG8mcz1oa3ZPREYwLUJlbTVVRTIzM1FQOFBKOC1FMk5o
bk8za2REaTZldUtCSU1JJmU9IC4NCj4gDQo+IFN1Z2dlc3RlZC1ieTogSm9lIFBlcmNoZXMgPGpv
ZUBwZXJjaGVzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogTmlzaGFkIEthbWRhciA8bmlzaGFka2Ft
ZGFyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IE1pbmFzIEhhcnV0eXVueWFuIDxobWluYXNAc3lu
b3BzeXMuY29tPg0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvY29yZS5oICB8IDIgKy0N
Cj4gICBkcml2ZXJzL3VzYi9kd2MyL2RlYnVnLmggfCAyICstDQo+ICAgZHJpdmVycy91c2IvZHdj
Mi9oY2QuaCAgIHwgMiArLQ0KPiAgIGRyaXZlcnMvdXNiL2R3YzIvaHcuaCAgICB8IDIgKy0NCj4g
ICA0IGZpbGVzIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuaCBiL2RyaXZlcnMvdXNiL2R3YzIv
Y29yZS5oDQo+IGluZGV4IDk5YjBiZGZlMDAxMi4uNjY4ZDFhZDY0NmE0IDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MyL2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2NvcmUu
aA0KPiBAQCAtMSw0ICsxLDQgQEANCj4gLS8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BM
LTIuMCsgT1IgQlNELTMtQ2xhdXNlKQ0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wKyBPUiBCU0QtMy1DbGF1c2UpICovDQo+ICAgLyoNCj4gICAgKiBjb3JlLmggLSBEZXNp
Z25XYXJlIEhTIE9URyBDb250cm9sbGVyIGNvbW1vbiBkZWNsYXJhdGlvbnMNCj4gICAgKg0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMi9kZWJ1Zy5oIGIvZHJpdmVycy91c2IvZHdjMi9k
ZWJ1Zy5oDQo+IGluZGV4IGE4YzU2NWI2YmMzNC4uNDcyNTJjNTZkNDEwIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3VzYi9kd2MyL2RlYnVnLmgNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMi9kZWJ1
Zy5oDQo+IEBAIC0xLDQgKzEsNCBAQA0KPiAtLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQ
TC0yLjANCj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+ICAgLyoN
Cj4gICAgKiBkZWJ1Zy5oIC0gRGVzaWdud2FyZSBVU0IyIERSRCBjb250cm9sbGVyIGRlYnVnIGhl
YWRlcg0KPiAgICAqDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MyL2hjZC5oIGIvZHJp
dmVycy91c2IvZHdjMi9oY2QuaA0KPiBpbmRleCAxMjI0ZmE5ZGY2MDQuLmVhMDJlZTYzYWM2ZCAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9oY2QuaA0KPiArKysgYi9kcml2ZXJzL3Vz
Yi9kd2MyL2hjZC5oDQo+IEBAIC0xLDQgKzEsNCBAQA0KPiAtLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IChHUEwtMi4wKyBPUiBCU0QtMy1DbGF1c2UpDQo+ICsvKiBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjArIE9SIEJTRC0zLUNsYXVzZSkgKi8NCj4gICAvKg0KPiAgICAqIGhj
ZC5oIC0gRGVzaWduV2FyZSBIUyBPVEcgQ29udHJvbGxlciBob3N0LW1vZGUgZGVjbGFyYXRpb25z
DQo+ICAgICoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzIvaHcuaCBiL2RyaXZlcnMv
dXNiL2R3YzIvaHcuaA0KPiBpbmRleCBjNDAyN2JiY2VkZWMuLjg2NGI3NmEwYjk1NCAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9ody5oDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzIv
aHcuaA0KPiBAQCAtMSw0ICsxLDQgQEANCj4gLS8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAo
R1BMLTIuMCsgT1IgQlNELTMtQ2xhdXNlKQ0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IChHUEwtMi4wKyBPUiBCU0QtMy1DbGF1c2UpICovDQo+ICAgLyoNCj4gICAgKiBody5oIC0gRGVz
aWduV2FyZSBIUyBPVEcgQ29udHJvbGxlciBoYXJkd2FyZSBkZWZpbml0aW9ucw0KPiAgICAqDQo+
IA0K
