Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADFDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF3A1207E8
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 03:48:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ezea8SpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgGBDss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 23:48:48 -0400
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com ([40.107.243.50]:6198
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725857AbgGBDsr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 23:48:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oY2hjG1HD1hqoDEE6SOCvoZfeZU/4napD8UzO4m0rI10fSNWVU0//lECpkJ+bzi/sOv5SElvouBMvFGZ5OLdFa81Ob0nKU3EZtRaNKWwEbBQatEpIymH60EORmC0WzYGrjKjJr4mg39CnC1rSY8TNyTrF3/tCEqKzuNEFpqxsH7q6Lq3WXRLFtHIe4xYN1XcvfoLpHBrpz/dMJX/xx863Q1Lxtv+9vcoP2UJv5ZWRVE8LsM1KRkQEQyeD3XfFUH4Lf5YhlDNhRPJEAFGDZ7OfRt94V0l+pzfTbCSjhYIUeNtryMR4uku3GadOkrL+jLHcm8hRWqeU2G33A4xnVe2CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP8tQ/9fw5w8EqPWI8Qb/k29R3UAr4r4nfsMULpDD34=;
 b=QKsmkBQ2yqEicvONCkicliS7iG/QiN2oI4FScPaZHM/diwrPizAzozmavJk4EkypCo2QboHefXfxp2eV9ZFVgBzy40DevVCDFzcgC+063+2AY15l5FO3eI7LPub3wXbB7ANWb7qgM0k+hul1pWXQSOVB0nZrspCqMPXgZvbtRoKL4iaT2jpx2couru/VKFlx17Lbfcg179nSRHHsVJ+EJ4H6VzpDnr2Zr/wcBoBPvjCHjf+r+6HKKwLgRRj+6KDaJzmpxmKci6fD8FRsHb0BViRier60yM5+6nAU0PU5f3ySy/0g5SIVZw+6S0dSRf1j2gD3loBvcJurwcdWlfAHEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wP8tQ/9fw5w8EqPWI8Qb/k29R3UAr4r4nfsMULpDD34=;
 b=ezea8SpY2tiWkOwqbT3WD9JqC2R+AFGqv3lmkgNflYjkBgWgGD7lxyjdp/1c6jhA1UEF86LpQhkjgYoTdCTTOVFRg12t5sR+mgOt3C2RGU3CohAt9cJFt8yxZHFvVbcBynvRS6Sa/WU/zkSy4002RVZ/CuV+GnRwuZXyJiOJb28=
Received: from BY5PR12MB3778.namprd12.prod.outlook.com (2603:10b6:a03:1a6::11)
 by BYAPR12MB2600.namprd12.prod.outlook.com (2603:10b6:a03:69::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 03:48:44 +0000
Received: from BY5PR12MB3778.namprd12.prod.outlook.com
 ([fe80::a866:94ec:65f:8015]) by BY5PR12MB3778.namprd12.prod.outlook.com
 ([fe80::a866:94ec:65f:8015%6]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 03:48:44 +0000
From:   "S, Shirish" <Shirish.S@amd.com>
To:     Tony Lindgren <tony@atomide.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
CC:     Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Raul Rangel <rrangel@google.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "kurt@linutronix.de" <kurt@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: RE: UART/TTY console deadlock
Thread-Topic: UART/TTY console deadlock
Thread-Index: AQHWSLrNQSoW9cNjzU6HnyviDkQV1Kjk5iMAgAutxQCAAGshAIAACVwAgAAYb4CAAAv+AIAAUxSAgADUzoCAAWC4kA==
Date:   Thu, 2 Jul 2020 03:48:43 +0000
Message-ID: <BY5PR12MB37780DF07B437B9FFD1BB344F26D0@BY5PR12MB3778.namprd12.prod.outlook.com>
References: <CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com>
 <CAHp75Vd8nTzmZdnhpTDChdc11zyCaSfeigbxaCpOWZ1Lv9ZBMw@mail.gmail.com>
 <20200630035816.GA21591@jagdpanzerIV.localdomain>
 <20200630102141.GA11587@alley>
 <20200630105512.GA530@jagdpanzerIV.localdomain> <20200630122239.GD6173@alley>
 <20200630130534.GB145027@jagdpanzerIV.localdomain>
 <20200630180255.GD37466@atomide.com>
 <3b665cbd-7afb-b72d-22c0-7dc1543ac42e@amd.com>
In-Reply-To: <3b665cbd-7afb-b72d-22c0-7dc1543ac42e@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: atomide.com; dkim=none (message not signed)
 header.d=none;atomide.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [124.123.104.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4ecdd267-6c69-4a08-c817-08d81e3ad139
x-ms-traffictypediagnostic: BYAPR12MB2600:
x-microsoft-antispam-prvs: <BYAPR12MB2600781D10292C51115D72A1F26D0@BYAPR12MB2600.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BgZR4dIadLGuJs0zlE/dNO2/+27F0vYQY1y2E/IAGxo/7HmX6XESBMgZAbv0j+57QNvgFfj6/i6cdSg6lYsONv8v6q/c3/3+66NDh2E17PbUA9FYzmx6QQ85fA/swngdqK59hLTsuiQJke+Z858MKng46Z6zomc13CHjwoq5GgffCcbLvNWuU+usEGHRxQiw6vzESOYa8anfe3vCzavAXsqUFMchfiKvnlbpr1/K42YT3R+qnUSXjn5nT60wAAF5ueixLpNhKxdhhcSzuTzt96C1VvlWNKAtuzNXIt13hh7gwxN6vrf91x6aqAcUo63i54P7LsOhx8AoF4r9JY3NEhXLYKvXlNKjMIUO9jtOgkV4/KEVhRLhwNWKEZOFlg7n
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB3778.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(4326008)(66946007)(7416002)(76116006)(26005)(66556008)(64756008)(66476007)(66446008)(186003)(71200400001)(110136005)(8936002)(54906003)(316002)(478600001)(6506007)(53546011)(8676002)(7696005)(86362001)(2906002)(5660300002)(83380400001)(9686003)(52536014)(3480700007)(33656002)(55016002)(326664003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: EOKP1+nELHKI3Jg9FgOW+WrBErmWCPATDNlzDdVbNvLq9gfkSw17+c+bjZATMtcLL9avql5yVcurOFzxpMG5TmV8geTQcJgFf+XK0yxCKqO06cYq0qy+p1NWIon+H7NIkBy1BcRjhvUiQepUOrYtNoDg1kBNIYoRMj50Y47MUKAxB+whwFAGk3nR+6ZcvszEq6MTFENRfRgFysAG5az+gjEKPQPu6mPmsU+o5C1/zUPKDxblQOzpxLh4oQ9NpLPgjqI2vxULomAuAFyA31Nj5ATb8GIPdZOaq4VX33g//Ax2M15pej2panoEJLVUBD/WmldtkFpuDMFq8Buw2ozneA+mvkp6ANRvi2a/UFDM7IULDfm5AzoqEf0IS/6n7UUiXBG+cZkI6dHxrb8UsTboUdr0nzdaBzJh3k6udv1hI23TNDj8jquQ5bKPoZlmSvwg6b4RyRQl9mArF0+Z2YO+a9sMh1AWhz/u5j6s7KmxQzC/Vq/p7e19fxd6iP6Gohke
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3778.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecdd267-6c69-4a08-c817-08d81e3ad139
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 03:48:43.8847
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BpWiYYRs8ZA+WmvRBvLp6a103dFJOeGjXrFIhHiSeVtaQxIdIEwWlR2cs3A/xcsgNh3X7Hhb36oQKyx6Z+zhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2600
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQWxsLA0KDQpDYW4gd2UgbGFuZCB0aGlzIHBhdGNoIHVwc3RyZWFtPw0KRmVlbCBmcmVlIHRv
IGFkZCBteSB0ZXN0ZWQtYnkuDQoNClRoYW5rcy4NCg0KUmVnYXJkcywNClNoaXJpc2ggUw0KDQot
LS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUywgU2hpcmlzaCA8U2hpcmlzaC5TQGFt
ZC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBKdWx5IDEsIDIwMjAgMTI6MTUgUE0NClRvOiBUb255
IExpbmRncmVuIDx0b255QGF0b21pZGUuY29tPjsgU2VyZ2V5IFNlbm96aGF0c2t5IDxzZXJnZXku
c2Vub3poYXRza3lAZ21haWwuY29tPg0KQ2M6IFBldHIgTWxhZGVrIDxwbWxhZGVrQHN1c2UuY29t
PjsgQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPjsgUmF1bCBSYW5n
ZWwgPHJyYW5nZWxAZ29vZ2xlLmNvbT47IFNlcmdleSBTZW5vemhhdHNreSA8c2VyZ2V5LnNlbm96
aGF0c2t5LndvcmtAZ21haWwuY29tPjsgbGludXgta2VybmVsIDxsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnPjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9y
Zz47IEFuZHkgU2hldmNoZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPjsg
a3VydEBsaW51dHJvbml4LmRlOyBTLCBTaGlyaXNoIDxTaGlyaXNoLlNAYW1kLmNvbT47IFBldGVy
IFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47IEpvaG4gT2duZXNzIDxqb2huLm9nbmVz
c0BsaW51dHJvbml4LmRlPjsgU3RldmVuIFJvc3RlZHQgPHJvc3RlZHRAZ29vZG1pcy5vcmc+DQpT
dWJqZWN0OiBSZTogVUFSVC9UVFkgY29uc29sZSBkZWFkbG9jaw0KDQoNCk9uIDYvMzAvMjAyMCAx
MTozMiBQTSwgVG9ueSBMaW5kZ3JlbiB3cm90ZToNCj4gKiBTZXJnZXkgU2Vub3poYXRza3kgPHNl
cmdleS5zZW5vemhhdHNreUBnbWFpbC5jb20+IFsyMDA2MzAgMTM6MDZdOg0KPj4gT24gKDIwLzA2
LzMwIDE0OjIyKSwgUGV0ciBNbGFkZWsgd3JvdGU6DQo+IC4uLg0KPg0KPj4+Pj4+IEBAIC0yMjg0
LDggKzIyODksNiBAQCBpbnQgc2VyaWFsODI1MF9kb19zdGFydHVwKHN0cnVjdCB1YXJ0X3BvcnQg
KnBvcnQpDQo+Pj4+Pj4gICAJCSAqIGFsbG93IHJlZ2lzdGVyIGNoYW5nZXMgdG8gYmVjb21lIHZp
c2libGUuDQo+Pj4+Pj4gICAJCSAqLw0KPj4+Pj4+ICAgCQlzcGluX2xvY2tfaXJxc2F2ZSgmcG9y
dC0+bG9jaywgZmxhZ3MpOw0KPj4+Pj4+IC0JCWlmICh1cC0+cG9ydC5pcnFmbGFncyAmIElSUUZf
U0hBUkVEKQ0KPj4+Pj4+IC0JCQlkaXNhYmxlX2lycV9ub3N5bmMocG9ydC0+aXJxKTsNCj4+Pj4+
PiAgIA0KPj4+Pj4+ICAgCQl3YWl0X2Zvcl94bWl0cih1cCwgVUFSVF9MU1JfVEhSRSk7DQo+Pj4+
Pj4gICAJCXNlcmlhbF9wb3J0X291dF9zeW5jKHBvcnQsIFVBUlRfSUVSLCBVQVJUX0lFUl9USFJJ
KTsgQEAgDQo+Pj4+Pj4gLTIyOTcsOSArMjMwMCw5IEBAIGludCBzZXJpYWw4MjUwX2RvX3N0YXJ0
dXAoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCkNCj4+Pj4+PiAgIAkJaWlyID0gc2VyaWFsX3BvcnRf
aW4ocG9ydCwgVUFSVF9JSVIpOw0KPj4+Pj4+ICAgCQlzZXJpYWxfcG9ydF9vdXQocG9ydCwgVUFS
VF9JRVIsIDApOw0KPj4+Pj4+ICAgDQo+Pj4+Pj4gLQkJaWYgKHBvcnQtPmlycWZsYWdzICYgSVJR
Rl9TSEFSRUQpDQo+Pj4+Pj4gLQkJCWVuYWJsZV9pcnEocG9ydC0+aXJxKTsNCj4+Pj4+PiAgIAkJ
c3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9ydC0+bG9jaywgZmxhZ3MpOw0KPj4+Pj4+ICsJCWlm
IChpcnFfc2hhcmVkKQ0KPj4+Pj4+ICsJCQllbmFibGVfaXJxKHBvcnQtPmlycSk7DQo+Pj4+Pj4g
ICANCj4+Pj4+PiAgIAkJLyoNCj4+Pj4+PiAgIAkJICogSWYgdGhlIGludGVycnVwdCBpcyBub3Qg
cmVhc3NlcnRlZCwgb3Igd2Ugb3RoZXJ3aXNlDQo+Pj4+PiBJIHRoaW5rIHRoYXQgaXQgbWlnaHQg
YmUgc2FmZSBidXQgSSBhbSBub3QgMTAwJSBzdXJlLCBzaWdoLg0KPj4+PiBZZWFoLCBJJ20gbm90
IDEwMCUsIGJ1dCBJJ2QgZ2l2ZSBpdCBhIHRyeS4NCj4+PiBJIGRvIG5vdCBmZWVsIGJyYXZlIGVu
b3VnaCB0byBhY2sgaXQgdG9kYXkuIEJ1dCBJIGFtIGFsbCBmb3IgdHJ5aW5nIA0KPj4+IGl0IGlm
IGFueW9uZSBtb3JlIGZhbWlsaWFyIHdpdGggdGhlIGNvZGUgaXMgZmluZSB3aXRoIGl0Lg0KPj4g
SSBzZWUuIFdlbGwsIEkgc3VwcG9zZSB3ZSBuZWVkIEFjay1zIGZyb20gdHR5L3NlcmlhbC84MjUw
IG1haW50YWluZXJzLg0KPj4gSSB3b3VsZCBub3QgYmUgdmVyeSBoYXBweSBpZiBfb25seV8gcHJp
bnRrIHBlb3BsZSBBY2sgdGhlIHBhdGNoLg0KDQpGV0lXLCB0aGUgbG9ja2RlcCB0cmFjZSBpcyBu
b3Qgc2VlbiBhbnltb3JlIHdpdGggdGhlIHBhdGNoIGFwcGxpZWQuDQoNClJlZ2FyZHMsDQoNClNo
aXJpc2ggUw0KDQo+IFRoaXMgY29uZGl0aW9uYWwgZGlzYWJsZSBmb3IgaXJxX3NoYXJlZCBkb2Vz
IG5vdCBsb29rIG5pY2UgdG8gbWUgZnJvbSANCj4gdGhlIG90aGVyIGRldmljZSBwb2ludCBvZiB2
aWV3IDopDQo+DQo+IFdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIGp1c3Qgc2V0IHVwIHRlIGR1bW15
IGludGVycnVwdCBoYW5kbGVyIGZvciB0aGUgDQo+IHN0YXJ0dXAsIHRoZW4gY2hhbmdlIGl0IGJh
Y2sgYWZ0ZXJ3YXJkcz8gU2VlIGZvciBleGFtcGxlIA0KPiBvbWFwODI1MF9ub19oYW5kbGVfaXJx
KCkuDQo+DQo+IFRoZSBvdGhlciBkZXZpY2UgZm9yIGlycV9zaGFyZWQgc2hvdWxkIGJlIGNhcGFi
bGUgb2YgZGVhbGluZyB3aXRoIA0KPiBzcHVyaW91cyBpbnRlcnJ1cHRzIGlmIGl0J3Mgc2hhcmVk
Lg0KPg0KPiBSZWdhcmRzLA0KPg0KPiBUb255DQoNCi0tDQpSZWdhcmRzLA0KU2hpcmlzaCBTDQoN
Cg==
