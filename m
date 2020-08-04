Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24D1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C35E2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NOnpc2qT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbgHDVie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgHDVic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:38:32 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28D4C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:38:31 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id s26so21435276pfm.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4c3zBWOBoW7xp3HrCBcy4dS6cve8V6weu+HU7unuUJA=;
        b=NOnpc2qTj/OJV8iwS9xvfHtescuXfOCQqqUOXB0T1ZxzeexlO+GsPdj8MbOvqxcWKl
         ze1BvmypdrJdF6JUUskuVeceZbd62shgANA0xKkwWukLs1nnhpH3c28cTYeIe+5QSb4I
         jZDkR65mA1EclTqORU2fGj7yVJhX3EFwc+l9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4c3zBWOBoW7xp3HrCBcy4dS6cve8V6weu+HU7unuUJA=;
        b=OuB7HUNjKV66seC+QOi8Hn8xbAMHXoStjEc7V/iXUPkUhaI9L+o+ohK0WH1waLzKJb
         ONAeY+PXw6+2vepnUwjJRj9B3EPtgoOc02LC5YXbr/fxkbow0GLGq0k5qibeFQkV/Wbf
         Wv9MuqUVo7eHOaMZrwCCRabnxLZBX4YOwYIB7G10rEay36eCP/NtENXBJoDUxAelpgpq
         f6xP58XO1ZDRYwbTh7TB8jyt4XpYOLebxMXbHakrsxbODpevu4Q6isv0RcDfQ5abe/tK
         L4G3uEoXWl6GzUWqxs78HLFehfGqlCux2PpKWq312v26dXJ76oHjs9ZHztp0IIURPHng
         Eccw==
X-Gm-Message-State: AOAM5329a2ztEVH7+IuhvqF1dDVeig0wbciJhfN3SDznYM7Ng4P7xBcM
        Ke6bsE/5xrjU7bKu5fOeszzkVg==
X-Google-Smtp-Source: ABdhPJwKg/6hXw3qujWRonlsnynDkNjCmUUGI6s++mju2N7eX5SPvNXbj8ox1gVfNUVMFE9OdatasQ==
X-Received: by 2002:a63:920b:: with SMTP id o11mr347918pgd.447.1596577111383;
        Tue, 04 Aug 2020 14:38:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id hi13sm6225pjb.26.2020.08.04.14.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:38:30 -0700 (PDT)
Date:   Tue, 4 Aug 2020 14:38:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, avagin@gmail.com, serge@hallyn.com,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/8] namespaces: Introduce generic refcount
Message-ID: <202008041421.E8F1A404A@keescook>
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
 <20200804115649.kzea757e5wwpk4k3@wittgenstein>
 <87d046sj8w.fsf@x220.int.ebiederm.org>
 <20200804123036.2lnkm6it7ko7j3ju@wittgenstein>
 <87r1smpmvk.fsf@x220.int.ebiederm.org>
 <20200804145714.rcz6vg3bo6chsuoh@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804145714.rcz6vg3bo6chsuoh@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 04, 2020 at 04:57:14PM +0200, Christian Brauner wrote:
> On Tue, Aug 04, 2020 at 08:21:51AM -0500, Eric W. Biederman wrote:
> > This change is not as trivial as a spelling change so it is not ok to
> > say it is just a cleanup and move on.  A change in the reference
> > counting can be noticable.  This needs at least to be acknowledged in
> > the change log and at a minimum a hand wavy reason put forth why it is
> > ok.
> > 
> > 
> > Instead what I am seeing as justification is this is a trivial cleanup
> > and no one will notice or care.   And it is not that trivial so I
> > object to the patchset.
> 
> The "not seeing a motivation for this" is a suprising argument to me to
> which I honestly can only respond that I don't see a motivation for not
> doing this. It unifies and simplifies code and removes variance.

Thanks for the CC! Ironically I had noticed this series yesterday at the
end of my day and thought to myself, "that's great; I need to go Ack
that tomorrow" and added it to my TODO list. :P

> > So I am opposed because the patchset does not explain at all why it
> > makes sense to do, nor what tradeoffs were considered, nor what
> > testing was done.

This is a reasonable concern; to me the rationale is clear, but you have
a point that it's not very well spelled out. From my perspective I see
the following benefits:

- The code is simplified because now there is a single lifetime counter
  and it goes in the right place: ns_common ... because it's common to
  all of the namespaces. (Yes there are other counters, but the lifetime
  count is common to all of them.) And the stats on the refactoring
  seems to support it with "51 insertions(+), 72 deletions(-)" which,
  while not "proof" that it's correct, is a positive signal that it's
  going in the right direction, implying a reduced maintenance cost.

- refcount_t is safer than atomic_t, and just as fast[1].

- This reduces the atomic_t -> refcount_t delta[2] that is still pending
  from Elena's efforts started in 2017.

So, while the commit logs could perhaps be clarified (and maybe include
a "in preparation for showing namespaces in ..." prefix describing the
work that triggered this clean-up), I think this is a good idea. Please
consider the whole series:

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

[1] https://git.kernel.org/linus/dcb786493f3e48da3272b710028d42ec608cfda1
[2] https://lore.kernel.org/lkml/1511954324-14414-1-git-send-email-elena.reshetova@intel.com/

-- 
Kees Cook
