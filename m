Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BED5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:12:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB6CF2082E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 22:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="TR9p7xmL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="rV69cR0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgFPWMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 18:12:39 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:57294 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725790AbgFPWMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 18:12:38 -0400
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1F8DB400FE;
        Tue, 16 Jun 2020 22:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1592345558; bh=cIgxyxJfZmw2K/kPsENvaFYyaf5ltuTCVNhxf50TUdU=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=TR9p7xmLOx7FjihvSVmUz+hrS/Y1+GYNjD2CoJv9Jc70ZF6KZG1cQRqYB/tfGdZtC
         NSSYaZW7snQ/152/FS1yKoAZcxL01Hm1NU4qLnOGUZSeqmVzSAae58Ply9BMFbn0li
         BGOM6JlWQ6vjMDic3vATHuQeKhWtSTSRPVn83BOMQs8c49i3+HU0UbrYB6+/Jeph5e
         HA566IqEs1BIuHE7zAA8/sgLOi1uiHpuKRSJoyjuh6phLBqOlchByfKlg6+hEAMwS1
         RheEnOTwpnOPZmN8vhjSDcaVTjwa/ynv3EEOHhyNXQqrkyahKEiNFy4ePcWNhmHMk+
         YRhjyggTjLv2w==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id CF4A7A0077;
        Tue, 16 Jun 2020 22:12:31 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2054.outbound.protection.outlook.com [104.47.37.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "GlobalSign Organization Validation CA - SHA256 - G3" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id B809F400BB;
        Tue, 16 Jun 2020 22:12:28 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=vgupta@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="rV69cR0V";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaQlKxrzoVVesT8PIz0wfujUel7gun/IxCjFNUQ4/u1Vc2ZKUSslrkT2wTfIRbf+amLSAQdU+8buoN7+W2iGNQ0tYHWVXgIJPv6ffEFdeGrZf7uao6PAG5soWsW+jVh5ur4vdlrbnrIvjJha7Eubnm7D9h48jUy9eZ947RL2B5pGe14+4Sgs0KTki8flm2csW1xaH4yr5+Fdt5HHzGi26Xab+Z5YwfD9cIm9GtYT5gpjEkwM6PPphM69vDT8YHtRU+pgcXfrd4ozvJoOAbCxRMv1rBbKvFlqAy9TYxtuwEP5nQObDxTWOhu4RLyE2SqROj/CgT94J/Uq2zmEECsjnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIgxyxJfZmw2K/kPsENvaFYyaf5ltuTCVNhxf50TUdU=;
 b=n2DAs+uLYJZRUKK5SpkCsFWZedOiGdldpDO9GW3+1Dcg3jKqyICy10G0L5dbuHFCtXRJBgXgOeyknl309HmyK+g5dPAi1Vh059DrLQw/2hOFwdb+EyCPfxUtsRZ6MolXCuVVeyM1e3WF2izBIZLZpC8o2xYKrsIWWQzIOEnLeC3NF3Q9jyix+GLGYX65uX03+vrskQHFpEEqrTjmLAgRdBpjRWJaiw7hujTr6553oDAdbWcCwkKGyTCjZ/o1Poq+50exTbzVCZIlR/iAc2F3T7XcLB6xxjbF6YOfVfS1fDmYj9Ea2rArPA+elDwuxBgdyCtFsUwKPXHZlr9QcJdatw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIgxyxJfZmw2K/kPsENvaFYyaf5ltuTCVNhxf50TUdU=;
 b=rV69cR0Vx8HhHjwsjUAIF84lAmKAqBdQH0vRmZKol68Fq9pg3nW2ZL+KcelJaw0NtZFCqaLONvrAGt0xns1copiE/7lzJ7lMn4qSjy0wyIIw1LIoSS54/wiwEkDFUnvj4cpRQtNsGHRJr6DSNDCYLnKkBknAoy87hP0UpAViOIA=
Received: from BYAPR12MB3479.namprd12.prod.outlook.com (2603:10b6:a03:dc::26)
 by BYAPR12MB3397.namprd12.prod.outlook.com (2603:10b6:a03:db::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Tue, 16 Jun
 2020 22:12:27 +0000
Received: from BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af]) by BYAPR12MB3479.namprd12.prod.outlook.com
 ([fe80::a43a:7392:6fa:c6af%6]) with mapi id 15.20.3088.029; Tue, 16 Jun 2020
 22:12:27 +0000
