Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0954C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688DD24656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="KhO5/pi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729172AbgBUPt0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:49:26 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34335 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728198AbgBUPtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:49:25 -0500
Received: by mail-qt1-f196.google.com with SMTP id l16so1590484qtq.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5vGDEPioi42Z57PWnWkzaCJCFUr+4txdzZver505xSg=;
        b=KhO5/pi1cWvAohS63DdYOurl4ApzmdBGa0GBdVwMpHCdvYcSr6VP4BxKIPtLEGu82x
         quC8NdvM+vJR48gFYLrdDm3wtz/cPYUeQpdAB1v3jhJ0CiRlH+4bl128XP57qmAHNllk
         pDJQfaFNEvnMUezh5vuvAbsQW+HHxEplbhlnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5vGDEPioi42Z57PWnWkzaCJCFUr+4txdzZver505xSg=;
        b=DuUhfmFOfIk0twlWwEBMfI7pn2uXPDlFdy/B8o+GfZR/1cLmIuk2tdJIlXmkJeRqJh
         pEwy9ds0smIP+SEZtq8SYYK7eNPViyQfjdd3Cyg+YB19m8V52uAPHfJAGqg4oX5Q7qxu
         W5wr+mQ9RsoIJ5tqgXL4daU3MhTi1kKi6c9J+UmK/h2wrfdK6RmtImHTB+GDbJ4xPQtl
         m6JPrKVuaLRO1BlcSjqwdlKsIriT2rYcPMC1OFcrK2s82hAqnOSfqiI6x9XpfyFRmTBR
         2BrPGG14Lg2tx5B6ZUY2lx6rgcoNy/iLBktl8uQmBsB/Aq2oKkq02L9lCumaaDnr4zX3
         GaxA==
X-Gm-Message-State: APjAAAW+cF0YDdBtjV88d7N+XkTu0fRBk17ctdE9fnw/4fsqZJJfLUFv
        cvCDzas0q/AN4D6g7hNrhwYc8A==
X-Google-Smtp-Source: APXvYqyUhARk6wTSmRhXmvCFgqESD8tZ8I1wShs0FI4oD7HA6je+2Ztj47eJ9hpbIVBPN67hiUL/Mw==
X-Received: by 2002:ac8:758a:: with SMTP id s10mr32779356qtq.283.1582300164261;
        Fri, 21 Feb 2020 07:49:24 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g84sm1644685qke.129.2020.02.21.07.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:49:23 -0800 (PST)
Date:   Fri, 21 Feb 2020 10:49:23 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Chris Kennelly <ckennelly@google.com>,
        Paul Turner <pjt@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        Carlos O'Donell <codonell@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: Rseq registration: Google tcmalloc vs glibc
