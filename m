Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9D3C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A84A920739
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="D66Yb8In";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.onmicrosoft.com header.i=@synopsys.onmicrosoft.com header.b="lZMBb4FC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgCKVKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:10:54 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:43622 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726684AbgCKVKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:10:54 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4C947C0F6D;
        Wed, 11 Mar 2020 21:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583961053; bh=WNC6DozOlP+L7U2CmsQjwoA4wovARtHTV7A5RcFjaks=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=D66Yb8InCdlmwWZXGUhyc3Tk/G4cI1sYjwmmcwnwuStUz1Ya7bfTYZmhyQ5uAhnf2
         e9Ym4w1X/lbR8YcyVpA7ABJsHCuRbtUAnLbYA6Z5xz5LxWa+CFEE8HGTFyeHcwuzfJ
         0fOcG3+1lxvyzyaJn6xpTFOKbeioGZ2fe2sRWAVvaVjkdKNL5h/zXuW00SlvE8KKE9
         UkwK/Ikgw8fxid9qbkkqMKDpBF7Ra6VS1g422uDYjLDuuRwBkRm0VsN1q4RS0nkkM7
         OYH5ORujOXEMiFMwz8mPaWXpjIugC2Bv3aV1ezVQRZvMe41+4N57ykrNSudVkTPbp/
         i37MCwMKY9wwg==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1ED54A0083;
        Wed, 11 Mar 2020 21:10:53 +0000 (UTC)
Received: from US01HYBRID2.internal.synopsys.com (10.15.246.24) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 11 Mar 2020 14:10:33 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.15.246.24) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Wed, 11 Mar 2020 14:10:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXtMeFdR8bam+Kz4uz+HowZIqyDRBiEPc4V1RcwLzvQZ6zw7XXgcmYCle2ZYebguRjnn1vQtMvvaL7uvq9DPMReY3siQPEmJoe/SxkMPK7gbSwsR3yCYEi2A6RrIguTiJB1Q0FS0W+CGNECFVrVbb9+HF5jrBZcXa4QqDpzjaAo13Njn72S7c2eNE7z5IXIx8tlTylwMqf3WcC2bLB1mILL6mh6Z/37ZZfFDbPtfkedifKdeAtRg6iM4sBKnWdHOV7p9Vp9/a8106KQLXxxVDUAgWy2hjBgScezV27zMG1ssWKuqY7TpCrIlLCYcXAKROe5zdc847Ow20Dm3V7fwqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNC6DozOlP+L7U2CmsQjwoA4wovARtHTV7A5RcFjaks=;
 b=h7WvhlyC/OlrxvtWxNol6PLYQzqhT8xEcb6ktRODaU/oSNl/hZ0whvrH7W7w7c09eOvGXEDh9RJfBr34sfwmckqibkL8GMGzZfurq0o5RLeiZTVZgQ9d9hP/4uVUlGnJXRPOytjDEM9tPZSJbAOMO0Tzlh55/gcAKoAHYVhok2myNmqILFCUnCXrIThaT1mcnI3WtATyOzPZogmJ1YpeTVJsIlbCdHa7mODY1XZH4cMF7mPLGmd8gAOgIvVhruUppPNTHlc/Sgj0c8r+YDz+aYDdGRExDPCrajxVBWucGtrzil3BQvTfb7zHd7XznZ7Z6m9VIXZEFRQGi4AgKDqdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=synopsys.onmicrosoft.com; s=selector2-synopsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNC6DozOlP+L7U2CmsQjwoA4wovARtHTV7A5RcFjaks=;
 b=lZMBb4FCE3QwjSjiufcho/ebE9sXNpqM3mWdKp2A+2lgspMI7AKkcr9lx8ebh3IEFhowdaC9YqO88HBfGDYhYiLzF1GZ407yNc+WKTn8SRbu6pQct/Y8AhGFxTGyJMNtpxHjjo0q/dT9UtKOBwrbEQZVdKWn9jdmV7C1kIxzA5o=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB2728.namprd12.prod.outlook.com (2603:10b6:a03:61::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.18; Wed, 11 Mar
 2020 21:10:32 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2793.013; Wed, 11 Mar 2020
 21:10:32 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH 2/2] ARC: don't align ret_from_exception function
