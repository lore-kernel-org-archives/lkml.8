Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C86C3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC3520728
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 04:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eZlIRuCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgCFESF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:18:05 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42924 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbgCFESF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 23:18:05 -0500
Received: by mail-pl1-f195.google.com with SMTP id u3so310682plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 20:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=q3CYCx+AG4CxtBXfsylfrlFjoEuF0NgtIwMxKz5QAI8=;
        b=eZlIRuCjLntGgO2m3aH8kOFt0zPtFqbpGzvjgnQKyYZdHNo2EDf/b7lCfLhKARMn1e
         N6ShRfuFaC+cerKwLrOmn6Qd27G6gZE14vUebKsOaTrN+leW6mSj9lXKFyRYV428Vbe/
         oOAiJH2QUTamX0YL0rXv8qF2QlnOoHhmc8Pr51c2LH6Gk/yLMJoBMWVZaPlaoeGPbLZ7
         0BkAZIE3pA38sRE+h8s71UEs+es9LBGUzds61VuA1UG59yp3WKQjBP8mkNnO6WhQn/BO
         ell7vWOdVCZFkmt6uJUcwTRU5XKSP6HSYMbxCztBq2r1C5f2TqjBrKbkqctHW/T6bCJz
         ebVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=q3CYCx+AG4CxtBXfsylfrlFjoEuF0NgtIwMxKz5QAI8=;
        b=aXom5o79QbPwlnN2XlfHtDVxzicYgWTvWdzHFo7KR9qHnH6s+GR8kQIJ9OSovYuSAP
         DT1DjtOJv6UUFawUpYXlSISAglxwXO8MGSFPUkwe4d/t3ciOzCFyk52WZcKvqy3IDoN4
         9yhHjl7GN9RF6e1oYSB6yhXkbVtwNbX8uak0yJSyUgwE/8/tHId5VtFpUNNbJ+XJPgVU
         jWbMPJR2hWm/mCJDUyM83BJ/N6LVvCi88D4vzvxiQj+fvctTNBVpiHtq09chCaPlrc+f
         37kEEaSCbCKQ7zyhCn4Z4V66T7/7cldlrofru1+Hq8sPOswn/oE8S1H0aJ0GtZlwUlqq
         zOkg==
X-Gm-Message-State: ANhLgQ3OYrOHqp19HjAi0UEmDQ9WIQtkg1VB1kN/+W10fsebZiJK025G
        rsrXn3SOxbJI8ZUGFRee3K67GQ==
X-Google-Smtp-Source: ADFU+vss1S9KBgZTzEnczUxldNHZlF9hyQrQHFKwPREdOhkflC3Zc5NIbYy83ASiBfs91sNxVF2p2w==
X-Received: by 2002:a17:902:8f8a:: with SMTP id z10mr1182965plo.169.1583468283562;
        Thu, 05 Mar 2020 20:18:03 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id 129sm8559790pfw.84.2020.03.05.20.18.02
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2020 20:18:02 -0800 (PST)
Date:   Thu, 5 Mar 2020 20:17:46 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Qian Cai <cai@lca.pw>
cc:     Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
        Alex Shi <alex.shi@linux.alibaba.com>,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name,
        kravetz@us.ibm.com, mhocko@kernel.org, mm-commits@vger.kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, yang.shi@linux.alibaba.com,
        linux-mm@kvack.org
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
In-Reply-To: <97EE83E1-FEC9-48B6-98E8-07FB3FECB961@lca.pw>
Message-ID: <alpine.LSU.2.11.2003052008510.3016@eggly.anvils>
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org> <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw> <20200306033850.GO29971@bombadil.infradead.org> <97EE83E1-FEC9-48B6-98E8-07FB3FECB961@lca.pw>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="0-1123677523-1583468282=:3016"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1123677523-1583468282=:3016
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 5 Mar 2020, Qian Cai wrote:
> > On Mar 5, 2020, at 10:38 PM, Matthew Wilcox <willy@infradead.org> wrote=
:
> >=20
> > On Thu, Mar 05, 2020 at 10:32:18PM -0500, Qian Cai wrote:
> >>> On Mar 5, 2020, at 9:50 PM, akpm@linux-foundation.org wrote:
> >>> The patch titled
> >>>    Subject: mm/vmscan: remove unnecessary lruvec adding
> >>> has been removed from the -mm tree.  Its filename was
> >>>    mm-vmscan-remove-unnecessary-lruvec-adding.patch
> >>>=20
> >>> This patch was dropped because it had testing failures
> >>=20
> >> Andrew, do you have more information about this failure? I hit a bug
> >> here under memory pressure and am wondering if this is related
> >> which might save me some time digging=E2=80=A6

