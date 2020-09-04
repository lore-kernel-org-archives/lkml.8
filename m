Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A1CC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 00:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A806120709
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 00:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="igHu7XlL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jQxb2PCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgIDArk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:47:40 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:54182 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726397AbgIDArh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 20:47:37 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 99259C00CC;
        Fri,  4 Sep 2020 00:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1599180456; bh=uI5J01GMjQO8pMsiUQOFpfLCfudKSBz5pw0lNTPAVRo=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=igHu7XlLnbwn1MpGaLztTcmnlvznVSuO0sQc6q/Pu2BMmppp0i+UaXhN3G9R3GFZ+
         cxdEOBTd7w4r67oxqn8lPFUUzJ81E6EqwF7wz9GCLsND1eXgweNWUGnTVQOfmZV+Cn
         kV2WVDKcr8hjphWxg58ZO3UTwvc2vwr9W6eaw5oJJ3u2lwhAM0nt6KmM2q0BYnZ5iX
         /wNf+p9r4cnWBM3F31Au2fESqD7rqKUKeUXb3Of1W5Iw9WIxUVes2VIXaQyp45EQfn
         raH1SGsoz+8HR0ni6j609i4seCvNHnx9J7O91CSYlJ9CoyghNGvKGUz1iW9+kxqEE3
         6hTNmV89ddYjg==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5FE4BA006E;
        Fri,  4 Sep 2020 00:47:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B1E628000A;
        Fri,  4 Sep 2020 00:47:32 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="jQxb2PCN";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WViaW3GwEbtUrtIzoMReZbJZgLTsp6LkLgOGgTx27+otE5YLbGgaESlsBT4wonmMPu/a13zvk2gJXGVT42C3lwzHpIsTJ6mlEm2rGNMVrNfGF3EedOBAVKPiHo+W8PgGEConRN7VZSmsEp/9zdIkKL9XKv6OtAzFUf4TPzn27i+vtRS7hFXDk+oZ4YaCaPEqnzrt8/S+gMJlUuntJDZGvCYWXmd7e3+j/Mglyj73XaTH0p5XBErgYFSZstedFy0dnlXVIrCAA4bn4KX3bXhcfT3f2jF7bSOOw+yZlOomh4Rj5J4ZawdkjgIK6WkfEQyOnAowMq4I5X+2QdRHPKC4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI5J01GMjQO8pMsiUQOFpfLCfudKSBz5pw0lNTPAVRo=;
 b=V9ByYWH6SbNYXtJveaTcU0Z73DpWrsOSIr2tBUVEvstypAOT5VjKPbat7OYjYPfLqwMEQVdkJAJvs9sFP1/k9ijLMAi4SHQHTSg159aX20nCaJBtSpaCaflOfHi7yVrCgXe2wxGV5gwhZIwADvhM0GMJGYfC6OWaNo41ga46z9kX7/gnDtADeXW+P9vqYy6btfCuNTe27OKxDExNhioMjbHGWRzrlmy3OmKNnLAbM9HgTAcSaCdevj38q0sNkD5PgJYsvHWz68ja762lhycRO8JEGh5Uap7mvnhB9ZW2Ya9Uv9CK4/LI7U3/kROV5MnXWRG+qw4ecufrqrAwUuFq6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uI5J01GMjQO8pMsiUQOFpfLCfudKSBz5pw0lNTPAVRo=;
 b=jQxb2PCNicxjf4SIeHu/OfoWeXxi3yb+RLM69+1x3pZo86a3Jpv3mEM/nqV/f/YZ0zx73pWiG7u05gU3Lm4df75U7vUfHB4CeyUyJGzx9cHGMus8svY90lO7UmJK9yz4gtuxmUktpC5DGbN8kDeT75M22Emia1NAnqRPNepFlaY=
