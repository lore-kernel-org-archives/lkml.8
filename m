Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43A56C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 241AB2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kh69GINX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgHaXrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 19:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgHaXro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 19:47:44 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF58C061755
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:47:43 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id l9so2387631plt.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=juVRqCbh5Pfx7E9cPKL91nx3eVpA7BnV8zBFSEBuwaA=;
        b=kh69GINXBiHDzJiTiyn9+ehF+OvxzNG97oGlhvGxYMQ9fpBRqm0X8hlDiWqDRJWDSQ
         1wcBIyNk1YsyTtnDmQGgSEBfBgHK9S6xFz/PXQcGWflxWImw5ZdebG/ENlsfZFpVifFg
         TkXdSNW30/YX1PXYkp0F/gED9PDLmsCcWXh5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=juVRqCbh5Pfx7E9cPKL91nx3eVpA7BnV8zBFSEBuwaA=;
        b=RsoLCMjSEioqRpKoGm94goylyXIgiR6W6vR3jZ5JRapwgMLSsCB51/68NAhU6BQ9EC
         75qDZ/RaQneOfpbB2qamYtXILsjCfHR9fdcGOLuyVLKypWKXUOlZvN/X9GX/1MIGkJ7a
         cpfyK3qqAqQoxj9EgJM+VnydsopYjEEeJmzjasLXTD5zVqzAiXFDC902tLsEJYtB+8ui
         vYhzwoe+dK86hw/C8B2eGOygiANNxD12Nr4iJ3aPLk9gGcUgtMa684sWjqrK1h0KvWeR
         rbztjlSbYdgB0gfscZhn+17GxEgLX6W6nglLhHBzQ/uap0Yb9Uu4W668xYdSwT+EiYCp
         YFbg==
X-Gm-Message-State: AOAM533eC9YWx459uSGYDrhsXBxDZcyj6JezM/uN3ZUbQVf9Mw696vlF
        AKmQP1+UVni5w/r49+Qd0V3nAg==
X-Google-Smtp-Source: ABdhPJz2avi7+a5JrSR3p0oULsjQKUAvVNfzFvybZMIz346VpwGBFn35ryQLN6PU7+5ZuPlW94+jfg==
X-Received: by 2002:a17:90b:1b12:: with SMTP id nu18mr1578872pjb.126.1598917662837;
        Mon, 31 Aug 2020 16:47:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a13sm8880906pfo.49.2020.08.31.16.47.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 16:47:41 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:47:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Gow <davidgow@google.com>
Cc:     Marco Elver <elver@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Maguire <alan.maguire@oracle.com>,
        Randy Dunlap <rd.dunlab@gmail.com>,
        Theodore Ts'o <tytso@mit.edu>, Tim Bird <Tim.Bird@sony.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: kunit: Add naming guidelines
Message-ID: <202008311641.D10607D43@keescook>
References: <20200702071416.1780522-1-davidgow@google.com>
 <20200827131438.GA3597431@elver.google.com>
 <CABVgOSmoiFh5i8Ue14MtCLwq-LbGgQ1hf4MyRYLFWFQrkushjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmoiFh5i8Ue14MtCLwq-LbGgQ1hf4MyRYLFWFQrkushjQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 12:17:05AM +0800, David Gow wrote:
> On Thu, Aug 27, 2020 at 9:14 PM Marco Elver <elver@google.com> wrote:
> > Just an idea: Maybe the names are also an opportunity to distinguish
> > real _unit_ style tests and then the rarer integration-style tests. I
> > personally prefer using the more generic *-test.c, at least for the
> > integration-style tests I've been working on (KUnit is still incredibly
> > valuable for integration-style tests, because otherwise I'd have to roll
> > my own poor-man's version of KUnit, so thank you!). Using *_kunit.c for
> > such tests is unintuitive, because the word "unit" hints at "unit tests"
> > -- and having descriptive (and not misleading) filenames is still
> > important. So I hope you won't mind if *-test.c are still used where
> > appropriate.

This is a good point, and I guess not one that has really been examined.
I'm not sure what to think of some of the lib/ tests. test_user_copy
seems to be a "unit" test -- it's validating the function family vs
all kinds of arguments and conditions. But test_overflow is less unit
and more integration, which includes "do all of these allocators end up
acting the same way?" etc

I'm not really sure what to make of that -- I don't really have a formal
testing background.

> As Brendan alluded to in the talk, the popularity of KUnit for these
> integration-style tests came as something of a surprise (more due to
> our lack of imagination than anything else, I suspect). It's great
> that it's working, though: I don't think anyone wants the world filled
> with more single-use test "frameworks" than is necessary!
> 
> I guess the interesting thing to note is that we've to date not really
> made a distinction between KUnit the framework and the suite of all
> KUnit tests. Maybe having a separate file/module naming scheme could
> be a way of making that distinction, though it'd really only appear
> when loading tests as modules -- there'd be no indication in e.g.,
> suite names or test results. The more obvious solution to me (at
> least, based on the current proposal) would be to have "integration"
> or similar be part of the suite name (and hence the filename, so
> _integration_kunit.c or similar), though even I admit that that's much
> uglier. Maybe the idea of having the subsystem/suite distinction be
> represented in the code could pave the way to having different suites
> support different suffixes like that.

Heh, yeah, let's not call them "_integration_kunit.c" ;) _behavior.c?
_integration.c?

> Do you know of any cases where something has/would have both
> unit-style tests and integration-style tests built with KUnit where
> the distinction needs to be clear?

This is probably the right question. :)

-- 
Kees Cook