Thread-Topic: [PATCH 2/2] ARC: don't align ret_from_exception function
Thread-Index: AQHV98Hv9KDgib9650awLwyjmkVe16hDqFKAgAA3uQCAAANwAA==
Date:   Wed, 11 Mar 2020 21:10:31 +0000
Message-ID: <a6728afe-10e4-ce85-b133-17395ac99b86@synopsys.com>
References: <20200311162644.7667-1-Eugeniy.Paltsev@synopsys.com>
 <20200311162644.7667-2-Eugeniy.Paltsev@synopsys.com>
 <448ba208-56a5-d8b2-9675-7be03b872c23@synopsys.com>
 <BY5PR12MB40348292DA303489C1DA2B66DEFC0@BY5PR12MB4034.namprd12.prod.outlook.com>
In-Reply-To: <BY5PR12MB40348292DA303489C1DA2B66DEFC0@BY5PR12MB4034.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [149.117.75.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e4f3352d-71f4-4786-504d-08d7c600a23c
x-ms-traffictypediagnostic: BYAPR12MB2728:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB2728AD3D2291780400279238B6FC0@BYAPR12MB2728.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0339F89554
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(376002)(396003)(366004)(346002)(136003)(199004)(64756008)(66476007)(66946007)(54906003)(8676002)(66446008)(66556008)(8936002)(81156014)(71200400001)(81166006)(316002)(186003)(53546011)(26005)(6506007)(110136005)(31686004)(76116006)(36756003)(4326008)(86362001)(2906002)(107886003)(6486002)(478600001)(2616005)(6512007)(31696002)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB2728;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1SEFvrW7yfsRk9wkDvsEayrPRstBECRZ0Jcjnd6C8iz9epnQkmdYTyp+VRL2kanKWG5STFvjGQYdR45uguhWrURUSeDVVSG5WGwcvqlNloCk1HtlnGEguqFXxkU7+vEI9fWJbDzQyhTgmWnKxigNaJqB8Wxo0mKLUBDWU3+kquN4lIESpnokXB2UYMTmsMwGQxJpfHEIm//3obxghHTmtJoLOMRiyA01lLq+YAoQ4Eay3kTo228vEKTfqW7BuNrxgnfpnbWJSqH/5x4VE+OWLuDWRZAO1FkBJvo7y6EAnw3e/DzbwGwb9Ck04r8qbVHDtri6mH3bbAOgSaXB1mQVIR7+GViZb7SdZJ7K/DLFnDp5tb6Srk4zbuAhMQNsyVTKlIItQWRVw91hA64mE1Tv7e6YE0rMgIHVgWSE40uJJOq9lgu48EQkvX6Yh27G1DKL
x-ms-exchange-antispam-messagedata: 3IRTVE5KjML6Ht5a5m2r/anIlYMp+EqaMwjxH6k+tAouotVjfGbQ7Ezx9dL6aPPqe16gS6ct0ZIpY2CkDh89PLifgqGCFGO8kpP6SY+ymND45k26W8FEwTzOvAeUGiPHZDU0ZcnfCc7z6ON9G9GqGg==
Content-Type: text/plain; charset="utf-8"
Content-ID: <175F414B7612564092E7BF61F1044787@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f3352d-71f4-4786-504d-08d7c600a23c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2020 21:10:31.8237
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoC2j7FYJ/QdsXZPOtVZ6wfVRPxL2Pdl5950dw2wPlcP4V0lkMhEM6n0scyh4gtE6GtYTJLFVgGdAgEgBrzB9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2728
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xMS8yMCAxOjU4IFBNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+Pg0KPj4gSSB3b3Vs
ZCBsaWtlIHRvIGtlZXAgaXQgYWxpZ25lZC4NCj4+DQo+PiBBUkM3MDAgZGVmaW5pdGVseSBoYXMg
cGVuYWx0eSBmb3IgdW5hbGlnbmVkIGJyYW5jaCB0YXJnZXRzLCBzbyBpdCB3aWxsIGRlZmluaXRl
bHkNCj4+IHN1ZmZlciB0aGVyZS4NCj4gDQo+IERvIHlvdSBrbm93IHNvbWUgZXhhY3QgbnVtYmVy
cz8gSSdtIG5vdCBhbiBleHBlcnQgaW4gQVJDNzAwIChmb3J0dW5hdGVseSA9KQ0KDQpJIGRvbid0
IHJlbWVtYmVyIHRoZSBleGFjdCBudW1iZXJzIGVpdGhlci4NCg0KPj4gRm9yIEhTLCB1bmFsaWdu
ZWQgYnJhbmNoIHRhcmdldHMgaGF2ZSBubyBwZW5hbHR5IChmb3IgdGhlIGdlbmVyYWwgY2FzZSBh
dGxlYXN0KSwNCj4+IGJ1dCBpZiBpdCBkb2VzIGdldCB1bmFsaWduZWQsIHRoZSBlbnRpcmUgZW50
cnkgcHJvbG9ndWUgY29kZSB3aWxsIGJlIC0gaS5lLiBlYWNoDQo+PiBvbmUgb2YgdGhlIHN1YnNl
cXVlbnQgMTMwIG9yIHNvIGluc3RydWN0aW9ucy4gVGhhdCBkb2Vzbid0IHNlZW0gbGlrZSBhIGdv
b2QgaWRlYQ0KPj4gaW4gZ2VuZXJhbCB0byBtZS4NCj4gDQo+IEkgcmVhbGx5IGRvbid0IGluc2lz
dCBhYm91dCBhcHBseWluZyB0aGlzIHBhdGNoIGJ1dCBJIGRvbid0IHVuZGVyc3RhbmQgeW91cg0K
PiBhcmd1bWVudGF0aW9uIGFib3V0IEFSQyBIUyBsaWtlIGF0IGFsbC4NCg0KSSBrbmV3IHlvdSB3
b3VsZCBhcmd1ZSBoZW5jZSBJIGFscmVhZHkgY29weS9wYXN0ZWQgdGhlIHN0YXJ0IGFuZCBlbmQg
b2YgdGhlDQplcGlsb2d1ZSBhbHJlYWR5IGluIG15IHByZXYgcmVwbHkgd2hpY2ggeW91IGRpZG4n
dCBjYXJlIHRvIHJlYWQgdGhydS4NCg0KSWYgeW91IHN0YXJ0IGNvdW50aW5nIGluc3RydWN0aW9u
cyBmcm9tIDxyZXRfZnJvbV9leGNlcHRpb24+IGFsbCB0aGUgd2F5IHRvIGVuZCBvZg0KPGRlYnVn
X21hcmtlcl9kcz4gdGhlcmUgYXJlIG92ZXIgMTMwIGluc3RydWN0aW9ucyBhbGwgb2Ygd2hpY2gg
Y2FuIGJlIHJlbmRlcmVkDQp1bmFsaWduZWQgYnkgeW91ciBwYXRjaC4gV2hhdCBpcyB3b3JzZSBp
cyB0aGF0IHRoaXMgd291bGQgYmUgdW5wcmVkaWN0YWJsZTogdGhlDQp1bmFsaWduZWQgY2FzZSB3
aWxsIG1vc3RseSBOT1QgaGFwcGVuLCBidXQgYSBuZXcgY29tcGlsZXIgb3Igc29tZSBzdWJ0bGUg
Y29kZQ0KY2hhbmdlIGNvdWxkIGNhdXNpbmcgcG90ZW50aWFsbHkgc2lkZS1lZmZlY3RzIHdlIHdv
bid0IGV2ZW4ga25vdyB3aGVyZSB0byBsb29rLg0KDQo+PiBJIGZha2VkIGl0IHVzaW5nIGEgbm9w
X3MgYW5kIHRoZSBTWU1fRlVOQ19TVEFSVF9OT0FMSUdOKCApIGFubm90YXRpb24gYW5kIGNhbiBz
ZWUNCj4+IGFsbCBpbnN0cnVjdGlvbnMgZ2V0dGluZyB1bmFsaWduZWQuDQo+IA0KPiBXaGF0IGlz
IHRoZSBwcm9ibGVtIHdpdGggaXQ/IEl0J3MgdG90YWxseSB2YWxpZCBhbmQgZmluZSBmb3IgQVJD
IEhTIHRvIGhhdmUgaW5zdHJ1Y3Rpb25zDQo+IGFsaWduZWQgYnkgMiBieXRlLiBPciBhcmUgeW91
IHRhbGtpbmcgYWJvdXQgQVJDNzAwIGFnYWluPw0KDQpZZXMgSSBrbm93IHRoYXQgYWxyZWFkeS4g
SXQgaXMgZmluZSBpbiBnZW5lcmFsIGFzIEkgZXhwbGFpbmVkIGVhcmxpZXIsIGJ1dCBjYW4NCnBv
dGVudGlhbGx5IE5PVCB3aGVuIDEzMCBpbnN0cnVjdGlvbnMgYXJlIHVuYWxpZ25lZC4NCg0KPj4g
QmVmb3JlOw0KPj4NCj4+IDkyMTIzOGU0IDxyZXRfZnJvbV9leGNlcHRpb24+Og0KPj4gOTIxMjM4
ZTQ6ICAgIGxkICAgIHI4LFtzcCwxMjRdDQo+PiA5MjEyMzhlODogICAgYmJpdDAubnQgICAgcjgs
MHg3LDIxMg0KPj4gLi4uDQo+PiA5MjEyM2FjODogICAgcnRpZQ0KPj4gOTIxMjNhY2MgPGRlYnVn
X21hcmtlcl9kcz46DQo+PiA5MjEyM2FjYzogICAgbGQgICAgcjIsWzB4OTI3ZDgxZDhdDQo+PiA5
MjEyM2FkNDogICAgYWRkICAgIHIyLHIyLDB4MQ0KPj4gOTIxMjNhZDg6ICAgIHN0ICAgIHIyLFsw
eDkyN2Q4MWQ4XQ0KPj4gOTIxMjNhZTA6ICAgIGJtc2tuICAgIHIxMSxyMTAsMHhmDQo+PiA5MjEy
M2FlNDogICAgc3IgICAgcjExLFthdXhfaXJxX2FjdF0NCj4+IDkyMTIzYWU4OiAgICBiICAgIC0x
NDAgICAgOzkyMTIzYTVjDQo+Pg0KPj4gQWZ0ZXI6DQo+Pg0KPj4gOTIxMjM5M2M6ICAgIG5vcF9z
DQo+PiA5MjEyMzkzZSA8cmV0X2Zyb21fZXhjZXB0aW9uPjoNCj4+IDkyMTIzOTNlOiAgICBsZCAg
ICByOCxbc3AsMTI0XQ0KPj4gOTIxMjM5NDI6ICAgIGJiaXQwLm50ICAgIHI4LDB4NywyMTQNCj4+
IC4uLg0KPj4gOTIxMjNiMjI6ICAgIHJ0aWUNCj4+IDkyMTIzYjI2IDxkZWJ1Z19tYXJrZXJfZHM+
Og0KPj4gOTIxMjNiMjY6ICAgIGxkICAgIHIyLFsweDkyN2Q4MWQ4XQ0KPj4gOTIxMjNiMmU6ICAg
IGFkZCAgICByMixyMiwweDENCj4+IDkyMTIzYjMyOiAgICBzdCAgICByMixbMHg5MjdkODFkOF0N
Cj4+IDkyMTIzYjNhOiAgICBibXNrbiAgICByMTEscjEwLDB4Zg0KPj4gOTIxMjNiM2U6ICAgIHNy
ICAgIHIxMSxbYXV4X2lycV9hY3RdDQo+PiA5MjEyM2I0MjogICAgYiAgICAtMTM4ICAgIDs5MjEy
M2FiNiA8ZGVidWdfbWFya2VyX3N5c2NhbGw+DQo+PiA5MjEyM2I0NjogICAgbm9wX3MNCg==
