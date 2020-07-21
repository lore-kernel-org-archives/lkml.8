Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75F9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96F122073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="DGfIX2Xt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="Hk1pyaAD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgGUKKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:10:00 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:60352 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726415AbgGUKJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:09:59 -0400
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4A771402EF;
        Tue, 21 Jul 2020 10:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1595326199; bh=D9L+Z/hslrJ6YB0VuQAx5b251y/V6RsZ5itqu6VtBlA=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=DGfIX2XtCCIVUyfUQqIelsfsh61KUlm1w7A5x3Qyty5jDcOKTfix7/YjC1VUsJH7N
         VY8IGQOP6QdY3Oq8xW04c2y9C8lnzBenfNtb4sYRTyEnoQE4iLl9II4MjHUL30h3du
         7s1dWONWbeflA412pthZSrFfHgsSCyxNBK+NdFdMbYRcT9WwyIcww9hLY6sJrFo9iJ
         QVymbJTrGIMTklyFi/Rjgv7FaH86ok07QWWbbsg4iMBVW7+X/68is+RWvkD28GlJLc
         U53Q1cgCANOlmXlExQEZA+Bd410U/d8cS7QIfqvNrpx/qpgdZy3X8Tr3pBgsB/+fJo
         KZE1u48DHh5yQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 5C5A1A009C;
        Tue, 21 Jul 2020 10:09:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 4FD6840104;
        Tue, 21 Jul 2020 10:09:52 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="Hk1pyaAD";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=draIGcmWe9CUcGz7k7qITLUzJG3GsauS4OoX8PylQ4xmcYagIiTfA9Dl5fqZmGIghb0zJ2dEqtb2JUVtTLFIMIw5H2bdXJZP+EMUYHVDd3P+cgPm0D8/inbYSL6LCUL3a6j9JTbJzhTKkMP9+HLi5G2/qOy3+h3DBI3EChA9c0llE4fGaArISnljg2fr3u9jFR+VL33b7jHnBHE9q3t1lAlDqWzkcxVPUjrGTW3ubu0fDFAaU2cDmGULqolnrN3kVUwv3Gup4dckve1BXN6rC5sB4jAsKtjnlEXtkAxpnSeu3i8kE6GPxKIhR8PHc5NX7aRvn3IRczOsj8aFOjvCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9L+Z/hslrJ6YB0VuQAx5b251y/V6RsZ5itqu6VtBlA=;
 b=D3gKfnGjizC2qv2zXFlhAK6uWj66Qy+CSozTFoK+9KvY7sZ5N1ueY82JHF1NK5L13VaWcR9oShGlScgwiJd1qA5Gp+svKaH+/a6dFTBLBtzVhLKOadQ7Hkuw/FeNr7czPvjACz+DRd4gfc2G4PQIWP8/9Gylo11ka73juHH/28aYjk9iILZQegIdLBAN+URo0n3stO3th5ptnKswK9+nz5sHN1Gltydyd0j6fBj9r6eQLwZfK8ouXlYvKTkVx5g1dhKWf9aTkXp+QiprGZa8A69MC17PrQ4MIfuQKBsp4MhoUh12YUUCytP9EGv8OYuEQchCfzV7+eBlWqySkyLI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9L+Z/hslrJ6YB0VuQAx5b251y/V6RsZ5itqu6VtBlA=;
 b=Hk1pyaADfNMSWIVos4DTQ+AEKKUkTBdqD7dzIZvME1YZ7vfl2IUnWlqowUGfcVNPp0mTGZJkkFnTHAHO/aggtFUmpsauy0jex/YdSGh81iZGWsgdJ9eQC55zUNldjlAN2ojteBg2IRbIkutQs+iSFrN9uu+OXiUHvDKuChgb/ig=
Received: from CY4PR12MB1432.namprd12.prod.outlook.com (2603:10b6:903:44::11)
 by CY4PR1201MB0054.namprd12.prod.outlook.com (2603:10b6:910:1a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Tue, 21 Jul
 2020 10:09:50 +0000
Received: from CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd]) by CY4PR12MB1432.namprd12.prod.outlook.com
 ([fe80::3cb9:e2f2:a4ff:14bd%10]) with mapi id 15.20.3195.025; Tue, 21 Jul
 2020 10:09:50 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Lee Jones <lee.jones@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Ben Dooks <ben@simtec.co.uk>
