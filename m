Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A006AC3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A44A2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 14:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="gRRfcW+L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgCFOyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:54:51 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:37959 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgCFOyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 09:54:51 -0500
Received: by mail-qv1-f67.google.com with SMTP id g16so1039852qvz.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 06:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Bqd6ZYkkbQZsjUZxOCU8aqreR8WWA0WqwI2veaijy9M=;
        b=gRRfcW+LPsQTVdeJewFIIRnlA202F8zGYP2AgclMBTeb0CBxB1TbU0/qiLa9bcWTNV
         ZYUkdFX63Ngz0qQYmBBAsGy750bWhxRAb1MoZ7Pq1akjCaHE2OoE36CcoAhYypW1cZP6
         4u8ShZYAvWn3C7OxQcK6b5spWaL/Cs4q/ZfbkevewKc9RIu1xoVTzTGT1scVhrdvoTss
         m/BJDhoiPFtdoKoGm7PFC20AWbeUO7zOJ3IUGNaJPCxI6kJtfVd962xNN7zqEsoKS6db
         8MGRymHyT9+8k7YXy8dkFFtqgl6nhSBT5b8pzTKiQEa3pPvUSWUSmBUW/M2e5p1rJpIC
         jiCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Bqd6ZYkkbQZsjUZxOCU8aqreR8WWA0WqwI2veaijy9M=;
        b=BVs9ld9WrG2LodtyRGOB4UDPh0fRZPcRkSAyVvDKyQ1gQotzVsvpsUqIB0q9Q7mMgS
         tR84wgaAVk2j3ANV+bYCPnuKFa08/cL4SaAa2LbBtzJDezpVClBjfLw5HSfZmrAdcAiN
         qzbPf19tpv6vV4XF+WPQr9dkW0VS66Qamg/KLVBMuxQtVsSURPg2Ckq5jSq5oJ/hjHsc
         CeVK0hBp7wgCeGZR4FFzB5EY6QtO/B+sYA7iwAEADyFG+z431JbqMpwFECFokPo8fbsG
         Sms4ZAj+fSa5u05s9XsdcSCOcKTMuaBpCgQQoNj1xQM6G+wI1jbAZxyB+iDJdDuNJL4o
         OVIQ==
X-Gm-Message-State: ANhLgQ1Kdhp0V8dFyjevYf+v5adgh0mRmHXjOZwf4Mo+wIYHeE7bPV25
        APSp0YqdYEm1CXZZTFVd+QKBVA==
X-Google-Smtp-Source: ADFU+vtpqlVu9kBXDV+OWxw1CwkNjTyc3KvT1BBOrBwFLLi3fGybwAnVngU+gPyyWiBeEgltwxQACA==
X-Received: by 2002:a05:6214:1351:: with SMTP id b17mr3209331qvw.73.1583506489751;
        Fri, 06 Mar 2020 06:54:49 -0800 (PST)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 4sm6355655qkm.22.2020.03.06.06.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 06:54:48 -0800 (PST)
Date:   Fri, 6 Mar 2020 09:54:48 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Qian Cai <cai@lca.pw>, Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
        Alex Shi <alex.shi@linux.alibaba.com>,
        daniel.m.jordan@oracle.com, khlebnikov@yandex-team.ru,
        kirill@shutemov.name, kravetz@us.ibm.com, mhocko@kernel.org,
        mm-commits@vger.kernel.org, tj@kernel.org, vdavydov.dev@gmail.com,
        yang.shi@linux.alibaba.com, linux-mm@kvack.org
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
Message-ID: <20200306145448.GC2508@cmpxchg.org>
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
 <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
 <20200306033850.GO29971@bombadil.infradead.org>
 <97EE83E1-FEC9-48B6-98E8-07FB3FECB961@lca.pw>
 <alpine.LSU.2.11.2003052008510.3016@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.LSU.2.11.2003052008510.3016@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 08:17:46PM -0800, Hugh Dickins wrote:
