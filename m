Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0150BC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D194920736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 20:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587673720;
	bh=rFETX999Zp3r99BfZgeA6NJYed2VirDJsVNov/jbgoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xcFpywurLcB7KncaZkSYntkMzixWlXUKOWW3VCKhKJX2/XaWvUWf3/ELtJ+kS7v4e
	 Llagsp1hbwDqyRf9jbzTj3FCoLltrAxwHiNfROdS64axOLBpUAE+CWBlXSwxjm0ybc
	 dZ9tDgL8OApXdk+Z7V/Wwnj+ai0SomR/oGinAZmM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgDWU2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 16:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgDWU2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 16:28:39 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0C7C09B043
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:28:38 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 198so5851423lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giPR15AGo2ieKRr3YuoUOrhNULDHeEPLry+vrqvhGiE=;
        b=JQhx257sPEWqT9zRF6PD8JqbodRaG1MGCuGlHa53uJha8lI8D96q5xrXYbWjmV6xLd
         oywtHlBFUsxfiEyxeaj+g1ToDxzvFWnhXvi/Cn4OihPXDgNMAC9boLNLxKuDK6PnpbS7
         xmyHWYFSP2mhTikwCZUYiiY3pVwTxO/itjoVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giPR15AGo2ieKRr3YuoUOrhNULDHeEPLry+vrqvhGiE=;
        b=PSDEGLNk+NsJOnMwW9TFCz05E+t702pMsk3Zki8ooNOz4YhvuDYlFoCc9AvJARx+Jy
         E7f0NlctrUKLM3V2btWoAeBMJ21GJ/yYRYePLBfXRC/adrMjRx2YenyuC2yStCSVk5hS
         x0Rvy9j6cna88uX7zPOGNujtz5iUxpykfUo2OZ/p8arV4VAZWNB5niZRTDSRzAjSqBUi
         XwNoHerszSdhOO4nP/CO20Q8ulkU1wD34I5lfeve5AWMKa1juCfUwNda6pU5fJV/PsGo
         /AJueBcHkTzfRK4vo0pkYd1Y6Azwx+3NGsHzLS2wxkB815UQj2bOtcuTBq9bA9+Wey+j
         T5/A==
X-Gm-Message-State: AGi0PuYzhTobKUw9vRfTKA8xqGa/ulMXooTM6CCv6/lS0DqdZOrf2NEh
        wfh/wPMAYsizgbHzZwgct5tGVqSHTic=
X-Google-Smtp-Source: APiQypJXTcwv4AS683IwK+W0P9GeV8VPyrhWsVqLnZXOWnWHH2gcSRFM4kIt2TmR/Td+9nYUHeThWQ==
X-Received: by 2002:a05:6512:405:: with SMTP id u5mr3490855lfk.192.1587673715877;
        Thu, 23 Apr 2020 13:28:35 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id z17sm2643302ljc.8.2020.04.23.13.28.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 13:28:34 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id u15so7659073ljd.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 13:28:34 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr3533041lji.201.1587673714229;
 Thu, 23 Apr 2020 13:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
In-Reply-To: <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Apr 2020 13:28:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com>
Message-ID: <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 12:42 PM Eric W. Biederman
<ebiederm@xmission.com> wrote:
>
> +void exchange_tids(struct task_struct *ntask, struct task_struct *otask)
> +{
> +       /* pid_links[PIDTYPE_PID].next is always NULL */
> +       struct pid *npid = READ_ONCE(ntask->thread_pid);
> +       struct pid *opid = READ_ONCE(otask->thread_pid);
> +
> +       rcu_assign_pointer(opid->tasks[PIDTYPE_PID].first, &ntask->pid_links[PIDTYPE_PID]);
> +       rcu_assign_pointer(npid->tasks[PIDTYPE_PID].first, &otask->pid_links[PIDTYPE_PID]);
> +       rcu_assign_pointer(ntask->thread_pid, opid);
> +       rcu_assign_pointer(otask->thread_pid, npid);
> +       WRITE_ONCE(ntask->pid_links[PIDTYPE_PID].pprev, &opid->tasks[PIDTYPE_PID].first);
> +       WRITE_ONCE(otask->pid_links[PIDTYPE_PID].pprev, &npid->tasks[PIDTYPE_PID].first);
> +       WRITE_ONCE(ntask->pid, pid_nr(opid));
> +       WRITE_ONCE(otask->pid, pid_nr(npid));
> +}

This function is _very_ hard to read as written.

It really wants a helper function to do the swapping per hlist_head
and hlist_node, I think. And "opid/npid" is very hard to see, and the
naming doesn't make much sense (if it's an "exchange", then why is it
"old/new" - they're symmetric).

At least something like

        struct hlist_head *old_pid_hlist = opid->tasks + PIDTYPE_PID;
        struct hlist_head *new_pid_hlist = npid->tasks + PIDTYPE_PID;
        struct hlist_node *old_pid_node = otask->pid_links + PIDTYPE_PID;
        struct hlist_node *new_pid_node = ntask->pid_links + PIDTYPE_PID;

        struct hlist_node *old_first_node = old_pid_hlist->first;
        struct hlist_node *new_first_node = new_pid_hlist->first;

and then trying to group up the first/pprev/thread_pid/pid  accesses
so that you them together, and using a helper function that does the
whole switch, so that you'd have

        /* Move new node to old hlist, and update thread_pid/pid fields */
        insert_pid_pointers(old_pid_hlist, new_pid_node, new_first_node);
        rcu_assign_pointer(ntask->thread_pid, opid);
        WRITE_ONCE(ntask->pid, pid_nr(opid));

        /* Move old new to new hlist, and update thread_pid/pid fields */
        insert_pid_pointers(new_pid_hlist, old_pid_node, old_first_node);
        rcu_assign_pointer(otask->thread_pid, npid);
        WRITE_ONCE(otask->pid, pid_nr(npid));

or something roughly like that.

(And the above still uses "old/new", which as mentioned sounds wrong
to me. Maybe it should just be "a_xyz" and "b_xyz"? Also note that I
did this in my MUA, so I could have gotten the names and types wrong
etc).

I think that would make it look at least _slightly_ less like random
line noise and easier to follow.

But maybe even a rcu_hlist_swap() helper? We have one for regular
lists. Do we really have to do it all written out, not do it with a
"remove and reinsert" model?

                Linus
