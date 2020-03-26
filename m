Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86D42C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4832073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RjYhPWa9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgCZRBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:01:52 -0400
Received: from merlin.infradead.org ([205.233.59.134]:34150 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgCZRBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=8/w/+qff5R2iTxpbWl+GqyyabfQ3vj7msnoKkO3d6QI=; b=RjYhPWa9RapdThqqJ+0hNIMdvz
        9fTDOHHlxr0hNHtfFZB8YqAC8PcTpWfiXitDyA11w9Ua1ouGKzGqX9kkwY3L0rodUqWbsxIDVp2XR
        JeS25HMbOuwx4k12ILr8VKGvTqqpTKbA23m5kviM4e4nr4/Rg7rDElWp11pVguj4UDN0LVw/TMmr+
        9OePL/DUSoclCnQ8wOlGQt1dItqO9QiulT53OzMlApV+OX4jFqZfiBK37j/sQDBIN1O5xHqO2Gndw
        Z1b6XpkWHfeg+kkOUWiRbaY17vSRZyXXGEsXmomxuKPy2mxrFkXsPAaZ9zAD8mUm9f4hP9rC6LU5E
        A6z77Fqw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHVsp-000774-P2; Thu, 26 Mar 2020 17:01:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3537D3010C1;
        Thu, 26 Mar 2020 18:01:28 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1FCB32B4E3C9A; Thu, 26 Mar 2020 18:01:28 +0100 (CET)
Date:   Thu, 26 Mar 2020 18:01:28 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <namit@vmware.com>
Cc:     x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "jbaron@akamai.com" <jbaron@akamai.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        tglx <tglx@linutronix.de>, "mingo@kernel.org" <mingo@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "jpoimboe@redhat.com" <jpoimboe@redhat.com>
Subject: Re: [RESEND][PATCH v3 06/17] static_call: Add basic static call
 infrastructure
Message-ID: <20200326170128.GQ20713@hirez.programming.kicks-ass.net>
References: <20200324135603.483964896@infradead.org>
 <20200324142245.632535759@infradead.org>
 <12A30BA0-18DA-4748-B82F-6008179CC88C@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12A30BA0-18DA-4748-B82F-6008179CC88C@vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 04:42:07PM +0000, Nadav Amit wrote:
> > On Mar 24, 2020, at 6:56 AM, Peter Zijlstra <peterz@infradead.org> wrote:

> > + * API overview:
> > + *
> > + *   DECLARE_STATIC_CALL(name, func);
> > + *   DEFINE_STATIC_CALL(name, func);
> > + *   static_call(name)(args...);
> > + *   static_call_update(name, func);
> > + *
> > + * Usage example:
> > + *
> > + *   # Start with the following functions (with identical prototypes):
> > + *   int func_a(int arg1, int arg2);
> > + *   int func_b(int arg1, int arg2);
> > + *
> > + *   # Define a 'my_name' reference, associated with func_a() by default
> > + *   DEFINE_STATIC_CALL(my_name, func_a);
> 
> Do you want to support optional function attributes, such as “pure” and
> “const”?

Do you see a need for that? And what is the syntax for a pointer to a
pure function?
