Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8CEEC2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA3F220720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 23:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586303832;
	bh=WSilxp3RCrgkW6mWlbRT0uiKXXBESgYhywfEelXKAIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a0kcfJZZ8WNF7o1TmxIttZCvQAPjN6LiSjOKbb5DjFXcIJnpUefjouQc6Bfs+vMTo
	 dLB9TTNWlV0AlorkvW1BFD1DEBxvhfdmOLekhHbjES7hIjm8mtx40JLrJ49SLZ0fi6
	 fapbEKPN0qjszOWFcDoj+Oxi6FfrmiQbhBatO+iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgDGX5L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 19:57:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37010 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgDGX5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 19:57:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id de14so6304402edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 16:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zksoCklR8z1unQJuTBJp3Rro9MEQv7rmoj+ED3C7oyg=;
        b=Td8kk/wwBIcNQ5/edS+wLaYx9ypQ0Xx+RdI4BqPcVFzedqFgesVW8C0IjQkk8xO+9c
         GFfwVFDIaBwoUeYyZ+F2+9SFOMkc4tW9LFJGDZ9t5P2P4MDclhoZQ8m9RwKd8bXmmICe
         ThbWpWcO8nS2CaXOD7SirGXBzJ6n6RI04OA4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zksoCklR8z1unQJuTBJp3Rro9MEQv7rmoj+ED3C7oyg=;
        b=gAY/F6uXc0HPWe5FJv9nhEnBXEf8rhPFhrk8ogU9qEd/Bz12LGEfMGoONJNwugudRc
         zEz7Pba/wM185sCE9v5x634uWLaXGHNOG86S0OVQV5Xod1aITlijJ30SoxREsgX3KLUA
         f4jCyibqDClC0DLKhWUW88DLs53oJUr9uamJKs+whZ0RYfYv1G8h/1N2ghCpjMvYRSNG
         HL13yPaovgyTt0TX0b1iHSXumSH4+L7cBXyM2K9AthpmjQCebvCNAVnXEuz3ySvXIncE
         gNlLSeSU+9/dn0wpMlny84QgrlyW0We+Lry9G+qaXStOjXctC6VCEA5DRALCyj587UWx
         6VRQ==
X-Gm-Message-State: AGi0PuZ9cEeBula2OhtAxBD5muKTUH9P31rdOj8ie2xUUVZU+idOKtdr
        xiw7SeoncEMZ6vF9szHRvJQUfi4nXME=
X-Google-Smtp-Source: APiQypI7vADbfeXHi2oZSNUWOoCOofyfRRSthSlSOgkTi9IJmB4PIkfruE34MR3ISaoT9rlt+9j5sg==
X-Received: by 2002:a17:906:35ce:: with SMTP id p14mr4434570ejb.43.1586303828846;
        Tue, 07 Apr 2020 16:57:08 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id um17sm584563ejb.50.2020.04.07.16.57.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 16:57:08 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id v1so6264630edq.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 16:57:08 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr2966560ljc.209.1586303427328;
 Tue, 07 Apr 2020 16:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200406185827.22249-1-longman@redhat.com> <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
 <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
 <CAHk-=wg2Vsb0JETo24=Tc-T2drwMopMRfKnc__r5SZ6tEnbwcA@mail.gmail.com>
 <699292.1586294051@warthog.procyon.org.uk> <CAHk-=whwaNvyd1q=h0nUQio9byojpxufGkOiVfAh10woRs8KSA@mail.gmail.com>
 <749735.1586300050@warthog.procyon.org.uk>
In-Reply-To: <749735.1586300050@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Apr 2020 16:50:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjJ4A8h=Qqq-mYuQ1CwyQkquQpNfHmeOkkbsPtb19+z5Q@mail.gmail.com>
Message-ID: <CAHk-=wjJ4A8h=Qqq-mYuQ1CwyQkquQpNfHmeOkkbsPtb19+z5Q@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
To:     David Howells <dhowells@redhat.com>
Cc:     Joe Perches <joe@perches.com>, Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>, law@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 3:54 PM David Howells <dhowells@redhat.com> wrote:
>
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94527
>
> With regard to this, I've got back "not sure what Linus was talking about WRT
> DSE, if he's got examples he could pass along, they'd be appreciated"

I'll do that. We have real examples in the kernel, although they
probably aren't all that _important_.

I don't see that comment on the bugzilla, but I'll put the stupid
example in there too.

One such example would be kernel/async.c: async_run_entry_fn(), where we have

        /* 2) remove self from the pending queues */
        spin_lock_irqsave(&async_lock, flags);
        list_del_init(&entry->domain_list);
        list_del_init(&entry->global_list);

        /* 3) free the entry */
        kfree(entry);
        atomic_dec(&entry_count);

and while it's good form to do "list_del_init()" on those fields in
entry, the fact that we then do "kfree(entry)" right afterwards means
that the stores that re-initialize the entry list are dead.

So _if_ we had some way to tell the compiler that "hey, kfree(ptr)
kills the lifetime of that object", the compiler could eliminate the
dead stores.

I think that dead store elimination is perhaps less important than if
the compiler could warn about us stupidly using the dead storage
afterwards, but I mention it as a "it can actually matter for code
generation" example too.

Now, the above is a particularly stupid example, because if we cared,
we could just turn the "list_del_init()" into a plain "list_del()",
and simply not do the unnecessary re-initialization of the list entry
after removing it.

But I picked a stupid example because it's easy to understand.

Less stupidly, we sometimes have "cleanup" functions that get rid of
things, and are called before you free the underlying storage.

And there, the cleanup function might be used in general, and not only
just before freeing. So the re-initialization could make sense in that
context, but might again be just dead stores for the actual final
freeing case.

Is this a big deal? No it's not. But it's not really any different
from the dead store elimination that gcc already does for local
variables on stack.

          Linus