Very likely related.

> >=20
> > See Hugh's message from a few minutes ago:

Thanks Matthew.

> >=20
> > Subject: Re: [PATCH v9 00/21] per lruvec lru_lock for memcg
>=20
> I don=E2=80=99t see it on lore.kernel or anywhere. Private email?

You're right, sorry I didn't notice, lots of ccs but
neither lkml nor linux-mm were on that thread from the start:

From=20hughd@google.com Thu Mar  5 18:16:06 2020
Date: Thu, 5 Mar 2020 18:15:40 -0800 (PST)
From: Hugh Dickins <hughd@google.com>
To: Andew Morton <akpm@linux-foundation.org>, Alex Shi <alex.shi@linux.alib=
aba.com>
Cc: cgroups@vger.kernel.org, mgorman@techsingularity.net, tj@kernel.org, hu=
ghd@google.com, khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com, yang=
=2Eshi@linux.alibaba.com, willy@infradead.org, hannes@cmpxchg.org, lkp@inte=
l.com, Fengguang Wu <fengguang.wu@intel.com>, Rong Chen <rong.a.chen@intel.=
com>
Subject: Re: [PATCH v9 00/21] per lruvec lru_lock for memcg

On Tue, 3 Mar 2020, Alex Shi wrote:
> =E5=9C=A8 2020/3/3 =E4=B8=8A=E5=8D=886:12, Andrew Morton =E5=86=99=E9=81=
=93:
> >> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu=
,
> >> and Yun Wang.
> > I'm not seeing a lot of evidence of review and test activity yet.  But
> > I think I'll grab patches 01-06 as they look like fairly
> > straightforward improvements.
>=20
> cc Fengguang and Rong Chen
>=20
> I did some local functional testing and kselftest, they all look fine.
> 0day only warn me if some case failed. Is it no news is good news? :)

And now the bad news.

Andrew, please revert those six (or seven as they ended up in mmotm).
5.6-rc4-mm1 without them runs my tmpfs+loop+swapping+memcg+ksm kernel
build loads fine (did four hours just now), but 5.6-rc4-mm1 itself
crashed just after starting - seconds or minutes I didn't see,
but it did not complete an iteration.

I thought maybe those six would be harmless (though I've not looked
at them at all); but knew already that the full series is not good yet:
I gave it a try over 5.6-rc4 on Monday, and crashed very soon on simpler
testing, in different ways from what hits mmotm.

The first thing wrong with the full set was when I tried tmpfs+loop+
swapping kernel builds in "mem=3D700M cgroup_disabled=3Dmemory", of course
with CONFIG_DEBUG_LIST=3Dy. That soon collapsed in a splurge of OOM kills
and list_del corruption messages: __list_del_entry_valid < list_del <
__page_cache_release < __put_page < put_page < __try_to_reclaim_swap <
free_swap_and_cache < shmem_free_swap < shmem_undo_range.

When I next tried with "mem=3D1G" and memcg enabled (but not being used),
that managed some iterations, no OOM kills, no list_del warnings (was
it swapping? perhaps, perhaps not, I was trying to go easy on it just
to see if "cgroup_disabled=3Dmemory" had been the problem); but when
rebooting after that, again list_del corruption messages and crash
(I didn't note them down).

So I didn't take much notice of what the mmotm crash backtrace showed
(but IIRC shmem and swap were in it).

Alex, I'm afraid you're focusing too much on performance results,
without doing the basic testing needed - I thought we had given you
some hints on the challenging areas (swapping, move_charge_at_immigrate,
page migration) when we attached a *correctly working* 5.3 version back
on 23rd August:

https://lore.kernel.org/linux-mm/alpine.LSU.2.11.1908231736001.16920@eggly.=
anvils/

(Correctly working, except missing two patches I'd mistakenly dropped
as unnecessary in earlier rebases: but our discussions with Johannes
later showed to be very necessary, though their races rarely seen.)

I have not had the time (and do not expect to have the time) to review
your series: maybe it's one or two small fixes away from being complete,
or maybe it's still fundamentally flawed, I do not know.  I had naively
hoped that you would help with a patchset that worked, rather than
cutting it down into something which does not.

Submitting your series to routine testing is much easier for me than
reviewing it: but then, yes, it's a pity that I don't find the time
to report the results on intervening versions, which also crashed.

What I have to do now, is set aside time today and tomorrow, to package
up the old scripts I use, describe them and their environment, and send
them to you (cc akpm in case I fall under a bus): so that you can
reproduce the crashes for yourself, and get to work on them.

Hugh
--0-1123677523-1583468282=:3016--
