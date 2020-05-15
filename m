Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2909CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA8BB20758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=necglobal.onmicrosoft.com header.i=@necglobal.onmicrosoft.com header.b="L+ydJpXv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgEODsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 23:48:16 -0400
Received: from mail-eopbgr1320072.outbound.protection.outlook.com ([40.107.132.72]:61075
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726176AbgEODsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 23:48:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcPsb97L1z7NRT7FvbDz8xnUjmJEyYeCmR258C2kCLajNaQFcOjpIzLu6OHbFlfr+ukEqHGPkqEVu8FyDOiAKEDPZR4COLLWqut+b8vTMSL3ZSb/QzTtswUC/Tjjch/HuF9BdsTHZmX+/ZnS2OYF9F67r6cyrgty3+obZ9So02OtUZweCPBLamtzgAPI1TgoiuI0w1FAzfGv6b7c3ig3X4+FuTge+D+WRZei6vZic1VL4PaKZTjR5/lhj0+y1nXc1trLJW3hKPcQSMLjWRLGZiaUW7DlkJ6BcRpOsL24jDgVzAyPD7QOWeWoee5XwLiDGPVvTpOyq00/sJF+8lxZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRa0sqwmZXtQirLHYe8GCnwWOQvtpoA5AZi91b4qO7Y=;
 b=ccTZXcd+WjmGCzmiRMzG1ApOzCJNbLwB5NCpUTLECcQlH9NHi8uUNBRr8d/wyPlDaF2i6Ib+O0hWetYPldT5EdttpOvJ4+46VIFDmLw3n1OgEmZev0Bj9NKq61nuDnJfaVMKsabLHrB29wJZ+P7kuD46nK6ulV3/iCXTAEP7qg79XdkAACdrviUVw1gIHXkpYcMmwtLgc1koiMHIhO0rzcN6X83/8A5V0VO2nIa2P+e2wDMRp0MY6kSVHzX980HsEwW5B6Za0xfLNm2hUU10hGpCYapU0mPkMKX+qTPLnZv60op0ZI0/xKmBwXRkTW+1ThEcT0GwX+S8aEjgQ4ZHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=necglobal.onmicrosoft.com; s=selector1-necglobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRa0sqwmZXtQirLHYe8GCnwWOQvtpoA5AZi91b4qO7Y=;
 b=L+ydJpXvQntIf8T07xqGg83ab/G5dCch4C3t8iWweGimtXkRa41D67qZKvsO0eOUu8CsQFiRm6ljb309Zl6s5YGzk8MTESaLugVvHluqveV3FyjXd4EKnnUuHObH+q+sJUzuS1WRsxQC3cw52ctrGXrjyq8uCWTNzlVBKKwLu58=
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com (20.177.98.142) by
 TY2PR01MB2171.jpnprd01.prod.outlook.com (52.133.182.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.27; Fri, 15 May 2020 03:48:10 +0000
Received: from TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58]) by TY2PR01MB3210.jpnprd01.prod.outlook.com
 ([fe80::3841:ec9f:5cdf:f58%5]) with mapi id 15.20.2979.033; Fri, 15 May 2020
 03:48:10 +0000
From:   =?iso-2022-jp?B?SE9SSUdVQ0hJIE5BT1lBKBskQktZOH0hIUQ+TGkbKEIp?= 
        <naoya.horiguchi@nec.com>
To:     Qian Cai <cai@lca.pw>
CC:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>,
        Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: memory offline infinite loop after soft offline
Thread-Topic: memory offline infinite loop after soft offline
Thread-Index: AQHWKmMR+OImEsyoBU+Os1O8O47V2qiogoWA
Date:   Fri, 15 May 2020 03:48:10 +0000
Message-ID: <20200515034809.GA27576@hori.linux.bs1.fc.nec.co.jp>
References: <20191018063222.GA15406@hori.linux.bs1.fc.nec.co.jp>
 <64DC81FB-C1D2-44F2-981F-C6F766124B91@lca.pw>
 <20191021031641.GA8007@hori.linux.bs1.fc.nec.co.jp>
 <DE0721DF-9E5C-4719-B382-01A4A74C04AD@lca.pw>
In-Reply-To: <DE0721DF-9E5C-4719-B382-01A4A74C04AD@lca.pw>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lca.pw; dkim=none (message not signed)
 header.d=none;lca.pw; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.110.202]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: adb44e31-0e48-4366-b323-08d7f882c973
