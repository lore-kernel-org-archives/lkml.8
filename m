Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9261EC433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D00C22BF5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 22:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="MXHij6NH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="HaNtJGTo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731190AbgGUWGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 18:06:23 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:57332 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728403AbgGUWGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 18:06:22 -0400
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id A2B5D400E6;
        Tue, 21 Jul 2020 22:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1595369182; bh=XfoA3wDwkQAyGJ0r3ASvxwksdkImsssZAYUimAUEt1k=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=MXHij6NH6YAp1bGLKoRtuesyzUA2rpCSX1ZyhgZzrUXuEpYtqGYV0bwDY5jt4px+a
         Ga/YMP9062RbwyZ/GEgHtKdFV/9JqKrZ73HVEKtkMo4vgDemDBys4nsb1l3ZB7603A
         JyemJ4pULIWfdTvdUJc1gnRFG8Akbq7KUQKXEmQG3boC8J3KP30iNdDRsxvatA+PeN
         5mj5+dBHzGg++or7FFoX/lN0NKXVCJFBVGC3PhaQnOZcEOOLgUrNZE5ZD532ORGQpo
         VnLKqKyZ8lexjHHXCh7Zz20D3rBRMKPa84H992p22qhetm9Wc3rgwVVCcb+Pb7VZkQ
         P5FtIwubz9zEQ==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 669F6A006F;
        Tue, 21 Jul 2020 22:06:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id A9CB2801C1;
        Tue, 21 Jul 2020 22:06:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="HaNtJGTo";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=guCHS2dmguRuPsQnA8pKqUsZu2EMTJ5Mgf1Wb4CsCnrrxxLn3XqmSp6Hs4Puy9ZLoVCjrWVLmq7DSgtuifJlMEgEwolSJPKHotQh0FdtOhzuQlY1IU+22ci9h8E3rZrgD2jWmGBepeRdP46h9Afb1UOXcEdc7CpiEFHeNQCrksz5diwc/LRcaRoItGwpgm7/R7eh7bzC6XCewqe5qMrPlDPCfW7T4ytlrBaYp/q/3WNIFo/UsQsw0tgiVWOuVmzvKjQb4Aq0EPnR3hGEsfJXlPsbyDF1mGkxdnACii0EvL0zoOcL4pByRWAqLlSxLwgAu1jj9n33HsLcSLszB0hD1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfoA3wDwkQAyGJ0r3ASvxwksdkImsssZAYUimAUEt1k=;
 b=e4e0UINAlbOFI5UYI/e3xfTJYxXDSV/ZyZv9itkSrdANRMtMks4zjaDywykTkSu10Y2Jrl8foZQIJ0aQZi9eoVKorlgPmCm9aXi97snfuyq8Rf98uwPQivohR81+Wya8g9KNnd2mrGpUc7D5MvSMn4vV1eLM+40bC2FsnYZkeasKhGWsSzw/rvppNATMah3PSogneXtqBpAojOLPJbdydQ+JuHCPDpSNeRGBYl567xvsGXieLf8tcG/wjEMStp04vBEFQx2iefulKjZQsBK0n+KcieUuzHIiH4m+HZuZPSlDPBXnQDaXPAPJd5+GiPokbWmXX/FUFIuViq6vBgzkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfoA3wDwkQAyGJ0r3ASvxwksdkImsssZAYUimAUEt1k=;
 b=HaNtJGToLiFkjV/Xa009OdJwW+aK27tJ2zwK++9zFa7jysk1tdCPVPMyMcL/PRiuWAu1vH5xpbp0TasERM9lvwHiaK75fXL75IyyHHzXUqx/b/Cn0hZo8rDPISEn/TfawKoOe2kkAGqqJZrFAntzdLqLhbPM3OFM7MTULQXVozM=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Tue, 21 Jul
 2020 22:06:15 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::3d4f:7ae8:8767:75a4%7]) with mapi id 15.20.3216.021; Tue, 21 Jul 2020
 22:06:15 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
