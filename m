Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6ECEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881C620888
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="G926+f3S";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="R6WXlFQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgESVgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:36:19 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:47560 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726203AbgESVgT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:36:19 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 391B940194;
        Tue, 19 May 2020 21:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1589924178; bh=apG4KoxxqfOl2O88FduSygaNSWnEvpmDhGRAoxSRjJs=;
        h=From:To:CC:Subject:Date:From;
        b=G926+f3STPUS7P7ntzz0wSdqgjggAtGG+H7iCO/CMi4jb3V587egUmmaXrArQY5cN
         NAc8spj4ISZREH+5AyKsQSVAmj0hwE79NtvY7yNGzebZ/bxfDKQA8tMTIs3jWm3cRW
         LPiGAwU5m/EBxAYtxUf6a9ZareCPv8cdYiCeRyUb8ISplL/xNnEusxL5PRDxruERCu
         inAwj+wBQImLzNdgkueHk/Q/9jplIF26iD2TNrt3Ez2GePCgV46Kkwl2n4etK6ywNc
         M/J/y015quRPViv4ZG+5o0E/oarmLTuOrCF4KiW7TLrX5+er5eB4j0P3qNcrdttRsQ
         cIw52w+ZQGkRw==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 22B1DA0071;
        Tue, 19 May 2020 21:36:16 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 19 May 2020 14:36:16 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.487.0; Tue, 19 May 2020 14:36:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR0K/CPqjg8BQmtEH9fT1AvoVJ+wYzus6Lb4CppVfQ1kbbPWNsfz5mNE3FTfAiCcjTtJKaPi//jZAIJ1p+d6wdXelVtSvASzF8k1nC0CtcmeLrU+S0xFIkzGjXu6jjQ5Kud3H50K4x0fet7TLw04XBLBGd6UmU3PKGR0Rddwzi41uV7nKIa+4XVP0jrw1WjwVvUl9xLf7ywI7/YmBwr/G8WQIzVLVo5eR8rC7NDv2vvG5fmRYlPuakSJBp09nAiknuxwXV691eTiUWu8Sn3EHPBwM+dJwLxHrcmOlFM9TmXVh6Cc5lGTKW13bjo0pgjk6uFrlaP7vn3bRhge+BudNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apG4KoxxqfOl2O88FduSygaNSWnEvpmDhGRAoxSRjJs=;
 b=WeDVjti9Z3wq8z8XWuH0Bx7VRPjfEPpzIyhMc1woPScmCmSWdDIZjVi4bGiGJPFsJiDtsglKv2lhZ6kSSIwSLxL8Dimwi8DXHFLL5cyh6hzObIzZQ0crRe7fctOde9PRh8oWEJjLweqAiuUqNjitCAfHZxSCVGgTDbD/vDPa36+6zfdCp5cmlt9UUtnaJZJeNbsVxeRcJ9Af/revqh4WDMCBOGH6omXLBRthstQEwrpZWobkvkkCxVq7LY6AZOaWWTME16vSm6Tgtqnfb0m45S9ylRfwCi/v1vttpzjk4SsH44NzT8hA54+44DIIVzpAT6w8nbWBCChpkyoBbiampg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=apG4KoxxqfOl2O88FduSygaNSWnEvpmDhGRAoxSRjJs=;
 b=R6WXlFQ/MFvO+PWc/54ox6OizdneLY3U8ae/rT5OUCuEroGt93PueUFA3ZjbQTUtVIa0IDTK9L0X1Yi3b00HY4XSYIA1UubzEUO/9uuV4tYSv6QLco/SrMBbJQ+mUAEsUShFO2AYT+DI968bLEbynqJv2BrNNpFvpDq2XVygFHY=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3046.namprd12.prod.outlook.com (2603:10b6:a03:aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Tue, 19 May
 2020 21:36:13 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af%6]) with mapi id 15.20.3000.034; Tue, 19 May 2020
 21:36:13 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     lkml <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [GIT PULL] ARC fixes for 5.7
