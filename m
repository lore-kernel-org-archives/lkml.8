Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D743C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3901820775
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:05:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gsF0ZGyR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391322AbgDNQFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:05:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24027 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391240AbgDNQDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586880228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=azRF+PxhqvsRfgCFrbt5heLat6wkx5149SjRHQdnP7Q=;
        b=gsF0ZGyRRqoBq/nBnGam0PlOcZVTWB3S4+YibYq3SBZqFnfug3P1ur/PhF5m6cCg90oiDz
        +7meuxg2XCe4ul2O52kU9EDGwhqYeadUvzTUDx8LeJWcIeBfiugbhg55XqG9VcYaWpMx5R
        yf+63brbZXO/Cy0OVE4xepP/bkC9Q+c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-467-fN3lL75JOwuE-Yt-p-pVuw-1; Tue, 14 Apr 2020 12:03:44 -0400
X-MC-Unique: fN3lL75JOwuE-Yt-p-pVuw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49A97800D53;
        Tue, 14 Apr 2020 16:03:43 +0000 (UTC)
Received: from krava (unknown [10.40.195.121])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4AA1C96B93;
        Tue, 14 Apr 2020 16:03:41 +0000 (UTC)
Date:   Tue, 14 Apr 2020 18:03:38 +0200
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
Message-ID: <20200414160338.GE208694@krava>
References: <20200408164641.3299633-1-jolsa@kernel.org>
 <20200409234101.8814f3cbead69337ac5a33fa@kernel.org>
 <20200409184451.GG3309111@krava>
 <20200409201336.GH3309111@krava>
 <20200410093159.0d7000a08fd76c2eaf1398f8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200410093159.0d7000a08fd76c2eaf1398f8@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 09:31:59AM +0900, Masami Hiramatsu wrote:

SNIP

> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index 4d7022a740ab..081d0f366c99 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -757,12 +757,33 @@ static struct kprobe kretprobe_kprobe = {
> >  	.addr = (void *)kretprobe_trampoline,
> >  };
> >  
> > +void arch_kprobe_reject_section_start(void)
> > +{
> > +	struct kprobe_ctlblk *kcb;
> > +
> > +	preempt_disable();
> > +
> > +	/*
> > +	 * Set a dummy kprobe for avoiding kretprobe recursion.
> > +	 * Since kretprobe never run in kprobe handler, kprobe must not
> > +	 * be running behind this point.
> > +	 */
> > +	__this_cpu_write(current_kprobe, &kretprobe_kprobe);
> > +	kcb = get_kprobe_ctlblk();
> > +	kcb->kprobe_status = KPROBE_HIT_ACTIVE;
> > +}
> 
> Yeah, the code seems good to me.
> 
> BTW, I rather like make it arch independent function so that other
> arch can use it. In this case, the dummy kprobe's addr should be
> somewhere obviously blacklisted (but it must be accessible.)
> I think get_kprobe() will be a candidate.

right.. as Ziqian noted we see this on other ppc as well

> 
> And (sorry about changing my mind), the naming, I think kprobe_busy_begin()
> and kprobe_busy_end() will be better because it doesn't reject registering
> kprobes, instead, just make it busy :)

ok, will change 

thanks,
jirka

