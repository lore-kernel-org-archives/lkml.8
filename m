Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791ADC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E192075A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 05:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="Ookat35x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgDWFwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 01:52:14 -0400
Received: from mail-eopbgr70131.outbound.protection.outlook.com ([40.107.7.131]:46945
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbgDWFwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 01:52:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aeAT6XXhd6Arz9gHuldJ37pRye5ImNpN66tliRW93J8iEVAa8ok3w6VruogPo/m1LlarmDXqNW3U2d9RMcRO/IzWfNvu1kCeeBjPxmCcoXTypCw6zpgmlocKctXQhpHX5f0LRC+0JhzcJb6Fb4WxiP1zci7mCvjXtUrhACdWqxO8gFBUAuBVqtLhGzLcDpcghLdAWiRMyCd70lqZjpgPt3douR+N9TVn3sTvZKnSEpedP28nqryefQSJ50SE4vJioNw4yJMa7bPSIwY2fGRIL7j9xwY24RBeuY8iY21ksarPXPK1gVF/73Es3jaM/jRqlV2857gWTpdJemolpoKk1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROSTFF6AWMXoBzkdYVuN5YLNu4Zp10T9SEOjJ9mKUEU=;
 b=G6r0nOB4x/k0SFPLD28qZ1XABD6nenYmfbZm9dMuY9i/QOyFGy8VxejBVI8COU6mWSgCHmrvboR2do/1Tb4PjM+rexyYYWfmBdPXDYZnxozB4Ri2n2zOlQNypscJcVd6tObKM8AdKHejVqK2fNBHFmOltzJebzsacPx66fvQQNmtKFDDPi8Rn3pgNYSW9EFl8BEkIByn7VFbKOBNDyseFstGdjYivp4VuTGS1q4Yb83Q8Y137gp3167yTeHLpFNivD/diH+vHAvxSE/AfhQlFcLtJCnbC6XujdUoivcZfi4ZaKuOk/07qZPYdkQvZP6WDWMRur5eA1kJWwtw9/P4sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROSTFF6AWMXoBzkdYVuN5YLNu4Zp10T9SEOjJ9mKUEU=;
 b=Ookat35xmJT920daPcBuEjHjgyZC20ul4GayZi5zA6lcot96cw/2+7GKkK3S/t8Rcw+WXcSVpp+kK79CRwZUp9UobsY3fSAU1FplbtJg4ANTFcaV5jH0D8WRleMaTK/r7V6Z1h2kAjkC9koacCUZENzfnzjdtBJexlzyDQneqv0=
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com (2603:10a6:3:4b::11)
 by HE1PR0701MB2777.eurprd07.prod.outlook.com (2603:10a6:3:99::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.10; Thu, 23 Apr
 2020 05:52:08 +0000
Received: from HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece]) by HE1PR0701MB2938.eurprd07.prod.outlook.com
 ([fe80::7877:564:f523:aece%10]) with mapi id 15.20.2937.012; Thu, 23 Apr 2020
 05:52:08 +0000
From:   "Rantala, Tommi T. (Nokia - FI/Espoo)" <tommi.t.rantala@nokia.com>
To:     "jolsa@redhat.com" <jolsa@redhat.com>
CC:     "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] perf tools: Move zstd_fini() to session deletion
Thread-Topic: [PATCH 2/4] perf tools: Move zstd_fini() to session deletion
Thread-Index: AQHWFLtvGkG5I0RKXUCK8vXtPmN80qiBuTkAgASD9IA=
Date:   Thu, 23 Apr 2020 05:52:08 +0000
Message-ID: <4845b1020dcd05d2927adced7ad5685437af03c2.camel@nokia.com>
References: <20200417132330.119407-1-tommi.t.rantala@nokia.com>
         <20200417132330.119407-2-tommi.t.rantala@nokia.com>
         <20200420084931.GD718574@krava>
