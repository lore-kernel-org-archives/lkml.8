Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D261CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA3420724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DkpdICMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbgHTRVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:21:43 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31154 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730544AbgHTRVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597944089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvDNF5Q3wwtznjdzEy9L2Cc3y4PlB8JtkjTiFM9v96o=;
        b=DkpdICMe113oxxJXIOehcL4LNQRw8VTuKvnZzLwRbEukHCy1ZemG0oJUdSfpWm39cDi9qW
        1yd1AXYB31TtFZm9/jW5Kz0mEFevum7+0zoYaPPWbwI58cgH+T6DpCmf6F7T351LJM3aPy
        MgU63+Cwaj2yBVY/HYSpx/Cp081sUnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-DJeVJEdTNtK3jEvIg62OwQ-1; Thu, 20 Aug 2020 13:21:25 -0400
X-MC-Unique: DJeVJEdTNtK3jEvIg62OwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 824E8873155;
        Thu, 20 Aug 2020 17:21:23 +0000 (UTC)
Received: from treble (ovpn-117-70.rdu2.redhat.com [10.10.117.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A46305C893;
        Thu, 20 Aug 2020 17:21:20 +0000 (UTC)
Date:   Thu, 20 Aug 2020 12:21:18 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     peterz@infradead.org, Brian Gerst <brgerst@gmail.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into
 exc_debug_kernel()
Message-ID: <20200820172118.n5injemo3ic63x6j@treble>
References: <20200820163453.GE1362448@hirez.programming.kicks-ass.net>
 <156769F5-0BCC-4FB8-A56D-0E92601F558A@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <156769F5-0BCC-4FB8-A56D-0E92601F558A@amacapital.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 09:43:15AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Aug 20, 2020, at 9:35 AM, peterz@infradead.org wrote:
> > 
> > ﻿On Thu, Aug 20, 2020 at 11:17:29AM -0500, Josh Poimboeuf wrote:
> >> On Thu, Aug 20, 2020 at 05:21:11PM +0200, peterz@infradead.org wrote:
> > 
> >>> qemu-gdb stub should eat the event before it lands in the guest
> >> 
> >> Are we sure about that?  I triggered the warning just now, stepping
> >> through the debug handler.
> > 
> > Not sure at all, that's what seemed reasonable, but since when did that
> > stop virt ;-)
> > 
> > Also, can you trigger that same with upstream? Because I suspect this
> > ought to tickle the old code too.
> 
> I’ve lost track of how many bugs QEMU and KVM have in this space.
> Let’s keep it as a warning, but a bug. But let’s get rid of the
> totally bogus TIF_SINGLESTEP manipulation.

By "but a bug", I assume you mean "not a bug" :-)

-- 
Josh