> On Tue, 3 Mar 2020, Alex Shi wrote:
> > 在 2020/3/3 上午6:12, Andrew Morton 写道:
> > >> Thanks for Testing support from Intel 0day and Rong Chen, Fengguang Wu,
> > >> and Yun Wang.
> > > I'm not seeing a lot of evidence of review and test activity yet.  But
> > > I think I'll grab patches 01-06 as they look like fairly
> > > straightforward improvements.
> > 
> > cc Fengguang and Rong Chen
> > 
> > I did some local functional testing and kselftest, they all look fine.
> > 0day only warn me if some case failed. Is it no news is good news? :)
> 
> And now the bad news.
> 
> Andrew, please revert those six (or seven as they ended up in mmotm).
> 5.6-rc4-mm1 without them runs my tmpfs+loop+swapping+memcg+ksm kernel
> build loads fine (did four hours just now), but 5.6-rc4-mm1 itself
> crashed just after starting - seconds or minutes I didn't see,
> but it did not complete an iteration.
> 
> I thought maybe those six would be harmless (though I've not looked
> at them at all); but knew already that the full series is not good yet:
> I gave it a try over 5.6-rc4 on Monday, and crashed very soon on simpler
> testing, in different ways from what hits mmotm.
> 
> The first thing wrong with the full set was when I tried tmpfs+loop+
> swapping kernel builds in "mem=700M cgroup_disabled=memory", of course
> with CONFIG_DEBUG_LIST=y. That soon collapsed in a splurge of OOM kills
> and list_del corruption messages: __list_del_entry_valid < list_del <
> __page_cache_release < __put_page < put_page < __try_to_reclaim_swap <
> free_swap_and_cache < shmem_free_swap < shmem_undo_range.
> 
> When I next tried with "mem=1G" and memcg enabled (but not being used),
> that managed some iterations, no OOM kills, no list_del warnings (was
> it swapping? perhaps, perhaps not, I was trying to go easy on it just
> to see if "cgroup_disabled=memory" had been the problem); but when
> rebooting after that, again list_del corruption messages and crash
> (I didn't note them down).
> 
> So I didn't take much notice of what the mmotm crash backtrace showed
> (but IIRC shmem and swap were in it).
> 
> Alex, I'm afraid you're focusing too much on performance results,
> without doing the basic testing needed - I thought we had given you
> some hints on the challenging areas (swapping, move_charge_at_immigrate,
> page migration) when we attached a *correctly working* 5.3 version back
> on 23rd August:
> 
> https://lore.kernel.org/linux-mm/alpine.LSU.2.11.1908231736001.16920@eggly.anvils/
> 
> (Correctly working, except missing two patches I'd mistakenly dropped
> as unnecessary in earlier rebases: but our discussions with Johannes
> later showed to be very necessary, though their races rarely seen.)
>
> I have not had the time (and do not expect to have the time) to review
> your series: maybe it's one or two small fixes away from being complete,
> or maybe it's still fundamentally flawed, I do not know.  I had naively
> hoped that you would help with a patchset that worked, rather than
> cutting it down into something which does not.

I'm a bit confused by this. I, and I believe Alex, kept going down a
different path because it didn't sound like there was a solution to
the compaction race. As I remember, the conversation ended on this:

: Your race here (again, lruvec lock taken then PageLRU observed, but
: page->mem_cgroup changed in between) really questions my whole scheme:
: I am not going to propose a solution now, I'll have to go back and
: recheck my assumptions all over.  Certainly isolate_migratepage_block()
: has a harder job than any other, but I need to re-review it all.

https://lore.kernel.org/lkml/alpine.LSU.2.11.1911221616580.1144@eggly.anvils/

That's certainly why I kept looking and eventually proposed using
PageLRU clearing as a lock. Maybe there is a better way to do it, but
I didn't see it.

An LRU list corruption in page_cache_release() suggests a bug in the
way this new locking scheme works or is applied - rather than a
gratuitous divergence from your series that could have been avoided.

> Submitting your series to routine testing is much easier for me than
> reviewing it: but then, yes, it's a pity that I don't find the time
> to report the results on intervening versions, which also crashed.
> 
> What I have to do now, is set aside time today and tomorrow, to package
> up the old scripts I use, describe them and their environment, and send
> them to you (cc akpm in case I fall under a bus): so that you can
> reproduce the crashes for yourself, and get to work on them.

I think that would be very useful. tmpfs+loop+swapping+memcg+ksm
kernel builds aren't exactly a go-to test case for most mm developers
(although maybe they should be!)
