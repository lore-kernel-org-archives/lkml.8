Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1C7C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0642071C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs+JhSeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbgCSRbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:31:10 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41467 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726934AbgCSRbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584639068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U1szoS1OFDclXKw5QldI0d7jkBPpWZukPaBQk/KVC9s=;
        b=Vs+JhSebnBPmB56sBJNNV7nq8o1803UOd2hZx2aevmhW5Fywi4mtafAYYet9/HKEUhgXrY
        gEPXYUrvACE+NmipLUy6edLaV2eY3F6HANiTWV3KhFBJr2Vtbjl+j425p+INzSMjSjL944
        V0FmY0Ckk2lyHSyYvIoCK6XXZbnY5Mc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-vtn1rn9YOOaetgHXFS6tFg-1; Thu, 19 Mar 2020 13:31:07 -0400
X-MC-Unique: vtn1rn9YOOaetgHXFS6tFg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80E24149C0;
        Thu, 19 Mar 2020 17:31:05 +0000 (UTC)
Received: from treble (unknown [10.10.110.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5391210027AB;
        Thu, 19 Mar 2020 17:31:04 +0000 (UTC)
Date:   Thu, 19 Mar 2020 12:31:01 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: linux-next: Tree for Mar 18 (objtool)
Message-ID: <20200319173101.wufpymi7obhqgoqd@treble>
References: <20200318220920.48df2e76@canb.auug.org.au>
 <d7dc5b4a-9a7e-ccf7-e00e-2e7f0e79a9bc@infradead.org>
 <20200318182352.2dgwwl4ugbwndi4x@treble>
 <20200318200542.GK20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200318200542.GK20730@hirez.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 09:05:42PM +0100, Peter Zijlstra wrote:
> "Built-in Function: void __builtin_trap (void)
> 
>     This function causes the program to exit abnormally. GCC implements
>     this function by using a target-dependent mechanism (such as
>     intentionally executing an illegal instruction) or by calling abort.
>     The mechanism used may vary from release to release so you should
>     not rely on any particular implementation."
> 
> Sounds encouraging :-(
> 
> Clearly it now emits UD2, but who knows what it'll do next week.
> 
> I think what happens is that we have code that does:
> 
> 	if (cond)
> 		BUG()/WARN()
> 
> And ubsan figures that @cond is something undefined, and then we get
> transformed into:
> 
> 	if (cond) {
> 		__builtin_trap();
> 		BUG()/WARN()
> 	}
> 
> And presto, double UD2.
>
> Since x86 has GENERIC_BUG unconditionally, we should actually have
> __bug_table entries for each BUG()/WARN() instance, which should allow
> us to distinguish between a proper BUG()/WARN() and this
> __builtin_trap() nonsense.

... except the __builtin_trap() UD2 seems to be coming *after* the BUG
UD2.  Could it be the BUG UD2 itself which is convincing UBSAN to add
the __builtin_trap()?

If the BUG() macro were to use __builtin_trap() instead of the inline
asm UD2, GCC might be able to merge the two UD2's into one, and all
would be well.  But that could be tricky because of the __bug_table
stuff which needs to reference the UD2.

-- 
Josh

