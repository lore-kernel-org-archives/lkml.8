Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07830C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBA621655
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbgEDIqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:46:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:57627 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbgEDIqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:46:10 -0400
Received: from mail-lf1-f72.google.com ([209.85.167.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1jVWj7-0002zr-Ni
        for linux-kernel@vger.kernel.org; Mon, 04 May 2020 08:46:06 +0000
Received: by mail-lf1-f72.google.com with SMTP id 85so5391706lfa.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 01:45:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B6wxkvYlDwcvNl28OAXd66foLiyX2Rf6xw2AGAy8rbg=;
        b=PmRqfIsy6mk4Nh+quO89ohbI77kVKz3tEiSXyQJpVj6VhBmuolOtESOWx5VoOTlrW6
         1p7eGngG4XveHaVtm2KcphlCAKFMuWO2MyUv1pUchXgQkUJBSPNu0o6FSoCw/8ooicj2
         /4RIXpOVkdNVUS/DkEYX1K+TmaFOmgxixQihxjxims2+/t9iSv3I3h6SLtsSuYxK0K/V
         xZGD54XrOr9+rOnwi71ZARSLHrkEFr7hUJJcI+x7t7EkqFqzRKopAwKJreyr4RXIjDnb
         LU6aYtU00XfkyO2qNXm+CkTYQtzC7KQUpPLButDOycKly3OU9oEg29Cgj5DZcwaYgiBz
         QPWA==
X-Gm-Message-State: AGi0PuYSDeL5N1/Ay69Jn+80t69OgsaeHo3or7gks4sdgVC827so0ZFd
        HFhPsTEMBoEsql33iAHu+gv/Gv2IMsYRMUeKCNECqjJ5xBDkrkTguXxvo0GQQYBYnu3iM8zu/gl
        jxPo+c9JQhAq7f5GfUi+f2FsXwS4MFtPfuwPMUkH+mme9oFPJW1YWLE4/
X-Received: by 2002:ac2:43c6:: with SMTP id u6mr11091157lfl.170.1588581925048;
        Mon, 04 May 2020 01:45:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypIFD22/DCljKnq+u7jZyFdo7Mol8bJVCRBOgP0jURuxOCQkhi9JrcMk24wR9tGnThznoIKAGBwM9EBBjnCRNbI=
X-Received: by 2002:ac2:43c6:: with SMTP id u6mr11091134lfl.170.1588581924658;
 Mon, 04 May 2020 01:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200429095044.24625-1-po-hsu.lin@canonical.com> <20200501105933.8ebf317da9be19884c7cd33e@kernel.org>
In-Reply-To: <20200501105933.8ebf317da9be19884c7cd33e@kernel.org>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Mon, 4 May 2020 16:45:13 +0800
Message-ID: <CAMy_GT91OyBCNFHHNyAd_6KcmBB6bexYZYO3xD8vEvC=wvOBFA@mail.gmail.com>
Subject: Re: [PATCH] selftests/ftrace: treat module requirement unmet
 situation as unsupported
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kselftest@vger.kernel.org,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, mingo@redhat.com,
        shuah <shuah@kernel.org>, Colin King <colin.king@canonical.com>,
        Xiao Yang <yangx.jy@cn.fujitsu.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 9:59 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> On Wed, 29 Apr 2020 17:50:44 +0800
> Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> > When the required module for the test does not exist, use
> > exit_unsupported instead of exit_unresolved to indicate this test is
> > not supported.
>
> Hmm, this doesn't mean "the function is not supported" but
> "we can not resolve this because of the environmental issue".
> For example, if you forgot to install the modules, but the
> function itself is enabled, that can not be tested, but the
> system supports that feature.
>
> >
> > By doing this we can make test behaviour in sync with the
> > irqsoff_tracer.tc test in preemptirq, which is also treating module
> > existence in this way. Moreover, the test won't exit with a non-zero
> > return value if the module does not exist.
>
> It is OK to return zero even if the result is "unresolved", but
> I don't want to change the result of each test cases, because
> it clarify that you must install modules correctly, instead of
> enabling the feature.

Hello Masami,

With Alan Maguire's recent commit b730d668138c ("ftrace/selftest: make
unresolved cases cause failure if --fail-unresolved set") landed on
the tree.
I think this unresolved return value issue is all good here.

It is indeed a good question to brainstorm with about how to
distinguish a not enabled / enabled but not working feature.
I will fix the irqsoff_tracer.tc test here to make them consistent first.

Thank you for your feedback.
Po-Hsu

>
> And OK, I found irqsoff_tracer.tc IS incorrect. It should be fixed to
> return UNRESOLVED if there is no test module.
>
> If you still think UNRESOLVED is unneeded, please propose the patch
> which removes all UNRESOLVED related code. That can start another
> discussion.
>
> Thank you,
>
>
> >
> > Fixes: 646f01ccdd59 ("ftrace/selftest: Add tests to test register_ftrace_direct()")
> > Fixes: 4d23e9b4fd2e ("selftests/ftrace: Add trace_printk sample module test")
> > Fixes: 7bc026d6c032 ("selftests/ftrace: Add function filter on module testcase")
> > Fixes: af2a0750f374 ("selftests/ftrace: Improve kprobe on module testcase to load/unload module")
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> > ---
> >  tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc  | 2 +-
> >  tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc  | 2 +-
> >  tools/testing/selftests/ftrace/test.d/event/trace_printk.tc    | 2 +-
> >  tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc | 2 +-
> >  tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc  | 2 +-
> >  5 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> > index d75a869..3d6189e 100644
> > --- a/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/direct/ftrace-direct.tc
> > @@ -5,7 +5,7 @@
> >  rmmod ftrace-direct ||:
> >  if ! modprobe ftrace-direct ; then
> >    echo "No ftrace-direct sample module - please make CONFIG_SAMPLE_FTRACE_DIRECT=m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >
> >  echo "Let the module run a little"
> > diff --git a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> > index 801ecb6..3d0e3ca 100644
> > --- a/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/direct/kprobe-direct.tc
> > @@ -5,7 +5,7 @@
> >  rmmod ftrace-direct ||:
> >  if ! modprobe ftrace-direct ; then
> >    echo "No ftrace-direct sample module - please build with CONFIG_SAMPLE_FTRACE_DIRECT=m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >
> >  if [ ! -f kprobe_events ]; then
> > diff --git a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > index b02550b..dd8b10d 100644
> > --- a/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/event/trace_printk.tc
> > @@ -5,7 +5,7 @@
> >  rmmod trace-printk ||:
> >  if ! modprobe trace-printk ; then
> >    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >
> >  echo "Waiting for irq work"
> > diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> > index 1a4b4a4..26dc06a 100644
> > --- a/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/ftrace/func_mod_trace.tc
> > @@ -13,7 +13,7 @@ echo '*:mod:trace_printk' > set_ftrace_filter
> >  if ! modprobe trace-printk ; then
> >    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
> >  m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >
> >  : "Wildcard should be resolved after loading module"
> > diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > index d861bd7..4e07c69 100644
> > --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_module.tc
> > @@ -8,7 +8,7 @@ rmmod trace-printk ||:
> >  if ! modprobe trace-printk ; then
> >    echo "No trace-printk sample module - please make CONFIG_SAMPLE_TRACE_PRINTK=
> >  m"
> > -  exit_unresolved;
> > +  exit_unsupported;
> >  fi
> >
> >  MOD=trace_printk
> > --
> > 2.7.4
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
