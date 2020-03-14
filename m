Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C20C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8142F2071C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 02:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="i8uOfsS2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="AM2Ezy8x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgCOCXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 22:23:05 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:41894 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727469AbgCOCXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 22:23:05 -0400
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7594FC00C9;
        Sat, 14 Mar 2020 19:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1584213312; bh=XzRMDYaq/XurOrDSPXouq7nYDVGUaZWwN0mTRrVM3kE=;
        h=From:To:CC:Subject:Date:From;
        b=i8uOfsS2BbSrfq63FghcviT+4sldV8vzc03BwBemmA0I9Wfu9HXcWO0S60bS66LJh
         9MomLwhM9t/LPsP4d6mD0gRdRG/ipyg0rDeSgRqBo5VbmfqgIp90Rw/1i53rkaECRT
         zx6iQrRtyqxGL4kj8GiHB9cVKbV5pQ096CAwg0uVXiZIE4RZk3kjJr5kBKgwMeXARD
         zLVt7M9Yu0s7WTsDz0Fpmscwnyq1WFQq2HiyAyvfnMuEFsaboZvp73kI4jOnxyXtF6
         zQ6jwBvv+s9HlOsbZzDk8XwE6yVM7pQO+k7VV+Clxi1FUQjV0P00i4UaSaHoQgEJNF
         gk9L3RD6HPI/A==
Received: from US01WEHTC3.internal.synopsys.com (us01wehtc3.internal.synopsys.com [10.15.84.232])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1FCF7A00DA;
        Sat, 14 Mar 2020 19:15:05 +0000 (UTC)
Received: from us01hybrid1.internal.synopsys.com (10.200.27.51) by
 US01WEHTC3.internal.synopsys.com (10.15.84.232) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Sat, 14 Mar 2020 12:15:04 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.202.3.67) by
 mrs.synopsys.com (10.200.27.51) with Microsoft SMTP Server (TLS) id
 14.3.408.0; Sat, 14 Mar 2020 12:15:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV58lTcLNFDKJIWzZU0tWpcXuJ0GyDAcJOwzeBkHMqCvnpb1Ar6r5xI4B+iSPXJo557gug+/99RjLyP5THx3ENu/7RZBJzbEjhBQHppLmcbgRU1DN1wfcUCl0MEfIZp1AFjFb2LV2eAaCfNwRYf7Q34Saig/KKf4avWGGMqoBO8H7qhmBvTF9KvsSH7a3lyIekegt3CRHLSVu4e6yvksWe60fsTq2+ZAQsE4J1Y6TqX3V6c7zXY8J04fNFzH3vlzL36wYk+EVhtABtn1aplutIP3G+HaxciGNw5dy8qaucIADt6/ks9scEGC4P4Mr7U+7iuS6ZNUduCBN7qnPzdC6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzRMDYaq/XurOrDSPXouq7nYDVGUaZWwN0mTRrVM3kE=;
 b=HbTtLoATeyasRj5lJSDZY+k0uh6c6CpvU3M3ozKhOL5Evze8rZRTuwmXKvuOmkmxWQ4tLQQJZ3iRNMMXtmBdO2gdEHwz1gGFDCZPgOFmszr8etwd2vBFJFXreCG2djvuQ+gM6ZWpaQs6FhlBl+bCDrDfjI3A22QPw21ZQ1QgBtIJQ6h1Cj87CGhDPRj98rp0fiYOhBQhd5W5J32JH4C/PUzrIFIhSkNmM+2ljAWtnNzMVtsTCirazL0fvYs+cwxDeMzYUVdjEIdpmT8Rln4pBWU3SAV2X/Zm1P7n2sB0d0T1/kWpXf7WPQN09kqRq6oxoSK/6h1MBWCnzXuwUhIr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XzRMDYaq/XurOrDSPXouq7nYDVGUaZWwN0mTRrVM3kE=;
 b=AM2Ezy8xXFs3oBZkc/L4EfRUFg2P8WBhw2c3bgy7jG10IFGDc/fdpB115VPYqUT/adalfF1medQm5v6G7GGlg/1dEcZABiQYerrg+HMCO6eOc9gR3WHdmf7Vr2BkoTmd1qAi94Du5d0jgcTd5md+DQjRiMt/QvCyyBYyQK4eWEk=
