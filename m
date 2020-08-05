Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1DFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B420206D4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 20:45:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="CFpCx570"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbgHEUpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:45:04 -0400
Received: from mail-eopbgr1400075.outbound.protection.outlook.com ([40.107.140.75]:60952
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725372AbgHEUpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 16:45:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBBri7dtldUVaTSMpEuFkZsey3OjJQuNqfq9Cw/TifauOINKoqPgNQcsV11V5yKp1oDnFmeMrMC27ZI0kkwNjszFBlYADMkjUvmwMi/5FJ4HzYb+YMjckYaDOtgv7DPKMtD0exeoNi4FpyG7Yn/hZobxK8u3zAFEAg/xF8WDVPW8qqCmzVysBDXw8tnlCEUo5LvQjbgA+5tzww2zz2UDWmxCcfFUAOaeO0Ixg9Dxzg8aoy9etiYPBX4Nl66qqtJoaM56CZPoTo+Lb00TpEQmcSW1MNd1maPIQurb+AD6lw1vpdpALftzTHbwEf1VEzUha/rsJ9xKCDhulnb8P2Mr8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW9TWSplx3UtP4kLPRZrj3oFVWwN0fbgzavD/p0NlmY=;
 b=FcnUqQPQXo6Kz98K4D2ij9MmMXZVAwoVE041trFdvAZUH+P8HgfIPO1/mfz1BYd47IGCcU3zSYTC4A9JFAIG6nbDxt3dH6cKDCW6CxJKa/celRkzYpUtee7GakibRp2pW1Ib7KjDE0pi3wqEofge0K6M1AyMsgTdxw6SIhxiEs3l/x3OSwiqzLyvbczxCV5jT9h/KfmzlE1pJjBggY0dHRc6lxE5ZfDYgdp8v97/3heSOYC6d1sE7YNt+aKa47EBZ73vj2fikg6ePX1GEVk822atPGgugJeeqEe+LO9uum20MqytDI2wMNJVE2m5zXGDNs12fuzpkeqtLOxu9qhXEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wW9TWSplx3UtP4kLPRZrj3oFVWwN0fbgzavD/p0NlmY=;
 b=CFpCx5700JuTrQN9XxfDdiQ/rSfWPporFEIvfQL1QfW0i37LncFdOjVskNYg2xg7mKOusqyduax5Mwocj9dVFiR5er/KnZF+vqe1fGKCFpb1ZzpIZHtLjODZWtUmYFhK92RKd8yaVi0NkerBfY1MHu4LnelsvTPY7QkocpXDZnM=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TY1PR01MB1610.jpnprd01.prod.outlook.com (2603:1096:403:5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Wed, 5 Aug
 2020 20:44:58 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042%7]) with mapi id 15.20.3239.022; Wed, 5 Aug 2020
 20:44:58 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Qian Cai <cai@lca.pw>
CC:     "nao.horiguchi@gmail.com" <nao.horiguchi@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "aneesh.kumar@linux.vnet.ibm.com" <aneesh.kumar@linux.vnet.ibm.com>,
        "zeil@yandex-team.ru" <zeil@yandex-team.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/16] HWPOISON: soft offline rework
Thread-Topic: [PATCH v5 00/16] HWPOISON: soft offline rework
Thread-Index: AQHWaclRY/IcAl5ZPUiTqlijcX3D9KknJkIAgAAJNgCAAs+EgA==
Date:   Wed, 5 Aug 2020 20:44:58 +0000
Message-ID: <20200805204457.GB16406@hori.linux.bs1.fc.nec.co.jp>
References: <20200731122112.11263-1-nao.horiguchi@gmail.com>
 <20200803190709.GB8894@lca.pw>
 <20200804011644.GA25028@hori.linux.bs1.fc.nec.co.jp>
 <20200804014942.GC8894@lca.pw>
In-Reply-To: <20200804014942.GC8894@lca.pw>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lca.pw; dkim=none (message not signed)
 header.d=none;lca.pw; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d2208103-ccf7-4bf0-f14e-08d839806abb