In-Reply-To: <20200420084931.GD718574@krava>
Accept-Language: fi-FI, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tommi.t.rantala@nokia.com; 
x-originating-ip: [131.228.2.15]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 958b1403-04a0-4cc1-6415-08d7e74a75b3
x-ms-traffictypediagnostic: HE1PR0701MB2777:
x-microsoft-antispam-prvs: <HE1PR0701MB2777928B709605B16DFE196AB4D30@HE1PR0701MB2777.eurprd07.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03827AF76E
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0701MB2938.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(81156014)(5660300002)(26005)(2906002)(316002)(4744005)(66446008)(7416002)(64756008)(66476007)(66556008)(76116006)(6506007)(66946007)(54906003)(6916009)(478600001)(8676002)(6486002)(2616005)(36756003)(186003)(6512007)(4326008)(8936002)(86362001)(71200400001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bbmwp7P9VmzZDHtM4Lt+p2gz75M1lqefBp5/Q9a1GCKZ0hGoOT3ZJ2NUh3sTNvgJ8OJ+RDLUSOfdvTiw0T3NpDMvPrwYf5qiVy0n7XmdnziiJQrp4oPptjMqTCav4ydupxd0V5p9HQDvE65qRN8JW3CB70GkcqaGgRiLTExd6Vcgs81QkfuB2fdU66kdgvV3zVbnmsIRT8wlo9OvSm9RNPXPRDdVs9B8F2CazOR9ofeDiC6Ly1XVcSQfKX0GTOrjgVpOITUHXtr0F8V6pD3fQeF8aY4VpBoAPRkJR1U+6Y6vcBExhue79JpFyz9JF5/tpre6FELkSdQv30FpWhO2UPjXlKmg1LF8SQJQviVwJTSOSRSax5W8e4TMdi7a4Ex5VIUlN0k2getcWgBDGI2OxBrfTJryt68jrheDlAoCAtcwYieLXS+5BtZ4hwjC7N2t
x-ms-exchange-antispam-messagedata: NgPRB6rwiLXGEYX0JHbxHuJl698CYcgr+6Bme0eqi3y0SIzCyjCti3qdOBVT16bJMFw0rFqLpfj0EKDJw1J8G7CwRBEh9oxvLPfRi0xzfacp0suIvSQ6bfXw/9KftjEdo1MYHl4STIL/7Q8WvGLK3Ztgv3fPTmGWSfrO+IqnsnFaOWM+3p1DyAGpAOwnri7dFxBoY97g3XNwv+sV5bbXKweOcXcykht6CxBNLn5fpWKwCdudZhRzc+X12xidiBnCtbAWUkqGSNkvtkj6u6PfTIOBrSX6ltQXPni0eq5f7AhDTtqP8NR8517RHtobfF/vYspdq9PtO1ISp9elhp2nENnAFHxD3IodHZXK4ISGRyFQFol7aPXD+8GWoe/3/Zh7xAJY5V2ig9dPHsQNObjOCMadcgDwt5HKKWM+IipY58CHJsyLSSHEpv99Q3004p3buywuyWF4lxRSCEnhlp/GxHmWGBSBZUrqyWNCgwcs03N/P0DISWAwzFoeEOPLku9SucWQ6yQaC/5uhU1s8Jqsscjns09pSyt4G4pnMvZ893L4CTaDOoEzPucy3HYt/OxFoFrfYxdOvYNIb2j5TF4rwrdpXDewgRUsnOENrYC/nPeu5MvuGyNCHe8B2AzHsnNkRsGYZfsmavil8vAUvS6aj0a1g+9rBuko2obFHzL9llyXWYxAYSvajJrYB79jlDouGt0ayojAAxojYwF4+ZMF5wGyj/doUsH0nic1v5gi8lqP5XJwslhcPs20K/mJHqa6DjXabb3iLIdWjQ33MEAgTGSpxqqNa9uOJ4KmIvwGWjQ=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <1F1877822C73674A9541F01269EE2051@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958b1403-04a0-4cc1-6415-08d7e74a75b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2020 05:52:08.3242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1wxdoflIkHDXKkii0KMYnARrPIenA9BLjCv/FCbRfCTley6ogkZfI+bsVAzLYyGBj0O2vuM/RZXPLaqf6QI8Q6d6nSQlV4dQqaFom+40isg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2777
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTIwIGF0IDEwOjU0ICswMjAwLCBKaXJpIE9sc2Egd3JvdGU6DQo+IE9u
IEZyaSwgQXByIDE3LCAyMDIwIGF0IDA0OjIzOjI3UE0gKzAzMDAsIFRvbW1pIFJhbnRhbGEgd3Jv
dGU6DQo+ID4gTW92ZSB6c3RkX2ZpbmkoKSBjYWxsIHRvIHBlcmZfc2Vzc2lvbl9fZGVsZXRlKCks
IHNvIHRoYXQgd2UgYWx3YXlzDQo+ID4gY2xlYW51cCB0aGUgenN0ZCBzdGF0ZSB3aGVuIGRlbGV0
aW5nIHRoZSBzZXNzaW9uLg0KPiANCj4gaXQgc2hvbGQgYmUgb3J0aG9nb25hbCB3aXRoIHpzdGRf
aW5pdCBjYWxscywgd2hpY2gNCj4gYXJlIG5vdCBjdXJyZW50bHkgY2FsbGVkIHdpdGhpbiBwZXJm
X3Nlc3Npb24gDQo+IA0KPiBJIGd1ZXNzICB6c3RkX2luaXRjb3VsZCBtb3ZlZCB0byBwZXJmX3Nl
c3Npb25fX25ldywNCj4ganVzdCBuZWVkIHNvbWUgbmljZSB3YXkgdG8gcGFzcyByZWMtPm9wdHMu
Y29tcF9sZXZlbA0KDQpNYWtlcyBzZW5zZSwgSSdsbCBwb3N0IHYyIGxhdGVyLg0KLVRvbW1pDQoN
Cg==
