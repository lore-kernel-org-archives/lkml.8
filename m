Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D949C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2DE2068E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7COmbV1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729832AbgEFP1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729321AbgEFP1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:27:10 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01621C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:27:10 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j4so1652797otr.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eGCPGsfl7EJQhLcR9ZieFJstYFNUvzZMzq7K6tCpWfI=;
        b=m7COmbV1y0NEdyCMq26y5R+ozIPQe1e9b1i1dIt42RXkxYKygKk8qebi6Q/me4A0lN
         UBZZjUWKYbs09g2A8AdY9VzJbzoVXyX1pS05tF5EHI16MUIGnhdr3OzDZVPLGi2F54gx
         BANbNSEVkW6CAZvM5hUZcSdYE5VcBvhdwfzsb/qspdMe5QXjukpCXM9p7CL2nAk0halH
         aah8NiadUrFjK48eQYJ+lesiZK+6N1frpq0C8OlKq3VZYtOMzo2StzkCj4RvJR2uMK+U
         IFuXePage1+LpAKZNDJmkjr0/dOu1yCOanPI8sPHexiN5vFJo+x7x8At2jxCFzloJnRW
         LcFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eGCPGsfl7EJQhLcR9ZieFJstYFNUvzZMzq7K6tCpWfI=;
        b=M6fZglTlxpXpU07fQyHtKUnIMZegMYeqzGRax6URe6ug2LN08S35ceD9WMX6LVkwd2
         25QeEFds3SWCV58BUTrmD5fuhuZCmPwgfRqCrAE/ihKnxm3xMLp4sb5RnaZH+uTxTbyW
         hKndA6pJLFhBt9eCfjzRfRbO0RNOSrmxYTnBkAkCRu/XPy/vHsiEG8SxR9BmFgTcfMyF
         hO5PbZAY36YAQbMXNEqtKtLKihKLkD7liHjo1MuG77nf6xs9ihxH7yV2ITeTdII3uLzh
         TdrUje9VaiZQVueLDG2qcwlXXGqHjsHWbYdXIFAo7G63aLFcSfhJL7mQomu//54QsQD9
         WdBA==
X-Gm-Message-State: AGi0PubtCCRCvonmBwaUsqEzdofl9PtUQDhuRN3FVNj4nCBUpZ4vuuI1
        BVCIHh/hJJKdxb5cjE2Tl1G1ZsEO510bUYaa8Be1hQ==
X-Google-Smtp-Source: APiQypIqZWUxuWlmvC0ioWT1YVFM8EdmBNF42IIaMVKHKcXRJP3qmACdQXoTRe722ZwPySImoGaL5yF47tWDjWNckhc=
X-Received: by 2002:a9d:412:: with SMTP id 18mr7072719otc.233.1588778829122;
 Wed, 06 May 2020 08:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200506132816.GJ8043@willie-the-truck> <20200506143616.GY2869@paulmck-ThinkPad-P72>
 <20200506144141.GA12919@willie-the-truck>
In-Reply-To: <20200506144141.GA12919@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Wed, 6 May 2020 17:26:56 +0200
Message-ID: <CANpmjNP3ge49sXJZS-KaL5bpEq0rmc4CqepjGRbtbCVwm7rwpw@mail.gmail.com>
Subject: Re: Please can I have a stable KCSAN branch for 5.8?
To:     Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 at 16:41, Will Deacon <will@kernel.org> wrote:
>
> Hi Paul,
>
> Cheers for the quick reply!
>
> On Wed, May 06, 2020 at 07:36:16AM -0700, Paul E. McKenney wrote:
> > On Wed, May 06, 2020 at 02:28:17PM +0100, Will Deacon wrote:
> > > I'm looking to rebase my READ_ONCE() series [1] on top of the KCSAN patches
> > > so that we can get them in for 5.8. However, tip/locking/kcsan seems to be
> > > missing some bits:
> > >
> > >   * An update to checkpatch.pl to warn about missing comments for
> > >     data_race():
> > >
> > >     https://lore.kernel.org/r/20200401101714.44781-1-elver@google.com
> >
> > For some reason, I thought this was going up some other tree, but I do
> > not see it in -next.  So unless I hear otherwise, I will pull it into
> > the v5.8 kcsan branch.
>
> Brill, thanks.
>
> > >   * I'm unable to apply these two patches from Marco that are needed for
> > >     my READ_ONCE() work:
> > >
> > >     https://lore.kernel.org/lkml/20200424154730.190041-1-elver@google.com/
> > >
> > >     I think these depend on stuff that has been queued by Paul, and appears
> > >     in linux-next, but to be honest with you I'm quite confused about what
> > >     is queued for 5.8 and what isn't.
> >
> > This one is queued, but I currently have it in the v5.9 pile (but
> > tentatively for v5.8).  Unless Marco tells me otherwise, I will move it
> > to the v5.8 branch, which will be part of my pull request next week.
>
> Great, then this would all show up on tip/locking/kscan, right?
>
> > > What's the best base for me to use?
> >
> > The -next tree has the latter, but not yet the former.
>
> That probably means -next is good enough for me to cook a new version of my
> series, and then I can make a proper branch next week.
>
> > Hopefully we can get this straightened out, and please accept my apologies
> > for the hassle!
>
> No need to apologise, I just couldn't figure out what was what and decided
> it was easier to ask the experts ;)

Just confirming that I don't see any issues with the plan -- the
patches that Will needs are good to go into the v5.8 branch.

Thanks,
-- Marco
