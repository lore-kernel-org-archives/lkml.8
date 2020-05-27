Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FF61C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA792071A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 22:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="XVLU5JS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgE0W4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 18:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgE0W4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 18:56:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA68C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:56:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id cx22so2239314pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 15:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PI2C96+3H6gIr9QJOVWp15+V0aH+BRuKNRaFs+DeBrE=;
        b=XVLU5JS4PFZ1+641xJQKCy+0a8KVBDdRwl4Dbp9YR4WGmAjr3Ni+MyKkpE5whw2SHY
         iPduvkSjiJe1YZ3ssvpu4kaGT857K4A1OBHBWd+VWmlOnJbQJYfx7RKSN4nQRAtbz4zd
         1wkp+drkbkadfk+Cl18tryoukg/3NQhWhi9Bhl17hL7M4j7e0GmLUEQL7KXPNAGK+VMA
         EqSJRZMN3qf5nw6ryczH8SmA1EYaetP+eQOSuOh5pWF6otfHvDItD9JtpPxzgEvCbnhT
         TrpwS5AtbcB7zKEY+ETAUpTUT+3FywPbYYOLWw1IJ9tepUgZBp+jjjn3vBKlpvrDZFRb
         eASg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PI2C96+3H6gIr9QJOVWp15+V0aH+BRuKNRaFs+DeBrE=;
        b=AIGIzVYlclpkPtYBmbwMAeziUCxQme0LoD2aaq6l6TOcTUWuxIUd0m2QTQAYA1FcGZ
         NFBaLVAbGgcmbH93p06w0wovF5SSOpTuJu5zc0fJ6+iRRnqJnliR3AIb2qXI9VBU5Wl8
         DokSbJVt4hAfWu9fPINs15xiKRyITt1j8aT/8APnrtS9xlOMVRnz+sK4uzEVyxDbmCsl
         L1eMEnNqwJe5V84P7Iviwvwy/dl//IeHoG5xtzphX+8gQ4tF0y4zJWiy3tHVK7cAyQce
         t2HmEHyPO6D54PYUM5BeB93ZIYNTjxMse/mJZRfoO5tMhyltQpKV4j48j8LS1YLKLaPP
         sEEA==
X-Gm-Message-State: AOAM530Fitqwc90srxxr52vK+vXTSjqCYOnZf8knS5sfMKfbjU+PD2F+
        op1kFMW9uGIDNdTQPF8/Z1/DdA==
X-Google-Smtp-Source: ABdhPJxJxFgWdftTPh49uH2OQXb4hplDrr5r41mtwat8UDNThFr8ByxDio8jyIPAGR9Wj/ZXs07d0Q==
X-Received: by 2002:a17:90a:db0f:: with SMTP id g15mr715025pjv.8.1590620160180;
        Wed, 27 May 2020 15:56:00 -0700 (PDT)
Received: from cisco ([2001:420:c0c8:1003::948])
        by smtp.gmail.com with ESMTPSA id q4sm3048352pfu.42.2020.05.27.15.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 15:55:59 -0700 (PDT)
Date:   Wed, 27 May 2020 16:56:00 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Matt Denton <mpdenton@google.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Jann Horn <jannh@google.com>, Chris Palmer <palmer@google.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Robert Sesek <rsesek@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Linux Containers <containers@lists.linux-foundation.org>
Subject: Re: [PATCH 1/2] seccomp: notify user trap about unused filter
Message-ID: <20200527225600.GF4153131@cisco>
References: <20200527111902.163213-1-christian.brauner@ubuntu.com>
 <202005271408.58F806514@keescook>
 <20200527215203.GE4153131@cisco>
 <202005271457.CF4BBB47@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005271457.CF4BBB47@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 03:36:09PM -0700, Kees Cook wrote:
> On Wed, May 27, 2020 at 03:52:03PM -0600, Tycho Andersen wrote:
> > On Wed, May 27, 2020 at 02:43:49PM -0700, Kees Cook wrote:
> > > (While I'm here -- why can there be only one listener per task? The
> > > notifications are filter-specific, not task-specific?)
> > 
> > Not sure what you mean here?
> 
> tatic struct file *init_listener(struct seccomp_filter *filter)
> {
>         struct file *ret = ERR_PTR(-EBUSY);
>         struct seccomp_filter *cur;
> 
>         for (cur = current->seccomp.filter; cur; cur = cur->prev) {
>                 if (cur->notif)
>                         goto out;
>         }
> 
> ...
> 
>         /* Installing a second listener in the chain should EBUSY */
>         EXPECT_EQ(user_trap_syscall(__NR_getpid,
>                                     SECCOMP_FILTER_FLAG_NEW_LISTENER),
>                   -1);
>         EXPECT_EQ(errno, EBUSY);
> 
> 
> Why does this limit exist? Since the fd is tied to a specific filter,
> I don't see conflicts about having multiple USER_NOTIF filters on one
> task -- the monitor's response will either fake it or continue it, so
> there is no "composition" needed? I must be missing something.

It exists because Andy asked for it :)

I agree that there's no technical reason for it to be there. I think
it's just that the semantics were potentially confusing, and it wasn't
a requirement anyone had to have multiples attached.

Tycho
