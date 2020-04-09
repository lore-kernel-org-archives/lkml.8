Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B94C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0744D20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ct8S4Op5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbgDISpF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:45:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40853 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726477AbgDISpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:45:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586457905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OMq2AN413rw3joBaxPqyBbjAP4rwGVS2rGQ+fmpuVd4=;
        b=Ct8S4Op5ulO7a4WPAHQYJgIosWKxPB4YxqqH3qw3erGZpN0eul/y3UeJv8J3EBYLLOlu99
        TWkvHI3KUvtI36eCCUmLSI2m0fdYdLTR4hnWHlCgMPglCQaRhvBCOFAo3R2nHeL7tD5ry/
        rGbF1gxStSSJ1G8Bz+XE4HbdPk+Hu7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-H4e-n8gYPR6vbS3PfJMIZw-1; Thu, 09 Apr 2020 14:45:02 -0400
X-MC-Unique: H4e-n8gYPR6vbS3PfJMIZw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BF991085925;
        Thu,  9 Apr 2020 18:45:01 +0000 (UTC)
Received: from krava (unknown [10.40.196.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25781277AD;
        Thu,  9 Apr 2020 18:44:53 +0000 (UTC)
Date:   Thu, 9 Apr 2020 20:44:51 +0200
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
Message-ID: <20200409184451.GG3309111@krava>
References: <20200408164641.3299633-1-jolsa@kernel.org>
 <20200409234101.8814f3cbead69337ac5a33fa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200409234101.8814f3cbead69337ac5a33fa@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 09, 2020 at 11:41:01PM +0900, Masami Hiramatsu wrote:

SNIP

> > ---
> >  kernel/kprobes.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 2625c241ac00..b13247cae752 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1236,6 +1236,10 @@ __releases(hlist_lock)
> >  }
> >  NOKPROBE_SYMBOL(kretprobe_table_unlock);
> >  
> > +static struct kprobe kretprobe_dummy = {
> > +        .addr = (void *)kretprobe_trampoline,
> > +};
> > +
> >  /*
> >   * This function is called from finish_task_switch when task tk becomes dead,
> >   * so that we can recycle any function-return probe instances associated
> > @@ -1256,12 +1260,14 @@ void kprobe_flush_task(struct task_struct *tk)
> >  	INIT_HLIST_HEAD(&empty_rp);
> >  	hash = hash_ptr(tk, KPROBE_HASH_BITS);
> >  	head = &kretprobe_inst_table[hash];
> > +	__this_cpu_write(current_kprobe, &kretprobe_dummy);
> 
> Can you also set the kcb->kprobe_state = KPROBE_HIT_ACTIVE?
> 
> BTW, we may be better to introduce a common kprobe_reject_section_start()
> and kprobe_reject_section_end() so that the user don't need to prepare
> dummy kprobes.

sure, will do

thank you both for review
jirka

> 
> Thank you,
> 
> >  	kretprobe_table_lock(hash, &flags);
> >  	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
> >  		if (ri->task == tk)
> >  			recycle_rp_inst(ri, &empty_rp);
> >  	}
> >  	kretprobe_table_unlock(hash, &flags);
> > +	__this_cpu_write(current_kprobe, NULL);
> >  	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
> >  		hlist_del(&ri->hlist);
> >  		kfree(ri);
> > -- 
> > 2.25.2
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>
> 