Message-ID: <20200221154923.GC194360@google.com>
References: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 04:33:30PM -0500, Mathieu Desnoyers wrote:
> Hi Chris,
> 
> As one of the maintainers of the Rseq system call in the Linux kernel, I would
> like to thank the Google team for open sourcing a tcmalloc implementation based
> on Rseq!
> 
> I've looked into some critical integration aspects of the tcmalloc implementation,
> and would like to bring up a topic which involves both tcmalloc developers and the
> glibc community.
> 
> I have been discussing aspects of co-existence between early Rseq adopter libraries
> and glibc for the past year with the glibc community, and tcmalloc happens to be the
> first project to publicly use Rseq outside of prototype branches or selftests code.
> Considering that there can only be one Rseq registration per thread (as imposed by
> the rseq ABI), there needs to be some kind of protocol between libraries to ensure we
> don't introduce regressions when we eventually combine a newer glibc which takes care
> of registration of the __rseq_abi TLS along with tcmalloc which also try to perform
> that registration within the same thread.
> 
> Throughout the various rounds of review of the glibc Rseq integration patch set,
> there were a few solutions envisioned. Here is a brief history:
> 
> 1) Introduce a __rseq_refcount TLS variable.
> 
> - Currently used by Linux tools/testing/selftests/rseq/rseq.c,
> - Currently used by Google tcmalloc,
> - Emitted by glibc as well my the original patchset (but was later removed),
> 
> A user incrementing the refcount from 0 -> 1 performs rseq registration.
> The last user decrementing from 1 -> 0 performs rseq unregistration.
> 
> Works for co-existence of dlopen'd/dlclose'd libraries, for dynamically
> linked libraries, and for the main executable.
> 
> The refcounting was deemed too complex for glibc's needs (it always
> exists for the entire executable's lifetime), so we moved to
> __rseq_handled instead.
> 
> 
> 2) Introduce a __rseq_handled global variable.
> 
> - Currently used by Linux tools/testing/selftests/rseq/rseq.c,
> - At some point emitted by glibc as well in my patch set (but was later
>   removed),
> 
> A library may take rseq ownership if it is still 0 when executing the
> library constructor. Set to 1 by library constructor when handling rseq.
> Set to 0 in destructor if handling rseq.
> 
> Not meant to be set by dlopen'd/dlclose'd libraries, only by libraries
> existing for the whole lifetime of the executable and/or the main executable.
> 
> This __rseq_handled symbol has been identified as being somewhat redundant
> with the information provided in the __rseq_abi.cpu_id field (uninitialized
> state), which motivated removing this symbol from the glibc integration
> entirely. The only reason for having __rseq_handled separate from
> __rseq_abi.cpu_id was because it was then impossible to touch TLS data
> early in the glibc initialization. This issue was later resolved within
> glibc.
> 
> 
> 3) Use the  __rseq_abi TLS cpu_id field to know whether Rseq has been
> registered.
> 
> - Current protocol in the most recent glibc integration patch set.
> - Not supported yet by Linux kernel rseq selftests,
> - Not supported yet by tcmalloc,
> 
> Use the per-thread state to figure out whether each thread need to register
> Rseq individually.
> 
> Works for integration between a library which exists for the entire lifetime
> of the executable (e.g. glibc) and other libraries. However, it does not
> allow a set of libraries which are dlopen'd/dlclose'd to co-exist without
> having a library like glibc handling the registration present.

Mathieu, could you share more details about why during dlopen/close
libraries we cannot use the same __rseq_abi TLS to detect that rseq was
registered?

Thanks!

  - Joel


> 
> So overall, I suspect the protocol we want for early adopters is that they
> only register Rseq if __rseq_abi.cpu_id == RSEQ_CPU_ID_UNINITIALIZED, which
> ensure they do not get -1, errno = EBUSY when linked against a newer glibc
> which handles Rseq registration. In order to handle multiple early adopters
> dlopen'd/dlclose'd in the same executable, those should synchronize with a
> __rseq_refcount TLS reference count, but it does not have to be taken into
> account by the main executable or libraries present for the entire executable
> lifetime (like glibc).
> 
> Based on this, what I think would be missing from the current Google tcmalloc
> implementation is a check for __rseq_abi.cpu_id == RSEQ_CPU_ID_UNINITIALIZED
> in InitThreadPerCpu().
> 
> Is tcmalloc ever meant to be dlopen'd/dlclose'd (either directly or indirectly),
> or is it required to exist for the entire executable lifetime ? The check and
> increment of __rseq_refcount is only useful to co-exist with dlopen'd/dlclose'd
> libraries, but it would not allow discovering the presence of a glibc which
> takes care of the rseq registration with the planned protocol. A dlopen'd
> library should then only perform rseq unregistration if if brings the
> __rseq_refcount back to 0 (e.g. in a pthread_key destructor).
> 
> Adding this check for __rseq_abi.cpu_id == RSEQ_CPU_ID_UNINITIALIZED is something
> I need to do in the Linux rseq selftests, but I refrained from submitting any
> further change to those tests until the glibc rseq integration gets finally
> merged.
> 
> Is it something that could be easily changed at this stage in Google tcmalloc,
> or should we reconsider adding back __rseq_refcount within the glibc integration
> patch set, even though it is not strictly useful to glibc ?
> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
