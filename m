Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39108C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0683A20716
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 19:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L46dV9k/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbgCMTuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 15:50:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42691 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgCMTuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 15:50:17 -0400
Received: by mail-oi1-f193.google.com with SMTP id 13so1769396oiy.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 12:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OccFZlfpxWSnstsDfX/t5uC4ktJwbst7Ql+mBPW6PVU=;
        b=L46dV9k/PzM9QibypV4eC4knKS0FospEIgjO0pKLmL165/ljUyO1wMUpMarNZMSC0L
         DFLjnQTReeU4uRUinvMYBZKAvzuO5MS7vAiSrMDO6bnlnkunbTzqXVl407N0L2OsHPV5
         ReXdVu7++HhTBhMlqfLP+Xq1corIFcIt2I6cVXmVUnRmr22xwa0RNLQs4sXymJxNwJS/
         J00GoDl61Vc139H+EDhsYtgQ9KZgNmCDKXFi1ozNo0nmG+Fen/RZf59UG3dH1/3031AV
         xkoFy2+8AddbRkZVnrP2Egjeo7/JRe+NuUJTjSoX2eyNGLab2W1sTS8rYgYeqAeOldyC
         /pUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OccFZlfpxWSnstsDfX/t5uC4ktJwbst7Ql+mBPW6PVU=;
        b=Y7JxK9QPPNCLKdTCDRdG7mZ39S5AJVXOZCPfmGPuC+1RfZOhH2iBuky7Ea0orA010h
         PIp1HbyTvlFWgpxy+t7S6fPBI8EcqWd7LD6YqiUUK956/z6yGizNoPYWQP48lGe8aJKO
         sZB1IBvetH0RNzKSGmy14o0S5moOBUKfZj233NKTOSSOYYDb3SjSgSsv8mVShMRQarvq
         hYulL3dzlIAUa/Xz/905PS/vugnEPoeIyt6QnSQNvOha8cNEtczEDrDwWuNbEr0ksFiE
         P/AuONWLyvXwkKyK4xrF3DY/fo5wqXYjN7dS4/3h32K+ZpP95iwE7bv/nMWQJx3y4CAE
         lb5w==
X-Gm-Message-State: ANhLgQ0EN5j6rZ2toxyi1l29dAd+7ox/hnw7sqSbRr7fbufAL6dUaE4m
        WaXHICWlFi1rmhUAvCpulDaLR7JrBXP/1lVKSeG/7w==
X-Google-Smtp-Source: ADFU+vuK5rsLC27IKgedSMZOd3/7MdVEra22iRgF8H1TVNIMVjy3OhlzxllzrbKh/L8EAM3AjLpbkW+q10p4CfDXGys=
X-Received: by 2002:aca:ed54:: with SMTP id l81mr8669490oih.69.1584129015069;
 Fri, 13 Mar 2020 12:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <1584124476-76534-1-git-send-email-yang.shi@linux.alibaba.com>
 <CALvZod4W9kkh578Kix7+M9Jkwm1sxx2zvvPG+0Us3R8bEkpEpg@mail.gmail.com> <520b3295-9fb8-04a7-6215-9bfda4f1a268@linux.alibaba.com>
In-Reply-To: <520b3295-9fb8-04a7-6215-9bfda4f1a268@linux.alibaba.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 13 Mar 2020 12:50:04 -0700
Message-ID: <CALvZod6VQ4PWNh=LKifx-8CfUMeeafE0ZoEswG3x2pXxKbRAxA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: swap: make page_evictable() inline
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 12:46 PM Yang Shi <yang.shi@linux.alibaba.com> wrote:
>
>
>
> On 3/13/20 12:33 PM, Shakeel Butt wrote:
> > On Fri, Mar 13, 2020 at 11:34 AM Yang Shi <yang.shi@linux.alibaba.com> wrote:
> >> When backporting commit 9c4e6b1a7027 ("mm, mlock, vmscan: no more
> >> skipping pagevecs") to our 4.9 kernel, our test bench noticed around 10%
> >> down with a couple of vm-scalability's test cases (lru-file-readonce,
> >> lru-file-readtwice and lru-file-mmap-read).  I didn't see that much down
> >> on my VM (32c-64g-2nodes).  It might be caused by the test configuration,
> >> which is 32c-256g with NUMA disabled and the tests were run in root memcg,
> >> so the tests actually stress only one inactive and active lru.  It
> >> sounds not very usual in mordern production environment.
> >>
> >> That commit did two major changes:
> >> 1. Call page_evictable()
> >> 2. Use smp_mb to force the PG_lru set visible
> >>
> >> It looks they contribute the most overhead.  The page_evictable() is a
> >> function which does function prologue and epilogue, and that was used by
> >> page reclaim path only.  However, lru add is a very hot path, so it
> >> sounds better to make it inline.  However, it calls page_mapping() which
> >> is not inlined either, but the disassemble shows it doesn't do push and
> >> pop operations and it sounds not very straightforward to inline it.
> >>
> >> Other than this, it sounds smp_mb() is not necessary for x86 since
> >> SetPageLRU is atomic which enforces memory barrier already, replace it
> >> with smp_mb__after_atomic() in the following patch.
> >>
> >> With the two fixes applied, the tests can get back around 5% on that
> >> test bench and get back normal on my VM.  Since the test bench
> >> configuration is not that usual and I also saw around 6% up on the
> >> latest upstream, so it sounds good enough IMHO.
> >>
> >> The below is test data (lru-file-readtwice throughput) against the v5.6-rc4:
> >>          mainline        w/ inline fix
> >>            150MB            154MB
> >>
> > What is the test setup for the above experiment? I would like to get a repro.
>
> Just startup a VM with two nodes, then run case-lru-file-readtwice or
> case-lru-file-readonce in vm-scalability in root memcg or with memcg
> disabled.  Then get the average throughput (dd result) from the test.
> Our test bench uses the script from lkp, but I just ran it manually.
> Single node VM should be more obvious showed in my test.
>

Thanks, I will try this on a real machine.
