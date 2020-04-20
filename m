Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1618C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C14E20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 09:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aMT3yXjm";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="aMT3yXjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDTJvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 05:51:42 -0400
Received: from mail-vi1eur05on2070.outbound.protection.outlook.com ([40.107.21.70]:29624
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgDTJvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 05:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjwRZk2+YdqcnpnbPy9E0OZbHZ3gCwNBIsc6WhYCcb8=;
 b=aMT3yXjmG6LYAZW3wrCtMJv4/KDim39KtDIxFIOu4XPVNUGaYt6aYJ9tA6XDxU/pnqGge0FJMj+/rYukFhKm7FYAPbhWr5pH/8LGKDNa/l23WNB3GJzcIw7vwi/UFS8gvQkW/Qv/8+POw8dmT8NYl7sGwE7HJRJGJh+gdpDcz1c=
Received: from AM6P192CA0064.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::41)
 by AM6PR08MB4550.eurprd08.prod.outlook.com (2603:10a6:20b:71::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 09:51:35 +0000
Received: from AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:82:cafe::79) by AM6P192CA0064.outlook.office365.com
 (2603:10a6:209:82::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Mon, 20 Apr 2020 09:51:35 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT016.mail.protection.outlook.com (10.152.16.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.18 via Frontend Transport; Mon, 20 Apr 2020 09:51:34 +0000
Received: ("Tessian outbound 43fc5cd677c4:v53"); Mon, 20 Apr 2020 09:51:34 +0000
X-CR-MTA-TID: 64aa7808
Received: from d329a660fc29.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 0BA86B06-3BBD-45A7-8655-7469AE3E1D52.1;
        Mon, 20 Apr 2020 09:51:29 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d329a660fc29.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 20 Apr 2020 09:51:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLwM7kHujprdi4eqIkw31zAWvSQ/AcmMvDndyr40uQZl9ClbwSsEEqonPKYAtsgc9XhA1R9NNn2ARfPYniC4hLM+zsL41CQeVcMdMxaF3ac8VmX7Kx2FbWMExIWDmyjAK7s+jVIfqEa6ac/5W/8IxTpXrQzD1cgQ1xEc8Klw1LlR5SeGgl2f8P0m4NgHuxYUzWb33dLK0OuyJLuG3fWneoScvMQFedhcWmJijNJuY/bBjrnC4vS7B4j85LAxegtI+j6ZMNhvkvYhMkFqDedU3k5MrgoZtzXZKy81oFbHP5Wk4i8XIS+w0Ftm6/4GmS5cLMvLS9Hw9f3+PZjBHckhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjwRZk2+YdqcnpnbPy9E0OZbHZ3gCwNBIsc6WhYCcb8=;
 b=VeyKRMr1HtoaHkA0gAr7XG0lzlvfU9ZoUFp9cNcuqtuHtflo14G1Rz9+5gs/tS0V7Ki5A54q00VDSUMxcJ+ddtPBjhCryIf0GGPRS+rT6k09Yuk+fvQQ96X10IdGVmOJ7seJGXkGIXjj9CB+5JLa0l/44ML/msemLPNOIQ/kx9vAgdzCV6zJyi7G4DmyBTmf89QlNQSiM7TIvY1n/BE0GbV98B6gAAW6wWy53XkfD9eWEGr8SMr9MG/6aSS32x7OVmr2ejd23zPwK1kUgihum/Svp7NcEWBElKdGbHDbwZxSmozRCLfthyyt+LsSqCx5mMM/6y34oetpBV5256KgUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OjwRZk2+YdqcnpnbPy9E0OZbHZ3gCwNBIsc6WhYCcb8=;
 b=aMT3yXjmG6LYAZW3wrCtMJv4/KDim39KtDIxFIOu4XPVNUGaYt6aYJ9tA6XDxU/pnqGge0FJMj+/rYukFhKm7FYAPbhWr5pH/8LGKDNa/l23WNB3GJzcIw7vwi/UFS8gvQkW/Qv/8+POw8dmT8NYl7sGwE7HJRJGJh+gdpDcz1c=
Received: from DB6PR0802MB2533.eurprd08.prod.outlook.com (2603:10a6:4:a0::12)
 by DB6PR0802MB2231.eurprd08.prod.outlook.com (2603:10a6:4:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 09:51:27 +0000
Received: from DB6PR0802MB2533.eurprd08.prod.outlook.com
 ([fe80::b959:1879:c050:3117]) by DB6PR0802MB2533.eurprd08.prod.outlook.com
 ([fe80::b959:1879:c050:3117%8]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 09:51:26 +0000
From:   Hadar Gat <Hadar.Gat@arm.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
CC:     Joe Perches <joe@perches.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Ofir Drang <Ofir.Drang@arm.com>, nd <nd@arm.com>
Subject: RE: MAINTAINERS: Wrong ordering in CCTRNG ARM TRUSTZONE CRYPTOCELL
 TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
Thread-Topic: MAINTAINERS: Wrong ordering in CCTRNG ARM TRUSTZONE CRYPTOCELL
 TRUE RANDOM NUMBER GENERATOR (TRNG) DRIVER
Thread-Index: AQHWFvewXLwxcHCB/UqDv3UthfTIB6iBw0Rw
Date:   Mon, 20 Apr 2020 09:51:26 +0000
Message-ID: <DB6PR0802MB25339A9DFF7F87CB06158476E9D40@DB6PR0802MB2533.eurprd08.prod.outlook.com>
References: <alpine.DEB.2.21.2004201122490.9739@felia>
In-Reply-To: <alpine.DEB.2.21.2004201122490.9739@felia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ts-tracking-id: beb4b194-693b-41ac-8f1b-341a63ddb01f.1
x-checkrecipientchecked: true
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Hadar.Gat@arm.com; 
x-originating-ip: [84.109.179.203]
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35acd2d7-cf10-4624-1e5c-08d7e5106966
x-ms-traffictypediagnostic: DB6PR0802MB2231:|DB6PR0802MB2231:|AM6PR08MB4550:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB455071E219B8611EFF060B63E9D40@AM6PR08MB4550.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
nodisclaimer: true
x-ms-oob-tlc-oobclassifiers: OLM:8882;OLM:8882;
x-forefront-prvs: 03793408BA
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0802MB2533.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(366004)(136003)(346002)(396003)(39860400002)(9686003)(71200400001)(8676002)(5660300002)(33656002)(55016002)(8936002)(81156014)(2906002)(4326008)(86362001)(76116006)(186003)(478600001)(6916009)(52536014)(66476007)(316002)(66946007)(66446008)(64756008)(66556008)(54906003)(53546011)(7696005)(966005)(6506007)(26005);DIR:OUT;SFP:1101;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Fj+RJxrrK+iL6x6DbmTyEai90pYDu4ZRyl97lYta73npF+h2Vu+0NYMxKLoStgKoNtzv0AsN3UHPu4IcDJK81VO1LGMvr9hAz9bKFHnnQGsbCsz54mN/QDnb02FcWHuOOqtZLdh8GQtHxyIM1MPi1npfYLxt8OnWK1YKyW4L35CcbOJMhYdIkINTCCGlvK/EHuCshJ/sTCw06/DHLARxbFL2f/t9C6FPRSziHIbly4EmUZDVoEgpuQYfCNVjsB14Rph+SMSahWW1Pz8ouGaB9Pk+f4rHaY/asAwAf6oJUYa3rBGBas+o/lor0QM8N6YbnctjIcIR4MwyS7lPkAe7TmBEQ+9uYcPT6u6vyFfdoy8gLTS9sMo0W4lz64d4TZRzdr+Fg5BA568kJQbz+ChhkSR/1N9P/LCS7pOeSScsasgcvwgPrsc/kBixw8FE87LQvJYHIgzmG60J3ZBXBzwfnZCexeQJhbZ6UsWOfz0bINgMWq7K6zT5k7g4BA2bgHegBbZzlLmhgiX+eUDe7kVK8A==
x-ms-exchange-antispam-messagedata: 0ZpHBlBU8uvwLwLe5wzisj2r7zWsarqX3u44vNwvxCXm6StCqQ/3X3I6L27nSvivqUSnogbyBwimvs7f7W+uFuD4Wky6zsqpJok9ZnJkpwae1YQVIu2HL0XQ6PNG8aUOM76OwRfyHjOUkSFmANbm2w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2231
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Hadar.Gat@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT016.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966005)(5660300002)(55016002)(26005)(316002)(478600001)(6862004)(966005)(9686003)(54906003)(52536014)(86362001)(36906005)(33656002)(4326008)(81156014)(8936002)(2906002)(450100002)(336012)(81166007)(356005)(47076004)(7696005)(53546011)(6506007)(186003)(70206006)(8676002)(70586007)(82740400003);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e5c25328-3835-473e-cc4f-08d7e51064ce
X-Forefront-PRVS: 03793408BA
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YJrFK/dSdbkKjGpdcTDzjK6Tg9dLT8sEFmbWWrw4gZZnrjg+mcg/WeHAKRl0DmXf/HZV8NeG7Wopt5IadE0gK9tTecWmSkRFzpwl5iLkWUMjfMjZdswBIs3gMAmmBKEATMMZeiKWeZvz6AL9sVByVEbi/LnohyvEG8I5GoJ5QsPoJ/lya6kfNI3JAHhEgMIGBsBDBE2eHsgdyy7qGGkU9wW/4Qz4SPSA6WuyKSeqS4IYzIrp9n4if5+q30+a11k4JbW5oyVA6nxZezWGHJuuMawB/HB6+wE+wiL7h1g9K7GwFaZL4pQYQc21U+GUJtufwSaPtw73yC7kkLpSG991GA9oLBpgslnDQlmQT0zS+mfLtbBa4GHK3hu5A9bEeSMUvsZB0cuplDaNMf5Qo9GascnYDX0NgmVfcahPg8DkoqupRWbODcbuxBuZQdGYgEAp2b1vvGZSiARfWAVZ66wdZorP6JhpbPTThvDeSWo1F+NtEyRA5r56QRpR/10QBbb9uolY0zL0bTrLJgS/M9mk3c14YpYP80ASO+csIkGasxNkkzL1LZVqlS5MK5/SvhqlJRvqAS+Maki3qlmbGDEwoF6nPSubvDBgm9Q2Xe2lyJI=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 09:51:34.5891
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35acd2d7-cf10-4624-1e5c-08d7e5106966
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4550
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1a2FzIEJ1bHdhaG4gPGx1
a2FzLmJ1bHdhaG5AZ21haWwuY29tPg0KPiBTZW50OiBNb25kYXksIDIwIEFwcmlsIDIwMjAgMTI6
MzkNCj4gVG86IEhhZGFyIEdhdCA8SGFkYXIuR2F0QGFybS5jb20+DQo+IENjOiBKb2UgUGVyY2hl
cyA8am9lQHBlcmNoZXMuY29tPjsgQW5keSBTaGV2Y2hlbmtvDQo+IDxhbmR5LnNoZXZjaGVua29A
Z21haWwuY29tPjsga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogTUFJTlRBSU5FUlM6IFdyb25nIG9yZGVy
aW5nIGluIENDVFJORyBBUk0gVFJVU1RaT05FDQo+IENSWVBUT0NFTEwgVFJVRSBSQU5ET00gTlVN
QkVSIEdFTkVSQVRPUiAoVFJORykgRFJJVkVSDQo+IA0KPiBIaSBIYWRhciwNCj4gDQo+IHdpdGgg
eW91ciBjb21taXQgM2M4ZTBiZDEwNTAzICgiTUFJTlRBSU5FUlM6IGFkZCBIRyBhcyBjY3RybmcN
Cj4gbWFpbnRhaW5lciIpLCBub3cgdmlzaWJsZSBvbiBuZXh0LTIwMjAwNDIwLCAuL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtZg0KPiBNQUlOVEFJTkVSUyBjb21wbGFpbnM6DQo+IA0KPiAjMzkwODog
RklMRTogTUFJTlRBSU5FUlM6MzkwODoNCj4gK0Y6CWRyaXZlcnMvY2hhci9od19yYW5kb20vY2N0
cm5nLmgNCj4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ybmcvYXJtLWNj
dHJuZy50eHQNCj4gDQo+IFdBUk5JTkc6IE1pc29yZGVyZWQgTUFJTlRBSU5FUlMgZW50cnkgLSBs
aXN0ICdXOicgYmVmb3JlICdGOicNCj4gIzM5MDk6IEZJTEU6IE1BSU5UQUlORVJTOjM5MDk6DQo+
ICtGOglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvcm5nL2FybS1jY3RybmcudHh0
DQo+ICtXOg0KPiBodHRwczovL2RldmVsb3Blci5hcm0uY29tL3Byb2R1Y3RzL3N5c3RlbS1pcC90
cnVzdHpvbmUtDQo+IGNyeXB0b2NlbGwvY3J5cHRvY2VsbC03MDAtZmFtaWx5DQo+IA0KPiBUaGlz
IGlzIGR1ZSB0byB3cm9uZyBvcmRlcmluZyBvZiB0aGUgZW50cmllcyBpbiB5b3VyIHN1Ym1pc3Np
b24uIElmIHlvdSB3b3VsZA0KPiBsaWtlIG1lIHRvIHNlbmQgeW91IGEgcGF0Y2ggZml4aW5nIHRo
YXQsIHBsZWFzZSBqdXN0IGxldCBtZSBrbm93Lg0KDQpUaGFua3MgYSBsb3QgTHVrYXMuDQpJIHdh
cyB3b25kZXJpbmcgd2h5IHRoaXMgcGF0Y2ggd2FzIG5vdCBhcHBsaWVkLi4gc29tZWhvdyBJIGRp
ZG4ndCBnZXQgdGhpcyB3YXJuaW5nIHdoZW4gcnVubmluZyBjaGVja3BhdGNoLnBsLg0KSSB3aWxs
IGZpeCB0aGlzIHNob3J0bHksIG5vIG5lZWQgdG8gc2VuZCBtZSBhIHBhdGNoLg0KDQo+IA0KPiBC
ZXN0IHJlZ2FyZHMsDQo+IA0KPiBMdWthcw0KDQpUaGFua3MsDQpIYWRhcg0K
