Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D931EC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9462082E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 22:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E0oUbKMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBDWBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 17:01:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37726 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727483AbgBDWBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 17:01:45 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so7854145plz.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 14:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gbLrEwk02zWD7CENpU+Y79Z4g6lABXP6G5204ZKfF0=;
        b=E0oUbKMeJ/0TYgw6tXi/MO3OscDACPIaTiAsWEZIXsQv1vNqtOobaC90NrPhXEpUYJ
         VssEyhthK9sByNSf/0MA5pn1q0+p1fv5/odVot189qFvsw1AJiFPZ1PMYV/iI4RKyOLp
         HJpmQkUZn4rwRCt+vIJZMS33fKHuIoaYsQ/BiBHFLf2hnVTthuZv7xXW53bOzIkoQXZ2
         82EOY+PI8EH9bdWbEInMwvP96+SdY1qHoHdF4wCgQ6t3r6pqFjL5pRm/JztJrnVDKGI5
         Lqtcr5XKBzE8EOobYkPpHanqQUdwU/9+0Aawc8tVHXQ0jI2uBbrwh9o6mCiu9iY0TSI1
         HlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2gbLrEwk02zWD7CENpU+Y79Z4g6lABXP6G5204ZKfF0=;
        b=WRoNYgJQLV02/5j6OqX0HU2XKGb2igs0/5PvouKgw+dy+fqOLvBBFSqgNLNOYNnwlt
         eLv0VPcynskda/sHgBxeTmC999ZS31PM4HofU/u+nBIbyek7iwKdBBS54ZtAJekMcUG0
         7wFLue809uzD1w6CNX+x+bQga4SWGBvPfxmIxhxHaHl4ukTAuK3IgLb/XWSyXRJj2pN5
         Av254ZSbMAo5D5l/9LM68PAFAMJUbtc6o7bOXtTPuHUK3t4ISTTLwA5vzrTZUq4xWc+O
         orQZGZjsIyNx7U68akZTPwXQI2amTsMA7+vq+KIlRZ35GUOanj51fEetkPMgyDw0Nhag
         +fCg==
X-Gm-Message-State: APjAAAUJuNNnhJx9PTaWotX9X3siTKK1TLy8/Ylokwvbbm/l5/UqgALc
        mI9rep7sptxwhVkfZEsQWA8rRrrw84JqlplbfXTfxg==
X-Google-Smtp-Source: APXvYqxbz4sx3QIM2DYLthc3QPGt7xVW390CJ1zhH8z0BnZ3BPAOQ4lgq+vVdXkWYRiV/OfTJYB2C5zBqBukoNrw4CM=
X-Received: by 2002:a17:902:fe8d:: with SMTP id x13mr32553040plm.232.1580853704991;
 Tue, 04 Feb 2020 14:01:44 -0800 (PST)
MIME-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com> <9e203718-dcca-3145-bc28-28979d41c278@gmail.com>
In-Reply-To: <9e203718-dcca-3145-bc28-28979d41c278@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Feb 2020 14:01:33 -0800
Message-ID: <CAFd5g45MQqGLY2xCjAmJz4-xxHwBo9DBPphZdnQMHDe=d-2K_Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 1:18 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 1/30/20 5:08 PM, Brendan Higgins wrote:
> > ## TL;DR
> >
> > This patchset adds a centralized executor to dispatch tests rather than
> > relying on late_initcall to schedule each test suite separately along
> > with a couple of new features that depend on it.
>
> And the "couple of new features" are .... ?

Sorry, I thought I addressed that in the next section, specifically by
calling out: printing the test plan, and adding the new kernel command
line option. I will call these out here in any future cover letters.

> > ## What am I trying to do?
> >
> > Conceptually, I am trying to provide a mechanism by which test suites
> > can be grouped together so that they can be reasoned about collectively.
> > The last two of three patches in this series add features which depend
> > on this:
> >
> > PATCH 5/7 Prints out a test plan right before KUnit tests are run[1];
> >           this is valuable because it makes it possible for a test
> >           harness to detect whether the number of tests run matches the
> >           number of tests expected to be run, ensuring that no tests
> >           silently failed.
> >
> > PATCH 6/7 Add a new kernel command-line option which allows the user to
> >           specify that the kernel poweroff, halt, or reboot after
> >           completing all KUnit tests; this is very handy for running
> >           KUnit tests on UML or a VM so that the UML/VM process exits
> >           cleanly immediately after running all tests without needing a
> >           special initramfs.
> >
>
> > In addition, by dispatching tests from a single location, we can
> > guarantee that all KUnit tests run after late_init is complete, which
>
> That the tests will run after late init (and are guaranteed to do such)
> needs to be added to the documentation.

Yeah, that's reasonable. I am not sure where I should put this in the
documentation, however. This seems kind of a technical detail, and all
the pages I have now are more of how-tos, I think.

Maybe I should send a patch which adds a page detailing how KUnit works?

I would like to get some other people's thoughts on this. Such a
technical guide wouldn't provide me a lot of value, at least not now,
so I want to make sure that something like that would be valuable to
others.
