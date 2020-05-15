Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB59FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87DC5206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 02:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PTkng51f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgEOCqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 22:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgEOCqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 22:46:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAFFC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 19:46:36 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f13so1172113qkh.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 19:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OMpUBY+Si2XPNxmdOWfPlfJqlBqAS2OaH/pPmfUEX/c=;
        b=PTkng51fM68rwc22zFEzlpUa9DppOiQ+C1BBsMl2ykCflNw18tmzb7azXQO1wnkOON
         HYdWD35Bw/dDMb/S2hWCEWI4+o3x/1OQtJcjQUNbXVv+e13FkmkIMNT0Iv3N1jh8mqRB
         RGswpRMnb39gbHE9eMGVBlxDfdYaNAvPL4qqDw6ydAmnCp8XDyTVV4AKkwrhz2K3yIjB
         eJ88K4ah439ZSvJnlKXZ07uXlBRt7VTlbjYSWN3FkCeRAJIPQR9S49nupGJghhxfOdyQ
         QJxkg4JTESbFI25BI0L2TQC76veBKXnzDHFgELDJyo4vt95yJZw7VJNJtsgX/Yy8jZeC
         z5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=OMpUBY+Si2XPNxmdOWfPlfJqlBqAS2OaH/pPmfUEX/c=;
        b=Rgqi1mHpHUyyhEJwOCPkrXJxsIRJeEAx+AEBpgvriZMRPMXfyGI33H++gawo648pFM
         wLYl5L/7cGEWg6z8X66hcYRODRAWfziy0yztRHy9TmEj8xknQlrD0EhuLy4m5P3/ur8E
         EamHcKCG4i4/+5MVm+XclfOq/ICLklitRwejViCuciz48kdNJf3JMhII3wGC/Wg4JNJ0
         QXhVCZc2R2JXukIO4/RxrdyzocBod55xFd7WaKJbI7fZsuspYZSmXLHFkkN9q/MFU2PF
         f53cMIWV9c+RD+bL7Y882azon8Bi5zri7Q9ueDlCdsT5+ml0T3NcvaUMjy72iB46MUWO
         wNvg==
X-Gm-Message-State: AOAM533JXsMyW5itfYEbqsUTk7nN2/B8Wkmb3AiTNPwmoagZq1C5bY7S
        SNtW5WyzL82LkQJ8FQqo+9lJCw==
X-Google-Smtp-Source: ABdhPJyeJRjlSg+dZoU6FPF+wM4IstAEXfuMBvDliuUpEd/HD5ke4KJOK5d8lhBESLsuHt/FIwr1Zw==
X-Received: by 2002:a37:84a:: with SMTP id 71mr1345992qki.56.1589510795700;
        Thu, 14 May 2020 19:46:35 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k73sm597467qke.132.2020.05.14.19.46.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 19:46:35 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: memory offline infinite loop after soft offline
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20191021031641.GA8007@hori.linux.bs1.fc.nec.co.jp>
Date:   Thu, 14 May 2020 22:46:33 -0400
Cc:     Michal Hocko <mhocko@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DE0721DF-9E5C-4719-B382-01A4A74C04AD@lca.pw>
References: <20191018063222.GA15406@hori.linux.bs1.fc.nec.co.jp>
 <64DC81FB-C1D2-44F2-981F-C6F766124B91@lca.pw>
 <20191021031641.GA8007@hori.linux.bs1.fc.nec.co.jp>
To:     Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Oscar Salvador <osalvador@suse.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 20, 2019, at 11:16 PM, Naoya Horiguchi =
<n-horiguchi@ah.jp.nec.com> wrote:
>=20
> On Fri, Oct 18, 2019 at 07:56:09AM -0400, Qian Cai wrote:
>>=20
>>=20
>>    On Oct 18, 2019, at 2:35 AM, Naoya Horiguchi =
<n-horiguchi@ah.jp.nec.com>
>>    wrote:
>>=20
>>=20
>>    You're right, then I don't see how this happens. If the error =
hugepage was
>>    isolated without having PG_hwpoison set, it's unexpected and =
problematic.
>>    I'm testing myself with v5.4-rc2 (simply ran move_pages12 and did =
hotremove
>>    /hotadd)
>>    but don't reproduce the issue yet.  Do we need specific kernel =
version/
>>    config
>>    to trigger this?
>>=20
>>=20
>> This is reproducible on linux-next with the config. Not sure if it is
>> reproducible on x86.
>>=20
>> =
https://raw.githubusercontent.com/cailca/linux-mm/master/powerpc.config
>>=20
>> and kernel cmdline if that matters
>>=20
>> page_poison=3Don page_owner=3Don numa_balancing=3Denable \
>> systemd.unified_cgroup_hierarchy=3D1 debug_guardpage_minorder=3D1 \
>> page_alloc.shuffle=3D1
>=20
> Thanks for the info.
>=20
>>=20
>> BTW, where does the code set PG_hwpoison for the head page?
>=20
> Precisely speaking, soft offline only sets PG_hwpoison after the =
target
> hugepage is successfully dissolved (then it's not a hugepage any =
more),
> so PG_hwpoison is set on the raw page in =
set_hwpoison_free_buddy_page().
>=20
> In move_pages12 case, madvise(MADV_SOFT_OFFLINE) is called for the =
range
> of 2 hugepages, so the expected result is that page offset 0 and 512
> are marked as PG_hwpoison after injection.
>=20
> Looking at your dump_page() output, the end_pfn is page offset 1
> ("page:c00c000800458040" is likely to point to pfn 0x11601.)
> The page belongs to high order buddy free page, but doesn't have
> PageBuddy nor PageHWPoison because it was not the head page or
> the raw error page.
>=20
>> Unfortunately, this does not solve the problem. It looks to me that =
in           =20
>> soft_offline_huge_page(), set_hwpoison_free_buddy_page() will only =
set           =20
>> PG_hwpoison for buddy pages, so the even the compound_head() has no =
PG_hwpoison  =20
>> set.                                                                  =
           =20
>=20
> Your analysis is totally correct, and this behavior will be fixed by
> the change (https://lkml.org/lkml/2019/10/17/551) in Oscar's rework.
> The raw error page will be taken off from buddy system and the other
> subpages are properly split into lower orderer pages (we'll properly
> manage PageBuddy flags). So all possible cases would be covered by
> branches in __test_page_isolated_in_pageblock.

Naoya, Oscar, it looks like this series was stuck.

https://lkml.org/lkml/2019/10/17/551

I can still reproduce this issue as today. Maybe it is best we could =
post a single patch (which one?) to fix the loop first?