Thread-Topic: [GIT PULL] ARC fixes for 5.7
Thread-Index: AQHWLiWEc55Jt/2y8UGB2/VlPfwYEw==
Date:   Tue, 19 May 2020 21:36:13 +0000
Message-ID: <249e6795-1eef-60b8-807c-e2385a62818a@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=synopsys.com;
x-originating-ip: [73.222.250.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e8f42b20-163c-4c5e-3b63-08d7fc3ca7b5
x-ms-traffictypediagnostic: BYAPR12MB3046:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB304682CDC66A64A8A4E41A4FB6B90@BYAPR12MB3046.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2276;
x-forefront-prvs: 040866B734
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q3megv2TUf8+SPXSNvzmGBjTeqYObmvGuQj7X9ifr8lgemzH6l8XGZ/BLL9Qi31quI13ohk/LY0Ivy4aR93atMhYf3uX+gP6PUsUXUUQUTUJshOZNCTewBf9FFxj/2mmDbA8k1hhVBTTSglBx1G3Qi0d3Phht5Mj6WOSXKiESmFUIGiXDrrnXYY9krldV90cfRQxn9wHEHLSkJvyTzJVLJlXmAVC0JsqKlYQGYh1FnpaXdzSwQ8ryTFRieexGj4MYsBH0VXSc/Jbyr57OJ7rJseUbs3IgHSUyO17PjbhZMqyHwVKA+bOSar8dU5ENbl/MxF5nW+5s0PVd0KJwsCzLJ+P932AsDnqe/NU9pxcALy49rqqG2y17AxwnH5yJ+h2vAEWmQXa4skFMTxGLxRkd4zGyPxt7DjZ7BBJAhJoCS3MxPLTpTiFeQMpQW+SjChSEZPpJq6/1sm52M03A7FDpPCCadg8W3Beudl4t9Q9gPV7hF4+ye/zYH5UhLQB6875
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(136003)(366004)(39860400002)(396003)(36756003)(5660300002)(4326008)(86362001)(31696002)(6486002)(316002)(8936002)(186003)(31686004)(6916009)(54906003)(26005)(8676002)(6512007)(6506007)(71200400001)(2616005)(107886003)(2906002)(66556008)(66476007)(66946007)(76116006)(66446008)(478600001)(64756008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: h8x+K0rhjEve4/hNFsK+2vd2fTsJU+mvFCwI/WdeeguhVJRYfoebpDEPmCGIKYbEBfKmLG2W3eQiBZE+gKdHc3l+gWfAbNX2yeEoAFsjUrwKmsXCcEiKg0fAX0Fxo1fSE1K2AV/J6UTdHyYaH/Hwi6v4Xz4T4kFhn13ZxjK4qSYqwg7t3NpdZ0PQRVGxN4izdlZhqlt5gSJKVA8qGCUFkph6MMTjVdBk8q5x9aH14UiIppi2MFZLxsaEO2Q4tfPVmMU1zzvoQrpsIvqXd9FS/RquCql/2gCOxowk8INmwnJvTozxY4nlNgOu08uRiP/zHlC8QjhXVKQEYTJXWI9ogby2r92N96tNn5Y8NBR/9lnVlfBVByDKvnR8mfsKtA6xjqBEJD2rC1m7V0DcTZNVBXQnjH+DHvZP7qfM75j8efQQohmVfMXhtllF+pdRwkVPdhYp0ZKGykCxmYyYyj271AQK4BghUwp/++e/hQdqN5A=
Content-Type: text/plain; charset="utf-8"
Content-ID: <777AA75FBA7221449D32E0A3F36616B6@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f42b20-163c-4c5e-3b63-08d7fc3ca7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2020 21:36:13.5855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: no4CK9p0xVFwy1quUZSBSH7mRWoptWsI4AIqfHnC0O19oUMlfJRxAX7ajh4gYnaYEbvPGq8F23An/NAWvMA/yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3046
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNClBsZWFzZSBwdWxsIHRoZSBhc3NvcnRlZCBBUkMgZml4ZXMgZm9yIDUuNy4N
Cg0KVGh4LA0KLVZpbmVldA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0+DQpUaGUgZm9s
bG93aW5nIGNoYW5nZXMgc2luY2UgY29tbWl0IDhmM2Q5ZjM1NDI4Njc0NWM3NTEzNzRmNWYxZmNh
ZmVlNmIzZjMxMzY6DQoNCiAgTGludXggNS43LXJjMSAoMjAyMC0wNC0xMiAxMjozNTo1NSAtMDcw
MCkNCg0KYXJlIGF2YWlsYWJsZSBpbiB0aGUgR2l0IHJlcG9zaXRvcnkgYXQ6DQoNCiAgZ2l0Oi8v
Z2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3ZndXB0YS9hcmMuZ2l0LyB0
YWdzL2FyYy01LjctcmM3DQoNCmZvciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byA3OTE1NTAy
Mzc3YzU0YzlmNThmNmFjNTM3YmRlMGMyYzM0MmE2NzQyOg0KDQogIEFSQzogc2hvd19yZWdzOiBh
dm9pZCBleHRyYSBsaW5lIG9mIG91dHB1dCAoMjAyMC0wNS0xNCAxNTowNTowMCAtMDcwMCkNCg0K
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KQVJDIGZpeGVzIGZvciA1LjcNCg0KIC0gUmVjZW50IERTUCBjb2RlIHJlZ3Jlc3Np
bmcgQVJDNzAwIHBsYXRmb3Jtcw0KDQogLSBUaGlua29zIGluIElDQ00vRENDTSBzaXplIGNoZWNr
cw0KDQogLSBVU0IgcmVncmVzc2lvbg0KDQogLSBvdGhlciBzbWFsbCBmaXhlcyBoZXJlIGFuZCB0
aGVyZQ0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQpFdWdlbml5IFBhbHRzZXYgKDMpOg0KICAgICAgQVJDOiBGaXggSUND
TSAmIERDQ00gcnVudGltZSBzaXplIGNoZWNrcw0KICAgICAgQVJDOiBbcGxhdC1oc2RrXTogZml4
IFVTQiByZWdyZXNzaW9uDQogICAgICBBUkM6IGd1YXJkIGRzcCBlYXJseSBpbml0IGFnYWluc3Qg
bm9uIEFSQ3YyDQoNCk1hc2FoaXJvIFlhbWFkYSAoMik6DQogICAgICBhcmM6IHB0cmFjZTogaGFy
ZC1jb2RlICJhcmMiIGluc3RlYWQgb2YgVVRTX01BQ0hJTkUNCiAgICAgIGFyYzogcmVtb3ZlICNp
Zm5kZWYgQ09ORklHX0FTX0NGSV9TSUdOQUxfRlJBTUUNCg0KVmluZWV0IEd1cHRhICgzKToNCiAg
ICAgIEFSQzogZW50cnk6IGNvbW1lbnQNCiAgICAgIEFSQzogW3BsYXQtZXpucHNdOiBSZXN0cmlj
dCB0byBDT05GSUdfSVNBX0FSQ09NUEFDVA0KICAgICAgQVJDOiBzaG93X3JlZ3M6IGF2b2lkIGV4
dHJhIGxpbmUgb2Ygb3V0cHV0DQoNCiBhcmNoL2FyYy9jb25maWdzL2hzZGtfZGVmY29uZmlnICAg
IHwgIDEgKw0KIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2RzcC1pbXBsLmggICAgfCAgMiArKw0KIGFy
Y2gvYXJjL2luY2x1ZGUvYXNtL2VudHJ5LWFyY3YyLmggfCAgMiArKw0KIGFyY2gvYXJjL2tlcm5l
bC9NYWtlZmlsZSAgICAgICAgICAgfCAgMyAtLS0NCiBhcmNoL2FyYy9rZXJuZWwvcHRyYWNlLmMg
ICAgICAgICAgIHwgIDIgKy0NCiBhcmNoL2FyYy9rZXJuZWwvc2V0dXAuYyAgICAgICAgICAgIHwg
IDUgKysrLS0NCiBhcmNoL2FyYy9rZXJuZWwvdHJvdWJsZXNob290LmMgICAgIHwgMTQgKysrKysr
LS0tLS0tLS0NCiBhcmNoL2FyYy9rZXJuZWwvdW53aW5kLmMgICAgICAgICAgIHwgIDIgLS0NCiBh
cmNoL2FyYy9wbGF0LWV6bnBzL0tjb25maWcgICAgICAgIHwgIDEgKw0KIDkgZmlsZXMgY2hhbmdl
ZCwgMTYgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo=
