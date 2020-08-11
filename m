Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39524C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 103B2206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 03:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="azkdk1LI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgHKDLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 23:11:44 -0400
Received: from mail-eopbgr1410048.outbound.protection.outlook.com ([40.107.141.48]:64000
        "EHLO JPN01-OS2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726981AbgHKDLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 23:11:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJ6gETDiGwTPJI+4KS2uFrRMr9NiFixar+k02L1AKayMD3o/LGFGDDKXwY//C9vy1DRMpcDER4CzV1jVobzyMFUv/DCDLgT8fAFWMC288k7+EvLTPBL9XrEh7BYCuquQVpP03UgsMFx0xdxmsprtTZPqk27Z+bQzF+xeXtM4hf6LPyn63pDzimSDshAmljXVrI3782bww+u6pHpzO2QtRzszYWpjde9Z+qNEK0BvbkfEeTo03QsToSY36vrzbuKDKywsUW9y+Opt6BCg/ZZ3O3jR3XIo03o+zN3ZnQBKnhbV0RUmRkGc6Tr7rCr9evoJrKcfMTAVO732wMZTU49PUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me3dk6tzEbJMXBBRyR3SlqF8kuWjc4BSqDBn+TumMDQ=;
 b=OR44U0RwLrQ3FlbnRxZjFl+rCIvqNZRIiZLX0zBI+I3LlntmKQWnh71fVeTjxwEX5USVHVNLMXtwc3VkKmN4GD9jkCd0fDrhJn4NvffB38vDKonMPnBFo01yjLKxeuoVfNqnsuzMv+6zvGeK5PpwyeIvzYTkh3/OW6b0JX9YYWhi6lSI22ACK6BUQ9zTg4ffu+2NjdwYP/Wff9D8sa2xNPKKsuXGgaUfSSlwyUYWAoErGziFDwIce+ki0rkRTb9Tz++6+eodWOgJ5nn8xTJAqqA5gQ38EAhvEuKGfrHfQUmafw451TwunIY7K4aKDw1SS8Eqk2rtWpG2F6Z1T2sRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me3dk6tzEbJMXBBRyR3SlqF8kuWjc4BSqDBn+TumMDQ=;
 b=azkdk1LIyAjeoyg3AxGqsGpulHJFFp2tcVz3w/tMZWax5KOQSSTzxNKcyRhjWxpUb53Yr+4qA2WV6JcOHztJKlrbWkVKM1ZIxLEoR38Kf+PfzERVGW6TrxaTUeWniYvUHr+mbDMBIP8yhVOJtVHxojcCIfM0yGDXqTbhojC9ZVs=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (2603:1096:404:74::14)
 by TYBPR01MB5486.jpnprd01.prod.outlook.com (2603:1096:404:802d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18; Tue, 11 Aug
 2020 03:11:40 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::21d2:e51a:a880:2042%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 03:11:40 +0000
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
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH v6 00/12] HWPOISON: soft offline rework
Thread-Topic: [PATCH v6 00/12] HWPOISON: soft offline rework
Thread-Index: AQHWbyom92sGRlXQfk+BXW7m7bWNQ6kyO+2A
Date:   Tue, 11 Aug 2020 03:11:40 +0000
Message-ID: <20200811031139.GA7145@hori.linux.bs1.fc.nec.co.jp>
References: <20200806184923.7007-1-nao.horiguchi@gmail.com>
 <20200810152254.GC5307@lca.pw>
In-Reply-To: <20200810152254.GC5307@lca.pw>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lca.pw; dkim=none (message not signed)
 header.d=none;lca.pw; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 958eb7c0-e420-4f57-39a5-08d83da44457
x-ms-traffictypediagnostic: TYBPR01MB5486:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYBPR01MB5486AA2FA38742C6F8839CF7E7450@TYBPR01MB5486.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oXyoRUM4kan+9iXw9360Dsluv2S2h5IF3olg3DI3H2tcsmYbmPyickUc9yWaY6Kw+t4Ec8rMhs+WjdRfDAhhv8UL16EqyVvmZsB975WR6wG8CKDWGKQqScZBGEmJdqnFCcoLKyADHqRe9ZYejaeZ4R4Rl2j5NTC+wkQ2wf4Nr5tXPTMTpOmVRD3OkGDg2FgwriNeT7rySu+4LxKh9QbflXPUDQv45DNlfwvhStC+ZzALpaA6nwI1areu5kgbC8dP0Oh7qoJ9r0mKKUh/qsm9JNdr6McQ9NYnL68uJ83+54eVJJ6IEMkQAqcG+3C7uJW8I3CG0D7BjNdw/QmeA0i0T1wqKMhtLEmmWLpjUZRyCqLsX8BzsbuqM/y2Ncf/14hw/wAUDeWFEYEyXEA8yqbyOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(8676002)(9686003)(966005)(55236004)(8936002)(33656002)(6506007)(71200400001)(86362001)(186003)(26005)(2906002)(83380400001)(64756008)(66446008)(5660300002)(6486002)(6916009)(54906003)(66556008)(85182001)(66946007)(66476007)(6512007)(76116006)(478600001)(7416002)(316002)(4326008)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bO4zbS0u6+TqBuy1mDyR2dwSF8TkGkx8HaxwYQnVrSTrdDbm5rij4ZQN6xgVaumhjMKqwQFR2NCJgAevEmkspUyjQFd9/WgLLXZ1YAUdVQ0vxsHuR25D6AkqOPCQBOgr4T5I0e/LiM7ie+NbU3fEAXLDt3Imm7FgpCPLVaHaCTvgukx+6ak261LxARXKaGYRZBytux4KAbIbH1vsQhN1MABZIbjKCLsAdh5zNECmoWUhWwh/bDM7EqjDF852cmlEQR93bVjW0jPsyryF62tkSjhuIWq31KggoN9KFejR81RWJ8IpLV7iLzvOO/y5wsL1BRAwsVqyNnW6Xb4rR7cDl39wdfJ7m66LJS4YyxZ6chTA5JVaDPRo8/UcQkbCN9A3jTk4oGhvxZNUaKWccZmu+shRZHKgpBRIZqFyk2va3C8blUXdX6FSaxmKP63bHUGjg7h5RLfpK0QDBgzGUKSozYR/0YRSM9EKBqmsW/TZ9eu1xoyvCnvIiJ7yj1Fi0F7IhCqEp7nlaROZy2hJ0USUql3b2SqQoLW2iVk1xjtLcHGvRZ/9z6HJL9LRdqEvAJIRVWr4Tkbtb3iLmqD6EXGlc7IUej0CPiR2L8apTaqqOT7qNcqYClB1Ui4IflpS4Bj8dwrju4EzkZp+5gDNtEGhYQ==
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <0E671F1123F4F14E8A06168884936EE9@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3210.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 958eb7c0-e420-4f57-39a5-08d83da44457
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 03:11:40.2583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ld/99Nys2kf0faOYCY+FZpXBcYFuACUADmsDrbBI7S1zV3v28EEqn3QZKx083vZpyvxrp1+JuFonL37VfITfGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYBPR01MB5486
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 11:22:55AM -0400, Qian Cai wrote:
> On Thu, Aug 06, 2020 at 06:49:11PM +0000, nao.horiguchi@gmail.com wrote:
> > Hi,
> >=20
> > This patchset is the latest version of soft offline rework patchset
> > targetted for v5.9.
> >=20
> > Since v5, I dropped some patches which tweak refcount handling in
> > madvise_inject_error() to avoid the "unknown refcount page" error.
> > I don't confirm the fix (that didn't reproduce with v5 in my environmen=
t),
> > but this change surely call soft_offline_page() after holding refcount,
> > so the error should not happen any more.
>=20
> With this patchset, arm64 is still suffering from premature 512M-size hug=
epages
> allocation failures.
>=20
> # git clone https://gitlab.com/cailca/linux-mm
> # cd linux-mm; make
> # ./random 1
> - start: migrate_huge_offline
> - use NUMA nodes 0,1.
> - mmap and free 2147483648 bytes hugepages on node 0
> - mmap and free 2147483648 bytes hugepages on node 1
> madvise: Cannot allocate memory
>=20
> [  292.456538][ T3685] soft offline: 0x8a000: hugepage isolation failed: =
0, page count 2, type 7ffff80001000e (referenced|uptodate|dirty|head)
> [  292.469113][ T3685] Soft offlining pfn 0x8c000 at process virtual addr=
ess 0xffff60000000
> [  292.983855][ T3685] Soft offlining pfn 0x88000 at process virtual addr=
ess 0xffff40000000
> [  293.271369][ T3685] Soft offlining pfn 0x8a000 at process virtual addr=
ess 0xffff60000000
> [  293.834030][ T3685] Soft offlining pfn 0xa000 at process virtual addre=
ss 0xffff40000000
> [  293.851378][ T3685] soft offline: 0xa000: hugepage migration failed -1=
2, type 7ffff80001000e (referenced|uptodate|dirty|head)
>=20
> The fresh-booted system still had 40G+ memory free before running the tes=
t.

