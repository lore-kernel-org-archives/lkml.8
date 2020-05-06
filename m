Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DFEC4724C
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 428E120CC7
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q/9X3Hqp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgEFPai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729931AbgEFPag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:30:36 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B22DC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:30:36 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q24so1045499pjd.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QdMtxniSWK3PkWXNKwBL1UPHuRFtnVNhLkmVLBdfg9k=;
        b=Q/9X3HqpDpP1bpMyEce6+77MmK6MN+XVjRdiAxqecgTGYNf3lBxevqb2kiejal14bb
         WjYaodQ0NtKSLfkI4ehZZNQCWbD4wu0b8/wpICLtZi+IHB10p/r0x/OfvVfBgznsLkHH
         mBJthd/pdvQ9+cBWw2Oz5oYEAiMhlyPElCbek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QdMtxniSWK3PkWXNKwBL1UPHuRFtnVNhLkmVLBdfg9k=;
        b=O5R+YuaAOTNTFQFpo7FdHVmGwM0Gtgfv4Mgqchci6y8HV4ebNB/f+3d6+J6BMJZO4d
         17n54GWr4Fm2KO6KnSltnEVXiD129mIEH4RDNyJ+BmEOAm4qtoi7fpvoBctc3ZeqjKlM
         SDutyj50QlhCU4MUUMjSnYV02UdCx+sRYQMedAS5R/7a39n1RE4gBwwuzhe53k2BnUG3
         ILz+QsoQu7v4GXpmLwOIdl3MnjDFqXmmNIrEO8f1I44MnqKQEC8ykhnVWXuvN1BZ/K0U
         SeuqN4klg3QV9daImGj/f2NNgrHHjIUmfF9ZkgUjgAQDx/Vxe1IotAL5Jc6/scwmG25I
         D+Tg==
X-Gm-Message-State: AGi0Puash/pJbOrpTFMUf9BEiWMJbzSK5s5AsPTtbIh2vv9IpscbYJhl
        1Pe6CrrRf6wn1sMrEna0iVDb/g==
X-Google-Smtp-Source: APiQypLr2NM9l03AagLLZo6M94o8eGZFpNOjjoclEjyQPblQQ32jPFWaWB507XPHEGNsAcVzeN19jg==
X-Received: by 2002:a17:90a:21ce:: with SMTP id q72mr9815638pjc.0.1588779036158;
        Wed, 06 May 2020 08:30:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 82sm2099813pfv.214.2020.05.06.08.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:30:34 -0700 (PDT)
Date:   Wed, 6 May 2020 08:30:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6/7] exec: Move most of setup_new_exec into flush_old_exec
Message-ID: <202005060829.A09C366D0@keescook>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
 <87ftcei2si.fsf@x220.int.ebiederm.org>
 <202005051354.C7E2278688@keescook>
 <87368ddsc9.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87368ddsc9.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 09:57:10AM -0500, Eric W. Biederman wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Tue, May 05, 2020 at 02:45:33PM -0500, Eric W. Biederman wrote:
> >> 
> >> The current idiom for the callers is:
> >> 
> >> flush_old_exec(bprm);
> >> set_personality(...);
> >> setup_new_exec(bprm);
> >> 
> >> In 2010 Linus split flush_old_exec into flush_old_exec and
> >> setup_new_exec.  With the intention that setup_new_exec be what is
> >> called after the processes new personality is set.
> >> 
> >> Move the code that doesn't depend upon the personality from
> >> setup_new_exec into flush_old_exec.  This is to facilitate future
> >> changes by having as much code together in one function as possible.
> >
> > Er, I *think* this is okay, but I have some questions below which
> > maybe you already investigated (and should perhaps get called out in
> > the changelog).
> 
> I will see if I can expand more on the review that I have done.
> 
> I saw this as moving thre lines and the personality setting later in the
> code, rather than moving a bunch of lines up
> 
> AKA these lines:
> >> +	arch_pick_mmap_layout(me->mm, &bprm->rlim_stack);
> >> +
> >> +	arch_setup_new_exec();
> >> +
> >> +	/* Set the new mm task size. We have to do that late because it may
> >> +	 * depend on TIF_32BIT which is only updated in flush_thread() on
> >> +	 * some architectures like powerpc
> >> +	 */
> >> +	me->mm->task_size = TASK_SIZE;
> 
> 
> I verified carefully that only those three lines can depend upon the
> personality changes.
> 
> Your concern if anything depends on those moved lines I haven't looked
> at so closely so I will go back through and do that.  I don't actually
> expect anything depends upon those three lines because they should only
> be changing architecture specific state.  But that is general handwaving
> not actually careful review which tends to turn up suprises in exec.

Right -- I looked through all of it (see my last email) and I think it's
all okay, but I was curious if you'd looked too. :)

> Speaking of while I was looking through the lsm hooks again I just
> realized that 613cc2b6f272 ("fs: exec: apply CLOEXEC before changing
> dumpable task flags") only fixed half the problem.  So I am going to
> take a quick detour fix that then come back to this.  As that directly
> affects this code motion.

Oh yay. :) Thanks for catching it!

-- 
Kees Cook
