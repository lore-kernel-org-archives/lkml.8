Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563C6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2752073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="L6Peb42i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388665AbgFXXBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:01:45 -0400
Received: from mail-eopbgr1400072.outbound.protection.outlook.com ([40.107.140.72]:14624
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388138AbgFXXBo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:01:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hXKdUTcCpuyrDYIHlbhJM937Jrj6VjeU5/tYCFdVEWdhy2xa113xr+uyS8OCFb8xhSr9zXDvdzmVLu8zLJJvodJKRsafrMxSEbkP+5mbZWfVZPscx+sXcFLATq3mJaL2rHgvo8e76Fbni8nuZr97K45ZTi3uH1Uviu2zgNSVqBP+yW5tcucNUVPb5sW8C+K6fsLWzSakP3nHAYV3nxk6HBT9QooImq7IKMxb+VfF+I6KVlqebmvPk5fnexQp26nHKinarb2f3XPW+2k/Rg8F9iwdxznSIHt16SzspXR60E/5pUXQ0hwc7X2JkzdxanBNS7d4UVbrhQPp6iEXyZOIMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13JgiSH/+frMk3DuwtpmUJLSg8UU5BaC+aLPYHf9NmA=;
 b=dmuoylWzU6iUhEhNTzAzgRt0nB6trX9rf2vAAFzta+oFevNAdTWZFTqzy0RbpCDhZGJYoy9mkri6ZG9b+TkQI1NxXDbuEYJPcgt9TXLXIsCeIa+egH458XzI5YmyD+I7KeufvAU5H8gb1Bns2jyUJJeO2BSR/azxCspEHMl5mGPT+UP6lSQMGj/2iHW+laz+yBnSScrD2s2gAQSxqinTsm+86d+jZ5qpLavLkOY7+Q85K4AeqY9l7im5r3XaoaEDG1/DKl3pNxbqB+kF/Khh8HdVjPzG3pfEB4mMdjPJ+JoJigETzk1F/dMaXDWapvKs5i2hfeGz2DPHG5avn+ODjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13JgiSH/+frMk3DuwtpmUJLSg8UU5BaC+aLPYHf9NmA=;
 b=L6Peb42iM66VEyTVUK0Io2g6CNLXaCkV9arwDLLLrug3SncJY73ARe1D/lQNevzRcW0/ru3ZzWadJoH4Pppo3Ix3akELrIwjUs/xmJzUXvLL1jkA7ZJauAoCe0cerWLD7Qf3B5yeneqrRSBt8s7x/YBPr2Gk5e4TmDkfvc+uiB4=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY1PR01MB1612.jpnprd01.prod.outlook.com (2603:1096:403:1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 23:01:41 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 23:01:41 +0000
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
Thread-Index: AQHWSlwottUppHD7sEaxjlCDSVewGKjoWwgAgAADxICAAANSAA==
Date:   Wed, 24 Jun 2020 23:01:41 +0000
Message-ID: <20200624230140.GA13052@hori.linux.bs1.fc.nec.co.jp>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
 <20200624121742.711331a2a65633a0e16fd9e6@linux-foundation.org>
 <20200624223618.GA13133@hori.linux.bs1.fc.nec.co.jp>
 <20200624154947.2f41c426d4b83fb9241d8584@linux-foundation.org>
In-Reply-To: <20200624154947.2f41c426d4b83fb9241d8584@linux-foundation.org>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux-foundation.org; dkim=none (message not signed)
 header.d=none;linux-foundation.org; dmarc=none action=none
 header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efb62a9b-a34f-4d2c-2a04-08d818928eba
x-ms-traffictypediagnostic: TY1PR01MB1612:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB16127A33167B1AB3BBB532B9E7950@TY1PR01MB1612.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /27ZhlyAxKjouGoPamfx72Y60OVqvHvwX2hC9uF8r2ZOThBw2D3lyzBGtJU3uTGxD9P6gFhVss61GnsIKPA3pmZE0XlKcdaVTYVvwcqP6z57HBKyyk9J4EzGFMuU7Bn+ZsglBKOzFagYclZ/PidvYIkDJdKI0weISXoqtLoCwhbmAlH2OZveCkxrxh8cUfD6SBFLCTrv2v8qwAxuIZDNqGgV0+WGWQc7BQ/sXGn9avvO2RRVe3iMYKHdnttw30tejFEtefOIV0lnf8qczwyjUG2bVHJvFHMFwlPWFZXDCmW1xqG1WoCD2q3IUtGj2Xk+t2SGpDyKWxnWiLmmV/cJ3b4/Ip9xn+SsqQS85hTwpK/5rI4OcP1hi/JFRIPWdSXbFWDL0ETQBDKU53gwtdvRzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(6916009)(26005)(85182001)(8936002)(6486002)(83380400001)(5660300002)(7416002)(966005)(2906002)(6506007)(71200400001)(55236004)(66476007)(66556008)(66446008)(66946007)(33656002)(316002)(86362001)(478600001)(64756008)(4326008)(9686003)(8676002)(76116006)(1076003)(186003)(54906003)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: C+apjbA956Oq1UGMRc7+tCK8IayOKW9K+hJGWH8cnk8G7aqiEPjaR4FgEIckuBKn/6Nw9N1mafzbisDi+5uE48Pgumf1tupK4FyGxWGZ83lOaGCrgHOdyxqB5pOX2kw9z4NQTE76QnMgm+U35J/p0tTgQ8WUrYVejSI1OUrRSO08zBjFfTYPLDqYdtjsV3mqMh53cGkvUpyPplg+mBFmAz38xV4X3DrKKBR0j1UaPmTu+MH/fwH08pjiBL311fCFVp84l6VSqva/GXKeHDNbumwh+b77DK3IrOgslS+KcoH8014xlMnqBiM/nJkDtBi8way1qJhQajicp3jA6TBurHRofq37oFPPZJhWkvDVkLtGF8aXtGPNs6ip7IqmL51ygVGJCFrBls+04vhQLmy4R5w9Pf2H5dk/y7ke8amUB3KbXItiHPCIBvvXo5nKwsXE9Tkixaplv8GTRKrz+3apHrKqc2uFHYkPvpne7mQF8d0r9gEwZMaCq+KmYCa137fh
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <B7CD0E4C7E1B0E479940EACBFB2DBBE3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efb62a9b-a34f-4d2c-2a04-08d818928eba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 23:01:41.0522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4S2iVgbJHW/AIkDNg/XqbUhAC0/jWbcKXEXaIDj94dyG50avuBSUBSV+GJQLQabKvMYRNptHHupGoHaYdcaQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1612
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 03:49:47PM -0700, Andrew Morton wrote:
> On Wed, 24 Jun 2020 22:36:18 +0000 HORIGUCHI NAOYA(=1B$BKY8}!!D>Li=1B(B) =
<naoya.horiguchi@nec.com> wrote:
>=20
> > On Wed, Jun 24, 2020 at 12:17:42PM -0700, Andrew Morton wrote:
> > > On Wed, 24 Jun 2020 15:01:22 +0000 nao.horiguchi@gmail.com wrote:
> > >=20
> > > > I rebased soft-offline rework patchset [1][2] onto the latest mmotm=
.  The
> > > > rebasing required some non-trivial changes to adjust, but mainly th=
at was
> > > > straightforward.  I confirmed that the reported problem doesn't rep=
roduce on
> > > > compaction after soft offline.  For more precise description of the=
 problem
> > > > and the motivation of this patchset, please see [2].
> > > >=20
> > > > I think that the following two patches in v2 are better to be done =
with
> > > > separate work of hard-offline rework, so it's not included in this =
series.
> > > >=20
> > > >   - mm,hwpoison: Take pages off the buddy when hard-offlining
> > > >   - mm/hwpoison-inject: Rip off duplicated checks
> > > >=20
> > > > These two are not directly related to the reported problem, so they=
 seems
> > > > not urgent.  And the first one breaks num_poisoned_pages counting i=
n some
> > > > testcases, and The second patch needs more consideration about comm=
ented point.
> > > >=20
> > >=20
> > > It would be nice to have some sort of overview of the patch series in
> > > this [0/n] email.
> > >=20
> > > > [1] v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-sen=
d-email-n-horiguchi@ah.jp.nec.com/
> > > > [2] v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osa=
lvador@suse.de/
> > >=20
> > > The above have such, but are they up to date?
> >=20
> > The description of the problem doesn't change, but there're some new pa=
tches
> > and some patches are postponed, so I should've added an overview of thi=
s series:
> >=20
> > - patch 1, 2 are cleanups.
> > - patch 3, 4, 5 change the precondition when calling memory_failure(). =
Previously
> >   we sometimes call it with holding refcount of the target page and som=
times call
> >   without holding it, and we passed a flag of whether refcount was take=
n out of
> >   memory_failure().  It was confusing and caused code more complex than=
 needed.
> > - patch 6-10 are cleanups.
> > - patch 11 introduces new logic to remove the error page from buddy all=
ocator,
> >   which is also applied to the path of soft-offling in-use pages in pat=
ch 12.
> > - patch 13 is basically a refactoring but I added some adjustment to ma=
ke sure
> >   that the freed page is surely sent back to buddy instead of being kep=
t in pcplist,
> >   which is based on discussion in v2.
> > - patch 14 fixes the inconsistency of return values between injection i=
nterfaces.
> > - patch 15 is a new patch to complement missing code found in code revi=
ew for
> >   previous version.
> >=20
> > Core change is in patch 11 and 12, and the others are kind of cleanup/r=
efactoring.
>=20
> And all the other words in
> https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-hori=
guchi@ah.jp.nec.com/
> are still accurate and complete?

Yes, they are.

- Naoya=
