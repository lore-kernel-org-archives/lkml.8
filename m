Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD84DC35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 07:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 807582072A
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 07:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="b3EWJEel"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgBIHPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 02:15:49 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6413 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725856AbgBIHPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 02:15:48 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3fb1950000>; Sat, 08 Feb 2020 23:15:33 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 08 Feb 2020 23:15:47 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 08 Feb 2020 23:15:47 -0800
Received: from [10.2.168.157] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 9 Feb
 2020 07:15:47 +0000
Subject: Re: [PATCH] mm: fix a data race in put_page()
To:     Qian Cai <cai@lca.pw>
CC:     Marco Elver <elver@google.com>, Jan Kara <jack@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
References: <5402183a-2372-b442-84d3-c28fb59fa7af@nvidia.com>
 <8602A57D-B420-489C-89CC-23D096014C47@lca.pw>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1a179bea-fd71-7b53-34c5-895986c24931@nvidia.com>
Date:   Sat, 8 Feb 2020 23:12:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <8602A57D-B420-489C-89CC-23D096014C47@lca.pw>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581232533; bh=wjG49hByqLN66EPjA1v8gaQtgrxSiSZBB9BPZmnH7A0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=b3EWJEelmm627JvqIaLU4arFl7f13Xcl+6rx30LH1UiX9DYyGfpsGVYvecDcwcwBe
         2ZTpRnsmdVwf6aULmvHjy0RkhtfoXtP2P8liqoN91WISyIRgANTnA9qjyx14DoGJFz
         MeEb9g9iwFR0ohyS29uM2wcdd4OPr7g1frIFYCV2Q24mowy7WqECzhYaF2wfJi2kSy
         bmjQCcEEwpHq+ouly/aKUv/jzY0WmIDTgzsYJzRQSQ9IMnk/FgABwiF+clSbTe30nl
         pQkeM4kBsfJYwotPLFVj2Xvx2HWhfSBGdC1IJigl5og87dxhoKwX3eSkuiZRD2e7zl
         mrYCToeTWroZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/20 7:10 PM, Qian Cai wrote:
>=20
>=20
>> On Feb 8, 2020, at 8:44 PM, John Hubbard <jhubbard@nvidia.com> wrote:
>>
>> So it looks like we're probably stuck with having to annotate the code. =
Given
>> that, there is a balance between how many macros, and how much commentin=
g. For
>> example, if there is a single macro (data_race, for example), then we'll=
 need to
>> add comments for the various cases, explaining which data_race situation=
 is
>> happening.
>=20
> On the other hand, it is perfect fine of not commenting on each data_race=
() that most of times, people could run git blame to learn more details. Ac=
tually, no maintainers from various of subsystems asked for commenting so f=
ar.
>=20

Well, maybe I'm looking at this wrong. I was thinking that one should attem=
pt to
understand the code on the screen, and that's generally best--but here, may=
be
"data_race" is just something that means "tool cruft", really. So mentally =
we
would move toward visually filtering out the data_race "key word".

I really don't like it but at least there is a significant benefit from the=
 tool
that probably makes it worth the visual noise.

Blue sky thoughts for The Far Future: It would be nice if the tools got a l=
ot
better--maybe in the direction of C language extensions, even if only used =
in
this project at first.

thanks,
--=20
John Hubbard
NVIDIA

>>
>> That's still true, but to a lesser extent if more macros are added. In t=
his case,
>> I suspect that READ_BITS() makes the commenting easier and shorter. So I=
'd tentatively
>> lead towards adding it, but what do others on the list think?
>=20
> Even read bits could be dangerous from data races and confusing at best, =
so I am not really sure what the value of introducing this new macro. Peopl=
e who like to understand it correctly still need to read the commit logs.
>=20
> This flags->zonenum is such a special case that I don=E2=80=99t really se=
e it regularly for the last few weeks digging KCSAN reports, so even if it =
is worth adding READ_BITS(), there are more equally important macros need t=
o be added together to be useful initially. For example, HARMLESS_COUNTERS(=
), READ_SINGLE_BIT(), READ_IMMUTATABLE_BITS() etc which Linus said exactly =
wanted to avoid.
>=20
