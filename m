Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C421C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FDE2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b1xFmE2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgDVXvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgDVXvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:51:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A5AC03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:51:42 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f8so1603625plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 16:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QgMVZz3XwLkExErntao4WLiI0VS/DsZOFmHjZC/Mbow=;
        b=b1xFmE2sV5VW4aIlU/whxS/awWX9vekQ0Ico8eQgciMKy7zuNVk5XtOpg39bOTWcKs
         gmE9IbR9W35bFsypZV4vL3HSs5YmoSf5fN8616fkMWbslDLfiUYdepcmXnGAGCT9UBow
         tcegupNB12V2vId+LwrLQi0D9fZMOT/3eaM73mrtZdPpGBHCbmDq0L+M54abVOxMotXA
         LxFAdJGBFIgJQJDG8i+fcobu58I88gq4sWg+B8YpHYN1E99k4GEnsYVLt9Kz7c/v8YvO
         1Ag5ItZ7vliNh16MSWpcpImUWRG2bw/nM3eiMhbI7Z3GgjX0L1CaNHTEcHJUd8nG/PfW
         SEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QgMVZz3XwLkExErntao4WLiI0VS/DsZOFmHjZC/Mbow=;
        b=rr1dh8VOwKuhVZxgR3LuxAQc9qUiw0q17zZHlzjt0MmAOdcSMH61feImw/I6YNrtjc
         2YlhhheZgyUDYT0P2gvjiGaj+SVtNd6iRo1AbmydG0mydmPxRvP633fgHYEcfQsxDcBB
         D8PmX0BqRBdl7xttoyL55Xq6kh3wV5kfvrkBLkMxELvq6xt1e8DWdRKXK7rdDiyU/Fsc
         n0+8NLBv1Lhi6YI4XH4lCvnzLv8I092O+okO67NLhx2dpK0TJgPKkONgWuury2mDmsOj
         uSUmtEQDOa+Awmk5gt0V0Ozdk9aFrgVAOTuwpyedL8vWw7UxEuzH+7DZBkEJ026KeI7F
         RpJA==
X-Gm-Message-State: AGi0PuZTd5ujIPhOtUGTGAZyiCMZpGZlmpIKKlZcLGBvz426yTZUw0pK
        B31xcxZz774rEnfb0CUYVY4Jlw==
X-Google-Smtp-Source: APiQypKd8hMC33L8Wj5RKdsZ70cGbYI15nshdaNSvjex+B8eCij/WOOT64Lb2ePxq5TYoHX5bEGXjw==
X-Received: by 2002:a17:902:b097:: with SMTP id p23mr1161570plr.195.1587599501845;
        Wed, 22 Apr 2020 16:51:41 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id h11sm621261pfo.120.2020.04.22.16.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 16:51:40 -0700 (PDT)
Date:   Wed, 22 Apr 2020 16:51:34 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 01/12] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <20200422235134.GA211149@google.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200416161245.148813-1-samitolvanen@google.com>
 <20200416161245.148813-2-samitolvanen@google.com>
 <20200420171727.GB24386@willie-the-truck>
 <20200420211830.GA5081@google.com>
 <20200422173938.GA3069@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422173938.GA3069@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 06:39:47PM +0100, Will Deacon wrote:
> On Mon, Apr 20, 2020 at 02:18:30PM -0700, Sami Tolvanen wrote:
> > On Mon, Apr 20, 2020 at 06:17:28PM +0100, Will Deacon wrote:
> > > > +	 * The shadow call stack is aligned to SCS_SIZE, and grows
> > > > +	 * upwards, so we can mask out the low bits to extract the base
> > > > +	 * when the task is not running.
> > > > +	 */
> > > > +	return (void *)((unsigned long)task_scs(tsk) & ~(SCS_SIZE - 1));
> > > 
> > > Could we avoid forcing this alignment it we stored the SCS pointer as a
> > > (base,offset) pair instead? That might be friendlier on the allocations
> > > later on.
> > 
> > The idea is to avoid storing the current task's shadow stack address in
> > memory, which is why I would rather not store the base address either.
> 
> What I mean is that, instead of storing the current shadow stack pointer,
> we instead store a base and an offset. We can still clear the base, as you
> do with the pointer today, and I don't see that the offset is useful to
> an attacker on its own.

I see what you mean. However, even if we store the base address +
the offset, we still need aligned allocation if we want to clear
the address. This would basically just move __scs_base() logic to
cpu_switch_to() / scs_save().

> But more generally, is it really worthwhile to do this clearing at all? Can
> you (or Kees?) provide some justification for it, please? We don't do it
> for anything else, e.g. the pointer authentication keys, so something
> feels amiss here.

Like Kees pointed out, this makes it slightly harder to locate the
current task's shadow stack pointer. I realize there are other useful
targets in thread_info, but we would rather not make this any easier
than necessary. Is your primary concern here the cost of doing this,
or just that it doesn't sufficiently improve security?

Sami