X-SNPS-Relay: synopsys.com
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] ARC: allow to override default mcpu compiler flag
Thread-Topic: [PATCH v2 1/4] ARC: allow to override default mcpu compiler flag
Thread-Index: AQHWOpc7/dFMmbTnfUuNOuuCbmnhSajJ2F2AgBII4wA=
Date:   Tue, 16 Jun 2020 22:12:27 +0000
Message-ID: <f3f54ba2-c050-83a2-ea93-dc147fd4bcfe@synopsys.com>
References: <20200604173927.23127-1-Eugeniy.Paltsev@synopsys.com>
 <20200604173927.23127-2-Eugeniy.Paltsev@synopsys.com>
 <MWHPR1201MB0046338E4B38598FFB5DBCB9A1860@MWHPR1201MB0046.namprd12.prod.outlook.com>
In-Reply-To: <MWHPR1201MB0046338E4B38598FFB5DBCB9A1860@MWHPR1201MB0046.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
authentication-results: synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=none action=none header.from=synopsys.com;
x-originating-ip: [73.222.250.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 502f862d-251b-4cec-f041-08d812425ab8
x-ms-traffictypediagnostic: BYAPR12MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB339708081998F929916236F6B69D0@BYAPR12MB3397.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 04362AC73B
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6T4YIyfZ96UlCJ95h+3sugQPf9k38Ob+Z/cMZE6MJQy8UA4FT6HW3ftOiBr1ds63vJkPyWe8UYj0hi8TDoxcTEuEEKcxMR3J0OjzW2tmW6eJsn4vLbYCZe11CGeb67POqC/SCnhXsfdSiy/cvA8PlSLdWXqV1hKkhqzfpKyMFNpnBjHJ0h4Y0y4vTbz2DSL/rWQszH7WBDScq2wBxWKnkidfOP1WcLjEC3eOgfyDThMm8kVN5jw3M1hmHDCTYCR/yu7yJiFgGxZhtdmuCe2j+/Z414Y5DpBhuzeycGZLCPA1TApYuBPhvTyCGgxaguJlOttx4gnHc/rkOm1R8ntgkISJZR4Pl1RM3UozB26kMF5/++d8UqxTl1TvatWnz149
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3479.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(64756008)(66446008)(71200400001)(83380400001)(478600001)(86362001)(66556008)(316002)(76116006)(66476007)(6486002)(26005)(2906002)(2616005)(6636002)(8676002)(5660300002)(53546011)(6512007)(6506007)(31686004)(36756003)(31696002)(54906003)(8936002)(186003)(66946007)(110136005)(4326008)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: dix0BNwtL9LHGC2A2pRIDd+EdaFXaiaQh2HfQMDHcgobkvukxVVh3TiYny+GqJIDhAtSUropazud6htYpGLtcmPA7EgPpguWi6f8MxdfQSTR/9h6SGIZ141F1+mNWKg+M9yrJC6MZbWuuFxgBr2XKXtKQ1PM+2xN8yR3erv6iSj5RS0gp945im69SERp0u0hyR/uH1gOjGdWggU7Zwr/FAb58mDwQQfX1oS+3r0SJQ1aXlTRrfLviChBIa6GxQzlt5Ll39ptXije1zN5FAbddNxhiJPxNqHWdK7G4vZ61wWWCrA6WxxpuoOTOSXvjpJUm49huQUh7ECXyf75rfaH/BCFSs+CgbxvFvC/omW/PO+Ht2lxtm/6O1c2PlbOjmcb/zp5T2K98x1cDVODQNMaYVlb5Vsb6i/41s7ibYXt0V2rwlp4nYk4QGmF8Tn+JmVfiHg4MshnTOCMvd9mqv9EoGPYmSdooIuaHsxJsjTqT+o=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8453CB6498572E4F8B26DE363F00D09B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 502f862d-251b-4cec-f041-08d812425ab8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2020 22:12:27.0557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YC9/sHVt5/ODcdkzPs0TG7T3YgoQuU9XhnmU73OGy5h0G8d5Yu3PxhLNRKO8hhoezli2IPEXlJpaAP1coD4SZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi81LzIwIDM6NDcgQU0sIEFsZXhleSBCcm9ka2luIHdyb3RlOg0KPiBIaSBFdWdlbml5LA0K
PiANCj4gQSBjb3VwbGUgb2YgbWlub3Igbm90ZXMgYmVsb3cuDQo+IA0KPj4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IEV1Z2VuaXkgUGFsdHNldiA8RXVnZW5peS5QYWx0c2V2
QHN5bm9wc3lzLmNvbT4NCj4+IFNlbnQ6IFRodXJzZGF5LCBKdW5lIDQsIDIwMjAgODozOSBQTQ0K
Pj4gVG86IGxpbnV4LXNucHMtYXJjQGxpc3RzLmluZnJhZGVhZC5vcmc7IFZpbmVldCBHdXB0YSA8
dmd1cHRhQHN5bm9wc3lzLmNvbT4NCj4+IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBBbGV4ZXkgQnJvZGtpbiA8YWJyb2RraW5Ac3lub3BzeXMuY29tPjsgRXVnZW5peSBQYWx0c2V2
DQo+PiA8cGFsdHNldkBzeW5vcHN5cy5jb20+DQo+PiBTdWJqZWN0OiBbUEFUQ0ggdjIgMS80XSBB
UkM6IGFsbG93IHRvIG92ZXJyaWRlIGRlZmF1bHQgbWNwdSBjb21waWxlciBmbGFnDQo+Pg0KPj4g
S2VybmVsIGJ1aWxkcyBzZXQgdGhlaXIgb3duIGRlZmF1bHQgLW1jcHUgZm9yIGEgZ2l2ZW4gSVNB
IGJ1aWxkLg0KPiANCj4gV2UgdXNlZCB0byB1c2UgYSBkZWZhdWx0ICItbWNwdSIgcGVyIEFSQyBJ
U0EgdmVyc2lvbiAob25lIGZvciBBUkNvbXBhY3QNCj4gYW5kIG9uZSBmb3IgQVJDdjIpLg0KPiAN
Cj4+IEJ1dCB0aGF0IGdldHMgaW4gdGhlIHdheSBvZiAiY3VzdG9tIiAtbWNwdSBmbGFncyBmcm9t
IHByb3BhZ2F0aW5nDQo+PiBpbnRvIGtlcm5lbCBidWlsZC4NCj4gDQo+IEJ1dCB3aXRoIG1vcmUg
dmVyc2lvbnMgb2YgQ1BVcyAmIFNvQ3MgYmVjb21pbmcgYXZhaWxhYmxlIHdlIHdhbnQgdG8NCj4g
YmUgYWJsZSB0byBmaW5lLXR1bmUgZ2VuZXJhdGVkIGNvZGUgbW9yZSBwcmVjaXNlLg0KPiANCj4+
IFRoaXMgd2lsbCBhbHNvIGJlIHVzZWQgaW4gbmV4dCBwYXRjaGVzIGZvciBIU0RLLTR4RCBib2Fy
ZCBzdXBwb3J0IHdoaWNoDQo+PiB1c2VzIGEgZGlmZmVyZW50IC1tY3B1IHRvIGVmZmVjdCBkdWFs
IGlzc3VlIHNjaGVkdWxpbmcuDQo+IA0KPiAiLi4uZm9yIHV0aWxpemF0aW9uIG9mIHRoZSBuZXcg
Q1BVJ3MgZHVhbC1pc3N1ZSBjYXBhYmlsaXRpZXMiPw0KPiANCj4+ICsrKyBiL2FyY2gvYXJjL01h
a2VmaWxlDQo+PiBAQCAtMTAsOCArMTAsMjUgQEAgQ1JPU1NfQ09NUElMRSA6PSAkKGNhbGwgY2Mt
Y3Jvc3MtcHJlZml4LCBhcmMtbGludXgtIGFyY2ViLWxpbnV4LSkNCj4+ICBlbmRpZg0KPj4NCj4+
ICBjZmxhZ3MteQkrPSAtZm5vLWNvbW1vbiAtcGlwZSAtZm5vLWJ1aWx0aW4gLW1tZWRpdW0tY2Fs
bHMgLURfX2xpbnV4X18NCj4+IC1jZmxhZ3MtJChDT05GSUdfSVNBX0FSQ09NUEFDVCkJKz0gLW1B
Nw0KPj4gLWNmbGFncy0kKENPTkZJR19JU0FfQVJDVjIpCSs9IC1tY3B1PWhzMzgNCj4+ICsNCj4+
ICt0dW5lLW1jcHUtZGVmLSQoQ09ORklHX0lTQV9BUkNPTVBBQ1QpCTo9IC1tQTcNCj4gDQo+IEkn
ZCBzdWdnZXN0IHRvIGVpdGhlciBzd2FwICItbUE3IiB3aGljaCBpcyBiZWluZyBvYnNvbGV0ZWQg
d2l0aCAiLW1jcHU9YXJjNzAwIg0KPiByaWdodCBoZXJlIG9yIGFzIGEgc2VwYXJhdGUgY2hhbmdl
LCBvdGhlcndpc2Ugd2UgbWF5IHNvb24gZ2V0IEFUQzcwMCBidWlsZHMNCj4gYnJva2VuIHdpdGgg
bmV3ZXIgY29tcGlsZXJzLg0KDQpGV0lXIEkndmUgYWRkZWQgYSBtb2RpZmllZCB2YXJpYW50IG9m
IHRoaXMgcGF0Y2ggdG8gZm9yLWN1cnIgYXMgd2UgbmVlZCBpdCBmb3INCm9uZ29pbmcgQVJDNjQg
cG9ydCBhcyB3ZWxsLg0KDQotVmluZWV0DQo=
