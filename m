Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6E4C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024E120748
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:07:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E7h8E3+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgAQVHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:07:43 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46825 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbgAQVHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:07:43 -0500
Received: by mail-pf1-f193.google.com with SMTP id n9so12470971pff.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YCsqNVhAm1Di2ZHCi7r9WDsSeSKbdfgtbe1b6IQVMR8=;
        b=E7h8E3+iNPnPKbULvSeSjkaSmiituhuO69cMDLqUOnoUXMVsx2OnVL0+YvFiDp56YI
         G3qgW2BGPaNqNa/7GL2mLvawMMVyUJ3CXBfzy2rh0Zf1uFi3fLXBpZo/7X8MJTZFvVNp
         wbmRQTeAuhoPXkt+1Euo3AeHJzb5a4CUU8JjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YCsqNVhAm1Di2ZHCi7r9WDsSeSKbdfgtbe1b6IQVMR8=;
        b=AB8cjgs3qGMijXoIPEjH7VbYpVjJ6KT/o3VFnDv21KOkYHOm1BsJpTNYlc9sDC5KBK
         VueDUdbwvjUaqmkGnzvcUBukRPr3VwwLDD3rJ9BVhFiv32w6oFpPTgEvWuTreBPzp1yG
         U5jxsB090P6QXoDNN9tgDCZCPMon0lqtYEfMvGxpAe/bDxOiuyGwc644TWjPWihzcQxW
         l2/A+DBlHKscmQMes+XwPfYxKaSR30IcOcHzrY3/VepEQSwA8EMK2WIaUtLBXem8/nkg
         jOocNfxIPlrdRsCuRpRDQzyLPDEcAsR6Ggags5SQpDs7VsmK/S8hV8QMRfHm8sfdk51K
         +uzQ==
X-Gm-Message-State: APjAAAXYbbWQ9bFnBiOR6qglXEmUqrzjgi0FPcaXh5dUwCGqNlz4n4BT
        9QyMyznX52tA02Z+coeOfooVXA==
X-Google-Smtp-Source: APXvYqzTfRUQytNCdU+h7w7eD9SUYQYpYSTDn6eIEjE3LOv1yzJWpeRIrNT7R1FFOHnW245zwomxTQ==
X-Received: by 2002:a63:5fd7:: with SMTP id t206mr48142029pgb.281.1579295261638;
        Fri, 17 Jan 2020 13:07:41 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j7sm32686601pgn.0.2020.01.17.13.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:07:40 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:07:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>,
        Oleg Nesterov <oleg@redhat.com>, stable@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>, Eric Paris <eparis@redhat.com>
Subject: Re: [REVIEW PATCH v2] ptrace: reintroduce usage of subjective
 credentials in ptrace_has_cap()
Message-ID: <202001171303.B27CCDA544@keescook>
References: <20200116224518.30598-1-christian.brauner@ubuntu.com>
 <202001161753.27427AD@keescook>
 <20200117051622.yre42znvc4r3i7ta@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117051622.yre42znvc4r3i7ta@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 06:16:23AM +0100, Christian Brauner wrote:
> On Thu, Jan 16, 2020 at 06:29:26PM -0800, Kees Cook wrote:
> > On Thu, Jan 16, 2020 at 11:45:18PM +0100, Christian Brauner wrote:
> > > Commit 69f594a38967 ("ptrace: do not audit capability check when outputing /proc/pid/stat")
> > > introduced the ability to opt out of audit messages for accesses to
> > > various proc files since they are not violations of policy.
> > > While doing so it somehow switched the check from ns_capable() to
> > > has_ns_capability{_noaudit}(). That means it switched from checking the
> > > subjective credentials of the task to using the objective credentials. I
> > > couldn't find the original lkml thread and so I don't know why this switch
> > > was done. But it seems wrong since ptrace_has_cap() is currently only used
> > > in ptrace_may_access(). And it's used to check whether the calling task
> > > (subject) has the CAP_SYS_PTRACE capability in the provided user namespace
> > > to operate on the target task (object). According to the cred.h comments
> > > this would mean the subjective credentials of the calling task need to be
> > > used.
> > 
> > I don't follow this description. As far as I can see, both the current
> > code and your patch end up using current's cred, yes? I'm not following
> > the subjective/objective change mentioned here.
> > 
> > Before:
> > bool has_ns_capability(struct task_struct *t,
> >                        struct user_namespace *ns, int cap)
> > {
> >         int ret;
> > 
> >         rcu_read_lock();
> >         ret = security_capable(__task_cred(t), ns, cap, CAP_OPT_NONE);
> 
> If I'm not mistaken, you're looking at the cuplrit: "__task_cred()":
> [...]
> #define __task_cred(task)	\
> 	rcu_dereference((task)->real_cred)

Ah! Yes, thank you. cred vs real_cred. That's what I missed!

> > However, I'm still trying to see where cred_guard_mutex() comes into
> > play for callers of ptrace_may_access(). I see it for the object
> > ("task" arg in ptrace_may_access()), but if this is dealing with the cred
> > on current, it's just the RCU read lock protecting it (which I think is
> > fine here), but seems confusing in the commit log.
> 
> Ah, right. I'll drop that from the commit message and place in the rcu
> lock.

Thanks for the clarification. With that adjusted, please consider it:

Reviewed-by: Kees Cook <keescook@chromium.org>

(I wonder how hard it might be to build some self-tests for this to
catch future glitches...)

-- 
Kees Cook
