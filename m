Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 602DEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37BDE206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:40:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X2zHDOTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgGFVkQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbgGFVkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:40:16 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E99CC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 14:40:16 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o1so9278028plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S8PPOwL6l2Qa5tBmuzCWfKqVL5UHTdEHxsmDd+xAnzM=;
        b=X2zHDOTNJJxY0s1N2WaVqaWAX0E1AoW926YUp/jqHRoHpZzkOUIHgynHDfFhLMl2bU
         cW5s9KB1H3iGKHCYccU+mRGbicmC4OLJPVHvTDnlQRbdH6xnHcGdyii296GtXoQfjYiU
         oQumYB9e9DRV0xxMwOOcLqZkTxpHB4PsHk9sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S8PPOwL6l2Qa5tBmuzCWfKqVL5UHTdEHxsmDd+xAnzM=;
        b=QdS8bWdLIyTvWSmHIwpY+Eaj6xTjfmGTKuuZfrS76koR+q6F4e4BvQtIJUyLGbwTqW
         q+atjhgEmw9L/nOHWZXNJx5KrAv3qe7jQg7v6CwXDgjsN33chLGvPmS9ypIlaKU6a8yq
         UzZvReuZ3ijcCFxZk2/NzdHsAhRsPrVwgleGQgenx6mGlKseclqCBN7v8CSe+FXUpSEm
         88h9fHrDI/iNZywbl//9/GMibG4tJi3hxmpX/jJTyKAzA1UvsK35n4Y5VSsctZSo9qiG
         k/9z2esVVF+GkDedBVgj1yAm2QzOHwsZYTStQrk5N7da8vtmviYAgR0t1VeTH8Ke8PVq
         kWqg==
X-Gm-Message-State: AOAM531CufR4wReIzeft9cbh0ma6SbO5pvoNvcpaghzQ6oXZl81Sqms/
        FVNKhnY9FNPkDdvKT72quAdTFQ==
X-Google-Smtp-Source: ABdhPJxfFUFYoO2RMHmnyzogkeoJ8sgrz7uvi6BJxPJY+5JXKtOGqopfD+gRzM7YUZ5yhTAs9xT5zQ==
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr6355094pls.98.1594071616026;
        Mon, 06 Jul 2020 14:40:16 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q6sm20177080pfg.76.2020.07.06.14.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 14:40:14 -0700 (PDT)
Date:   Mon, 6 Jul 2020 14:40:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Will Deacon <will@kernel.org>
Cc:     Keno Fischer <keno@juliacomputing.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: ptrace: seccomp: Return value when the call was already invalid
Message-ID: <202007061439.8BF61308@keescook>
References: <CABV8kRxA9mXPZwtYrjbAfOfFewhABHddipccgk-LQJO+ZYu4Xg@mail.gmail.com>
 <20200703083914.GA18516@willie-the-truck>
 <202007030815.744AAB35D@keescook>
 <20200703154426.GA19406@willie-the-truck>
 <202007030851.D11F1EFA@keescook>
 <20200704123355.GA21185@willie-the-truck>
 <202007042132.DAFA2C2@keescook>
 <20200706081550.GA23032@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706081550.GA23032@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:15:51AM +0100, Will Deacon wrote:
> On Sat, Jul 04, 2020 at 09:56:50PM -0700, Kees Cook wrote:
> > different per-architecture expectations). If I read this thread
> > correctly, we need to test:
> > 
> > 	syscall(-1), direct,  returns ENOSYS
> > 	syscall(-10), direct, returns ENOSYS
> > 	syscall(-1), SECCOMP_RET_TRACE+PTRACE_CONT, returns ENOSYS
> > 	syscall(-10), SECCOMP_RET_TRACE+PTRACE_CONT, returns ENOSYS
> > 	syscall(-1), ptrace+PTRACE_SYSCALL, returns ENOSYS
> > 	syscall(-10), ptrace+PTRACE_SYSCALL, returns ENOSYS
> > 
> > do we need to double-check that registers before/after are otherwise
> > unchanged too? (I *think* just looking at syscall return should be
> > sufficient to catch the visible results.)
> 
> There's also the case where the tracer sets the system call to -1 to skip
> it.

Yes, though that's already part of the seccomp selftests. (Specifically
TRACE_syscall's syscall_faked.)

-- 
Kees Cook
