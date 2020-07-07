Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FA7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:32:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 298CD2065F
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="ZPMcGNiT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgGGJcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:32:23 -0400
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com ([40.107.236.41]:36114
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725825AbgGGJcW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:32:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bFW84hV4nuWSdGjp2qKpILZUD6BTAya7jpC1ppUbrM9LPt1nn3WrcR+Js9f9QMbX5LmJzyodVlrxDkp3CK12Smxn0C+TAdc4M//hqCgBJr+zw4Y9vIsdigNyi9VFo0NABgGqtQi/SSaXDKtHVhgcX7U5AFsCiApAmS1gQb7L4o1gDTuVDCxbtXIKH1sPXoHo1dYXKUetfi1/8lQYfO6y1g/AMKnzsK/SJ9gmLS/XmYqqwuFv5g+9rr2hkevUrHdSDfEVGO2AXWTD0BrbEnfEkzuL7jGYDphQLKkllYpTyPln0LuNqAm6JyFcTdC/i9C1e4IMzDA2LGTKXc4x/mu65g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J20JtLgmeAZX6yGz27OoYVmh53OAD7PYyQ5amr4qyY=;
 b=dF4r8TXaZIGmenDH4OCsXjqvl4AdLYkkYT/SlafAW9yBHrj04xoHnFj3iq/W+SPFD90/PhUBGm9p8Wwq7y8YD73Z+kqTJoJd3ybs0tXuTOtK94W1hBNI5qK3cCBJ+zhMlgn5i2JnYoaCopnwkt2Bht0ZhpWkIZCphDMzadFsrTSJOM41MmDqUhnkR4dhN6RudB0oK6LRKHi2umtv0vdbHhzH/WMuWHosBU1OdG4GB8frFIjY1rX65f/5hc3T9pVau8u965LEIzDcgf3euTIbtQTHXos2AIZXwwvhjrma8G0V3jzZZK5iaf/CaSJDTVVdh7hp11gLBZPeHA8I5ga2tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+J20JtLgmeAZX6yGz27OoYVmh53OAD7PYyQ5amr4qyY=;
 b=ZPMcGNiTdo8ckHOJjAhyaZQtOkU489DVpp4hlVMcVHfoGpLCV9BcXtQ+p3Qg52DNfdcHPohMVTVbIn5tLQ+QBXJ9KMKajSuUnc7JezAnIKJ/RrtFG2yjJ5j2KJHONBYlKapTTt1wpOcGTtmQT+8rL+T/jReh48rAMrooMMP3keE=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2902.namprd11.prod.outlook.com (2603:10b6:a03:83::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Tue, 7 Jul
 2020 09:32:18 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::3d7d:dfc1:b35d:63d1%7]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 09:32:18 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     Petr Mladek <pmladek@suse.com>
CC:     "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "bfields@redhat.com" <bfields@redhat.com>,
        "cl@rock-chips.com" <cl@rock-chips.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "tj@kernel.org" <tj@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "naresh.kamboju@linaro.org" <naresh.kamboju@linaro.org>,
        "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHY0XSBrdGhyZWFkOiBXb3JrIGNvdWxkIG5vdCBiZSBx?=
 =?gb2312?Q?ueued_when_worker_being_destroyed?=
Thread-Topic: [PATCH v4] kthread: Work could not be queued when worker being
 destroyed
Thread-Index: AQHWVDD52/2V0EhhNEuqN0mWbsCuZKj702GAgAAEqUY=
Date:   Tue, 7 Jul 2020 09:32:18 +0000
Message-ID: <BYAPR11MB26328F18ED623E1FCEB0193AFF660@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200706054647.5344-1-qiang.zhang@windriver.com>,<20200707090621.GC4087@alley>
In-Reply-To: <20200707090621.GC4087@alley>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3bbf3a19-0f20-465b-0c07-08d82258a45b
x-ms-traffictypediagnostic: BYAPR11MB2902:
x-microsoft-antispam-prvs: <BYAPR11MB290253E3C1394C39C3DE16F8FF660@BYAPR11MB2902.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KErgHhtTeoC4tyLT5A9Ag0C8G2ceQg2uhkW104L46h3bGaWl/e56ufWRvTYfQVPDxZac/nbDY1n2F1SwRzsgmrpfD/O6ukj+qglD6xzrKgyx56dUH2jXjMqVyAPagkEkwWUwo4+D3KP4OoOg+WP8yMJbq7XBmenXmZ+6wC+QLXqx5BBTCiy0oZWrJpa2t7784RDuFvHv2w4NIR/7GpJdNnzSGJoYDmqL1li/MerPbKLQJk+RDt+djOSSGV279c9N8PGr6VyflqPNZcAS027aDlXu2x6uJVhTfiCqWHT486AfgE+5T7/N/brMdlQ4H1TY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(346002)(366004)(376002)(396003)(39850400004)(26005)(33656002)(6506007)(4326008)(52536014)(9686003)(71200400001)(224303003)(7696005)(86362001)(2906002)(66446008)(64756008)(66556008)(66476007)(55016002)(7416002)(8936002)(478600001)(186003)(316002)(6916009)(83380400001)(5660300002)(91956017)(76116006)(66946007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Fnzjy16sYtNoiKNpEKJvpesc558LzRT8BajFuf/0sQwfQW/OvFMJi/0G7SlyauzoFDaPeeNeNYLRpZyMO9quI1zJjZPtd0/Yt5G6Sx4NAO0qe+GLMPnWUJj7bIhgq9g4uMIC3w8nJJDAiU/MAhVRM+4C/t1+rvz55LyyMwMoGGz0AtHipLnIJOutCEE+p4PVmRacC1cU7Vt8+ov/85Ozoul2V6uI79K7Bwn1c13qFQ/zunGkVwVdtGHSkNJHHzfUOoFlo6lsaoCf4aGHUf2VZcyuhyF1LLsyzV41qeMVgb6Fb1J5muHFFQChfSzXkrf95Ca3Sj6HN2BmBwFQEbCXOT1E9Fw66c/bkzRMqQD9+Bvl1B2R9W4ifz9BRsBYPbdvHQypDlGonwYJkGf55F51nxZOnzm2UeR51yAtDrFeXnaTA7A4xTn6ReBClcvwuVDRq17bYpwker9faxysbquU6AE5DxdDRLyjA0bVGx0NqA4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bbf3a19-0f20-465b-0c07-08d82258a45b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 09:32:18.1422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vcs6b2L4cDoqF+8kYdbfDMCjE1RQt+gxieBw57lkLf0A8VOTYcFScTzA0b4nqjRU2vmTcphLryibPy7zNmxslTIsLjmv6zIGlo7plMTYLuU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2902
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29ycnksICBQdGVyIE1sYWRlaywgdGhpcyBpcyBteSBtaXN0YWtlIHBsZWFzZSBpZ25vcmUgdGhp
cyBjaGFuZ2UuDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCrei
vP7IyzogbGludXgta2VybmVsLW93bmVyQHZnZXIua2VybmVsLm9yZyA8bGludXgta2VybmVsLW93
bmVyQHZnZXIua2VybmVsLm9yZz4gtPqx7SBQZXRyIE1sYWRlayA8cG1sYWRla0BzdXNlLmNvbT4N
Creiy83KsbzkOiAyMDIwxOo31MI3yNUgMTc6MDYNCsrVvP7IyzogWmhhbmcsIFFpYW5nDQqzrcvN
OiBiZW4uZG9va3NAY29kZXRoaW5rLmNvLnVrOyBiZmllbGRzQHJlZGhhdC5jb207IGNsQHJvY2st
Y2hpcHMuY29tOyBwZXRlcnpAaW5mcmFkZWFkLm9yZzsgdGpAa2VybmVsLm9yZzsgYWtwbUBsaW51
eC1mb3VuZGF0aW9uLm9yZzsgbmFyZXNoLmthbWJvanVAbGluYXJvLm9yZzsgbW0tY29tbWl0c0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCtb3zOI6IFJlOiBb
UEFUQ0ggdjRdIGt0aHJlYWQ6IFdvcmsgY291bGQgbm90IGJlIHF1ZXVlZCB3aGVuIHdvcmtlciBi
ZWluZyBkZXN0cm95ZWQNCg0KT24gTW9uIDIwMjAtMDctMDYgMTM6NDY6NDcsIHFpYW5nLnpoYW5n
QHdpbmRyaXZlci5jb20gd3JvdGU6DQo+IEZyb206IFpoYW5nIFFpYW5nIDxxaWFuZy56aGFuZ0B3
aW5kcml2ZXIuY29tPg0KPg0KPiBCZWZvcmUgdGhlIHdvcmsgaXMgcHV0IGludG8gdGhlIHF1ZXVl
IG9mIHRoZSB3b3JrZXIgdGhyZWFkLA0KPiB0aGUgc3RhdGUgb2YgdGhlIHdvcmtlciB0aHJlYWQg
bmVlZHMgdG8gYmUgZGV0ZWN0ZWQsYmVjYXVzZQ0KPiB0aGUgd29ya2VyIHRocmVhZCBtYXkgYmUg
aW4gdGhlIGRlc3RydWN0aW9uIHN0YXRlIGF0IHRoaXMgdGltZS4NCj4NCj4gU2lnbmVkLW9mZi1i
eTogWmhhbmcgUWlhbmcgPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+DQo+IFN1Z2dlc3RlZC1i
eTogUGV0ciBNbGFkZWsgPHBtbGFkZWtAc3VzZS5jb20+DQo+IFJldmlld2VkLWJ5OiBQZXRyIE1s
YWRlayA8cG1sYWRla0BzdXNlLmNvbT4NCg0KVGhpcyBwYXRjaCBpcyBjb21wbGV0ZWx5IGRpZmZl
cmVudCBmcm9tIHRoZSBvbmUgdGhhdCBJIHN1Z2dlc3RlZA0Kb3IgYWNrZWQuIFBsZWFzZSwgbmV2
ZXIga2VlcCBhY2tzIHdoZW4gZG9pbmcgbWFqb3IgcmV3b3JrIGFuZA0KcGVvcGxlIGRpZCBub3Qg
YWdyZWUgd2l0aCBpdC4NCg0KRm9yIHRoaXMgcGF0Y2g6DQoNCk5hY2tlZC1ieTogUGV0ciBNbGFk
ZWsgPHBtbGFkZWtAc3VzZS5jb20+DQoNClNlZSBiZWxvdyB3aHkuDQoNCg0KPiAtLS0NCj4gIHYx
LT52MjoNCj4gIEFkZCB3YXJuaW5nIGluZm9ybWF0aW9uIGZvciBjb25kaXRpb24gIiF3b3JrZXIt
PnRhc2siLg0KPiAgdjItPnYzOg0KPiAgTW9kaWZ5IHN1Ym1pc3Npb24gaW5mb3JtYXRpb24gYW5k
IGFkZCAiUmV2aWV3ZWQtYnkiIHRhZ3MuDQo+ICB2My0+djQ6DQo+ICBGaXggc3BpIGNvbnRyb2xs
ZXIgcmVnaXN0ZXIgdHJpZ2dlciBXYXJuaW5nLg0KPiAgd2hlbiBhIHNwaSBjb250cm9sbGVyIHJl
Z2lzdGVyLCBhICJrdGhyZWFkX3dvcmtlcl9mbiIgd29ya2VyIGlzIGNyZWF0ZWQNCj4gIHRocm91
Z2ggImt0aHJlYWRfcnVuIiBpbnN0ZWFkIG9mICJrdGhyZWFkX2NyZWF0ZV93b3JrZXIiIHdoaWNo
IGluIHRoaXMNCj4gIGZ1bmMgdGhlICJ3b3JrZXItPnRhc2siIHdpbGwgYmUgaW5pdGlhbGl6ZWQu
IGFuZCB0aGVuIHRoZSAic3BpX3N0YXJ0X3F1ZXVlIg0KPiAgZnVuYyBxdWV1ZSBhIHdvcmsgdG8g
d29ya2VyIHF1ZXVlLCBhdCB0aGlzIHRpbWUsIGlmIHRoZSB3b3JrZXIgaGFzIG5vdA0KPiAgYmVn
aW4gdG8gcnVubmluZywgdGhlICIhd29ya2VyLT50YXNrIiB3aWxsIGJlIHRydWUsIHNvIGEgd2Fy
bmluZyBpcyB0cmlnZ2VyZWQuDQo+DQo+ICBrZXJuZWwva3RocmVhZC5jIHwgNSArKysrKw0KPiAg
MSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEva2VybmVs
L2t0aHJlYWQuYyBiL2tlcm5lbC9rdGhyZWFkLmMNCj4gaW5kZXggYmZiZmE0ODFiZTNhLi44MjVi
ZDRkY2RiOTUgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9rdGhyZWFkLmMNCj4gKysrIGIva2VybmVs
L2t0aHJlYWQuYw0KPiBAQCAtNzkxLDYgKzc5MSwxMSBAQCBzdGF0aWMgaW5saW5lIGJvb2wgcXVl
dWluZ19ibG9ja2VkKHN0cnVjdCBrdGhyZWFkX3dvcmtlciAqd29ya2VyLA0KPiAgew0KPiAgICAg
ICBsb2NrZGVwX2Fzc2VydF9oZWxkKCZ3b3JrZXItPmxvY2spOw0KPg0KPiArICAgICBpZiAoa3Ro
cmVhZF9zaG91bGRfc3RvcCgpKSB7DQoNClRoaXMgZG9lcyBub3QgbWFrZSBtdWNoIHNlbnNlLg0K
DQprdGhyZWFkX3Nob3VsZF9zdG9wKCkgY2hlY2tzIGEgZmxhZyBzZXQgZm9yIHRoZSAiY3VycmVu
dCIgcHJvY2Vzcy4NCkl0IHdvcmtzIG9ubHkgd2hlbiBjYWxsZWQgZnJvbSBpbnNpZGUgdGhlIGt0
aHJlYWQgd29ya2VyIHRocmVhZC4NCg0KcXVldWluZ19ibG9ja2VkKCkgaXMgY2FsbGVkIGZyb20g
a3RocmVhZF9xdWV1ZV93b3JrKCkNCm9yIGt0aHJlYWRfcXVldWVfZGVsYXllZF93b3JrKCkuIFRo
ZXNlIGFyZSB0eXBpY2FsbHkNCmNhbGxlZCBmcm9tIGFub3RoZXIgcHJvY2Vzcy4gVGhlIG9ubHkg
ZXhjZXB0aW9uIGlzIHdoZW4NCnRoZXkgZ2V0IHJlLXF1ZXVlZCBmcm9tIGluc2lkZSB0aGUgd29y
ay4NCg0KQmVzdCBSZWdhcmRzLA0KUGV0cg0KDQoNCj4gKyAgICAgICAgICAgICBXQVJOX09OKDEp
Ow0KPiArICAgICAgICAgICAgIHJldHVybiB0cnVlOw0KPiArICAgICB9DQo+ICsNCj4gICAgICAg
cmV0dXJuICFsaXN0X2VtcHR5KCZ3b3JrLT5ub2RlKSB8fCB3b3JrLT5jYW5jZWxpbmc7DQo+ICB9
DQo+DQo+IC0tDQo+IDIuMjQuMQ0K
