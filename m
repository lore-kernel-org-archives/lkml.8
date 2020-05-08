Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB748C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B711C2184D
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 15:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QwAYtLtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgEHPrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 11:47:18 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41223 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727051AbgEHPrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 11:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588952836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/Mrqq8bocBIcn8N6pk0yrIvKuTZiVjG74AykFdJPm0U=;
        b=QwAYtLtXYnLfYLGXdnOTZJkPvlLciAJdKX1tYfmg9LlU8Y6OI4QOy7P4rE2uHGT7INXkrL
        n3Ty5TSEZh1qP0k2cxdilxXn0Ct/p+Amdu457vB+hWe24u7OUoHkKSGcJ817nsq5ZDZ0o3
        uJcgyd4wb5TK08rcpATLTzI40Ylqrgo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-mC4Qyy3fPDSzUiaZr6VNew-1; Fri, 08 May 2020 11:47:14 -0400
X-MC-Unique: mC4Qyy3fPDSzUiaZr6VNew-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 189F418FE861;
        Fri,  8 May 2020 15:47:12 +0000 (UTC)
Received: from treble (ovpn-115-96.rdu2.redhat.com [10.10.115.96])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E9B43691F9;
        Fri,  8 May 2020 15:47:06 +0000 (UTC)
Date:   Fri, 8 May 2020 10:47:04 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, bristot@redhat.com, jbaron@akamai.com,
        torvalds@linux-foundation.org, tglx@linutronix.de,
        mingo@kernel.org, namit@vmware.com, hpa@zytor.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, pbonzini@redhat.com,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v4 14/18] static_call: Add static_cond_call()
Message-ID: <20200508154704.6njw5wfsain7p3ev@treble>
References: <20200501202849.647891881@infradead.org>
 <20200501202944.593400184@infradead.org>
 <20200506172455.ho5em2mtzn7qqfjl@treble>
 <20200508152730.GB3344@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200508152730.GB3344@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 05:27:30PM +0200, Peter Zijlstra wrote:
> On Wed, May 06, 2020 at 12:24:55PM -0500, Josh Poimboeuf wrote:
> 
> > On that note, what do you think about tweaking the naming from
> > 
> >   DEFINE_STATIC_COND_CALL(name, typename);
> >   static_cond_call(name)(args...);
> > 
> > to
> > 
> >   DEFINE_STATIC_CALL_NO_FUNC(name, typename);
> >   static_call_if_func(name)(args...);
> > 
> > ?
> > 
> > Seems clearer to me.  They're still STATIC_CALLs, so it seems logical to
> > keep those two words together.  And NO_FUNC clarifies the initialized
> > value.
> > 
> > Similarly RETTRAMP could be ARCH_DEFINE_STATIC_CALL_NO_FUNC.
> 
> So I dislike static_call_if_func(), that's so much typing. Also, I
> prefer ARCH_*_RETTRAMP as it clearly describes what the thing is.
> 
> How is something like this? 

I like DEFINE_STATIC_CALL_NULL.  I also like the new comment.

And if you're calling it

  DEFINE_STATIC_CALL_NULL

then it seems like

  ARCH_DEFINE_STATIC_CALL_NULL

would be the logical name rather than RETTRAMP?

Still not crazy about static_cond_call(), though I think at least
changing it to static_call_cond() would be better for namespacing
reasons.

-- 
Josh

