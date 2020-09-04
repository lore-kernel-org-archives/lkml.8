Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068C3C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 01:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2C5D20767
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 01:49:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=windriversystems.onmicrosoft.com header.i=@windriversystems.onmicrosoft.com header.b="DG3U7dhT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgIDBsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 21:48:42 -0400
Received: from mail-co1nam11on2054.outbound.protection.outlook.com ([40.107.220.54]:22913
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728288AbgIDBsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 21:48:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gW3p7+RxcGgiVxOjM/V8XKYUPpRGgIDHEWCwkbLLIQkXoRUxeJ72Q1rHfzSfRbJ+3KuuEaGmnW4wpREU0iSAPNqUOlukd2iEEJGUt8E6aTqT0eoaBzDp4d3PM1HMmsuUsO11O+TcMVL/UK4fcme21inpYy+FzrMNhYPnHSpOdU73ASIREyWTumcweFO+UtQf+/j8sE0lK4PXRFaJhyrPOdUSo/v7OtBFeJ9sj5ofH3q0ktt9otuKB1ymAaqzofRjTMYbRjvEYP4EVGiDgtlv7ls9ij7Jix2MogFxY6iToXkch43gXQ2CcrFzQGv3JGaEyC1M1GHSePYlIelEZQb5qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrS1WS5gA8lH+sQ7mDdLJdOyc1fB0S6mZ52ILbnK0QE=;
 b=Er2HO2l2zF4UC5oWC8XMVkQxvC6+97d54sdlkxSpBLEb94CH0kvaS1YqAjkecHANmIMGWyk+VRcTUZOLpAhOiM8tEFbYnfSOQNKW2ya9GvEFSXX3/yxWhhudO7N6e1izMO92pMO9wVU/qk69XSfTHyLhpiNGRw7pIrWDj88Z/2pWqFarm6H/PnEyMLLV29SWWP/WTtc3B6Qs5bgpjUr9Ke+Qxu5iz9PiovuNDhcuxaPcvPlQHaQYrB6xs4HiGzaO/RFxCQG3mU/QYjQT/a4rSJV7hKCn49QQndXRpbuoFwcrrxXUd7zLQjPJ8qRLTLPBAY7qYtsBWA7VYob7kpnFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrS1WS5gA8lH+sQ7mDdLJdOyc1fB0S6mZ52ILbnK0QE=;
 b=DG3U7dhTgmM7EpNim1odd2bsjotjIssN2PBklwgnYUmq6CbY3bmMk/639VvVsg+xMq9q+SZb02BSMLeQL99TubrGF8XiPh/Zx0kecNwWAtO+GETDZg12puZ/IpXoMvI23EP6pEygoVF+vZY9lDHG1PzobdeWLIi4k8/XgUNWCQw=
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4183.namprd11.prod.outlook.com (2603:10b6:a03:18e::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Fri, 4 Sep
 2020 01:48:39 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::21a8:8895:6487:5126%6]) with mapi id 15.20.3348.015; Fri, 4 Sep 2020
 01:48:39 +0000
From:   "Zhang, Qiang" <Qiang.Zhang@windriver.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "elver@google.com" <elver@google.com>,
        Ingo Molnar <mingo@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIHYyXSBkZWJ1Z29iamVjdHM6IGluc3RhbGwgY3B1IGhv?=
 =?gb2312?Q?tplug_callback?=