Subject: Re: [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
Thread-Topic: [PATCH v2 1/8] usb: dwc2: gadget: Make use of GINTMSK2
Thread-Index: AQHWWorVyBqGE0pBtk+bf+VA53x5lqkIkEaAgAlBjICAAAc6gA==
Date:   Tue, 21 Jul 2020 10:09:50 +0000
Message-ID: <5862f649-8058-7e39-cb43-2a4b09303333@synopsys.com>
References: <20200715093209.3165641-1-lee.jones@linaro.org>
 <20200715093209.3165641-2-lee.jones@linaro.org>
 <566f2d65-1b5a-ed2a-f33f-516b66be2624@synopsys.com>
 <87blk9p5ia.fsf@kernel.org>
In-Reply-To: <87blk9p5ia.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [37.252.95.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24642a59-8df0-41c4-cb93-08d82d5e34a8
x-ms-traffictypediagnostic: CY4PR1201MB0054:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1201MB0054F231006AB783BAF7332CA7780@CY4PR1201MB0054.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0wCHv/2Usr/neWfgOMnCxHTzFQMuTSsVEVRJ1qyUqCRdn9417i0+KufFuz2sBr23+3cvyNvPMTJHgJA2v21lTU/tmOl7Bu55C3f7Eq/gM/1Vjj9MbOkaMAr8kj4JfVVW2flYb9oZ2n6NPtZFBS86Y/vWqchPt7sIPoRTn6DCqUyIF81qOZus6CQIb0Ufh6PF5SW5da0Fa69WFFGk5oETL6lxw812b2xhc3xmZz2WXnYlXKwfdy4X7LTH8VVGJwkR3PD69uVzz66A6sf5gtgGoO06io9uKAtKySSO2LhazhFw3YzBhAXzTZLaCP9mdy/6T1vX4PgWDG8tU3/lLmLkC7Xgf+/7nbdwXH1iN+Ycp6mjjPxs0DiC+2BOg15PEOPE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1432.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(39860400002)(376002)(366004)(396003)(26005)(5660300002)(8676002)(36756003)(66476007)(110136005)(76116006)(478600001)(186003)(6486002)(4326008)(6512007)(316002)(66446008)(66556008)(64756008)(91956017)(66946007)(54906003)(8936002)(31696002)(2906002)(6506007)(86362001)(71200400001)(83380400001)(2616005)(53546011)(31686004)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GhTuO2uolJcEP2/3U5w2HKLYU4+2VIxJ9p9fNSyuref1jYA1Mf0NA/dWKt2Y2n6Jm7BSibX3nL5leDsFh4lgILNVr/KPUgrQfI/BCZQykcSHK/1n+nJdDS+3wUFVR/AOJvnQxBVQyv1PPbB/Jj+bJzRwSJmapTIkRj1jk88DR9bpG1xtrSAc/394Mr1KgPCKmviBPf+v03FEGNUUjitcCyUs357b7d44AT5/JxBwyz60chHG75GUvHQlfe4FYWlBrTRV5N/AfGtgE/9u7C3jdfWieAtr+YFSGZDhNXE0GFShHZ5ihimID0gjGegrMK+Qo/UmnkV53FumMpp/fjtYSKdwYqRfshWIbJNNdEb3NURfrUB3/e0WsgWudJly/ayMKzb+aeT0DoWfKbMva0U46V8InazfLaD8i/NeY1Pt0XB+GD52CpGkXVk1K0GEfpZdqxXMAOxyi0WT2yc/3bwYjGJTzcrkuNi5t2Fwl/DvT78=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EFC39F9999D6AD4EBED8499AB064A854@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1432.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24642a59-8df0-41c4-cb93-08d82d5e34a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 10:09:50.5418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q+rMZsd2bl2g5D2IcwpPTLA/CAofHfT3uWkyF4kd8T6P5ozspYoho8PLJAxRBmm1R/2+iJkukIW4utDwGNG9qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgRmVsaXBlLA0KDQpPbiA3LzIxLzIwMjAgMTo0MyBQTSwgRmVsaXBlIEJhbGJpIHdyb3RlOg0K
PiBNaW5hcyBIYXJ1dHl1bnlhbiA8TWluYXMuSGFydXR5dW55YW5Ac3lub3BzeXMuY29tPiB3cml0
ZXM6DQo+IA0KPj4gT24gNy8xNS8yMDIwIDE6MzIgUE0sIExlZSBKb25lcyB3cm90ZToNCj4+PiBU
aGUgdmFsdWUgb2J0YWluZWQgZnJvbSBHSU5UU1RTMiBzaG91bGQgYmUgbWFza2VkIHdpdGggdGhl
IEdJTlRNU0syDQo+Pj4gdmFsdWUuICBMb29rcyBsaWtlIHRoaXMgaGFzIGJlZW4gYnJva2VuIHNp
bmNlDQo+Pj4gZHdjMl9nYWRnZXRfd2t1cF9hbGVydF9oYW5kbGVyKCkgd2FzIGFkZGVkIGJhY2sg
aW4gMjAxOC4NCj4+Pg0KPj4+IEFsc28gZml4ZXMgdGhlIGZvbGxvd2luZyBXPTEgd2FybmluZzoN
Cj4+Pg0KPj4+ICAgIGRyaXZlcnMvdXNiL2R3YzIvZ2FkZ2V0LmM6IEluIGZ1bmN0aW9uIOKAmGR3
YzJfZ2FkZ2V0X3drdXBfYWxlcnRfaGFuZGxlcuKAmToNCj4+PiAgICBkcml2ZXJzL3VzYi9kd2My
L2dhZGdldC5jOjI1OTo2OiB3YXJuaW5nOiB2YXJpYWJsZSDigJhnaW50bXNrMuKAmSBzZXQgYnV0
IG5vdCB1c2VkIFstV3VudXNlZC1idXQtc2V0LXZhcmlhYmxlXQ0KPj4+ICAgIDI1OSB8IHUzMiBn
aW50bXNrMjsNCj4+PiAgICB8IF5+fn5+fn5+DQo+Pj4NCj4+PiBDYzogTWluYXMgSGFydXR5dW55
YW4gPGhtaW5hc0BzeW5vcHN5cy5jb20+DQo+Pj4gQ2M6IEJlbiBEb29rcyA8YmVuQHNpbXRlYy5j
by51az4NCj4+PiBGaXhlczogMTg3YzUyOThhMTIyOSAoInVzYjogZHdjMjogZ2FkZ2V0OiBBZGQg
aGFuZGxlciBmb3IgV2t1cEFsZXJ0IGludGVycnVwdCIpDQo+Pj4gU2lnbmVkLW9mZi1ieTogTGVl
IEpvbmVzIDxsZWUuam9uZXNAbGluYXJvLm9yZz4NCj4+DQo+PiBBY2tlZC1ieTogTWluYXMgSGFy
dXR5dW55YW4gPGhtaW5hc0BzeW5vcHN5cy5jb20+DQo+IA0KPiBTaG91bGQgSSBhcHBseSB0aGUg
ZW50aXJlIHNlcmllcyBvciBvbmx5IDEvOD8NCj4gDQpJbiB0aGlzIHNlcmllcyBvbmx5IDIgcGF0
Y2hlcyBhcmUgcmVsYXRlZCB0byBkd2MyLCB3aGljaCBJJ20gYWxyZWFkeSBBY2tlZDoNCg0KW1BB
VENIIHYyIDEvOF0gdXNiOiBkd2MyOiBnYWRnZXQ6IE1ha2UgdXNlIG9mIEdJTlRNU0syDQpbUEFU
Q0ggdjIgMi84XSB1c2I6IGR3YzI6IGdhZGdldDogQXZvaWQgcG9pbnRsZXNzIHJlYWQgb2YgRVAg
Y29udHJvbCANCnJlZ2lzdGVyDQoNCkkgY2FuJ3QgYWNrZWQgb3RoZXIgcGF0Y2hlcyBmcm9tIHRo
aXMgc2VyaWVzLCBiZWNhdXNlIHRoZXkgYXJlIG5vdCANCnJlbGF0ZWQgdG8gZHdjMi4NCg0KVGhh
bmtzLA0KTWluYXMNCg==