As I commented over v5, this failure is expected and it doesn't mean kernel
issue.  Once we successfully soft offline a hugepage, the memory range
covering the hugepage will never participate in hugepage because one of the
subpages is removed from buddy.  So if you iterate soft offlining hugepages=
,
all memory range are "holed" finally, and no hugepage will be available in
the system.

Please fix your test program to properly determine nubmer of loop (NR_LOOP)
so that you can assume that you can always allocate hugepage during testing=
.
For example, if you can use 40G memory and hugepage size is 512MB, NR_LOOP
should not be larger than 80.

>=20
> Reverting the following commits allowed the test to run succesfully over =
and over again.
>=20
> "mm, hwpoison: remove recalculating hpage"
> "mm,hwpoison-inject: don't pin for hwpoison_filter"
> "mm,hwpoison: Un-export get_hwpoison_page and make it static"
> "mm,hwpoison: kill put_hwpoison_page"
> "mm,hwpoison: unify THP handling for hard and soft offline"
> "mm,hwpoison: rework soft offline for free pages"
> "mm,hwpoison: rework soft offline for in-use pages"
> "mm,hwpoison: refactor soft_offline_huge_page and __soft_offline_page"

I'm still not sure why the test succeeded by reverting these because
current mainline kernel provides similar mechanism to prevent reuse of
soft offlined page. So this success seems to me something suspicious.

To investigate more, I want to have additional info about the page states
of the relevant pages after soft offlining.  Could you collect it by the
following steps?

  - modify random.c not to run hotplug_memory() in migrate_huge_hotplug_mem=
ory(),
  - compile it and run "./random 1" once,
  - to collect page state with hwpoisoned pages, run "./page-types -Nlr -b =
hwpoison",
    where page-types is available under tools/vm in kernel source tree.
  - choose a few pfns of soft offlined pages from kernel message
    "Soft offlining pfn ...", and run "./page-types -Nlr -a <pfn>".

Thanks,
Naoya Horiguchi

>=20
> i.e., it is not enough to only revert,
>=20
> mm,hwpoison: double-check page count in __get_any_page()
> mm,hwpoison: introduce MF_MSG_UNSPLIT_THP
> mm,hwpoison: return 0 if the page is already poisoned in soft-offline
> =
