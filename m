Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C23BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CA6720B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 12:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYPZ4uHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDIMwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 08:52:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33333 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726699AbgDIMwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 08:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586436743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CUcDKhjapgf3njMY2a0jlc66UvHSWsd44p46boZg1eg=;
        b=HYPZ4uHK0EHQfyq55GHqca7HA2O3eEENm7B8u4y6b6uILpqASFpzfnhan3XV9XJ55ypNs/
        7ncTwDHAb9bN/p8RLmfAavTyrZzsOC7svDy4jtoJBPYafROP3Ya/Fa1xpdmzZgTeB40pEQ
        lsutRWZONPVF1AjtoA9T/bD8W53zYTA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-191-j_B1CWzhPviYOqT5GTp7Sg-1; Thu, 09 Apr 2020 08:52:19 -0400
X-MC-Unique: j_B1CWzhPviYOqT5GTp7Sg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 461FF19067E3;
        Thu,  9 Apr 2020 12:52:18 +0000 (UTC)
Received: from krava (unknown [10.40.196.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 339811147DC;
        Thu,  9 Apr 2020 12:52:16 +0000 (UTC)
Date:   Thu, 9 Apr 2020 14:52:13 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "bibo,mao" <bibo.mao@intel.com>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>
Subject: Re: [RFC] kretprobe: Prevent triggering kretprobe from within
 kprobe_flush_task
Message-ID: <20200409125213.GA3309111@krava>
References: <20200408164641.3299633-1-jolsa@kernel.org>
 <20200409213806.7657ec27d1b5cbd8243505b9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409213806.7657ec27d1b5cbd8243505b9@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 09:38:06PM +0900, Masami Hiramatsu wrote:
> Hi Jiri,
> 
> On Wed,  8 Apr 2020 18:46:41 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > hi,
> > Ziqian reported lockup when adding retprobe on _raw_spin_lock_irqsave.
> 
> Hmm, kprobe is lockless, but kretprobe involves spinlock.
> Thus, eventually, I will blacklist the _raw_spin_lock_irqsave()
> for kretprobe.

I thought of blacklisting, but we were using that kretprobe
in a bcc script.. it's not overloaded by using bpf trampolines,
but still might be useful

SNIP

> > The code within the kretprobe handler checks for probe reentrancy,
> > so we won't trigger any _raw_spin_lock_irqsave probe in there.
> > 
> > The problem is in outside kprobe_flush_task, where we call:
> > 
> >   kprobe_flush_task
> >     kretprobe_table_lock
> >       raw_spin_lock_irqsave
> >         _raw_spin_lock_irqsave
> > 
> > where _raw_spin_lock_irqsave triggers the kretprobe and installs
> > kretprobe_trampoline handler on _raw_spin_lock_irqsave return.
> 
> Hmm, OK. In this case, I think we should mark this process is
> going to die and never try to kretprobe on it.
> 
> > 
> > The kretprobe_trampoline handler is then executed with already
> > locked kretprobe_table_locks, and first thing it does is to
> > lock kretprobe_table_locks ;-) the whole lockup path like:
> > 
> >   kprobe_flush_task
> >     kretprobe_table_lock
> >       raw_spin_lock_irqsave
> >         _raw_spin_lock_irqsave ---> probe triggered, kretprobe_trampoline installed
> > 
> >         ---> kretprobe_table_locks locked
> > 
> >         kretprobe_trampoline
> >           trampoline_handler
> >             kretprobe_hash_lock(current, &head, &flags);  <--- deadlock
> > 
> > The change below sets current_kprobe in kprobe_flush_task, so the probe
> > recursion protection check is hit and the probe is never set. It seems
> > to fix the deadlock.
> > 
> > I'm not sure this is the best fix, any ideas are welcome ;-)
> 
> Hmm, this is a bit tricky to fix this issue. Of course, temporary disable
> kprobes (and kretprobe) on an area by filling current_kprobe might
> be a good idea, but it also involves other kprobes.
> 
> How about let kretprobe skip the task which state == TASK_DEAD ?

hum, isn't that considerable amount of paths (with state == TASK_DEAD)
that we would kill kprobes for? someone might want to trace it

thanks,
jirka

