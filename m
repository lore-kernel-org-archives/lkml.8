Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3021C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F56B20768
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 22:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="ZtYPk6vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389997AbgFXWgY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 18:36:24 -0400
Received: from mail-eopbgr1320044.outbound.protection.outlook.com ([40.107.132.44]:37222
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732717AbgFXWgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 18:36:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfJH8Hi8E3TmTgm0IZSogMzcZt9mdMbKTFQzmukzSEXF7DB8L4PzZrQLquePZ10YgmOdX3uConHqAkQCL0jaf2Nn/qwYf7RkYMfTuoLt1m5g6i8BOqtU8xmSkRcNfE6SU0TFDUi+tzng09B+Z04UYKEbRn8+q/39WMOGFMzINVfZjbAn4b1tTVbBBS81ULGnOHudx+hk/H6nDSAj2MRPp+xvR6d5h+rltYjANrv9t8Iy4zmM+cmk/ftut1yUZOGY8a97jzWL8pAgcy6ObpKNl/qWpwZzra6sHFEBCTeasBVEAPi9QZX1Rcg8h4B6P1VrDOtHhycT8z7oy8ArYh1EdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1LdQ98+6eAJ6q7NwkHu1nSzDy/O8tGVNs72rYdM6uM=;
 b=RFw2fAN2FLB6Vj0L+hWbxzq+yYw5Apr/PitNBOzqr8G3AYlBGzYDhZNwfuWlmTureWBqA8HLsGzx4X2V0FPOCz6Q/bwuAgQotLt3pAym9HMc/2o4ZiYnOq+gpTPIlJ8mC5oQ/8h9ZJkZwI4xFl4e3KQ85pNpSSSjnsr/QnHu+3kS6oW8p4X+1Tc+EMumxkbwxa+ODcPJlHdB5tdYtLcA+mXJDvw0xW+KtP0v7QOhu3VtRJWNGz4LMmLr4VM/e6bZEV8VQhbgyhWzUXrkBTuPSrBXolccNoS3XBuIyhCKCQJlLi7UBKVoNhuhF3VkOhLomn1r8ki6mv3Id3LQ0LxsYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1LdQ98+6eAJ6q7NwkHu1nSzDy/O8tGVNs72rYdM6uM=;
 b=ZtYPk6vnaOWccs/y60+CpdWfcAPIVeuvezWjwB0anQPVNmIxNQP5cDiEchZDNt7C1nNWIkUIkehoMXaJk1YOCnAXgQRLMbrZYI9tPzDZWXBoWssyWkkp1JkhkpXjcXVHqgMIwaQEHKfeyyXGzXqgj2MsCHNsS4sgUYhUKGEhvUE=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY2PR01MB4076.jpnprd01.prod.outlook.com (2603:1096:404:dc::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 24 Jun
 2020 22:36:18 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 22:36:18 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "zeil@yandex-team.ru" <zeil@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 00/15] HWPOISON: soft offline rework
Thread-Topic: [PATCH v3 00/15] HWPOISON: soft offline rework
Thread-Index: AQHWSlwottUppHD7sEaxjlCDSVewGKjoWwgA
Date:   Wed, 24 Jun 2020 22:36:18 +0000
Message-ID: <20200624223618.GA13133@hori.linux.bs1.fc.nec.co.jp>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
 <20200624121742.711331a2a65633a0e16fd9e6@linux-foundation.org>
In-Reply-To: <20200624121742.711331a2a65633a0e16fd9e6@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5bfc718-85a2-4ce0-9d96-08d8188f0347
x-ms-traffictypediagnostic: TY2PR01MB4076:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4076BB7C086DDCDF568E3DB0E7950@TY2PR01MB4076.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e8rNkTGdeKS1VTo5EDxdms5EmH3QnBK7UV3ZtOyHQJfT9F70ZouT0IbVIz64uO+0vaUqaaK3xmeMNGCEQbL+r/MFrYE4WQFTwUH0Npq65+DjSl8brKGIJqWdwZcYKsSs+nHymZDuI5s19u9VuZF6o6cBLS/7UDhhL03qQvz/XY1pBZngXntv/UKiY3m4TQtTpOZ0XuATHJr1HCL+Oj1NOL7qQTo4GgPexQ2plFubOBuWtm1MdYkrqkVtLERtWEhrV7ORIfR7DDULcyq+EIPHx+BUjU+lPW6I8SMNxhwR09kAeKu5vsZ7ANjEHXQrl0Y4S2r+88CA/5A/ahIBOQ5nGBHTT44TTjN9UXwOm89ICGHm9Sh5CGwlwpS4+KbMYb8+0sEN3YLUeAyXXu92YHqGhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(366004)(346002)(39860400002)(136003)(4326008)(33656002)(85182001)(6916009)(76116006)(66946007)(83380400001)(2906002)(86362001)(54906003)(66556008)(316002)(966005)(71200400001)(6486002)(6512007)(9686003)(5660300002)(478600001)(64756008)(66476007)(186003)(66446008)(7416002)(8936002)(55236004)(1076003)(26005)(8676002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: zrP9I0RZ713hYo75hN0ekSkvraIRD1A1sgYhKzU2oJYhciLtkMsP4JQ66VsBZIidN6jlYe0SmJs9jY4Z3bSCiasmqRY4elQsW0rCX0Tkp9rQZ0ubIsE4uVXVJtvOT8zJ/gG1vz7/pFS+jf24cn+wXtNFC65eRJxzSwN86hTH56c5ccS4VSp7h4DMYbk7TGLKyxO7w3B+116XqG6pPFAjdI9KwMV1B+7mcCHK2LkH4IUsMTZswX1KRlxBufkDAy34nRTttzFlIS7oDXbHPQcMc/zt3OF3KgVCSBqFdoWIo+nwmrXvAcwjtDFqzjpKuF68EETV4R7GimTVtzTEp44FJI8cFaKXuWvdBXQn/stziX0/OoDjN+Qc/6JJ8DjGmj5jEpMWkxw+oHLYzdwdfs6/S1ourdzE8+/aRI2m1i7vCS+Mv/R7GFYIhjw1Ab5c8y21FYAZ9NI3/eMevpG4Fxj34spEerCDXqEIAwcTmzZv7YZKQfs+s+yXh6wtvUAt7XcD
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <1B98CB1C80B07449AD2D8C0681ECF62A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5bfc718-85a2-4ce0-9d96-08d8188f0347
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 22:36:18.6550
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PkXIIYP95GgCppS3sxkoE65IDE6Rdf8LcdyxrmsH/1J/v8TGuYAvdV7uToX+2wdLa6mJjZZngcNXTX8H7xhC3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:17:42PM -0700, Andrew Morton wrote:
> On Wed, 24 Jun 2020 15:01:22 +0000 nao.horiguchi@gmail.com wrote:
>=20
> > I rebased soft-offline rework patchset [1][2] onto the latest mmotm.  T=
he
> > rebasing required some non-trivial changes to adjust, but mainly that w=
as
> > straightforward.  I confirmed that the reported problem doesn't reprodu=
ce on
> > compaction after soft offline.  For more precise description of the pro=
blem
> > and the motivation of this patchset, please see [2].
> >=20
> > I think that the following two patches in v2 are better to be done with
> > separate work of hard-offline rework, so it's not included in this seri=
es.
> >=20
> >   - mm,hwpoison: Take pages off the buddy when hard-offlining
> >   - mm/hwpoison-inject: Rip off duplicated checks
> >=20
> > These two are not directly related to the reported problem, so they see=
ms
> > not urgent.  And the first one breaks num_poisoned_pages counting in so=
me
> > testcases, and The second patch needs more consideration about commente=
d point.
> >=20
>=20
> It would be nice to have some sort of overview of the patch series in
> this [0/n] email.
>=20
> > [1] v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-em=
ail-n-horiguchi@ah.jp.nec.com/
> > [2] v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osalvad=
or@suse.de/
>=20
> The above have such, but are they up to date?

The description of the problem doesn't change, but there're some new patche=
s
and some patches are postponed, so I should've added an overview of this se=
ries:

- patch 1, 2 are cleanups.
- patch 3, 4, 5 change the precondition when calling memory_failure(). Prev=
iously
  we sometimes call it with holding refcount of the target page and somtime=
s call
  without holding it, and we passed a flag of whether refcount was taken ou=
t of
  memory_failure().  It was confusing and caused code more complex than nee=
ded.
- patch 6-10 are cleanups.
- patch 11 introduces new logic to remove the error page from buddy allocat=
or,
  which is also applied to the path of soft-offling in-use pages in patch 1=
2.
- patch 13 is basically a refactoring but I added some adjustment to make s=
ure
  that the freed page is surely sent back to buddy instead of being kept in=
 pcplist,
  which is based on discussion in v2.
- patch 14 fixes the inconsistency of return values between injection inter=
faces.
- patch 15 is a new patch to complement missing code found in code review f=
or
  previous version.

Core change is in patch 11 and 12, and the others are kind of cleanup/refac=
toring.

Thanks,
Naoya Horiguchi=
