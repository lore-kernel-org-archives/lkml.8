Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26BCC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BFA220674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUo2YqnI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgHQLyI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 07:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgHQLyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 07:54:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A11C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 04:54:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id y206so8101681pfb.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 04:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPagJq8bfLV5JHleSz/YdyHxTxcPKxeM2AT318YsVDU=;
        b=cUo2YqnIduCfkp3HRFHUsby0zIh4dQYG3sMlKf28FS6lSwIo6RgJH+LytxK18B2Xwv
         CKGCwVlOVoB0vdx09P+hquL2g0fnLEFIl6278frwEGWyWh0wgn/FvpnULmcjwCMz4P1m
         QvOeSCUuHTNcDLC2nwxNGjoTp1xDchiJDXN4AKsy9QdAk3z3fxrZukSimZOz1mSFoEIM
         oenaufwaX+LZD3rAy7UYelrnzOy5gZWXAtEiJJlBEQfRb+iUgUW/mdb4BbuOnqpNqx/A
         l6MKMdZZ/IeSpillNWWS64wACRvp7VRH+Zs+o5syOFhQFzaMuHD9BMXIMcqXebI9ga5j
         Xmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPagJq8bfLV5JHleSz/YdyHxTxcPKxeM2AT318YsVDU=;
        b=ZZlFxYa5No2o0pBKE06fI6zBfoed+TKrpZjI1pTq6rByQJodokDmG2nbuJkVLUFgcU
         yk18E9dAvFEl9kEk+sKF+OOFhmfY4+6gykjsVEg3kv8GYm2Mw01VZ3YJrlLkyOcN9lcp
         PzouN4OeSO2BY722Dy0QRqf9d1nIbqT+qZAZdCsRMSILl9k2twdI7AVMfA+4waVR4UXF
         I+0IDiQr6JEHj8TPhuIQIuf0ys9AU+lyxnZraLUd5ZjtywFAF8eYB5rYYuLS2A8LB3Wj
         lCMm/Z4mA0TtajJPPDvmZforKgRCQ6s5JgeTQUYlAL/Wc91rg1s0hq92f5Wyb0w3I373
         2YpQ==
X-Gm-Message-State: AOAM533+Jnf/02zNWpUPgU0e3o9bfpygKGOH8t+WvDqv9o259ydOW95h
        kT9IDNTsms91F9q8WtZ3UgzS1UiVK6lXjcUui1zPmg==
X-Google-Smtp-Source: ABdhPJxQsY+haVSQeWnKsAs3ixBm6FjQ0//5YkN0AYGeNZHDelu/iOrnxxlOSVO5MvjaUD8VZOIX74GJgLknb82gmsU=
X-Received: by 2002:a65:680b:: with SMTP id l11mr3369972pgt.440.1597665241999;
 Mon, 17 Aug 2020 04:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200813151922.1093791-1-alex.popov@linux.com>
 <20200813151922.1093791-2-alex.popov@linux.com> <202008150939.A994680@keescook>
In-Reply-To: <202008150939.A994680@keescook>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 17 Aug 2020 13:53:51 +0200
Message-ID: <CAAeHK+yPFoQZanzjXBty8rM9eY4thv+ThdHX7mz-sgeg147F7w@mail.gmail.com>
Subject: Re: [PATCH RFC 1/2] mm: Extract SLAB_QUARANTINE from KASAN
To:     Kees Cook <keescook@chromium.org>,
        Alexander Popov <alex.popov@linux.com>
Cc:     Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        kernel-hardening@lists.openwall.com,
        LKML <linux-kernel@vger.kernel.org>, notify@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 6:52 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Aug 13, 2020 at 06:19:21PM +0300, Alexander Popov wrote:
> > Heap spraying is an exploitation technique that aims to put controlled
> > bytes at a predetermined memory location on the heap. Heap spraying for
> > exploiting use-after-free in the Linux kernel relies on the fact that on
> > kmalloc(), the slab allocator returns the address of the memory that was
> > recently freed. Allocating a kernel object with the same size and
> > controlled contents allows overwriting the vulnerable freed object.
> >
> > Let's extract slab freelist quarantine from KASAN functionality and
> > call it CONFIG_SLAB_QUARANTINE. This feature breaks widespread heap
> > spraying technique used for exploiting use-after-free vulnerabilities
> > in the kernel code.
> >
> > If this feature is enabled, freed allocations are stored in the quarantine
> > and can't be instantly reallocated and overwritten by the exploit
> > performing heap spraying.

[...]

> In doing this extraction, I wonder if function naming should be changed?
> If it's going to live a new life outside of KASAN proper, maybe call
> these functions quarantine_cache_*()? But perhaps that's too much
> churn...

If quarantine is to be used without the rest of KASAN, I'd prefer for
it to be separated from KASAN completely: move to e.g. mm/quarantine.c
and don't mention KASAN in function/config names.
