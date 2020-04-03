Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD62C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD1C206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="fU2mbi/J";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="EJTDPuYt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgDCWAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:00:07 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:39448 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727829AbgDCWAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:00:07 -0400
Received: from mailhost.synopsys.com (badc-mailhost2.synopsys.com [10.192.0.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AAD96C0096;
        Fri,  3 Apr 2020 22:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1585951206; bh=xeoKf2NT+Dnyg0AvEw5NamxbJx7PD7Cxx/KksBf8avE=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fU2mbi/JTMjY6t+kwQfWi7FfnUGDM8swKgOhUPxrAu5UNDQKjTRo0N+l/XYVzwQGt
         ylj4SVIOyhUh6TYZQOV5fdcoXGySgSRQaALVH9RgWBAVbBtyPrnYSsJs8M4feO5lZU
         /9FGHeNkcRmAP/NOUD/TO2s3meQejYolkAc0BX21v7hIGCOyFhFPyfNp/p5kth6lKk
         kwmKeSKc9Bq7ryaPW4OL7VUue9JkX2LzP8I+9O4J0BRkxFfY34Qepd56BtEiubZFvw
         yLL+p4rv39npI1M/CFEzKGPhXLVcZz3jrgm3TZIuV0XlM34V8S32U8wxugzLckU797
         X1p7pxn9xoOZQ==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 13C81A0072;
        Fri,  3 Apr 2020 22:00:03 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 3 Apr 2020 15:00:02 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Fri, 3 Apr 2020 15:00:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLGDJJDiGcS60fZfxBVMd04/hSFrr93HHFCvVGK1Vj/BOlC2l9QSvdwhvk86kOyRC9U5GM1FV2VAsebIFH9YTSIO+9dOoCnYmXwlYRMbGes/5vQrQQf2Bvj2JAUP41rPtpHVMnnr4SjapSWs7b6E8i5shFjC5eAoMFLSjmsnZQ4t6T9oPFMXngPc3U8qglHMZAV5+i/OOwM82cLJgIKkcM+CtODCPT5ceIaGA59f9Uq+TRUILlYjdXAdJpUtbxV3PmG2MF7Mr/oAnivaRbSB3ejpX/urAn+tEW5ggLzAkrMEAPkrD72BWXiUxDq2PvK26C+iMrGNWez5YKazz1MS7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeoKf2NT+Dnyg0AvEw5NamxbJx7PD7Cxx/KksBf8avE=;
 b=Bw64w1eLyJUOkWGxVDARZE6lXyhCbWZvnuo2GTrtefGyheEf4jlSk3Lg51WIC7q5sLcQz89dC5NXGflT4f7McmAmJdTPEsLjAJOJkKBjpyVjf1FNSGfB/ijLGe6aB2LE2G/ckhFr0Z64AOhftqkgm2DiVW4tub1zNrYlCh0s9CQ94NjDb72GpB0lOd30OsOTiVNFfClMrPJSoZC9FSCT5F64/xzFYR5sP5n+d3OHa0x0FDrdyKZ225RhF+TBuednfHAIWkKj79igp3nbaHkfII538e4/bO9pOtvdCZ983G8kn+sz3zx92SXu+lyttlJnpaLq1cPjA3m3z1hOaJpmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeoKf2NT+Dnyg0AvEw5NamxbJx7PD7Cxx/KksBf8avE=;
 b=EJTDPuYtn4bLpqFtx2uOwxOA1qvUmmRI366/kW2BZdWoeEog5JngJBHsyHp6LkrVv2A7RnU8cL9DMBBbH8T8c6LfUmOa1FktQjgk5b4dZM75PT5Jjzc3K8xY2bWdSDVsRLuoFGkTCYVWBxF/xDbg+XB1mtHenoYayuLjTlZQgNE=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.19; Fri, 3 Apr
 2020 22:00:01 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2856.019; Fri, 3 Apr 2020
 22:00:01 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH] ARC: Fix ICCM & DCCM runtime size checks
Thread-Topic: [PATCH] ARC: Fix ICCM & DCCM runtime size checks
Thread-Index: AQHWCRfcKCnfYlxDV0y863/IP8FliKhn9D+A
Date:   Fri, 3 Apr 2020 22:00:00 +0000
Message-ID: <e6d6dcb1-9bdf-fab1-75d6-379b6d04dac8@synopsys.com>
References: <20200402175428.18823-1-Eugeniy.Paltsev@synopsys.com>
In-Reply-To: <20200402175428.18823-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vgupta@synopsys.com; 
x-originating-ip: [24.7.46.224]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae1b7644-9fde-4a8a-ddb6-08d7d81a5b67
x-ms-traffictypediagnostic: BYAPR12MB3176:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB3176A9989ACCB63CC4E6E207B6C70@BYAPR12MB3176.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3592.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(39860400002)(366004)(396003)(346002)(136003)(376002)(86362001)(81166006)(66946007)(478600001)(31686004)(54906003)(53546011)(6506007)(31696002)(2906002)(66476007)(66556008)(64756008)(66446008)(316002)(76116006)(107886003)(26005)(81156014)(2616005)(4326008)(110136005)(6486002)(5660300002)(6512007)(186003)(36756003)(8676002)(8936002)(71200400001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XLn5chdsbcwdxkaotHOPrGZvjZ4UAjJie2NTwEiiRH3v6COY8CZtCoKeZlUGYUFHcbgxlFrZ6IIzINIGguShCfou4RNQpIaCj5dtMBEFdIeW2KZ1Q2s5Wcu3uekV8c7+GqFU0Ndt3+a3aLozrDV6JHlciWO2KJbLeHnP1dN0dJUIUG57RcN2wz0pOY9+YDeokT5gz5fm7SYlevumlBn4kAQK1fTKcsDhVLwPu5Nypohg9wyOR2GNmL3mzV2SHsYcZyP+a04R9/FatUaGSeaNlXgmXL3LVKwP0BkO5gTm1XvYu8P9WaWpnzuxDCc8YVPaKB4lY74EdsSmCBRlsLbLW70vCf3qVN6IWLs33WBfzkU3dEZhm1etK+xpHcMu2cvH/JGeFN4Hgv2vA0Up77YEi/92kTRJfN9ztWjlEiWVVF1IA5kPDnkzvNoWCVyKY3A0
x-ms-exchange-antispam-messagedata: UQkhZh/oB7G6oeytf1Z7YBSVuCDcs6dW6TDIC+IkdbEcFkNiXshCqLuhqvECLFecjuNQVTjuPfcwjxVWR1FCUGpYRwTCBwCoF1h1po6ZM6NfkXQhNMYoXYRJTT1tHrQHCWUY1Akkd9VSp6DftFUW7Q==
Content-Type: text/plain; charset="utf-8"
Content-ID: <8CB6C1E884A29D4AAFD29AB46D781BA8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae1b7644-9fde-4a8a-ddb6-08d7d81a5b67
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 22:00:00.8348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q8LldBcb366+3HQe+ewrjalU0kJ2j1YCex2/g6WURlCkjPKVhPE0u5reSICRuUUQgZ6gLlget5BX+u94951MtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3176
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8yLzIwIDEwOjU0IEFNLCBFdWdlbml5IFBhbHRzZXYgd3JvdGU6DQo+IEFzIG9mIHRvZGF5
IHRoZSBJQ0NNIGFuZCBEQ0NNIHNpemUgY2hlY2tzIGFyZSBpbmNvcnJlY3RseSB1c2luZw0KPiBt
aXNtYXRjaGVkIHVuaXRzIChLaUIgY2hlY2tlZCBhZ2FpbnN0IGJ5dGVzKS4gVGhlIENPTkZJR19B
UkNfRENDTV9TWg0KPiBhbmQgQ09ORklHX0FSQ19JQ0NNX1NaIGFyZSBpbiBLaUIsIGJ1dCB0aGUg
c2l6ZSBjYWxjdWxhdGVkIGluDQo+IHJ1bnRpbWUgYW5kIHN0b3JlZCBpbiBjcHUtPmRjY20uc3og
YW5kIGNwdS0+aWNjbS5zeiBpcyBpbiBieXRlcy4NCj4NCj4gRml4IHRoYXQuDQo+DQo+IFJlcG9y
dGVkLWJ5OiBQYXVsIEdyZWNvIDxwbWdyZWNvQHVzLmlibS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6
IEV1Z2VuaXkgUGFsdHNldiA8RXVnZW5peS5QYWx0c2V2QHN5bm9wc3lzLmNvbT4NCg0KTEdUTS4g
V2lsbCBiZSBhZGRlZCBhZnRlciBtZXJnZSB3aW5kb3cgIQ0KDQpUaHgsDQotVmluZWV0DQoNCj4g
LS0tDQo+ICBhcmNoL2FyYy9rZXJuZWwvc2V0dXAuYyB8IDUgKysrLS0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FyYy9rZXJuZWwvc2V0dXAuYyBiL2FyY2gvYXJjL2tlcm5lbC9zZXR1cC5jDQo+IGluZGV4
IGFhNDFhZjZlZjRhYy4uZWZkZWRmODNiOTU0IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FyYy9rZXJu
ZWwvc2V0dXAuYw0KPiArKysgYi9hcmNoL2FyYy9rZXJuZWwvc2V0dXAuYw0KPiBAQCAtMTEsNiAr
MTEsNyBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2Nsb2Nrc291cmNlLmg+DQo+ICAjaW5jbHVkZSA8
bGludXgvY29uc29sZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KPiArI2luY2x1
ZGUgPGxpbnV4L3NpemVzLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvY3B1Lmg+DQo+ICAjaW5jbHVk
ZSA8bGludXgvb2ZfY2xrLmg+DQo+ICAjaW5jbHVkZSA8bGludXgvb2ZfZmR0Lmg+DQo+IEBAIC00
MDksMTIgKzQxMCwxMiBAQCBzdGF0aWMgdm9pZCBhcmNfY2hrX2NvcmVfY29uZmlnKHZvaWQpDQo+
ICAJaWYgKCh1bnNpZ25lZCBpbnQpX19hcmNfZGNjbV9iYXNlICE9IGNwdS0+ZGNjbS5iYXNlX2Fk
ZHIpDQo+ICAJCXBhbmljKCJMaW51eCBidWlsdCB3aXRoIGluY29ycmVjdCBEQ0NNIEJhc2UgYWRk
cmVzc1xuIik7DQo+ICANCj4gLQlpZiAoQ09ORklHX0FSQ19EQ0NNX1NaICE9IGNwdS0+ZGNjbS5z
eikNCj4gKwlpZiAoQ09ORklHX0FSQ19EQ0NNX1NaICogU1pfMUsgIT0gY3B1LT5kY2NtLnN6KQ0K
PiAgCQlwYW5pYygiTGludXggYnVpbHQgd2l0aCBpbmNvcnJlY3QgRENDTSBTaXplXG4iKTsNCj4g
ICNlbmRpZg0KPiAgDQo+ICAjaWZkZWYgQ09ORklHX0FSQ19IQVNfSUNDTQ0KPiAtCWlmIChDT05G
SUdfQVJDX0lDQ01fU1ogIT0gY3B1LT5pY2NtLnN6KQ0KPiArCWlmIChDT05GSUdfQVJDX0lDQ01f
U1ogKiBTWl8xSyAhPSBjcHUtPmljY20uc3opDQo+ICAJCXBhbmljKCJMaW51eCBidWlsdCB3aXRo
IGluY29ycmVjdCBJQ0NNIFNpemVcbiIpOw0KPiAgI2VuZGlmDQo+ICANCg0K
