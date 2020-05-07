Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF90C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC16D2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmnYQEbY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgEGKPc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:15:32 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:58708 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbgEGKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:15:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588846529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=A+jh5pN6NKDoDRaUFFxRu2RRzvKqaD7ThAzjRQGAp3Y=;
        b=hmnYQEbY8s3VmTecUMtKkOmlusl/A/a9eLWDnQkxrJrYsMrQQJebwbo8RwXIuuTBy2BgNH
        kPiln3sMZYAFTQQVCSlEX8xPg7jIeyYBTqfh+Y7q8pYJd/eSUgJSgT4eaZgICWJDQCgOVL
        cgsVGJKDA9OSjR8+UkEYtCrx1v5stkM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-hjGq-kPwPFm1R0h_2ZbcTg-1; Thu, 07 May 2020 06:15:25 -0400
X-MC-Unique: hjGq-kPwPFm1R0h_2ZbcTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A74745F;
        Thu,  7 May 2020 10:15:23 +0000 (UTC)
Received: from krava (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7893B61100;
        Thu,  7 May 2020 10:15:20 +0000 (UTC)
Date:   Thu, 7 May 2020 12:15:17 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@elte.hu>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "bibo,mao" <bibo.mao@intel.com>,
        "Ziqian SUN (Zamir)" <zsun@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCHv2] kretprobe: Prevent triggering kretprobe from within
 kprobe_flush_task
Message-ID: <20200507101517.GB2447905@krava>
References: <20200410093159.0d7000a08fd76c2eaf1398f8@kernel.org>
 <20200414160338.GE208694@krava>
 <20200415090507.GG208694@krava>
 <20200416105506.904b7847a1b621b75463076d@kernel.org>
 <20200416091320.GA322899@krava>
 <20200416224250.7a53fb581e50aa32df75a0cf@kernel.org>
 <20200416143104.GA400699@krava>
 <20200417163810.ffe5c9145eae281fc493932c@kernel.org>
 <20200428213627.GI1476763@krava>
 <20200501110107.bc859c6603704c0bcdb8889a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501110107.bc859c6603704c0bcdb8889a@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 11:01:07AM +0900, Masami Hiramatsu wrote:
> On Tue, 28 Apr 2020 23:36:27 +0200
> Jiri Olsa <jolsa@redhat.com> wrote:
> 
> > On Fri, Apr 17, 2020 at 04:38:10PM +0900, Masami Hiramatsu wrote:
> > 
> > SNIP
> > 
> > > > 
> > > > The code within the kretprobe handler checks for probe reentrancy,
> > > > so we won't trigger any _raw_spin_lock_irqsave probe in there.
> > > > 
> > > > The problem is in outside kprobe_flush_task, where we call:
> > > > 
> > > >   kprobe_flush_task
> > > >     kretprobe_table_lock
> > > >       raw_spin_lock_irqsave
> > > >         _raw_spin_lock_irqsave
> > > > 
> > > > where _raw_spin_lock_irqsave triggers the kretprobe and installs
> > > > kretprobe_trampoline handler on _raw_spin_lock_irqsave return.
> > > > 
> > > > The kretprobe_trampoline handler is then executed with already
> > > > locked kretprobe_table_locks, and first thing it does is to
> > > > lock kretprobe_table_locks ;-) the whole lockup path like:
> > > > 
> > > >   kprobe_flush_task
> > > >     kretprobe_table_lock
> > > >       raw_spin_lock_irqsave
> > > >         _raw_spin_lock_irqsave ---> probe triggered, kretprobe_trampoline installed
> > > > 
> > > >         ---> kretprobe_table_locks locked
> > > > 
> > > >         kretprobe_trampoline
> > > >           trampoline_handler
> > > >             kretprobe_hash_lock(current, &head, &flags);  <--- deadlock
> > > > 
> > > > Adding kprobe_busy_begin/end helpers that mark code with fake
> > > > probe installed to prevent triggering of another kprobe within
> > > > this code.
> > > > 
> > > > Using these helpers in kprobe_flush_task, so the probe recursion
> > > > protection check is hit and the probe is never set to prevent
> > > > above lockup.
> > > > 
> > > 
> > > Thanks Jiri!
> > > 
> > > Ingo, could you pick this up?
> > 
> > Ingo, any chance you could take this one?
> 
> Hi Ingo,
> 
> Should I make a pull request for all kprobes related patches to you?

looks like Ingo is offline, Thomas, could you please pull this one?

thanks,
jirka