x-ms-traffictypediagnostic: TY1PR01MB1610:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY1PR01MB161000DCD76636275C73953FE74B0@TY1PR01MB1610.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zuDMJIcctjCrMW7tpOfTyut51QT/GD0qYdBAFcVKIhAYmtZ2YrSw4iU5nR6KKN3RBPLiEnFxcpx3Y8yoOSkzdmnodbCsBQawyNJHAZ1UsTCZpu750jYKAi2uNBGrPSJ4IOgdfE+3TyHkd2bFZEnnrf+9QoQPXfTxpYToaNpz6dXvxiIVgFClO+IhPz0C/wYl2rSPQgNq0onQly8KyjyhTZEDoIirRLsD9tWCCnch4I1NaKgh6ow+Zk5PsKLAHdBP5INIBaYW06fDaCOX8oCZci5p9p1PkWMfR5L4UwW+a3VhDu0DlC58EDT639tLACE0MTyuwNuUvcWS0LJSbH+wVC+ht/GWcpat9p4iR/dOegIFnX7s/U1wck1ZeZdE7WGrrA3SiAGp5FNkwZUN3t5cDw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(6486002)(2906002)(186003)(33656002)(6512007)(9686003)(4326008)(8676002)(26005)(83380400001)(66946007)(85182001)(71200400001)(6506007)(478600001)(8936002)(966005)(66446008)(316002)(86362001)(76116006)(66476007)(66556008)(64756008)(7416002)(54906003)(1076003)(6916009)(55236004)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BsO+iwIOby8QDBOIzAUs19YjDOar2zBCap3LaiiVtYrOkf1wBjLsRMO89/cr0DHNlBuXcHsODfBDdN8GUJl6OK3kGgaUWe38mTaEhqNnboMw295GiRyErvImS705FO8NIjP+2iQP/txNgAfPiCrsLallb7ahiAoHlzx4fl+ghEm3QPkaLDoPN+6mHcAnPgHC9/tmN17HACoAkmsjYStXcKbrVnOkEekt2BPyzFDSejJnHZfbcF9+FDaUWJ7ocr1R/ZAcQ8xP1V1IAvRGm+P4JPitG0Oj//UxNAhiYVEN4/F8cXOh+eJ30uO4NvwhpHrkfbKy0Sgwiz9xeW4yCWdt2Sc4ena9ozaWTAA+iJjpKaSwmJ92tsLmHPKYlLKcsLOWX/Y42F1T0U1gg8vNKlKpQh1RluLJ3Qhq9AWsKdPiThFcqj73ALQn/pDwbUDKwkYiGNFSU12f10QyHEv4yCZdx4Y9eyH+9/rd//05PU737gC9hOE1CzMJYlMuAiHL3YmF1X0gqWZoDiLRrZ7xlpeCQ8lgvOJf8c8deNXYQsU00P1PAjlLf0isKmnLozDrJnpRi2O9iUkTszFZOvV/4HZOndMO+PPjJioGHD6ZS1ejnbJc9mSKkO93n7pff7iKjcliiypuDpt73g48jknSVto9pw==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <574DB1C497E1CD45980F6F9A27505DBE@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2208103-ccf7-4bf0-f14e-08d839806abb
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2020 20:44:58.0934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hPmUzlNvr1xjrhvCIfl7C7quouhJGEd+K49dOXZB5UBdR+/OIDdcXx8B+oKPiDzk6n3rr9Kc38zsgcdWPXCxYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB1610
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 09:49:42PM -0400, Qian Cai wrote:
> On Tue, Aug 04, 2020 at 01:16:45AM +0000, HORIGUCHI NAOYA(=1B$BKY8}=1B(B =
=1B$BD>Li=1B(B) wrote:
> > On Mon, Aug 03, 2020 at 03:07:09PM -0400, Qian Cai wrote:
> > > On Fri, Jul 31, 2020 at 12:20:56PM +0000, nao.horiguchi@gmail.com wro=
te:
> > > > This patchset is the latest version of soft offline rework patchset
> > > > targetted for v5.9.
> > > >=20
> > > > Main focus of this series is to stabilize soft offline.  Historical=
ly soft
> > > > offlined pages have suffered from racy conditions because PageHWPoi=
son is
> > > > used to a little too aggressively, which (directly or indirectly) i=
nvades
> > > > other mm code which cares little about hwpoison.  This results in u=
nexpected
> > > > behavior or kernel panic, which is very far from soft offline's "do=
 not
> > > > disturb userspace or other kernel component" policy.
> > > >=20
> > > > Main point of this change set is to contain target page "via buddy =
allocator",
> > > > where we first free the target page as we do for normal pages, and =
remove
> > > > from buddy only when we confirm that it reaches free list. There is=
 surely
> > > > race window of page allocation, but that's fine because someone rea=
lly want
> > > > that page and the page is still working, so soft offline can happil=
y give up.
> > > >=20
> > > > v4 from Oscar tries to handle the race around reallocation, but tha=
t part
> > > > seems still work in progress, so I decide to separate it for change=
s into
> > > > v5.9.  Thank you for your contribution, Oscar.
> > > >=20
> > > > The issue reported by Qian Cai is fixed by patch 16/16.
> > > >=20
> > > > This patchset is based on v5.8-rc7-mmotm-2020-07-27-18-18, but I ap=
plied
> > > > this series after reverting previous version.
> > > > Maybe https://github.com/Naoya-Horiguchi/linux/commits/soft-offline=
-rework.v5
> > > > shows what I did more precisely.
> > > >=20
> > > > Any other comment/suggestion/help would be appreciated.
> > >=20
> > > There is another issue with this patchset (with and without the patch=
 [1]).
> > >=20
> > > [1] https://lore.kernel.org/lkml/20200803133657.GA13307@hori.linux.bs=
1.fc.nec.co.jp/
> > >=20
> > > Arm64 using 512M-size hugepages starts to fail allocations prematurel=
y.
> > >=20
> > > # ./random 1
> > > - start: migrate_huge_offline
> > > - use NUMA nodes 0,1.
> > > - mmap and free 2147483648 bytes hugepages on node 0
> > > - mmap and free 2147483648 bytes hugepages on node 1
> > > madvise: Cannot allocate memory
> > >=20
> > > [  284.388061][ T3706] soft offline: 0x956000: hugepage isolation fai=
led: 0, page count 2, type 17ffff80001000e (referenced|uptodate|dirty|head)
> > > [  284.400777][ T3706] Soft offlining pfn 0x8e000 at process virtual =
address 0xffff80000000
> > > [  284.893412][ T3706] Soft offlining pfn 0x8a000 at process virtual =
address 0xffff60000000
> > > [  284.901539][ T3706] soft offline: 0x8a000: hugepage isolation fail=
ed: 0, page count 2, type 7ffff80001000e (referenced|uptodate|dirty|head)
> > > [  284.914129][ T3706] Soft offlining pfn 0x8c000 at process virtual =
address 0xffff80000000
> > > [  285.433497][ T3706] Soft offlining pfn 0x88000 at process virtual =
address 0xffff60000000
> > > [  285.720377][ T3706] Soft offlining pfn 0x8a000 at process virtual =
address 0xffff80000000
> > > [  286.281620][ T3706] Soft offlining pfn 0xa000 at process virtual a=
ddress 0xffff60000000
> > > [  286.290065][ T3706] soft offline: 0xa000: hugepage migration faile=
d -12, type 7ffff80001000e (referenced|uptodate|dirty|head)
> >=20
> > I think that this is due to the lack of contiguous memory.
> > This test program iterates soft offlining many times for hugepages,
> > so finally one page in every 512MB will be removed from buddy, then we
> > can't allocate hugepage any more even if we have enough free pages.
> > This is not good for heavy hugepage users, but that should be intended.
> >=20
> > It seems that random.c calls madvise(MADV_SOFT_OFFLINE) for 2 hugepages=
,
> > and iterates it 1000 (=3D=3DNR_LOOP) times, so if the system doesn't ha=
ve
> > enough memory to cover the range of 2000 hugepages (1000GB in the Arm64
> > system), this ENOMEM should reproduce as expected.
>=20
> Well, each iteration will mmap/munmap, so there should be no leaking.=20
>=20
> https://gitlab.com/cailca/linux-mm/-/blob/master/random.c#L376
>=20
> It also seem to me madvise(MADV_SOFT_OFFLINE) does start to fragment memo=
ry
> somehow, because after this "madvise: Cannot allocate memory" happened, I
> immediately checked /proc/meminfo and then found no hugepage usage at all=
.
>=20
> >=20
> > >=20
> > > Reverting this patchset and its dependency patchset [2] (reverting th=
e
> > > dependency alone did not help) fixed it,
> >=20
> > But it's still not clear to me why this was not visible before this
> > patchset, so I need more check for it.

I've reproduced ENOMEM with v5.8 (without this patchset) simply by using
VM with small memory (4GB). So this specific error seems not to be caused
by this series.

Thanks,
Naoya Horiguchi=