Thread-Topic: [PATCH v2] debugobjects: install cpu hotplug callback
Thread-Index: AQHWfDAO5jpQA5SJrUqpN2M1RBCMy6lXwXwr
Date:   Fri, 4 Sep 2020 01:48:39 +0000
Message-ID: <BYAPR11MB2632C578C5863019114EE572FF2D0@BYAPR11MB2632.namprd11.prod.outlook.com>
References: <20200827050614.15100-1-qiang.zhang@windriver.com>
In-Reply-To: <20200827050614.15100-1-qiang.zhang@windriver.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
x-originating-ip: [60.247.85.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ede5622a-356d-44fc-4bc3-08d85074a54f
x-ms-traffictypediagnostic: BY5PR11MB4183:
x-microsoft-antispam-prvs: <BY5PR11MB4183EFA7CD6B86C5222434EBFF2D0@BY5PR11MB4183.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YHCZEnUKAi6w5BjO/4I7Sqmn0tIYzpcWM5jyLOdyDAa3pAIE69dpfvmHrfA3fexHzKY1Pdk3oBTG4WsasJLs9KrDcGi5tqiFvaOXf7wx9TUBsbQLYgGTgbRl3tK2kSnv0rEqutDdKpvFguCn2QZoL8cz6MMzB1HacfxGETf/s8MYgvvFiYnQhqMYXFaHgTmmxBsumtMgwgvUhvSrfYxhZB/UGkBE6JW6H/lWNGWN1x3E1hKLFXvLrQaLu1UWYS9t4MvJrL24McHFU2D1SZklNdCZi5LvQuFrT0mFEepv334f2RJcSsmbohkwWqOTxAEmb3CG9XASb/ku1Eoo5K2pHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(366004)(39850400004)(136003)(66946007)(6506007)(86362001)(316002)(26005)(55016002)(71200400001)(224303003)(7696005)(9686003)(186003)(2906002)(33656002)(4326008)(110136005)(66446008)(66556008)(5660300002)(76116006)(66476007)(83380400001)(8936002)(478600001)(52536014)(91956017)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: wl83jJqKilBH0jEiWXI6ACLgekmnaBrPW7/eGc+gz0iVKEjbrnjJJ9QBr7TL+Rajq2NoTaEYh3LoSHZhLBFPjc7ZPWbXdodIfmhCU34r2qFqC8wlSgviQoEdaBX2PGz1cmThQzUMGsUEP0X0SIx2HImdpxMjWivezEw3j2h18PKZLoBlZ33axi1DhYMvzWO+4a3F8DsyHccmsPQ+kJGQ/FkQ2PJc0aORKQtz9iUq8b/oWFaaU5bMIbkilSqTncXX3PDB7rxdGFvqlUNh5cEyKsdwkIuh2V5qbEe3Wr26Aaou+9V10b6IzE64MxAIKOPvSo127PNkZFg1OPkqMepp8pMi1YJHS2rWzngKFsnxlVAFARkCJH5qMCnNJy4nt46IswTZhkFcoKwAhYENdihR7fPwJZ9xb6ZK2/QxQ7z+6nfu78HKbsnY2vfJrQVKjDgA9VUvmJLeXlfKXmbfltWVTo/onqv42oRmgAeSdze2zydtqkngidikO9r6p1J8EdZ+y4KDYQ8sjwVaVv8GJEinIymr8iM8kCHMjCgMcL61I1USb3BvePNF3SlGC33EeIrHbhbCz29JsetIo+afdBLqvbaq+sW7IXMakI8J3vbvDDElVQyPdnUSRAHloUtwVFdzx7KKv05hUtA1SZejeYZbDw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ede5622a-356d-44fc-4bc3-08d85074a54f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2020 01:48:39.1371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjwBYzJjF8bbL5YuNNifoHAMXaE1Grrog3PFaoodTBVYlQXNtinz7alf/JJJzAXsm1mrPmzyQ380r3NOL+YA0YNMqBA1cyVaitjwwIxMIIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4183
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dGdseCBwbGVhc2UgcmV2aWV3LgoKVGhhbmtzClFpYW5nCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18Kt6K8/sjLOiBsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwu
b3JnIDxsaW51eC1rZXJuZWwtb3duZXJAdmdlci5rZXJuZWwub3JnPiC0+rHtIHFpYW5nLnpoYW5n
QHdpbmRyaXZlci5jb20gPHFpYW5nLnpoYW5nQHdpbmRyaXZlci5jb20+Creiy83KsbzkOiAyMDIw
xOo41MIyN8jVIDEzOjA2CsrVvP7IyzogdGdseEBsaW51dHJvbml4LmRlOyBsb25nbWFuQHJlZGhh
dC5jb207IGVsdmVyQGdvb2dsZS5jb20Ks63LzTogbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZwrW98ziOiBbUEFUQ0ggdjJdIGRlYnVnb2JqZWN0czogaW5zdGFsbCBjcHUgaG90cGx1ZyBjYWxs
YmFjawoKRnJvbTogWnFpYW5nIDxxaWFuZy56aGFuZ0B3aW5kcml2ZXIuY29tPgoKRHVlIHRvIGNw
dSBob3RwbHVnLCBpdCBtYXkgbmV2ZXIgYmUgb25saW5lIGFmdGVyIGl0J3Mgb2ZmbGluZSwKc29t
ZSBvYmplY3RzIGluIHBlcmNwdSBwb29sIGlzIG5ldmVyIGZyZWUsIGluIG9yZGVyIHRvIGF2b2lk
CnRoaXMgaGFwcGVuaW5nLCBpbnN0YWxsIGNwdSBob3RwbHVnIGNhbGxiYWNrLCBjYWxsIHRoaXMg
Y2FsbGJhY2sKZnVuYyB0byBmcmVlIG9iamVjdHMgaW4gcGVyY3B1IHBvb2wgd2hlbiBjcHUgZ29p
bmcgb2ZmbGluZS4KClNpZ25lZC1vZmYtYnk6IFpxaWFuZyA8cWlhbmcuemhhbmdAd2luZHJpdmVy
LmNvbT4KLS0tCiB2MS0+djI6CiBNb2RpZnkgc3VibWlzc2lvbiBpbmZvcm1hdGlvbi4KCiBpbmNs
dWRlL2xpbnV4L2NwdWhvdHBsdWcuaCB8ICAxICsKIGxpYi9kZWJ1Z29iamVjdHMuYyAgICAgICAg
IHwgMjMgKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY3B1aG90cGx1Zy5oIGIvaW5jbHVk
ZS9saW51eC9jcHVob3RwbHVnLmgKaW5kZXggYTI3MTBlNjU0YjY0Li4yZTc3ZGI2NTVjZmEgMTAw
NjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvY3B1aG90cGx1Zy5oCisrKyBiL2luY2x1ZGUvbGludXgv
Y3B1aG90cGx1Zy5oCkBAIC0zNiw2ICszNiw3IEBAIGVudW0gY3B1aHBfc3RhdGUgewogICAgICAg
IENQVUhQX1g4Nl9NQ0VfREVBRCwKICAgICAgICBDUFVIUF9WSVJUX05FVF9ERUFELAogICAgICAg
IENQVUhQX1NMVUJfREVBRCwKKyAgICAgICBDUFVIUF9ERUJVR19PQkpfREVBRCwKICAgICAgICBD
UFVIUF9NTV9XUklURUJBQ0tfREVBRCwKICAgICAgICBDUFVIUF9NTV9WTVNUQVRfREVBRCwKICAg
ICAgICBDUFVIUF9TT0ZUSVJRX0RFQUQsCmRpZmYgLS1naXQgYS9saWIvZGVidWdvYmplY3RzLmMg
Yi9saWIvZGVidWdvYmplY3RzLmMKaW5kZXggZmU0NTU3OTU1ZDk3Li41MGUyMWVkMDUxOWUgMTAw
NjQ0Ci0tLSBhL2xpYi9kZWJ1Z29iamVjdHMuYworKysgYi9saWIvZGVidWdvYmplY3RzLmMKQEAg
LTE5LDYgKzE5LDcgQEAKICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAjaW5jbHVkZSA8bGludXgv
aGFzaC5oPgogI2luY2x1ZGUgPGxpbnV4L2ttZW1sZWFrLmg+CisjaW5jbHVkZSA8bGludXgvY3B1
Lmg+CgogI2RlZmluZSBPREVCVUdfSEFTSF9CSVRTICAgICAgIDE0CiAjZGVmaW5lIE9ERUJVR19I
QVNIX1NJWkUgICAgICAgKDEgPDwgT0RFQlVHX0hBU0hfQklUUykKQEAgLTQzMyw2ICs0MzQsMjMg
QEAgc3RhdGljIHZvaWQgZnJlZV9vYmplY3Qoc3RydWN0IGRlYnVnX29iaiAqb2JqKQogICAgICAg
IH0KIH0KCisjaWYgZGVmaW5lZChDT05GSUdfSE9UUExVR19DUFUpCitzdGF0aWMgaW50IG9iamVj
dF9jcHVfb2ZmbGluZSh1bnNpZ25lZCBpbnQgY3B1KQoreworICAgICAgIHN0cnVjdCBkZWJ1Z19w
ZXJjcHVfZnJlZSAqcGVyY3B1X3Bvb2w7CisgICAgICAgc3RydWN0IGhsaXN0X25vZGUgKnRtcDsK
KyAgICAgICBzdHJ1Y3QgZGVidWdfb2JqICpvYmo7CisKKyAgICAgICBwZXJjcHVfcG9vbCA9IHBl
cl9jcHVfcHRyKCZwZXJjcHVfb2JqX3Bvb2wsIGNwdSk7CisgICAgICAgaGxpc3RfZm9yX2VhY2hf
ZW50cnlfc2FmZShvYmosIHRtcCwgJnBlcmNwdV9wb29sLT5mcmVlX29ianMsIG5vZGUpIHsKKyAg
ICAgICAgICAgICAgIGhsaXN0X2RlbCgmb2JqLT5ub2RlKTsKKyAgICAgICAgICAgICAgIGttZW1f
Y2FjaGVfZnJlZShvYmpfY2FjaGUsIG9iaik7CisgICAgICAgfQorCisgICAgICAgcmV0dXJuIDA7
Cit9CisjZW5kaWYKKwogLyoKICAqIFdlIHJ1biBvdXQgb2YgbWVtb3J5LiBUaGF0IG1lYW5zIHdl
IHByb2JhYmx5IGhhdmUgdG9ucyBvZiBvYmplY3RzCiAgKiBhbGxvY2F0ZWQuCkBAIC0xMzY3LDYg
KzEzODUsMTEgQEAgdm9pZCBfX2luaXQgZGVidWdfb2JqZWN0c19tZW1faW5pdCh2b2lkKQogICAg
ICAgIH0gZWxzZQogICAgICAgICAgICAgICAgZGVidWdfb2JqZWN0c19zZWxmdGVzdCgpOwoKKyNp
ZiBkZWZpbmVkKENPTkZJR19IT1RQTFVHX0NQVSkKKyAgICAgICBjcHVocF9zZXR1cF9zdGF0ZV9u
b2NhbGxzKENQVUhQX0RFQlVHX09CSl9ERUFELCAib2JqZWN0Om9mZmxpbmUiLCBOVUxMLAorICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgb2JqZWN0X2NwdV9vZmZsaW5lKTsK
KyNlbmRpZgorCiAgICAgICAgLyoKICAgICAgICAgKiBJbmNyZWFzZSB0aGUgdGhyZXNob2xkcyBm
b3IgYWxsb2NhdGluZyBhbmQgZnJlZWluZyBvYmplY3RzCiAgICAgICAgICogYWNjb3JkaW5nIHRv
IHRoZSBudW1iZXIgb2YgcG9zc2libGUgQ1BVcyBhdmFpbGFibGUgaW4gdGhlIHN5c3RlbS4KLS0K
Mi4xNy4xCgo=