Received: from BYAPR12MB3592.namprd12.prod.outlook.com (2603:10b6:a03:db::25)
 by BYAPR12MB3605.namprd12.prod.outlook.com (2603:10b6:a03:ae::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21; Sat, 14 Mar
 2020 19:15:03 +0000
Received: from BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7]) by BYAPR12MB3592.namprd12.prod.outlook.com
 ([fe80::a45a:6a41:3fe5:2eb7%7]) with mapi id 15.20.2793.023; Sat, 14 Mar 2020
 19:15:03 +0000
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     arcml <linux-snps-arc@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [GIT PULL] ARC updates for 5.6-rc6
Thread-Topic: [GIT PULL] ARC updates for 5.6-rc6
Thread-Index: AQHV+jTcjdMOGsQR2E2cWJ4esMeuug==
Date:   Sat, 14 Mar 2020 19:15:03 +0000
Message-ID: <e38a57cc-3744-e3b8-3c5f-b96b218aebd4@synopsys.com>
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
x-ms-office365-filtering-correlation-id: fa34e1a1-9082-4e77-49a4-08d7c84bff9a
x-ms-traffictypediagnostic: BYAPR12MB3605:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR12MB36054CC4B8E3A456376EA4C6B6FB0@BYAPR12MB3605.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 034215E98F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39850400004)(396003)(136003)(376002)(199004)(76116006)(66476007)(66556008)(64756008)(66446008)(66946007)(2616005)(2906002)(71200400001)(26005)(31696002)(15650500001)(8936002)(6506007)(31686004)(54906003)(81156014)(8676002)(81166006)(4326008)(316002)(6486002)(5660300002)(6512007)(478600001)(36756003)(86362001)(6916009)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR12MB3605;H:BYAPR12MB3592.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: synopsys.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmD0eAC95cQU0esdB+RVU2UTUE42qw4DQtW+3jdXHEQABtE6eCklt34BOlLsQXDf5/Sp5hLuUViyuIRP/85WUE4ShILiPADf4Qhu+FKWCL8ycaxD15VzoGjw8Qy9RZ1e+oXfn+bwW8iqH7RNrUNZm2UrsPp/xc5sAF/fTxVqINl3TrXCk1K8sPYNDHZuX9Ohu5U1GMgISuA0xLjUjPzvjKssZpTuop90+mcblqHOV7amDqhN6u1IkFxc6QTW5Hs49J5e8d7UYoIs3JC8DzdTDyD4ORQSCF/Ze3w3EHTseUIbFvObAZhBjhUxRJbTKiURBsEKPu6badW1ckA1SbWJiuMosYtSp/HHtucofuOHu8l42GrjFRz1rlckxLZKrMxHpcogU4ZZqYqmPbpWlynWxxy8XgPR7T0kTbuG09GcOWhWWnvk9pN/KVC8k6TEaQhE
x-ms-exchange-antispam-messagedata: FRCS/KLR9NjECP+7S8+IkYtSU0roJRs1CKlYsmwsL/aFBHiVe/bNuOzixETUzF4yGavqxGe+ZmW7FiYs9RLGneHJuC6JOMRHzzsdqgorrih1HCIl1wHOoZMsOwcqQlMvdmM9dlN43ndur/oNxedLxA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD5149BCE2ECA1489862D34AFD57BE80@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fa34e1a1-9082-4e77-49a4-08d7c84bff9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2020 19:15:03.1309
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjtJnAFBml3y6n1UppnR+9CCtqsMuqkvH2HjcKTRH1Y6TlBOXkWo5NhRaD8cxRTvlKv+4nbM8XUu1PjdhL485A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3605
X-OriginatorOrg: synopsys.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTGludXMsDQoNCkJ1bmNoIG9mIG1pc2NsbCBmaXhlcyBmb3IgQVJDIHdoaWNoIGhhdmUgYmVl
biBwaWxpbmcgdXAgYW5kIG1heSBnbyBpbiBzb29uZXIgdGhhbg0KbGF0ZXIuDQoNClBsZWFzZSBw
dWxsLg0KDQpUaHgsDQotVmluZWV0DQoNCi0tLS0tLS0tLS0tLS0tLT4NClRoZSBmb2xsb3dpbmcg
Y2hhbmdlcyBzaW5jZSBjb21taXQgYmI2ZDNmYjM1NGM1ZWU4ZDZiZGUyZDU3NmViNzIyMGVhMDk4
NjJiOToNCg0KICBMaW51eCA1LjYtcmMxICgyMDIwLTAyLTA5IDE2OjA4OjQ4IC0wODAwKQ0KDQph
cmUgYXZhaWxhYmxlIGluIHRoZSBHaXQgcmVwb3NpdG9yeSBhdDoNCg0KICBnaXQ6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdmd1cHRhL2FyYy5naXQvIHRhZ3MvYXJj
LTUuNi1yYzYNCg0KZm9yIHlvdSB0byBmZXRjaCBjaGFuZ2VzIHVwIHRvIDhkOTJlOTkyYTc4NWYz
NWQyM2Y4NDUyMDZjZjhjNmNhZmJjMjY0ZTA6DQoNCiAgQVJDOiBkZWZpbmUgX19BTElHTl9TVFIg
YW5kIF9fQUxJR04gc3ltYm9scyBmb3IgQVJDICgyMDIwLTAzLTExIDEwOjA3OjE1IC0wNzAwKQ0K
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tDQpBUkMgZml4ZXMgZm9yIDUuNi1yYzYNCg0KIC0gRml4IF9fQUxJR05fU1RSIGFu
ZCBfX0FMSUdOIHRvIG5vdCBqdW5rIHBhZGRpbmcNCg0KIC0gTWlzY2xsIEtjb25maWcgY2xlYW51
cHMsIGhlYWRlciB1cGRhdGVzDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkV1Z2VuaXkgUGFsdHNldiAoMSk6DQogICAg
ICBBUkM6IGRlZmluZSBfX0FMSUdOX1NUUiBhbmQgX19BTElHTiBzeW1ib2xzIGZvciBBUkMNCg0K
R2VlcnQgVXl0dGVyaG9ldmVuICgxKToNCiAgICAgIEFSQzogUmVwbGFjZSA8bGludXgvY2xrLXBy
b3ZpZGVyLmg+IGJ5IDxsaW51eC9vZl9jbGsuaD4NCg0KS3J6eXN6dG9mIEtvemxvd3NraSAoMSk6
DQogICAgICBBUkM6IENsZWFudXAgb2xkIEtjb25maWcgSU8gc2NoZWR1bGVyIG9wdGlvbnMNCg0K
UmFuZHkgRHVubGFwICgxKToNCiAgICAgIEFSQzogZml4IHNvbWUgS2NvbmZpZyB0eXBvcw0KDQpW
aW5lZXQgR3VwdGEgKDIpOg0KICAgICAgQVJDOiBmcHU6IGZpeCByYW5kY29uZmlnIGJ1aWxkIGVy
cm9yIHJlcG9ydGVkIGJ5IDAtZGF5IHRlc3Qgc2VydmljZQ0KICAgICAgQVJDOiBzaG93X3JlZ3M6
IHJlZHVjZSBsaW5lcyBvZiBvdXRwdXQNCg0KIGFyY2gvYXJjL0tjb25maWcgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICA0ICsrLS0NCiBhcmNoL2FyYy9jb25maWdzL25wc19kZWZjb25maWcg
ICAgICAgICAgICAgfCAgMiAtLQ0KIGFyY2gvYXJjL2NvbmZpZ3MvbnNpbW9zY2lfZGVmY29uZmln
ICAgICAgICB8ICAyIC0tDQogYXJjaC9hcmMvY29uZmlncy9uc2ltb3NjaV9oc19kZWZjb25maWcg
ICAgIHwgIDIgLS0NCiBhcmNoL2FyYy9jb25maWdzL25zaW1vc2NpX2hzX3NtcF9kZWZjb25maWcg
fCAgMiAtLQ0KIGFyY2gvYXJjL2luY2x1ZGUvYXNtL2ZwdS5oICAgICAgICAgICAgICAgICB8ICAy
ICsrDQogYXJjaC9hcmMvaW5jbHVkZS9hc20vbGlua2FnZS5oICAgICAgICAgICAgIHwgIDIgKysN
CiBhcmNoL2FyYy9rZXJuZWwvc2V0dXAuYyAgICAgICAgICAgICAgICAgICAgfCAgMiArLQ0KIGFy
Y2gvYXJjL2tlcm5lbC90cm91Ymxlc2hvb3QuYyAgICAgICAgICAgICB8IDI3ICsrKysrKysrKysr
Ky0tLS0tLS0tLS0tLS0tLQ0KIDkgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMjYg
ZGVsZXRpb25zKC0pDQo=
