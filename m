Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D28AC4BA00
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3588220675
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WMlJ8w13"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbgBYVw0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:52:26 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:51184 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgBYVw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:52:26 -0500
Received: by mail-pj1-f66.google.com with SMTP id r67so331620pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 13:52:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=67FIIq1D+V+asq39t76M7ReKeHhVxdkAMjdLa3hjO4A=;
        b=WMlJ8w13eGrO7Kbvy/9m9s0u5Yu0HmI3lHoSYEAYxlrTLRzW/t99dMlQdrxXWUTA0D
         zKAmdbiNd8kRXlpySjM2lvvcC2Hrmo0HP4YW9rpS6oFMjb29MVFYxZGh5TjKHEklLotV
         /G3J3usnTgzRuBApWWMw7tLWKjHmtDNeTGVBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=67FIIq1D+V+asq39t76M7ReKeHhVxdkAMjdLa3hjO4A=;
        b=c0Fb5Ih6+jbCPL+71Pq13CeJgS+uOauXE88/seJQ4HW5sULUy85CCgRW6rdxq+g1IP
         HBaAMoF640bgREICpmmzXo98cF66CLsCVSDEOXs7CYziL9UIpAnM4jKN1rKiPA3h6eyG
         br1fYEEm86QMWzgNJk3kU4ytbzQCRIdSgk1OkUKTiItqJGhdnc61Jp5F4zVyGG2+iWE/
         v7JWjjOJrVjauMjXY6WodaUnWCQ8fCqo63lsVTxt2ncHsgNFqEv2zQZEkRmY20T2MAGf
         QuQAtY7SEoNf3y/4aCpflNbFdo89FtJNe0L6KVx4kDMFfm/bmt8abXvv2oAvhK3KkNda
         jSFQ==
X-Gm-Message-State: APjAAAWi5pt2TA+uQZGSNUXgGRvCUPl4lvLKdPYOmwPZY6Smk2bhDtcX
        Ud0qNKKQvFefseGQTMZ2UHfrrw==
X-Google-Smtp-Source: APXvYqytfJllWL3kvVcykyzU2VtupNrDrUaLjpP3rd5JD3s1hTnEWkeZBgHal8imd07uv+qMVVQhdg==
X-Received: by 2002:a17:90a:aa83:: with SMTP id l3mr1311964pjq.5.1582667545448;
        Tue, 25 Feb 2020 13:52:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f18sm7161pgn.2.2020.02.25.13.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 13:52:24 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:52:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, dan.carpenter@oracle.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Ben Hutchings <ben@decadent.org.uk>, will@kernel.org,
        ebiederm@xmission.com, linux-arch@vger.kernel.org,
        security@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] execve: warn if process starts with executable stack
Message-ID: <202002251341.48BC06E@keescook>
References: <20191208171918.GC19716@avx2>
 <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191210174726.101e434df59b6aec8a53cca1@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2019 at 05:47:26PM -0800, Andrew Morton wrote:
> On Sun, 8 Dec 2019 20:19:18 +0300 Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > There were few episodes of silent downgrade to an executable stack over
> > years:
> > 
> > 1) linking innocent looking assembly file will silently add executable
> >    stack if proper linker options is not given as well:
> > 
> > 	$ cat f.S
> > 	.intel_syntax noprefix
> > 	.text
> > 	.globl f
> > 	f:
> > 	        ret
> > 
> > 	$ cat main.c
> > 	void f(void);
> > 	int main(void)
> > 	{
> > 	        f();
> > 	        return 0;
> > 	}
> > 
> > 	$ gcc main.c f.S
> > 	$ readelf -l ./a.out
> > 	  GNU_STACK      0x0000000000000000 0x0000000000000000 0x0000000000000000
> >                          0x0000000000000000 0x0000000000000000  RWE    0x10
> > 			 					 ^^^
> > 
> > 2) converting C99 nested function into a closure
> > https://nullprogram.com/blog/2019/11/15/
> > 
> > 	void intsort2(int *base, size_t nmemb, _Bool invert)
> > 	{
> > 	    int cmp(const void *a, const void *b)
> > 	    {
> > 	        int r = *(int *)a - *(int *)b;
> > 	        return invert ? -r : r;
> > 	    }
> > 	    qsort(base, nmemb, sizeof(*base), cmp);
> > 	}
> > 
> > will silently require stack trampolines while non-closure version will not.
> > 
> > Without doubt this behaviour is documented somewhere, add a warning so that
> > developers and users can at least notice. After so many years of x86_64 having
> > proper executable stack support it should not cause too many problems.
> 
> hm, OK, let's give it a trial run.

So, I'm a fan of the sentiment here, but this check is bogus for
several architectural and programmatic combinations. Sometimes
it's an intentional choice, not an "accident". e.g. klibc
uses trampolines for its setjmp implementation:
https://lists.zytor.com/archives/klibc/2020-February/004271.html

So now all the klibc initrds are throwing this warning (and then never
warning again, so it's extra pointless for such machines as "legitimate"
cases will never be discovered).

I've got a series up to fix the much sneakier version of this
(READ_IMPLIES_EXEC[1]), but at this point, I think this problem is well
addressed by distros scanning for this kind of thing in their repos.
For example, Ubuntu did this years ago (and flagged klibc as having
this condition):
https://wiki.ubuntu.com/SecurityTeam/Roadmap/ExecutableStacks

> 
> > --- a/fs/exec.c
> > +++ b/fs/exec.c
> > @@ -761,6 +761,11 @@ int setup_arg_pages(struct linux_binprm *bprm,
> >  		goto out_unlock;
> >  	BUG_ON(prev != vma);
> >  
> > +	if (unlikely(vm_flags & VM_EXEC)) {
> > +		pr_warn_once("process '%pD4' started with executable stack\n",
> > +			     bprm->file);
> > +	}
> > +
> >  	/* Move stack pages down in memory. */
> >  	if (stack_shift) {
> >  		ret = shift_arg_pages(vma, stack_shift);
> 
> What are poor users supposed to do if this message comes out? 
> Hopefully google the message and end up at this thread.  What do you
> want to tell them?

And that's the other problem (for which I see there is a thread). The
user can't actually do anything here.

I would really like something like this check, but maintaining a whitelist
of architectures or binaries to ignore is going to be awful, and there
is a very non-zero amount of software is built this way intentionally...

-Kees

[1] https://lore.kernel.org/lkml/20200225051307.6401-1-keescook@chromium.org/#r

-- 
Kees Cook
