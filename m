Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D32C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7056D20792
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 18:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595528587;
	bh=zYccf1YIuxWvATI1tSItkk6cO4pgnvtZMi2RqU173yM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=v3Rb9YdYIf130oesXqI4qw6aPVb2Bo4v+vfW18mTbwN0zwO7NAUGJ3k6YztlY5ZqY
	 39v2rtwcnAUNebPDPWV5uX00DtJ6mCowHxVuCn/QwCdjQRIVeyUozz4DjG0l1DQxA8
	 TMG0Us4Ca+dei12UmjoVIZ8dlk2jq0GKYGWViI1g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbgGWSXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 14:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgGWSXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 14:23:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949B6C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 11:23:05 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j11so7376381ljo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 11:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8jbqAu4MTtKZYfsDRzg9oxuVgmZXrDgAOWgETbdmt3I=;
        b=TpC1L9yeqU8VAOIGIaabNRD2URVdeVJkJUvan/PdnVoywn5ewbqyDjsAOR2s/j/716
         6qzVRkeThyuPOPLm0TzlXk/CAB2wM0XXQkHKrpkXglrPHKkEtftSwCjuVRP3t7TqqESK
         mwqoKZRybu74iu0fz+q3OrSQs3NydidhrfzPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8jbqAu4MTtKZYfsDRzg9oxuVgmZXrDgAOWgETbdmt3I=;
        b=OWh/NLUzlGXzyUZrB3xCzpcWTM9XCuVlM7aXa3sdHDm0LtVmCrF0QK9f9MC+nt3j0c
         AEn6fE5EN6lohs1B3U+eea7FUmqfDMq+yS7SjbUapMGZqMfeX8JbtqTiLc5VcgrVABu9
         j8fgBFdpmQvTMC9c817O9fxJW+pTTBbi7BrOeAHXFSITI6Gt6jO30zW3QA5put/TXDtB
         P9boGbZDH0vsjDiUEBpCEFrNGhwZrY0oXiGgZcJt6vxfiLvOBQJwDnNrerwhdwG74KyV
         St83sYwa+L1MhSrAhCpVOkrtTOraDzWWUX5IC4Kg9H8YCtBwZFN5VbeYdXJzf0ewpsno
         XTxA==
X-Gm-Message-State: AOAM530dKc8ipdm51KsN7rUbF7BpytMmRO5cypDbG3zPfFzEQA9jWqau
        RtOwwbPO8qJ2gJBM5UqdBPVB3eXaSWo=
X-Google-Smtp-Source: ABdhPJwaNZAGnAKShw3Tx0ZNg0yT9Lq/nPvmhff5YmKPaCDV76LqnAF4wrDeueDL1Vr8ahHhcvbDMw==
X-Received: by 2002:a2e:964d:: with SMTP id z13mr2521557ljh.98.1595528583240;
        Thu, 23 Jul 2020 11:23:03 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id 186sm3250414lfn.66.2020.07.23.11.23.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 11:23:02 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id b11so3790216lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 11:23:01 -0700 (PDT)
X-Received: by 2002:ac2:58d5:: with SMTP id u21mr2835310lfo.31.1595528581489;
 Thu, 23 Jul 2020 11:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200721063258.17140-1-mhocko@kernel.org> <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
 <alpine.LSU.2.11.2007221359450.1017@eggly.anvils> <CAHk-=wi=vuc6sdu0m9nYd3gb8x5Xgnc6=TH=DTOy7qU96rZ9nw@mail.gmail.com>
 <CAHk-=whEjnsANEhTA3aqpNLZ3vv7huP7QAmcAEd-GUxm2YMo-Q@mail.gmail.com>
 <20200723124749.GA7428@redhat.com> <CAHk-=wgyc7en4=HddEYiz_RKJXfqe1JYv3BzHc=+_wYq9ti+LQ@mail.gmail.com>
 <20200723180100.GA21755@redhat.com>
In-Reply-To: <20200723180100.GA21755@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Jul 2020 11:22:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9KWfs799xU5eW0J_hkee52C5kvFFmBV-A+vN7qNWnjA@mail.gmail.com>
Message-ID: <CAHk-=wj9KWfs799xU5eW0J_hkee52C5kvFFmBV-A+vN7qNWnjA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Hugh Dickins <hughd@google.com>, Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 11:01 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> > +      *
> > +      * We _really_ should have a "list_del_init_careful()" to
> > +      * properly pair with the unlocked "list_empty_careful()"
> > +      * in finish_wait().
> > +      */
> > +     smp_mb();
> > +     list_del_init(&wait->entry);
>
> I think smp_wmb() would be enough, but this is minor.

Well, what we _really_ want (and what that comment is about) would be
got that list_del_init_careful() to use a "smp_store_release()" for
the last store, and then "list_empty_careful()" would use a
"smp_load_acquire()" for the corresponding first load.

On x86, that's free. On most other architectures, it's the minimal
ordering requirement.

And no, I don't think "smp_wmb()" is technically enough.

With crazy memory ordering, one of the earlier *reads* (eg loading
"wait->private" when waking things up) could have been delayed until
after the stores that initialize the list - and thus read stack
contents from another process after it's been released and re-used.

Does that happen in reality? No. There are various conditionals in
there which means that the stores end up being gated on the loads and
cannot actually be re-ordered, but it's the kind of subtley

So we actually do want to constrain all earlier reads and writes wrt
the final write. Which is exactly what "smp_store_release()" does.

But with our current list_empty_careful(), the smp_mb() is I think
technically sufficient.

> We need a barrier between "wait->flags |= WQ_FLAG_WOKEN" and list_del_init(),

See above: we need more than just that write barrier, although in
_practice_ you're right, and the other barriers actually all already
exist and are part of wake_up_state().

So the smp_mb() is unnecessary, and in fact your smp_wmb() would be
too. But I left it there basically as "documentation".

> But afaics we need another barrier, rmb(), in wait_on_page_bit_common() fo
> the case when wait->private was not blocked; we need to ensure that if
> finish_wait() sees list_empty_careful() == T then we can't miss WQ_FLAG_WOKEN.

Again, this is what a proper list_empty_careful() with a
smp_load_acquire() would have automatically gotten for us.

But yes, I think that without that, and with the explicit barriers, we
need an smp_rmb() after the list_empty_careful().

I really think it should be _in_ list_empty_careful(), though. Or
maybe finish_wait(). Hmm.

Because looking at all the other finish_wait() uses, the fact that the
waitqueue _list_ is properly ordered isn't really a guarantee of the
rest of the stack space is.

In practice, it will be, but I think this lack of serialization is a
potential real bug elsewhere too.

(Obviously none of this would show on x86, where we already *get* that
smp_store_release/smp_load_acquire behavior for the existing
list_del_init()/list_empty_careful(), since all stores are releases,
and all loads are acquires)

So I think that is a separate issue, generic to our finish_wait() uses.

             Linus