Subject: Re: [PATCH] ARC: pgalloc.h: delete a duplicated word + other fixes
Thread-Topic: [PATCH] ARC: pgalloc.h: delete a duplicated word + other fixes
Thread-Index: AQHWX6Ht/QnQkfU2BESqeocpiml8FKkSlwmA
Date:   Tue, 21 Jul 2020 22:06:15 +0000
Message-ID: <faf86b1c-fe64-5614-c212-ab707725f0d5@synopsys.com>
References: <20200721205958.15229-1-rdunlap@infradead.org>
In-Reply-To: <20200721205958.15229-1-rdunlap@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [73.222.250.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b55ffe46-3d24-4277-92c5-08d82dc249d5
x-ms-traffictypediagnostic: BY5PR12MB4051:
x-microsoft-antispam-prvs: <BY5PR12MB4051FE5CECE8934866339684B6780@BY5PR12MB4051.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j/Wwwobx54ow8YKj9Cz94PfeRkBCrJcx0YeVw09L2+AkoA2aDq3rM7nlXpu3vJLZ1B9AU5pO8bb4ankK99abn1xwfHJmVFAyEFCWR4DlrPdDV+ZYorsM8ZBEu9T8DQW6Sk/Own6uagzfo++xBLBkd6pT60881YutqJsymcFmkPy9eJw+B6oCvtNcr2A3BlOtrlkdsuJZTJf9YUN/LMjlJB0yBso94XkXg/RDQh2DTioIbazhhnLIpFp1vktF4qySo9nNq5wFP8YQ1iXZNAe/zU7sdQgH/WliTETHBMsIDewa1CwJf1Y8r32EfuD0PTfu20I0Dwf7YMaVE/Vdd1rh6lYcj0XBMDeugZwxNvbjGzh5Gi7Kd2BeZdakXhI+m+sn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(376002)(136003)(39830400003)(346002)(66476007)(66446008)(66556008)(64756008)(66946007)(2906002)(6506007)(8676002)(86362001)(53546011)(26005)(76116006)(6486002)(478600001)(71200400001)(2616005)(4326008)(31696002)(110136005)(5660300002)(8936002)(186003)(31686004)(83380400001)(36756003)(6512007)(316002)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: MkDQBDPQPyhyMOsc/WdNIIDlF77pO49w2Gldf7zha+v045A2dSa4/vo6C9xTaTuxrSxyjQgXd6jP8cL0K7t41692s8T0n4Ld3Oe6Y5fYj6wDfO1Xu+/wwS6KyaBv47fwwYq99PwXlt/ZNiUpHhge/wvNZzHVh08RN3v5NJOPGjowK8FIkei4TQ3gQP28qfhsBflwuJm0u7L9yXcWkOSbXyMLylU5Hvsc/vMV4Z8hYQekKHrZdGuQvs8ZQnhSoRyQ+nDnN9f4sRfVkNXaAldXNWs9yC4vJH7kx3cx7MVzqUjmIvbnYvOKgCbUs1ycP4bFM+SH2UZqhO6mHURHz6P4cT5FyQQNspCXE1mkhH7emlyoIn7cT07tfcWpvyuWuzJ4lWJb2ySzuGxUAgZXV5Shc2g7wAbCyDjhrUwzFOLqgCyXWgQJcC0Qnbj09jTs3P+5M4GIZhHMjpplRU6uwVF9jSt3Tgba+pjnyNfkP30Ra9E=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E82BCA8EFB1A4E4B8ED4159593D7C8E9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3479.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b55ffe46-3d24-4277-92c5-08d82dc249d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 22:06:15.6115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: euGmiozzcvSS1sZboVCMn5aV1p3f/ZmyZGIfK4j4ys6+Age8Ab4VqEbNrkVl94d8LHfJMttuEwzjvMFuI/75Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yMS8yMCAxOjU5IFBNLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+IERyb3AgdGhlIHJlcGVh
dGVkIHdvcmQgInRvIi4NCj4gQ2hhbmdlICJUaGF5IiB0byAiVGhhdCIuDQo+IEFkZCBhIGNsb3Np
bmcgcmlnaHQgcGFyZW50aGVzaXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAg
PHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gQ2M6IFZpbmVldCBHdXB0YSA8dmd1cHRhQHN5bm9w
c3lzLmNvbT4NCj4gQ2M6IGxpbnV4LXNucHMtYXJjQGxpc3RzLmluZnJhZGVhZC5vcmcNCg0KVGh4
IFJhbmR5LiBBZGRlZCB0byBmb3ItY3VyciAhDQoNCi1WaW5lZXQNCg0KPiAtLS0NCj4gIGFyY2gv
YXJjL2luY2x1ZGUvYXNtL3BnYWxsb2MuaCB8ICAgIDQgKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IC0tLSBsaW51eC1uZXh0LTIw
MjAwNzIwLm9yaWcvYXJjaC9hcmMvaW5jbHVkZS9hc20vcGdhbGxvYy5oDQo+ICsrKyBsaW51eC1u
ZXh0LTIwMjAwNzIwL2FyY2gvYXJjL2luY2x1ZGUvYXNtL3BnYWxsb2MuaA0KPiBAQCAtMTgsMTAg
KzE4LDEwIEBADQo+ICAgKiB2aW5lZXRnOiBBcHJpbCAyMDEwDQo+ICAgKiAgLVN3aXRjaGVkIHBn
dGFibGVfdCBmcm9tIGJlaW5nIHN0cnVjdCBwYWdlICogdG8gdW5zaWduZWQgbG9uZw0KPiAgICog
ICAgICA9TmVlZGVkIHNvIHRoYXQgUGFnZSBUYWJsZSBhbGxvY2F0b3IgKHB0ZV9hbGxvY19vbmUp
IGlzIG5vdCBmb3JjZWQgdG8NCj4gLSAqICAgICAgIHRvIGRlYWwgd2l0aCBzdHJ1Y3QgcGFnZS4g
VGhheSB3YXkgaW4gZnV0dXJlIHdlIGNhbiBtYWtlIGl0IGFsbG9jYXRlDQo+ICsgKiAgICAgICBk
ZWFsIHdpdGggc3RydWN0IHBhZ2UuIFRoYXQgd2F5IGluIGZ1dHVyZSB3ZSBjYW4gbWFrZSBpdCBh
bGxvY2F0ZQ0KPiAgICogICAgICAgbXVsdGlwbGUgUEcgVGJscyBpbiBvbmUgUGFnZSBGcmFtZQ0K
PiAgICogICAgICA9c3dlZXQgc2lkZSBlZmZlY3QgaXMgYXZvaWRpbmcgY2FsbHMgdG8gdWdseSBw
YWdlX2FkZHJlc3MoICkgZnJvbSB0aGUNCj4gLSAqICAgICAgIHBnLXRsYiBhbGxvY2F0b3Igc3Vi
LXN5cyAocHRlX2FsbG9jX29uZSwgcHRyX2ZyZWUsIHBtZF9wb3B1bGF0ZQ0KPiArICogICAgICAg
cGctdGxiIGFsbG9jYXRvciBzdWItc3lzIChwdGVfYWxsb2Nfb25lLCBwdHJfZnJlZSwgcG1kX3Bv
cHVsYXRlKQ0KPiAgICoNCj4gICAqICBBbWl0IEJob3IsIFNhbWVlciBEaGF2YWxlOiBDb2RpdG8g
VGVjaG5vbG9naWVzIDIwMDQNCj4gICAqLw0KPiANCg0K
