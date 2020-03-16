Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A73E0C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:27:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78369206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 13:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yn1exyHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731336AbgCPN1K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 09:27:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33059 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731234AbgCPN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 09:27:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584365229;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:in-reply-to:in-reply-to:  references:references;
        bh=of4mUL4rmHq6XhJnwzhTCE0KMqAQsZJRaiD2FUTq71A=;
        b=Yn1exyHXjLgLQKCsOxunUqUH2+ZgQDTzpH1jwkeE0ypgd8oNFoFeAXMmUhs0SOhfGR45qs
        vyENoTyp7aPJbycfnd28dSIzBQpt2u7caIiAK4XN/v9t4qKZjnTzlRPs8AIHxUR040kpqn
        gi/SfZKNF5rx6JrvcaDOi4UP0rq/txE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-123-fqJGX8F_OYKDw0hvF-bISA-1; Mon, 16 Mar 2020 09:27:01 -0400
X-MC-Unique: fqJGX8F_OYKDw0hvF-bISA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8ACF513F6;
        Mon, 16 Mar 2020 13:26:59 +0000 (UTC)
Received: from tucnak.zalov.cz (ovpn-116-37.ams2.redhat.com [10.36.116.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00D7190776;
        Mon, 16 Mar 2020 13:26:58 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
        by tucnak.zalov.cz (8.15.2/8.15.2) with ESMTP id 02GDQt3m018001;
        Mon, 16 Mar 2020 14:26:56 +0100
Received: (from jakub@localhost)
        by tucnak.zalov.cz (8.15.2/8.15.2/Submit) id 02GDQmtB018000;
        Mon, 16 Mar 2020 14:26:48 +0100
Date:   Mon, 16 Mar 2020 14:26:48 +0100
From:   Jakub Jelinek <jakub@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] x86: fix early boot crash on gcc-10
Message-ID: <20200316132648.GM2156@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20200314164451.346497-1-slyfox@gentoo.org>
 <20200316130414.GC12561@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316130414.GC12561@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:04:14PM +0100, Peter Zijlstra wrote:
> > diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> > index 9b294c13809a..da9f4ea9bf4c 100644
> > --- a/arch/x86/kernel/Makefile
> > +++ b/arch/x86/kernel/Makefile
> > @@ -11,6 +11,12 @@ extra-y	+= vmlinux.lds
> >  
> >  CPPFLAGS_vmlinux.lds += -U$(UTS_MACHINE)
> >  
> > +# smpboot's init_secondary initializes stack canary.
> > +# Make sure we don't emit stack checks before it's
> > +# initialized.
> > +nostackp := $(call cc-option, -fno-stack-protector)
> > +CFLAGS_smpboot.o := $(nostackp)
> 
> What makes GCC10 insert this while GCC9 does not. Also, I would much

My bet is different inlining decisions.
If somebody hands me over the preprocessed source + gcc command line, I can
have a look in detail (which exact change and why).

> rather GCC10 add a function attrbute to kill this:
> 
>   __attribute__((no_stack_protect))

There is no such attribute, only __attribute__((stack_protect)) which is
meant mainly for -fstack-protector-explicit and does the opposite, or
__attribute__((optimize ("no-stack-protector"))) (which will work only
in GCC7+, since https://gcc.gnu.org/PR71585 changes).
Or of course you could add noinline attribute to whatever got inlined
and contains some array or addressable variable that whatever
-fstack-protector* mode kernel uses triggers it.  With -fstack-protector-all
it would never work even in the past I believe.

	Jakub

