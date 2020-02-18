Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850CFC3404C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C1B21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 22:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVKcd0As"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgBRWEJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:04:09 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37890 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbgBRWEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:04:08 -0500
Received: by mail-pl1-f193.google.com with SMTP id t6so8627066plj.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KjiEVUVH3LhEUahEgPDeCz6/w7FXRv21B6oRozWFPDw=;
        b=VVKcd0AsCnqbiOA75vkfYLI8PR3c9gYothwuJHKWcW2POCaYfkrnile0l9cvw1DZso
         e34atdHIm1vZM6nQdkGZPjLyU5oKCoSyHDWlxq6zFeJRogIz5MXD4Pegzg0tLVa45NdM
         6fHMsvuRHjhL4q6xbb0r5JrMPyc6Sk6/CWzl6mG5jRwKT4c3uRa7pyahek4pdPf0DDg7
         p1a+SqSJDDpnFGPegCZYbyrKOZW/7nDyA5Si/GXPSfUaY3jNo9JZY3U2M1bWGANEPHIR
         F44OupWSSIp/AfgNBRZ8zzQkz2qRSOq2iKh4+BA0mjADleLHYS33X+NtAg0VGI6LIIze
         a6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KjiEVUVH3LhEUahEgPDeCz6/w7FXRv21B6oRozWFPDw=;
        b=Zh9Pp+fIlHF3gdGRqUJ0aC2L/8OjO/V0H6WdwnK4Pn+Jr9yu+/asiDBYCvS6cxL55w
         jZzKTVgdrkgM83VcJ7fqeGt2E3vP56UYBKx3hXktzlp9BL6oO6BqKMqH3JlTCqU/x1Ss
         v8vyKed3JP3xVYu8thBj291r5hj9MyOpNRvK3DcfAlCq5MX8et6xihrQBn8E8d4EawQH
         FpLuYC/Yhqu4jhYVbe1UIOdKIUoX+uaVoxb/pczwR+ADhUs6duvwjyQm+uqDLrTyHQYY
         ftkV5UF+5T2vd8W8ZldUEo82twsrwAtX+uG6JIAbD9Z3Abkri30h8UdrCP17HbQ5nB2H
         Ysiw==
X-Gm-Message-State: APjAAAXDrlslUVQkBlYPUc75oi51iMnx5K7tzEHV4Pa95vjC+jn+DzwC
        Qv6XRDeUwUxsvHu7QqJbSC7GOV7fewEXCJ2fpJ3ALw==
X-Google-Smtp-Source: APXvYqzOs3hVD9imOllueUR+A3F1a+++GIZjcCfIXygMhJX1S7V5sZjKG9PFURgXzJqEh/OPsKcQAciddf1QhLTeH9g=
X-Received: by 2002:a17:902:9a4c:: with SMTP id x12mr21844315plv.297.1582063446576;
 Tue, 18 Feb 2020 14:04:06 -0800 (PST)
MIME-Version: 1.0
References: <1581094694-6513-1-git-send-email-alan.maguire@oracle.com>
 <1581094694-6513-2-git-send-email-alan.maguire@oracle.com>
 <c42ac237-476a-526f-b445-61e7a63bc101@gmail.com> <CAFd5g47p9wnbz=HrNh0U2bbc=0ZaJ7n0U+_=E8yp8yPMrqwzaA@mail.gmail.com>
 <MWHPR13MB0895A9AC64475539ECF99987FD110@MWHPR13MB0895.namprd13.prod.outlook.com>
