Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C94C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:03:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 078D72076B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JdUMN5WJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391243AbgDNQDv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:03:51 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40196 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391231AbgDNQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:03:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586880211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lJFGKIR12MEFkKiRn5YTOsm7nR2F68cHjhNsuPQ0F6U=;
        b=JdUMN5WJk8yl57IfSaIjuXl5FrCRMFo44NjIHXHW33aKOJzVxmvFQ1NFhjZocqn4ACgtCU
        fRiLFJzTk0mE+r3A7kcsO0rioAKwf9rdqfAV2/9Uv3sm504fYSIIAFiaI+DoH89URoSwaK
        foLovQeQoam3BM4Zz+M6qD+pk8F11go=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-of0AEIPuP5e6HR-xZUupJA-1; Tue, 14 Apr 2020 12:03:28 -0400
X-MC-Unique: of0AEIPuP5e6HR-xZUupJA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5902013FD;
        Tue, 14 Apr 2020 16:03:26 +0000 (UTC)
Received: from krava (unknown [10.40.195.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1076311D2CF;
        Tue, 14 Apr 2020 16:03:23 +0000 (UTC)
Date:   Tue, 14 Apr 2020 18:03:21 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Ziqian SUN (Zamir)" <zsun@redhat.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "bibo,mao" <bibo.mao@intel.com>, sztsian@gmail.com
Subject: Re: [RFC] kretprobe: Prevent triggering kretprobe from within
 kprobe_flush_task
Message-ID: <20200414160321.GA215906@krava>
References: <20200408164641.3299633-1-jolsa@kernel.org>
 <20200409234101.8814f3cbead69337ac5a33fa@kernel.org>
 <20200409184451.GG3309111@krava>
 <20200409201336.GH3309111@krava>
 <5334d3b4-4020-6705-9bcc-e6777070c9c7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5334d3b4-4020-6705-9bcc-e6777070c9c7@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 09:31:07AM +0800, Ziqian SUN (Zamir) wrote:
> 
> 
> On 4/10/20 4:13 AM, Jiri Olsa wrote:
> > On Thu, Apr 09, 2020 at 08:45:01PM +0200, Jiri Olsa wrote:
> > > On Thu, Apr 09, 2020 at 11:41:01PM +0900, Masami Hiramatsu wrote:
> > > 
> > > SNIP
> > > 
> > > > > ---
> > > > >   kernel/kprobes.c | 6 ++++++
> > > > >   1 file changed, 6 insertions(+)
> > > > > 
> > > > > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > > > > index 2625c241ac00..b13247cae752 100644
> > > > > --- a/kernel/kprobes.c
> > > > > +++ b/kernel/kprobes.c
> > > > > @@ -1236,6 +1236,10 @@ __releases(hlist_lock)
> > > > >   }
> > > > >   NOKPROBE_SYMBOL(kretprobe_table_unlock);
> > > > > +static struct kprobe kretprobe_dummy = {
> > > > > +        .addr = (void *)kretprobe_trampoline,
> > > > > +};
> > > > > +
> > > > >   /*
> > > > >    * This function is called from finish_task_switch when task tk becomes dead,
> > > > >    * so that we can recycle any function-return probe instances associated
> > > > > @@ -1256,12 +1260,14 @@ void kprobe_flush_task(struct task_struct *tk)
> > > > >   	INIT_HLIST_HEAD(&empty_rp);
> > > > >   	hash = hash_ptr(tk, KPROBE_HASH_BITS);
> > > > >   	head = &kretprobe_inst_table[hash];
> > > > > +	__this_cpu_write(current_kprobe, &kretprobe_dummy);
> > > > 
> > > > Can you also set the kcb->kprobe_state = KPROBE_HIT_ACTIVE?
> > > > 
> > > > BTW, we may be better to introduce a common kprobe_reject_section_start()
> > > > and kprobe_reject_section_end() so that the user don't need to prepare
> > > > dummy kprobes.
> > > 
> > > sure, will do
> > > 
> > > thank you both for review
> > 
> > ok, found out it's actually arch code..  would you guys be ok with something like below?
> > 
> > jirka
> > 
> 
> Hi Jiri,
> 
> In my origin test lockup happens on both x86_64 and ppc64le. So I would
> appreciate if you can also come up with a solution for both of the
> architectures.

aaaah right.. will update the fix

thanks,
jirka