Received: from BYAPR12MB2917.namprd12.prod.outlook.com (2603:10b6:a03:130::14)
 by BYAPR12MB3288.namprd12.prod.outlook.com (2603:10b6:a03:130::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Fri, 4 Sep
 2020 00:47:29 +0000
Received: from BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c98f:a13f:fd88:c209]) by BYAPR12MB2917.namprd12.prod.outlook.com
 ([fe80::c98f:a13f:fd88:c209%7]) with mapi id 15.20.3348.015; Fri, 4 Sep 2020
 00:47:29 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "jackp@codeaurora.org" <jackp@codeaurora.org>
Subject: Re: [PATCH v3] usb: dwc3: Stop active transfers before halting the
 controller
Thread-Topic: [PATCH v3] usb: dwc3: Stop active transfers before halting the
 controller
Thread-Index: AQHWgjaiLW2EE8lR5kGO8l+SmwKig6lXpX8A
Date:   Fri, 4 Sep 2020 00:47:29 +0000
Message-ID: <f42dd74b-979c-85e4-bc73-0d0834fb4e38@synopsys.com>
References: <20200903210954.24504-1-wcheng@codeaurora.org>
In-Reply-To: <20200903210954.24504-1-wcheng@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
authentication-results: codeaurora.org; dkim=none (message not signed)
 header.d=none;codeaurora.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [98.248.94.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dd6c937-0738-4385-dee5-08d8506c1a27
x-ms-traffictypediagnostic: BYAPR12MB3288:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3288AE95E475CADC0F737803AA2D0@BYAPR12MB3288.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /udq2Q2sJo40tAomM6fSCg4AafrHPK5x3QzYT+GVgsOusS549g2OIB0iKQYokV9RICMwPb32e0aXdaY73Xmz3ThJshiQgk1MjZvv1PfoCP9v1RU8gjDm3E9stkfuM3UaN0ws8OV3Ewh0tNNlAWetburBg7wUnqpR/z/RbMaCeJL6e4dsfcM5FVskguA9QBw6v3xNyZfMnctq6cqGVXS42dMbRGwzQNmeVp5niBGXR4UBgsv6+Uj9xhCDMG/rXyf1QiUKqHKBusBvYZxdPFubWib2VziycqeHjp2gz8DFOgueCPOKjsDXy3QA7SAhqL1v7RICEA74YChtF5wqT/iRlpDeA6PJtMESWAzCnBSvlDzD+Ybhu5SjJ0E5SQcNuPMM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2917.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(346002)(39860400002)(186003)(316002)(26005)(31686004)(6506007)(31696002)(71200400001)(66556008)(4326008)(86362001)(5660300002)(36756003)(76116006)(66946007)(66476007)(478600001)(2906002)(83380400001)(2616005)(110136005)(54906003)(6486002)(8936002)(8676002)(6512007)(64756008)(66446008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5tVMOxkJwbcJYUeh6TKdgZm8VHwmjRtkd3MoNbRIYfYSC8vTOII0GCr5NkW+3MYitNOy3OE5XlneCpSLQfkKeA73VR2DwOj/ovntDhhxKFZtk3x9UQP7mrRD5Yks4MvnI1iyzpCHpPsvaEcNUp2+bX9TmCxY8zon+MgDBBLDmsssMBXay/BPxAGgB7AyNdnLr8D+pBSql4H50Hbdew3Q+xz172VixQQqjmofKkZb7dS0GyVSM0DY41MrZS2KT/mTi/n7028sCZZJVupTHoGeEzXZZfh0AAcbk2cb9cBL393E0oPm/SPH1vbMhsrw/2ZMolRl4ARy5rHrfnZH3TX6vbPmx3zVoeu7W8BNtcJAcFCAfYhn7ZIy8YPTlVI/Wv9OwkIA/fXvbCk6XJEAQSSPATcrNz1wPHXRlwKBzyZ4HGXHPalAVd4S9psrdBoXLZOi9Q7BXAbSi7BpECk6nVdYB8SeKaKwrEsEYEkzavOzI/M2M78jbtX9yKz/br8giNZzxqtLRgLL/rdGi5STHq3xtKmsieorYszwp4DvGyW9b25jkvEkfwLmJzUGffThnuWu8aDXSFWoLzAwGKorcLw5+08eKnm+Bi7HM7vYBxDSYYeNgS+YnEjHekI0rQs7AWKjHjyHGuGcu9AIk9qn69vLCg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8FC1A90424EFED4EB1BE7444DD6A6BBC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2917.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd6c937-0738-4385-dee5-08d8506c1a27
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 00:47:29.7346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tqLvgBB7B4FNzJJZaGqnb4Lb4+beKNwRUnQKqyKAYNL5WS9xOecgmg0uibkdr4EIQl1pT4bkhYPrLaGCEgl3fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3288
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBJbiB0aGUgRFdDMyBkYXRhYm9vaywgZm9yIGEgZGV2aWNl
IGluaXRpYXRlZCBkaXNjb25uZWN0IG9yIGJ1cyByZXNldCwgdGhlDQo+IGRyaXZlciBpcyByZXF1
aXJlZCB0byBzZW5kIGRlcGVuZHhmZXIgY29tbWFuZHMgZm9yIGFueSBwZW5kaW5nIHRyYW5zZmVy
cy4NCj4gSW4gYWRkaXRpb24sIGJlZm9yZSB0aGUgY29udHJvbGxlciBjYW4gbW92ZSB0byB0aGUg
aGFsdGVkIHN0YXRlLCB0aGUgU1cNCj4gbmVlZHMgdG8gYWNrbm93bGVkZ2UgYW55IHBlbmRpbmcg
ZXZlbnRzLiAgSWYgdGhlIGNvbnRyb2xsZXIgaXMgbm90IGhhbHRlZA0KPiBwcm9wZXJseSwgdGhl
cmUgaXMgYSBjaGFuY2UgdGhlIGNvbnRyb2xsZXIgd2lsbCBjb250aW51ZSBhY2Nlc3Npbmcgc3Rh
bGUgb3INCj4gZnJlZWQgVFJCcyBhbmQgYnVmZmVycy4NCj4NCj4gU2lnbmVkLW9mZi1ieTogV2Vz
bGV5IENoZW5nIDx3Y2hlbmdAY29kZWF1cm9yYS5vcmc+DQo+DQo+IC0tLQ0KPiBDaGFuZ2VzIGlu
IHYzOg0KPiAgLSBSZW1vdmVkIERXQzNfRVBfRU5BQkxFRCBjaGVjayBmcm9tIGR3YzNfZ2FkZ2V0
X3N0b3BfYWN0aXZlX3RyYW5zZmVycygpDQo+ICAgIGFzIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNm
ZXIoKSBoYXMgYSBjaGVjayBhbHJlYWR5IGluIHBsYWNlLg0KPiAgLSBDYWxsaW5nIF9fZHdjM19n
YWRnZXRfc3RvcCgpIHdoaWNoIGVuc3VyZXMgdGhhdCBEV0MzIGludGVycnVwdCBldmVudHMNCj4g
ICAgYXJlIGNsZWFyZWQsIGFuZCBlcDAgZXBzIGFyZSBjbGVhcmVkIGZvciB0aGUgcHVsbHVwIGRp
c2FibGVkIGNhc2UuICBOb3QNCj4gICAgcmVxdWlyZWQgdG8gY2FsbCBfX2R3YzNfZ2FkZ2V0X3N0
YXJ0KCkgb24gcHVsbHVwIGVuYWJsZSwgYXMgdGhlDQo+ICAgIGNvbXBvc2l0ZSBkcml2ZXIgd2ls
bCBleGVjdXRlIHVkY19zdGFydCgpIGJlZm9yZSBjYWxsaW5nIHB1bGx1cCgpLg0KPg0KPiBDaGFu
Z2VzIGluIHYyOg0KPiAgLSBNb3ZlZCBjbGVhbnVwIGNvZGUgdG8gdGhlIHB1bGx1cCgpIEFQSSB0
byBkaWZmZXJlbnRpYXRlIGJldHdlZW4gZGV2aWNlDQo+ICAgIGRpc2Nvbm5lY3QgYW5kIGhpYmVy
bmF0aW9uLg0KPiAgLSBBZGRlZCBjbGVhbnVwIGNvZGUgdG8gdGhlIGJ1cyByZXNldCBjYXNlIGFz
IHdlbGwuDQo+ICAtIFZlcmlmaWVkIHRoZSBtb3ZlIHRvIHB1bGx1cCgpIGRpZCBub3QgcmVwcm9k
dWNlIHRoZSBwcm9ibGVuIHVzaW5nIHRoZQ0KPiAgICBzYW1lIHRlc3Qgc2VxdWVuY2UuDQo+DQo+
IFZlcmlmaWVkIGZpeCBieSBhZGRpbmcgYSBjaGVjayBmb3IgRVRJTUVET1VUIGR1cmluZyB0aGUg
cnVuIHN0b3AgY2FsbC4NCj4gU2hlbGwgc2NyaXB0IHdyaXRpbmcgdG8gdGhlIGNvbmZpZ2ZzIFVE
QyBmaWxlIHRvIHRyaWdnZXIgZGlzY29ubmVjdCBhbmQNCj4gY29ubmVjdC4gIEJhdGNoIHNjcmlw
dCB0byBoYXZlIFBDIGV4ZWN1dGUgZGF0YSB0cmFuc2ZlcnMgb3ZlciBhZGIgKGllIGFkYg0KPiBw
dXNoKSAgQWZ0ZXIgYSBmZXcgaXRlcmF0aW9ucywgd2UnZCBydW4gaW50byBhIHNjZW5hcmlvIHdo
ZXJlIHRoZQ0KPiBjb250cm9sbGVyIHdhc24ndCBoYWx0ZWQuICBXaXRoIHRoZSBmb2xsb3dpbmcg
Y2hhbmdlLCBubyBmYWlsZWQgaGFsdHMgYWZ0ZXINCj4gbWFueSBpdGVyYXRpb25zLg0KPiAtLS0N
Cj4gIGRyaXZlcnMvdXNiL2R3YzMvZXAwLmMgICAgfCAgMiArLQ0KPiAgZHJpdmVycy91c2IvZHdj
My9nYWRnZXQuYyB8IDQ5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9lcDAuYyBiL2RyaXZlcnMvdXNiL2R3YzMv
ZXAwLmMNCj4gaW5kZXggNTlmMmU4YzMxYmQxLi40NTZhYTg3ZTg3NzggMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4gKysrIGIvZHJpdmVycy91c2IvZHdjMy9lcDAuYw0K
PiBAQCAtMTk3LDcgKzE5Nyw3IEBAIGludCBkd2MzX2dhZGdldF9lcDBfcXVldWUoc3RydWN0IHVz
Yl9lcCAqZXAsIHN0cnVjdCB1c2JfcmVxdWVzdCAqcmVxdWVzdCwNCj4gIAlpbnQJCQkJcmV0Ow0K
PiAgDQo+ICAJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAtCWlmICgh
ZGVwLT5lbmRwb2ludC5kZXNjKSB7DQo+ICsJaWYgKCFkZXAtPmVuZHBvaW50LmRlc2MgfHwgIWR3
Yy0+cHVsbHVwc19jb25uZWN0ZWQpIHsNCj4gIAkJZGV2X2Vycihkd2MtPmRldiwgIiVzOiBjYW4n
dCBxdWV1ZSB0byBkaXNhYmxlZCBlbmRwb2ludFxuIiwNCj4gIAkJCQlkZXAtPm5hbWUpOw0KPiAg
CQlyZXQgPSAtRVNIVVRET1dOOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRn
ZXQuYyBiL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggM2FiNmYxMThjNTA4Li43
M2JkYTdlYWE3NzMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4g
KysrIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMTUxNiw3ICsxNTE2LDcgQEAg
c3RhdGljIGludCBfX2R3YzNfZ2FkZ2V0X2VwX3F1ZXVlKHN0cnVjdCBkd2MzX2VwICpkZXAsIHN0
cnVjdCBkd2MzX3JlcXVlc3QgKnJlcSkNCj4gIHsNCj4gIAlzdHJ1Y3QgZHdjMwkJKmR3YyA9IGRl
cC0+ZHdjOw0KPiAgDQo+IC0JaWYgKCFkZXAtPmVuZHBvaW50LmRlc2MpIHsNCj4gKwlpZiAoIWRl
cC0+ZW5kcG9pbnQuZGVzYyB8fCAhZHdjLT5wdWxsdXBzX2Nvbm5lY3RlZCkgew0KPiAgCQlkZXZf
ZXJyKGR3Yy0+ZGV2LCAiJXM6IGNhbid0IHF1ZXVlIHRvIGRpc2FibGVkIGVuZHBvaW50XG4iLA0K
PiAgCQkJCWRlcC0+bmFtZSk7DQo+ICAJCXJldHVybiAtRVNIVVRET1dOOw0KPiBAQCAtMTkyNiw2
ICsxOTI2LDIxIEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfc2V0X3NlbGZwb3dlcmVkKHN0cnVj
dCB1c2JfZ2FkZ2V0ICpnLA0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgdm9p
ZCBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVycyhzdHJ1Y3QgZHdjMyAqZHdjKQ0KPiArew0KPiAr
CXUzMiBlcG51bTsNCj4gKw0KPiArCWZvciAoZXBudW0gPSAyOyBlcG51bSA8IERXQzNfRU5EUE9J
TlRTX05VTTsgZXBudW0rKykgew0KPiArCQlzdHJ1Y3QgZHdjM19lcCAqZGVwOw0KPiArDQo+ICsJ
CWRlcCA9IGR3Yy0+ZXBzW2VwbnVtXTsNCj4gKwkJaWYgKCFkZXApDQo+ICsJCQljb250aW51ZTsN
Cj4gKw0KPiArCQlkd2MzX3JlbW92ZV9yZXF1ZXN0cyhkd2MsIGRlcCk7DQo+ICsJfQ0KPiArfQ0K
PiArDQo+ICBzdGF0aWMgaW50IGR3YzNfZ2FkZ2V0X3J1bl9zdG9wKHN0cnVjdCBkd2MzICpkd2Ms
IGludCBpc19vbiwgaW50IHN1c3BlbmQpDQo+ICB7DQo+ICAJdTMyCQkJcmVnOw0KPiBAQCAtMTk3
MSw2ICsxOTg2LDggQEAgc3RhdGljIGludCBkd2MzX2dhZGdldF9ydW5fc3RvcChzdHJ1Y3QgZHdj
MyAqZHdjLCBpbnQgaXNfb24sIGludCBzdXNwZW5kKQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAg
DQo+ICtzdGF0aWMgdm9pZCBfX2R3YzNfZ2FkZ2V0X3N0b3Aoc3RydWN0IGR3YzMgKmR3Yyk7DQo+
ICsNCj4gIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpn
LCBpbnQgaXNfb24pDQo+ICB7DQo+ICAJc3RydWN0IGR3YzMJCSpkd2MgPSBnYWRnZXRfdG9fZHdj
KGcpOw0KPiBAQCAtMTk5NCw5ICsyMDExLDM3IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfcHVs
bHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBpbnQgaXNfb24pDQo+ICAJCX0NCj4gIAl9DQo+ICAN
Cj4gKwkvKg0KPiArCSAqIFN5bmNocm9uaXplIGFuZCBkaXNhYmxlIGFueSBmdXJ0aGVyIGV2ZW50
IGhhbmRsaW5nIHdoaWxlIGNvbnRyb2xsZXINCj4gKwkgKiBpcyBiZWluZyBlbmFibGVkL2Rpc2Fi
bGVkLg0KPiArCSAqLw0KPiArCWRpc2FibGVfaXJxKGR3Yy0+aXJxX2dhZGdldCk7DQo+ICAJc3Bp
bl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiArDQo+ICsJLyogQ29udHJvbGxl
ciBpcyBub3QgaGFsdGVkIHVudGlsIHBlbmRpbmcgZXZlbnRzIGFyZSBhY2tub3dsZWRnZWQgKi8N
Cj4gKwlpZiAoIWlzX29uKSB7DQo+ICsJCXUzMiBjb3VudDsNCj4gKw0KPiArCQkvKg0KPiArCQkg
KiBUaGUgZGF0YWJvb2sgZXhwbGljaXRseSBtZW50aW9ucyBmb3IgYSBkZXZpY2UtaW5pdGlhdGVk
DQo+ICsJCSAqIGRpc2Nvbm5lY3Qgc2VxdWVuY2UsIHRoZSBTVyBuZWVkcyB0byBlbnN1cmUgdGhh
dCBpdCBlbmRzIGFueQ0KPiArCQkgKiBhY3RpdmUgdHJhbnNmZXJzLg0KPiArCQkgKi8NCj4gKwkJ
ZHdjM19zdG9wX2FjdGl2ZV90cmFuc2ZlcnMoZHdjKTsNCj4gKwkJX19kd2MzX2dhZGdldF9zdG9w
KGR3Yyk7DQo+ICsNCj4gKwkJY291bnQgPSBkd2MzX3JlYWRsKGR3Yy0+cmVncywgRFdDM19HRVZO
VENPVU5UKDApKTsNCj4gKwkJY291bnQgJj0gRFdDM19HRVZOVENPVU5UX01BU0s7DQo+ICsJCWlm
IChjb3VudCA+IDApIHsNCj4gKwkJCWR3YzNfd3JpdGVsKGR3Yy0+cmVncywgRFdDM19HRVZOVENP
VU5UKDApLCBjb3VudCk7DQo+ICsJCQlkd2MtPmV2X2J1Zi0+bHBvcyA9IChkd2MtPmV2X2J1Zi0+
bHBvcyArIGNvdW50KSAlDQo+ICsJCQkJCQlkd2MtPmV2X2J1Zi0+bGVuZ3RoOw0KPiArCQl9DQo+
ICsJfQ0KPiArDQo+ICAJcmV0ID0gZHdjM19nYWRnZXRfcnVuX3N0b3AoZHdjLCBpc19vbiwgZmFs
c2UpOw0KPiAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmR3Yy0+bG9jaywgZmxhZ3MpOw0KPiAr
CWVuYWJsZV9pcnEoZHdjLT5pcnFfZ2FkZ2V0KTsNCj4gIA0KPiAgCXJldHVybiByZXQ7DQo+ICB9
DQo+IEBAIC0zMTAwLDYgKzMxNDUsOCBAQCBzdGF0aWMgdm9pZCBkd2MzX2dhZGdldF9yZXNldF9p
bnRlcnJ1cHQoc3RydWN0IGR3YzMgKmR3YykNCj4gIAl9DQo+ICANCj4gIAlkd2MzX3Jlc2V0X2dh
ZGdldChkd2MpOw0KPiArCS8qIFN0b3AgYW55IGFjdGl2ZS9wZW5kaW5nIHRyYW5zZmVycyB3aGVu
IHJlY2VpdmluZyBidXMgcmVzZXQgKi8NCj4gKwlkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVycyhk
d2MpOw0KPiAgDQo+ICAJcmVnID0gZHdjM19yZWFkbChkd2MtPnJlZ3MsIERXQzNfRENUTCk7DQo+
ICAJcmVnICY9IH5EV0MzX0RDVExfVFNUQ1RSTF9NQVNLOw0KDQpMb29rcyBnb29kIHRvIG1lLg0K
DQpSZXZpZXdlZC1ieTogVGhpbmggTmd1eWVuIDx0aGluaG5Ac3lub3BzeXMuY29tPg0KDQpUaGFu
a3MsDQpUaGluaA0KDQo=
