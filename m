Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C49C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:36:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A13AD208A7
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ktyd7gBs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgE2FgH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgE2FgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:36:07 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90131C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:36:06 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id f21so826739pgg.12
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 22:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o7dKRf0Hebx8bKbWSLBiy415oUNWb1twJmt55KaFsGM=;
        b=Ktyd7gBsXKBCrU/QvdFNHGZTfvb+lBDDjjqC4JXPHIMB4WQNZ4Ube+TAzWaFo/cvPK
         XlqggI2Ayrf+yRjAO1GhueCpe7CIneXBaVPns19Iqwkw9BwrrLm9IGkY5jm2cgL6F7+5
         4+KUrgC0NVNJo5539ewaELoVXT1OMiq+OBnig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o7dKRf0Hebx8bKbWSLBiy415oUNWb1twJmt55KaFsGM=;
        b=g6gHH+WRtSiO8nX9BKGDDcNuGLBUGmr3R0noM8tM2uZKOpig1o4mjXJY6xWjeV229J
         owt4Uo3fx4fkEPBdQKWN7Tx+bTUVj59JaywmzqAR1pYUNFB8vyDN3VhPJMalXgFvuP8Q
         NH9RLxIN8UsAzvzA0riCZx1kp7uF/NqkM8VcyN09uV42tzO7WpjmlACS1/B4PAO6lq8n
         TVClAOME4y2EMnOLD0xJ2kLmdJRZJ5fvRac2STA2cDQtGagyGx7Vf+h1LRI6xcgLX1j1
         5JZ47vOxfFIqzNoMrXe2m8jYhlswsFsK+Qax2KHnwLtru9ToOvibGsnRmvhv3qAfON8L
         97BQ==
X-Gm-Message-State: AOAM53367vpIu0y4Bv0VI/GADU4islhFpggOHbp8wd030C0aJ55DzrCL
        69tXz85LGL8HsD7/+VW4EKON1Nnniv7T+g==
X-Google-Smtp-Source: ABdhPJzMN/wUdi7aywrcMuZINHoO1NBXeKKVrsdWbONwZ8EtvEcjL4kPE+/JS29Bf2N2gcOlAsytfg==
X-Received: by 2002:a63:e60b:: with SMTP id g11mr7006842pgh.120.1590730566107;
        Thu, 28 May 2020 22:36:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v17sm6012834pfg.164.2020.05.28.22.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 22:36:05 -0700 (PDT)
Date:   Thu, 28 May 2020 22:36:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH v2 1/2] seccomp: notify user trap about unused filter
Message-ID: <202005282229.3D87432@keescook>
References: <20200528151412.265444-1-christian.brauner@ubuntu.com>
 <202005281404.276641223F@keescook>
 <CAG48ez0k23qM2QEi42VTjCbnoY9_nfTH09B_Qr2zu+m3KWWUiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0k23qM2QEi42VTjCbnoY9_nfTH09B_Qr2zu+m3KWWUiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 01:32:03AM +0200, Jann Horn wrote:
> On Fri, May 29, 2020 at 1:11 AM Kees Cook <keescook@chromium.org> wrote:
> > So, is it safe to detach the filter in release_task()? Has dethreading
> > happened yet? i.e. can we race TSYNC? -- is there a possible
> > inc-from-zero?
> 
> release_task -> __exit_signal -> __unhash_process ->
> list_del_rcu(&p->thread_node) drops us from the thread list under
> siglock, which is the same lock TSYNC uses.

Ah, there it is. I missed the __unhash_process() in __exit_signal, but
once I saw the call to release_task(), I figured it was safe at that
point. So this seems correct:

> > I *think* we can do it
> > before the release_thread() call (instead of after cgroup_release()).

> One other interesting thing that can look at seccomp state is
> task_seccomp() in procfs - that can still happen at this point. At the
> moment, procfs only lets you see the numeric filter state, not the
> actual filter contents, so that's not a problem; but if we ever add a
> procfs interface for dumping seccomp filters (in addition to the
> ptrace interface that already exists), that's something to keep in
> mind.

Right -- but we can just reuse the get/put to pin the filter while
dumping it from proc (there IS someone working on this feature...)

> > (Actually, all our refcount_inc()s should be
> > refcount_inc_not_zero() just for robustness.)
> 
> Eeeh... wouldn't that just make the code more complicated for no good reason?

Sorry, ignore that. I got myself briefly confused -- we're fine;
refcount_inc() already does inc-from-zero checking.

-- 
Kees Cook