In-Reply-To: <MWHPR13MB0895A9AC64475539ECF99987FD110@MWHPR13MB0895.namprd13.prod.outlook.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 18 Feb 2020 14:03:55 -0800
Message-ID: <CAFd5g44BmpxS7RgxoNBywBOs3NjWdFp+A_aU5Ym0MrSn=O_RbA@mail.gmail.com>
Subject: Re: [PATCH v3 kunit-next 1/2] kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results
 display
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>, shuah <shuah@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 12:49 PM Bird, Tim <Tim.Bird@sony.com> wrote:
>
>
>
> > -----Original Message-----
> > From:  Brendan Higgins
> >
> > On Wed, Feb 12, 2020 at 7:25 PM Frank Rowand <frowand.list@gmail.com> wrote:
> > >
> > > On 2/7/20 10:58 AM, Alan Maguire wrote:
>
> ...
>
> > > > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > > > index 9242f93..aec607f 100644
> > > > --- a/lib/kunit/test.c
> > > > +++ b/lib/kunit/test.c
> > > > @@ -10,6 +10,7 @@
> > > >  #include <linux/kernel.h>
> > > >  #include <linux/sched/debug.h>
> > > >
> > > > +#include "debugfs.h"
> > > >  #include "string-stream.h"
> > > >  #include "try-catch-impl.h"
> > > >
> > > > @@ -28,73 +29,91 @@ static void kunit_print_tap_version(void)
> > > >       }
> > > >  }
> > > >
> > > > -static size_t kunit_test_cases_len(struct kunit_case *test_cases)
> > > > +size_t kunit_suite_num_test_cases(struct kunit_suite *suite)
> > > >  {
> > > >       struct kunit_case *test_case;
> > > >       size_t len = 0;
> > > >
> > > > -     for (test_case = test_cases; test_case->run_case; test_case++)
> > > > +     kunit_suite_for_each_test_case(suite, test_case)
> > > >               len++;
> > > >
> > > >       return len;
> > > >  }
> > > > +EXPORT_SYMBOL_GPL(kunit_suite_num_test_cases);
> > > >
> > > >  static void kunit_print_subtest_start(struct kunit_suite *suite)
> > > >  {
> > > >       kunit_print_tap_version();
> > > > -     pr_info("\t# Subtest: %s\n", suite->name);
> > > > -     pr_info("\t1..%zd\n", kunit_test_cases_len(suite->test_cases));
> > > > +     kunit_log(KERN_INFO, suite, "# Subtest: %s", suite->name);
> > > > +     kunit_log(KERN_INFO, suite, "1..%zd",
> > > > +               kunit_suite_num_test_cases(suite));
> > >
> > > The subtest 'is a TAP stream indented 4 spaces'.  (So the old code was
> > > also incorrect since it indented with a tab.)
> >
> > Whoops.
> >
> > I agree that fixing tabs to spaces is probably the easiest thing to do
> > here; nevertheless, I think this might be a good time to talk about
> > other deviations from the spec and what to do about it. This might
> > also be a good time to bring up Tim's comment at LPC last year about
> > forking TAP. Arguably I already have given that TAP14 is still under
> > review and is consequently subject to change.
> >
> > Additionally, the way I report expectation/assertion failures are my
> > own extension to the TAP spec. I did this because at the time I wasn't
> > ready to open the can of worms that was adding a YAML serializer to
> > the Linux kernel; I mentioned adding a YAML serializer at LPC and
> > people didn't seem super thrilled with the idea.
>
> I'm not sure I follow.  Are you talking about writing YAML or interpreting
> YAML.  You don't need a serializer to write YAML.  It can be done
> with straight text output.  I guess it depends on the scope of what you
> envision.  Even if you want to do more than trivial structured output,
> I don't think you'll need a full serializer.  (IOW, I think you could sneak
> something in and just call it a test output formatter.  Just don't call it YAML
> and most people won't notice. :-)

Yeah, for the first one or two things just printing things out
directly is probably fine, and yes, I could have just snuck it in, but
at the time it wasn't a hindrance for me to ask what people wanted: I
had already worked around it.

In any case, I was just explaining part of why I did expectations and
assertion failures the way that I did.

> >
> > Further both the TAP implementation here as well as what is in
> > kselftest have arbitrary kernel output mixed in with TAP output, which
> > seems to be a further deviation from the spec.
> Well that's a different kettle of worms, and really argues for staying
> with something that is strictly line-based.
>
> >
> > In an effort to do this, and so that at the very least I could
> > document what I have done here, I have been looking into getting a
> > copy of TAP into the kernel. Unfortunately, TAP appears to have some
> > licensing issues. TAP says that it can be used/modified "under the
> > same terms as Perl itself" and then provides a dead link. I filed a
> > pull request to update the licence to the Perl Artistic Licence 1.0
> > since I believe that is what they are referencing; however, I have not
> > heard back from them yet.
>
> When you say "getting a copy of TAP into the kernel", I presume you mean
> an existing implementation to produce TAP output?  Or are you talking about
> a TAP interpreter?  I'm not sure the former needs to use an existing implementation.

Sorry, that wasn't clear. I meant: get a copy of the TAP spec itself
into the kernel documentation. KUnit already has an implementation.

> I previously volunteered (in Lisbon) to write up the TAP deviations,
> and never got around to it.   Sorry about that. I can try to work on it now if
> people are still interested.

I think that would be useful. I would do it, but, as I mentioned,
there are licensing issues with the TAP spec. I am trying to resolve
those issues, and am currently waiting to hear back from somebody from
TAP.
