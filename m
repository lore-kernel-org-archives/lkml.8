Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A81C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1E820773
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 14:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="icvfQlKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgFROiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 10:38:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51481 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730804AbgFROiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 10:38:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592491087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kR8hgd7C1aRuJxjGr8WKWNlO51iJPFeA6wAT6FeN9mY=;
        b=icvfQlKxLy2tRreWqNpTUN7ZrgXzp9Z2d78tRoZ0VVRwkzyZylpj7U+jsN+MM8SxZ/ZMru
        bnASD1mJVpAh9okK2vsXCnYqSvxA3fGCFtcdV/ZQn0IcxvR46im2KavTIz60069TEEiMLi
        nGVCiTfiQ7Zk8ZtZ5HXtorgVTafa4MM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-sIDRt17RMzWxaOfSqB8lDQ-1; Thu, 18 Jun 2020 10:38:04 -0400
X-MC-Unique: sIDRt17RMzWxaOfSqB8lDQ-1
Received: by mail-qt1-f199.google.com with SMTP id k23so4558382qtb.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 07:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kR8hgd7C1aRuJxjGr8WKWNlO51iJPFeA6wAT6FeN9mY=;
        b=X7Xp8lU6VtzmE5E3Xt2NxIrDiNkUxcYrz26WY6BnzPyZFrHeCcsuQY35Nr2v4FhTk6
         L62wxFBGIKww71PRPjli0VFdmVmDJdAsy04MLRRujdn1axAh4+jqTMRMo4Pk+2Hv6DP7
         EjoegYO/ElyU67okri8IVUrY9hycdC1dk3AQzs+TZZcqYHlGhTv8RZquxzQpkWY4efTW
         ne3rx/AwYwKMHMV+A5e//wsSIyw79us+oxHNqzwlSnLtGLwCoc/1EZ7xMTgkt+Wr9iJf
         Rg7YpFFR5qxHIu2U+K2a3mxZLVWIPGI76LuuAF7KsdDRYLHDzSBJOnGbvGHG5p0jrcFF
         Rnmg==
X-Gm-Message-State: AOAM530gJAIkbynw5N9csz3iB90B6uqDG3QYTO5mDBvG4cICyjvvO1lS
        eSYLilql3IUldIxZfebAk51nZUdpH8O8ZS5aBHO/lbSnF08UWue7ga/qAk3hC0NaNWkuJ9wiGfD
        AX8kagxunYPbaQKjXjc8XnORN
X-Received: by 2002:a37:510:: with SMTP id 16mr3799068qkf.158.1592491084286;
        Thu, 18 Jun 2020 07:38:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgIlVSOfyTkKlA6rdJwQo1PKbMN5rge+wF3Pm4MBxSEYVC1edOee7Ik8ZU/elsoO8j3z7Lbg==
X-Received: by 2002:a37:510:: with SMTP id 16mr3799027qkf.158.1592491083984;
        Thu, 18 Jun 2020 07:38:03 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f30sm3143755qtb.9.2020.06.18.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 07:38:03 -0700 (PDT)
Date:   Thu, 18 Jun 2020 10:38:01 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
Message-ID: <20200618143801.GK76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
 <20200617154925.GC76766@xz-x1>
 <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
 <20200617195807.GH76766@xz-x1>
 <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:15:31PM -0700, Linus Torvalds wrote:
> On Wed, Jun 17, 2020 at 12:58 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > But currently remote GUP will still do the page fault accounting on the remote
> > task_struct, am I right?  E.g., when the get_user_pages_remote() is called with
> > "tsk != current", it seems the faultin_page() will still do maj_flt/min_flt
> > accounting for that remote task/thread?
> 
> Well, that would be a data race and fundamentally buggy.
> 
> It would be ok with something like ptrace (which only works when the
> target is quiescent), but is completely wrong otherwise.
> 
> I guess it works fine in practice, and it's only statistics so even if
> you were to have a data race it doesn't much matter, but it's
> definitely conceptually very very wrong.
> 
> The fault stats should be about who does the fault (they are about the
> _thread_) not about who the fault is done to (which is about the
> _mm_).
> 
> Allocating the fault data to somebody else sounds frankly silly and
> stupid to me, exactly because it's (a) racy and (b) not even
> conceptually correct. The other thread literally _isn't_ doing a major
> page fault, for crissake!
> 
> Now, there are some actual per-mm statistics too (the rss stuff etc),
> and it's fundamentally harder exactly because of the shared data. See
> the mm_counter stuff etc. Those are not about who does soemthing, they
> are about the resulting MM state.

I see.  How about I move another small step further to cover GUP (to be
explicit, faultin_page() and fixup_user_fault())?

GUP needs the per-task accounting, but not the perf events.  We can do that by
slightly changing the new approach into:

        bool major = (ret & VM_FAULT_MAJOR) || (flags & FAULT_FLAG_TRIED);

        if (major)
                current->maj_flt++;
        else
                current->min_flt++;

        if (!regs)
                return ret;

        if (major)
                perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
        else
                perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);

With the change we will always account that onto current task.  Since there're
GUP calls that are not even accounted at all, e.g., get_user_pages_remote()
with tsk==NULL: for these calls, we also account these page faults onto current
task.

Another major benefit I can see (besides a completely cleaned up accounting) is
that we can remove the task_struct pointer in the whole GUP code, because
AFAICT that's only used for this pf accounting either in faultin_page() or
fixup_user_fault(), which seems questionable itself now to not use current...

Any opinions?

Thanks,

--
Peter Xu

