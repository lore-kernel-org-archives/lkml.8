Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 166C2C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3309206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 08:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FcVyCXAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgE2IHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 04:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgE2IHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 04:07:01 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB255C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:07:01 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id cx22so893737pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 01:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zUnJbyzOf32MFYbpKtQSpaY9+L0BrbDcveZwkXnT5Lc=;
        b=FcVyCXAZfE6X6PbFEXJ+8Y9NyyJfAld1YjTlxG4H2az5M9VeGoXraytbZZT3BZqrzB
         UZA/Vkvl/USVFdv1UlyGZMVBHys8Sa4oBVkUxSi2hX9+52J6s7Li2lDG+G0ADIjZgbk7
         qrY9YvvyquAzkhjn93QzDCApUyWg6jY7qz5+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUnJbyzOf32MFYbpKtQSpaY9+L0BrbDcveZwkXnT5Lc=;
        b=tz432s9oM3NZGQUPeh9q5zavRsjyJ/ZBHLFSz6DQxFflK8fF/en+Cyc1xy08b9pSxH
         hes17tiGyDYwgVQsZ3IQilM/iDnMfBynKnjOwJo1q2haJI+LsHZs7Y+jt7ysRWW/zKjf
         3k/tYGPrJsfs3FlB+8v19UKTYnZ4cqImXuj/VeQrzo/SxfTCwbOcNVOjub8nHdTkYx2B
         XtAUwtlWNR8B516IsV9SlK3GrTnA6NrVacDIrMt4A0lWtiP9XqOENkqhnl1JLGx5oIAo
         dhWdFV0f+9EkcwgZtA1pmtoEh+FJIyF1z7Mdnnd0Dnk2xZI/nObM+qtiwu7+laII1xV6
         NgSw==
X-Gm-Message-State: AOAM531YzO/BzUxiEVGzyEejx+G2ERA1pEuMLKoDZ71Mg4ijcf/mFoIw
        Q/DIM1PYX0vAlBCeRDltinl6rA==
X-Google-Smtp-Source: ABdhPJz/H3/3xGMBVlFtnQstYVNrZAT/CmvF0C4DKUiUUXoyibvRDtfJcLFBmIDbruoa3hyqpDZS9Q==
X-Received: by 2002:a17:90a:aa8f:: with SMTP id l15mr8733509pjq.156.1590739621505;
        Fri, 29 May 2020 01:07:01 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r18sm6766321pjz.43.2020.05.29.01.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 01:07:00 -0700 (PDT)
Date:   Fri, 29 May 2020 01:06:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH v2 1/2] seccomp: notify user trap about unused filter
Message-ID: <202005290102.3BB21C875@keescook>
References: <20200528151412.265444-1-christian.brauner@ubuntu.com>
 <202005281404.276641223F@keescook>
 <20200529075641.eoogczu6t5gmv3e3@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529075641.eoogczu6t5gmv3e3@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 09:56:41AM +0200, Christian Brauner wrote:
> On Thu, May 28, 2020 at 04:11:00PM -0700, Kees Cook wrote:
> > void seccomp_filter_release(const struct task_struct *tsk)
> > {
> > 	struct seccomp_filter *orig = READ_ONCE(tsk->seccomp.filter);
> > 
> > 	smp_store_release(&tsk->seccomp.filter, NULL);
> 
> I need to go through the memory ordering requirements before I can say
> yay or nay confidently to this. :)
> 
> > 	__seccomp_filter_release(orig);
> > }

The only caller will be release_task() after dethread, so honestly this
was just me being paranoid. I don't think it actually needs the
READ_ONCE() nor the store_release. I think I wrote all that before I'd
convinced myself it was safe to remove a filter then. But I'm still
suspicious given the various ways release_task() gets called... I just
know that if mode 2 is set and filter == NULL, seccomp will fail closed,
so I went the paranoid route. :)

-- 
Kees Cook
