Return-Path: <SRS0=B91b=AB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B109C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F16423380
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Jun 2020 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592670769;
	bh=PiTqpExOkJ4jtmo/igH0XjJUDL8XyWqQnsFO1jatvyc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0eNa3UM0CBizz8gkT04Ar3jyhZKkKQiHuJcSJNZUjdaqCQtSvLdoamqjOEGK5wQ/d
	 cThI0JEF2KmrjGWBJ18W57cgHajPuy3vxYjDvSAjUMPhfKhZ6bQMHWjNsLKC7Fj8ca
	 PViwOX191PIL3bqMdcHTCjFa4eAdNNxBmdVFLPrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgFTQcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Jun 2020 12:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgFTQcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Jun 2020 12:32:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200F0C06174E
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:32:47 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q19so14882859lji.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dcRSJRK8urDyldn/ETgWnP509gz8x9p5kdeaHsZfzGs=;
        b=X7ptCrRAii6sPtj0fatuBjGITTaDL1PU9dnjPRqfI4+AHTgGqNE7wmR6SaW4AQEIUN
         ryhWAR5G2+dwxs4IGvQClbkR79s5DN6S7RkDgR8L0YrKCedkIURWL1gvBFgY/XO5PtdI
         LxQIIwT0YpBCKsuVyjsGcB0TyvnF/W2wGl8c4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dcRSJRK8urDyldn/ETgWnP509gz8x9p5kdeaHsZfzGs=;
        b=fL/fieQKU8bU29jjZEcY4xd/jbIiPrXrteBPrWFX9GVuHwz8tgv3LYKMNZWpsW7yTV
         rJ5tDU54YDCawHcIB1KmJTGFdUPBA9NwFfuEAvmyIOa8SnCwq/cTBB8mginHgoLbyX7D
         hGAoecKNFvRF0DeFPs9kVF+cql77sx29O01Ios2sxJOlvN3mz1aPWWvKOlsfdojiFpXW
         UPPCHQ2LAi73EIeNaYN8URSjBK7yENJNk8J290sZb+3cREKjrY3f5r6qL7nF9bjAeDll
         jvA8R5Nu4wPkcaTR9TlxHmYmcgb/OAqti29YIL9wue/5xlk8cHQcDf2NJ2gtPIkdl68M
         QG6w==
X-Gm-Message-State: AOAM530BKMfdlvoXl29/4+tGkaDEGtHy8ymJ0ZwK1omvgnAo+85YuH38
        SI+6rqvf25wbcpiL8/MhyO7nThMGcjk=
X-Google-Smtp-Source: ABdhPJzuQIAVC5C0c8rwYcOapZvl3EqZVXJ4dQVZ7sz3gI0afCfanOitwSLCDuAQPLvYBxTmOIRjUg==
X-Received: by 2002:a2e:b176:: with SMTP id a22mr4144413ljm.291.1592670764397;
        Sat, 20 Jun 2020 09:32:44 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a15sm1761646ljn.105.2020.06.20.09.32.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Jun 2020 09:32:43 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id d7so7265675lfi.12
        for <linux-kernel@vger.kernel.org>; Sat, 20 Jun 2020 09:32:42 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr4982811lfd.31.1592670762430;
 Sat, 20 Jun 2020 09:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <159178525684.17951.17825196124597318263.tip-bot2@tip-bot2> <202006192008.337CB5212E@keescook>
In-Reply-To: <202006192008.337CB5212E@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 20 Jun 2020 09:32:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgj17RR3zetey4fpbOxbC58A=jMt87bQ9QRe4QDnxE46w@mail.gmail.com>
Message-ID: <CAHk-=wgj17RR3zetey4fpbOxbC58A=jMt87bQ9QRe4QDnxE46w@mail.gmail.com>
Subject: Re: [tip: sched/urgent] sched: Fix RANDSTRUCT build fail
To:     Kees Cook <keescook@chromium.org>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Eric Biggers <ebiggers@kernel.org>, x86 <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 8:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jun 10, 2020 at 10:34:16AM -0000, tip-bot2 for Peter Zijlstra wrote:
> > The following commit has been merged into the sched/urgent branch of tip:
> >
> > Commit-ID:     bfb9fbe0f7e70ec5c8e51ee55b6968d4dff14456
> > Gitweb:        https://git.kernel.org/tip/bfb9fbe0f7e70ec5c8e51ee55b6968d4dff14456
> > Author:        Peter Zijlstra <peterz@infradead.org>
> > AuthorDate:    Wed, 10 Jun 2020 12:14:09 +02:00
> > Committer:     Peter Zijlstra <peterz@infradead.org>
> > CommitterDate: Wed, 10 Jun 2020 12:30:19 +02:00
> >
> > sched: Fix RANDSTRUCT build fail
> >
> > As a temporary build fix, the proper cleanup needs more work.
> >
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Reported-by: Eric Biggers <ebiggers@kernel.org>
> > Suggested-by: Eric Biggers <ebiggers@kernel.org>
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Fixes: a148866489fb ("sched: Replace rq::wake_list")
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>
> Hi, can this please get sent to Linus before -rc2? With a148866489fb in
> -rc1, all the CI with the GCC plugins installed have been failing their
> all*config builds. This entered -next 9 days ago (and fixed the -next
> builds), but Linus's tree is still failing:

Ugh.

I actually think the problem goes deeper than that.

The code expects the list entries to be of type 'call_single_data_t'

Then they damn well should be that type.

Note how "call_single_data_t" also implies certain alignment rules
that the hack in 'struct task_struct' does *not* have, and while that
doesn't matter on x86, it could matter on other architectures.

So no, I don't think Peter's patch is correct. It may make the build
pass, but that "check the offsets between two fields" is not
sufficient.

Now, if we could create a new

   struct __call_single_list_entry {
        struct llist_node llist;
        unsigned int flags;
   } call_single_list_entry_t;

and use that as part of thecall_single_data_t and only use that for
tyhe traversal of the list, then that would avoid the alignment issue
and the waste of space in struct task_struct.

Hmm?

Peter/Ingo?

                 Linus
