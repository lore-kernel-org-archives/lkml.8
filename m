Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD129C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 04:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADCEE20575
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 04:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YcncgkHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgC0ETx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 00:19:53 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45482 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725857AbgC0ETx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 00:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585282792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R7kEi4TwwBAd1SAi29VCs2LuslD0J8oe5KEE3bYZ8Zk=;
        b=YcncgkHiu/R1H07mpUPxzPcvkNOGQ8fRy8Oq4ouim0VgpOWWpk8UXzvAxvICN2ZTKHA41L
        9zuufR91sRaC6X2RAlpWNr8flgdkynnMd/xX5WvfcYSjGJMy+GDcrewTzmGj2Cjh2JPqKi
        6f7+ZFfkhBjC5t2QuECjdC6TfBnl+Bo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-GDP-ZNF-NQuHEUXJwj6KsA-1; Fri, 27 Mar 2020 00:19:48 -0400
X-MC-Unique: GDP-ZNF-NQuHEUXJwj6KsA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C30EA189D6CA;
        Fri, 27 Mar 2020 04:19:46 +0000 (UTC)
Received: from treble (unknown [10.10.110.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5344491284;
        Fri, 27 Mar 2020 04:19:45 +0000 (UTC)
Date:   Thu, 26 Mar 2020 23:19:41 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        mhiramat@kernel.org, mbenes@suse.cz
Subject: Re: [PATCH v4 01/13] objtool: Remove CFI save/restore special case
Message-ID: <20200327041941.ykycltxtaulj4wqz@treble>
References: <20200325174525.772641599@infradead.org>
 <20200325174605.369570202@infradead.org>
 <20200326113049.GD20696@hirez.programming.kicks-ass.net>
 <20200326125844.GD20760@hirez.programming.kicks-ass.net>
 <20200326134448.5zci3ikdlf5ar2w5@treble>
 <20200326153841.GN20713@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200326153841.GN20713@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 04:38:41PM +0100, Peter Zijlstra wrote:
> On Thu, Mar 26, 2020 at 08:44:48AM -0500, Josh Poimboeuf wrote:
> > On Thu, Mar 26, 2020 at 01:58:44PM +0100, Peter Zijlstra wrote:
> > > So instr_begin() / instr_end() have this exact problem, but worse. Those
> > > actually do nest and I've ran into the following situation:
> > > 
> > > 	if (cond1) {
> > > 		instr_begin();
> > > 		// code1
> > > 		instr_end();
> > > 	}
> > > 	// code
> > > 
> > > 	if (cond2) {
> > > 		instr_begin();
> > > 		// code2
> > > 		instr_end();
> > > 	}
> > > 	// tail
> > > 
> > > Where objtool then finds the path: !cond1, cond2, which ends up at code2
> > > with 0, instead of 1.
> > 
> > Hm, I don't see the nesting in this example, can you clarify?
> 
> Indeed no nesting here, but because they can nest we have that begin as
> +1, end as -1 and then we sum it over the code flow.
> 
> Then given that, the above, ends up as -1 + 1 in the !cond1,cond2 case,
> because that -1 escapes the cond1 block.

Ok, I see now.  I wonder if you can take a similar approach to the
save/restore patch I sent out.  Though I guess the nesting adds an
additional wrinkle I'm too tired to think about.

-- 
Josh