x-ms-traffictypediagnostic: TY2PR01MB2171:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB217141AF07F24076D018A142E7BD0@TY2PR01MB2171.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 04041A2886
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HjiExkaObhvVwhtl1WXTc0ueXYUnZX4P5sKjuFwgEuWYfYkA4uQkJdcidG+pq8w+te1JNUelDZwDvn4aUb2TU6fyzH/RU2I/Ob2hm5295X6f3BaFljHK4JKViogRgKwVNzbYCUn+3daxpkGIJveGkUnNvc6e5m2MhDQaHvMvdOSEGQIz42UqrKmqaDPkzT/JpFD4MpDS+qHKNHomxtgX3iCEHuHvQLM6OU5VLclv18TejkgSunBt8CuhcjsSUq331A2ZUZnKmZFpTWmZKD09S0BuK04vN4ZVA9nFtcgqjq1HLjxisNqSbpzREnAV6yW9Y+KaNS4JJvhe0HkTdhwQZUOtZSBcQhYm/qj7+XrXd+c7UvR96MxjsDgUdcZrmR6YJ7HsZG4LoI0MP9Lm913vwUP8wGZ1jSZTTIKHAbtT5SSXpqUNIzU/JpBr9z2170hPUjWGg6gYAxJhLWPNnQe8avoL6/J1w9/McpYPwRMMFht8uBq4aNjS9d51Ch54o67upjufCa18DYhQWnw9VtsPHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3210.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(6506007)(498600001)(53546011)(54906003)(966005)(8676002)(186003)(6916009)(6486002)(26005)(1076003)(85182001)(4326008)(76116006)(86362001)(55236004)(2906002)(71200400001)(8936002)(66556008)(6512007)(9686003)(83080400001)(64756008)(33656002)(66476007)(66446008)(66946007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: GvceLKeLMKG1kvHrq/rgKiZo4o+O4o0oPXwDrI22WnOp99Bdqqtg3IkKTx9IwlH/I8euvH1/cOpineSeNVxvLv53YpL0LTDlDh/YzW9s8nqvxjjIhjiDvzoLaxHvbJhf9mlARbEq9l4v+bJFTVQmiVc8iKSlLxElnxcCP5P5MFMhT88HPxavyX1fXuv4C4wnd/Qn/A4qU1r4PysVo9LH0uR4biP9BIe4mDoiD7M8tnXuVYC0MXre8/jQmgjM+gBPcLhnfCJgjU2akHqOIRigUK2ljZLGRxl/RCQWkHL1j/CyYk3tNUAeq0rj5ZIgJRDYJDnyFW82zKCpKP7xS5yrM8jdieSaQfaI33Z4puPcKA6Ac6J2e4K3DP5HizPdoN5VjwFiRRKEP2Vj8CogjjmtwVb5M7Bn/Z1Z7US+8tDlvYHTuq5PkXSVqfmQevzMPkyNsoeMDC93Nt+XxBt6jS7NfV9fg55XdQ4aUBKfKSNo7536GiNmwcuhHw3FGwZpUBPC
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <50CBFE582D1C6140995E0C2FFA112B47@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adb44e31-0e48-4366-b323-08d7f882c973
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2020 03:48:10.4325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOpzZDBh2a3CBqNCaSxnWjaYFXGQa3BYKtXTMECjRND0QUldIyDzZUBiHS3FkKNZv4WlW+uqd513F1cqbQRbSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:46:33PM -0400, Qian Cai wrote:
>=20
>=20
> > On Oct 20, 2019, at 11:16 PM, Naoya Horiguchi <n-horiguchi@ah.jp.nec.co=
m> wrote:
> >=20
> > On Fri, Oct 18, 2019 at 07:56:09AM -0400, Qian Cai wrote:
> >>=20
> >>=20
> >>    On Oct 18, 2019, at 2:35 AM, Naoya Horiguchi <n-horiguchi@ah.jp.nec=
.com>
> >>    wrote:
> >>=20
> >>=20
> >>    You're right, then I don't see how this happens. If the error hugep=
age was
> >>    isolated without having PG_hwpoison set, it's unexpected and proble=
matic.
> >>    I'm testing myself with v5.4-rc2 (simply ran move_pages12 and did h=
otremove
> >>    /hotadd)
> >>    but don't reproduce the issue yet.  Do we need specific kernel vers=
ion/
> >>    config
> >>    to trigger this?
> >>=20
> >>=20
> >> This is reproducible on linux-next with the config. Not sure if it is
> >> reproducible on x86.
> >>=20
> >> https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.confi=
g
> >>=20
> >> and kernel cmdline if that matters
> >>=20
> >> page_poison=3Don page_owner=3Don numa_balancing=3Denable \
> >> systemd.unified_cgroup_hierarchy=3D1 debug_guardpage_minorder=3D1 \
> >> page_alloc.shuffle=3D1
> >=20
> > Thanks for the info.
> >=20
> >>=20
> >> BTW, where does the code set PG_hwpoison for the head page?
> >=20
> > Precisely speaking, soft offline only sets PG_hwpoison after the target
> > hugepage is successfully dissolved (then it's not a hugepage any more),
> > so PG_hwpoison is set on the raw page in set_hwpoison_free_buddy_page()=
.
> >=20
> > In move_pages12 case, madvise(MADV_SOFT_OFFLINE) is called for the rang=
e
> > of 2 hugepages, so the expected result is that page offset 0 and 512
> > are marked as PG_hwpoison after injection.
> >=20
> > Looking at your dump_page() output, the end_pfn is page offset 1
> > ("page:c00c000800458040" is likely to point to pfn 0x11601.)
> > The page belongs to high order buddy free page, but doesn't have
> > PageBuddy nor PageHWPoison because it was not the head page or
> > the raw error page.
> >=20
> >> Unfortunately, this does not solve the problem. It looks to me that in=
           =20
> >> soft_offline_huge_page(), set_hwpoison_free_buddy_page() will only set=
           =20
> >> PG_hwpoison for buddy pages, so the even the compound_head() has no PG=
_hwpoison  =20
> >> set.                                                                  =
           =20
> >=20
> > Your analysis is totally correct, and this behavior will be fixed by
> > the change (https://lkml.org/lkml/2019/10/17/551) in Oscar's rework.
> > The raw error page will be taken off from buddy system and the other
> > subpages are properly split into lower orderer pages (we'll properly
> > manage PageBuddy flags). So all possible cases would be covered by
> > branches in __test_page_isolated_in_pageblock.
>=20
> Naoya, Oscar, it looks like this series was stuck.
>=20
> https://lkml.org/lkml/2019/10/17/551
>=20
> I can still reproduce this issue as today. Maybe it is best we could post=
 a single patch (which one?) to fix the loop first?

I'm very sorry to be quiet for long, but I think that I agree with
this patchset and try to see what happend if merged into mmtom,
although we need rebaseing to latest mmotm and some basic testing.=
