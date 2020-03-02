Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93053C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6904721739
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 23:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FPSeLrB7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCBXCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 18:02:10 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38266 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgCBXCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 18:02:09 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so549593pgh.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 15:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=alU+BgvFGo59yM0O+ldee5pOjl7Ty1NQ+17QZiMtzMo=;
        b=FPSeLrB7GcxGD/0n0DkgZRMYdBUiZeQ+laPMlp2Pb3icU44iK9eIgS7nJheSVzUk4x
         XzQrD4vw1cKLDfSG7T4p+rZUN5/fWPWf5odYIvQHZz0B3JCIvnVMia0pRtb1FtCenogk
         e82T6ScsKsm8DbFN0db3OAll3/2xdOIMdHVxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=alU+BgvFGo59yM0O+ldee5pOjl7Ty1NQ+17QZiMtzMo=;
        b=Z6/SnCLYs3K5mJbtOMyfL3ezwiABs5aDkakDLA9hlpHFv3ZLoQEtjh3mUCkg5MFypA
         eY8CbbLMJOp8/SStqt2HHaDS63Q1HgBzq8GJ7tLuYVrWPSpPs8Gt1LFljzKxWkBMW5xD
         wJJFEqdZ9D5evg4jucxpHCKRYprwPXcTg/PUOmgV1MvjJ5Fyokya5FRuxBZdpV7eVbGz
         gxxZYY+ZLCORrizFXAOnUBmhTe0F3rZ9lIXIc7XnRA4KVI5qG3H7QbDkv6X3BpdVi7nu
         qPUSBBAnpmUy00Us20olaoDkakx20Oi8NndA0r05d0K4hfmgZy54jNhYJvOYl8v6FpLl
         a8hw==
X-Gm-Message-State: ANhLgQ3rfL9CqKzgca/xq9dKARhwIDEZ3haiTjr9nkiX5HKBYXxezIqy
        XAX/n81OPUQOsRj72dU3NwTjuw==
X-Google-Smtp-Source: ADFU+vvaMShTu4H+Bx5ShEjs077RseA1NzW7/myf8UYsI/g5oF2fIvhSkSOhJhD1EMHTIgkyXbQ4Ug==
X-Received: by 2002:aa7:8bc1:: with SMTP id s1mr1226128pfd.215.1583190127144;
        Mon, 02 Mar 2020 15:02:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v29sm22024356pgc.72.2020.03.02.15.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 15:02:06 -0800 (PST)
Date:   Mon, 2 Mar 2020 15:02:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Patricia Alfonso <trishalfonso@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        David Gow <davidgow@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Subject: Re: [RFC PATCH 1/2] Port KASAN Tests to KUnit
Message-ID: <202003021500.9E0FEE1BEF@keescook>
References: <20200227024301.217042-1-trishalfonso@google.com>
 <CACT4Y+Z_fGz2zVpco4kuGOVeCK=jv4zH0q9Uj5Hv5TAFxY3yRg@mail.gmail.com>
 <CAKFsvULZqJT3-NxYLsCaHpxemBCdyZN7nFTuQM40096UGqVzgQ@mail.gmail.com>
 <CACT4Y+YTNZRfKLH1=FibrtGj34MY=naDJY6GWVnpMvgShSLFhg@mail.gmail.com>
 <CAGXu5jKbpbH4sm4sv-74iHa+VzWuvF5v3ci7R-KVt+StRpMESg@mail.gmail.com>
 <CAFd5g47OHZ-6Fao+JOMES+aPd2vyWXSS0zKCkSwL6XczN4R7aQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFd5g47OHZ-6Fao+JOMES+aPd2vyWXSS0zKCkSwL6XczN4R7aQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 02, 2020 at 02:36:48PM -0800, Brendan Higgins wrote:
> On Mon, Mar 2, 2020 at 9:52 AM Kees Cook <keescook@chromium.org> wrote:
> > I'm all for unittests (I have earlier kind-of-unit-tests in
> > lib/test_user_copy.c lib/test_overflow.c etc), but most of LKDTM is
> 
> <Minor tangent (sorry)>
> 
> I took a brief look at lib/test_user_copy.c, it looks like it doesn't
> use TAP formatted output. How do you feel about someone converting
> them over to use KUnit? If nothing else, it would be good getting all
> the unit-ish tests to output in the same format.
> 
> I proposed converting over some of the runtime tests over to KUnit as
> a LKMP project (Linux Kernel Mentorship Program) here:
> 
> https://wiki.linuxfoundation.org/lkmp/lkmp_project_list#convert_runtime_tests_to_kunit_tests
> 
> I am curious what you think about this.
> 
> </Minor tangent>

Yes please! Anything that helps these tests get more exposure/wider
testing is good. (That said, I don't want to lose any of the existing
diagnostic messages -- _adding_ TAP would be lovely.)

-- 
Kees Cook
