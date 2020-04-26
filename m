Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213B4C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009B62070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587922840;
	bh=tnlXImV+PXCRk6++M2i8k6bZqjcOqZLN/srygYIFlH4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WgNm/wbJwDS+AebsYLpnq+44xfMFauJc+Xsm20jEF1cBdqAsgpuP1vIUhs9rW5tg9
	 ZrF1Zrc5E6DM9W0OhOUUR2nkh5SVenJbhfI1+gQWUoOXyZ5Jw5wP6OcpdL2ajcLh2l
	 fcLn8z2vi4s8p/wYjdDcvcTINA8qhg13jtU+ABi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbgDZRkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 13:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726154AbgDZRkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:40:37 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E580C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 10:40:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a21so15115458ljb.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 10:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dtrc1LxUXrGUTeYL+CIuPg7oi+xXAsX+zAakCRKGiTs=;
        b=gWkMPLVnPEbeWIBml8xtUosL0GHDXmBQiDAFLjIwwAlYDi29kGpQkrjnC64dJybCS7
         BiJ+6Syhkqkbm6+KIFNNzKiJeiMMp5xN3JWU/LjVbJIt4pWvSyvfzWxfecXPDDM7OAJ6
         lflbEU3okvfCmduQIp/pfmXaU9P0WDZ7eJ6ic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dtrc1LxUXrGUTeYL+CIuPg7oi+xXAsX+zAakCRKGiTs=;
        b=eoggxDVPQ5pIx9nokYfqfw4BxcccdVYDVzGPtloXbdyMuoryc43lF9qjnyEE+kwJvg
         zkR4BN3yxlgO68KhkeTBRGNEAR3a9K4FF5v22/AHIj5LgDo+7Wq6JaaYN7fJpVa+16Al
         epnASu1LQ5CgHdX15rVY9xw1aVxZBGZq1psY1bZSggSF583FYgzvHgY3b2Eq92rCz5wa
         bMEN/fA32NDHdXh5dHyNmA4ij5anx7dVNPjib8DiUdA9RZgpoX5iMkVPlYK9vPcxJA2A
         ek3kNl7wSlrcTif5F2QTYa8SXDb3CnPzBZeDm3CHEKDN9u4DAPzSwsqXMrHH70u30IHd
         byvg==
X-Gm-Message-State: AGi0PubIU1SYGY+ccz1RCyeRx7LRtfy6cHVQvwFVHSpCKy5OexQvOFNP
        B/Dj3mpwaCQWtoWg/IvIt/25NCzsg3U=
X-Google-Smtp-Source: APiQypJXZz1gefmsjSv4+GYm32tEgusgTrhN4TOsA8RsSTOxTAZR+9EYOZ2hBZ4Sh5Y/oAo6MYrYaA==
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr10321087ljj.265.1587922834680;
        Sun, 26 Apr 2020 10:40:34 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k18sm11200565lfg.81.2020.04.26.10.40.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Apr 2020 10:40:33 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id y4so15134672ljn.7
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 10:40:33 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr10321031ljj.265.1587922833220;
 Sun, 26 Apr 2020 10:40:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <20200424173927.GB26802@redhat.com> <87mu6ymkea.fsf_-_@x220.int.ebiederm.org> <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <875zdmmj4y.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 26 Apr 2020 10:40:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
Message-ID: <CAHk-=whvktUC9VbzWLDw71BHbV4ofkkuAYsrB5Rmxnhc-=kSeQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] rculist: Add hlist_swap_before_rcu
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 26, 2020 at 7:14 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> To support this add hlist_swap_before_rcu.  An hlist primitive that
> will allow swaping the leading sections of two tasks.  For exchanging
> the task pids it will just be swapping the hlist_heads of two single
> entry lists.  But the functionality is more general.

So I have no problems with the series now - the code is much more
understandable. Partly because of the split-up, partly because of the
comments, and partly because you explained the special case and why it
was a valid thing to do...

However, I did start thinking about this case again.

I still don't think the "swap entry" macro is necessarily useful in
_general_ - any time it's an actual individual entry, that swap macro
doesn't really work.

So the only reason it works here is because you're actually swapping
the whole list.

But that, in turn, shouldn't be using that "first node" model at all,
it should use the hlist_head. That would have made it a lot more
obvious what is actually going on to me.

Now, the comment very much talks about the head case, but the code
still looks like it's swapping a non-head thing.

I guess the code technically _works_ with "swap two list ends", but
does that actually really make sense as an operation?

So I no longer hate how this patch looks, but I wonder if we should
just make the whole "this node is the *first* node" a bit more
explicit in both the caller and in the swapping code.

It could be as simple as replacing just the conceptual types and
names, so instead of some "pnode1" double-indirect node pointer, we'd
have

        struct hlist_head *left_head = container_of(left->pprev,
struct hlist_head, first);
        struct hlist_head *right_head = container_of(right->pprev,
struct hlist_head, first);

and then the code would do

        rcu_assign_pointer(right_head->first, left);
        rcu_assign_pointer(left_head->first, right);
        WRITE_ONCE(left->pprev,  &right_head->first);
        WRITE_ONCE(right->pprev,  &left_head->first);

which should generate the exact same code, but makes it clear that
what we're doing is switching the whole hlist when given the first
entries.

Doesn't that make what it actually does a lot more understandable? The
*pnode1/pnode2 games are somewhat opaque, but with that type and name
change and using "container_of()", the code now fairly naturally reads
as "oh, we're changing the first pointers in the list heads, and
making the nodes point back to them" .

Again - the current function _works_ with swapping two hlists in the
middle (not two entries - it swaps the whole list starting at that
entry!), so your current patch is in some ways "more generic". I'm
just suggesting that the generic case doesn't make much sense, and
that the "we know the first entries, swap the lists" actually is what
the real use is, and writing it as such makes the code easier to
understand.

But I'm not going to insist on this, so this is more an RFC. Maybe
people disagree, and/or have an actual use case for that "break two
hlists in the middle, swap the ends" that I find unlikely...

(NOTE: My "convert to hlist_head" code _works_ for that case too
because the code generation is the same! But it would be really really
confusing for that code to be used for anything but the first entry).

                       Linus
