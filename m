Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559D9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28B1320801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O6iMlj7M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgFLFHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgFLFHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 01:07:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA2AC08C5C2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 22:07:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id b5so2634169pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 22:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=E/c/tVNZnZXtqPcvM/cRJXYwg6T3yZDLqtUKUDRTdt4=;
        b=O6iMlj7M7cPlzLPmVV55ccyxdmoDkLHEjx9YGi+rTx/SuEeA8L0Kjs9Ne+dGwMTwbq
         rc2ZpA3N/oYNyMbp1V99/7JChJws0nqKJfN0shrkRwbPVuIUABRpkiMLhLyjJLxaGdmP
         ovUHtZjYkmhLf2+ypJUlrY0Jy3jRXFdlAQ+h0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E/c/tVNZnZXtqPcvM/cRJXYwg6T3yZDLqtUKUDRTdt4=;
        b=QTT/EG1y4GZA39xTonp89uqYPxawe2CVB9bsJleqeUjt11Dzc0XrrocfrTbj24k4/P
         sk88Le5BPXopI8uEx8lPsKOB2o2Wpg7kXJGnLZMTxsIc6Q0x1PB135PTx+J4z5qGTqlx
         4gk3Z+GVnZJT9NLeRLg5Xe/MGsGjPWd0CcRHZLZOnDwOGNg4ERnScBIfvPKret9vK7bZ
         XUU8wO2vwg+Fztx3Czlc4cz4HZnWsZR4uivIkZpZjHJc1cF0iStGfGW67aaXrpeY7Mun
         3IQ0dc7dYgZypvvZn2hs3AplJj6gokvQTbkFCCPKPdAJaZQWpQ59KzMESkyBEN+C1Kgc
         ypuA==
X-Gm-Message-State: AOAM5333Ge4FC0xAyWXPQhREU57i1kUg7N1MtOpiK5gW28SQhC6hjDK3
        yX50CW8AOPPtl2jkU2DiIT2NmA==
X-Google-Smtp-Source: ABdhPJyFBSPyYUPRAZIz7sEMo6uAmEjOuign7oI0Sc1zUD3PayBJbV8oAMHdaVR5RPSIOnhngmXDQg==
X-Received: by 2002:a65:6883:: with SMTP id e3mr9569317pgt.5.1591938427251;
        Thu, 11 Jun 2020 22:07:07 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x126sm4664416pfc.36.2020.06.11.22.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 22:07:06 -0700 (PDT)
Date:   Thu, 11 Jun 2020 22:07:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michael Cree <mcree@orcon.net.nz>,
        Matt Turner <mattst88@gmail.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-alpha <linux-alpha@vger.kernel.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Subject: Re: Regression bisected to f2f84b05e02b (bug: consolidate
 warn_slowpath_fmt() usage)
Message-ID: <202006112201.3B20AB28DC@keescook>
References: <20200602024804.GA3776630@p50-ethernet.mattst88.com>
 <202006021052.E52618F@keescook>
 <CAEdQ38F2GP92xB2gMXTrEo-Adbbc9Cy1DWHU9yveGLzJNd2HrA@mail.gmail.com>
 <20200612044757.GA10703@tower>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612044757.GA10703@tower>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 04:47:57PM +1200, Michael Cree wrote:
> On Thu, Jun 11, 2020 at 09:23:52PM -0700, Matt Turner wrote:
> > Since I noticed earlier that using maxcpus=1 on a 2-CPU system
> > prevented the system from hanging, I tried disabling CONFIG_SMP on my
> > 1-CPU system as well. In doing so, I discovered that the RCU torture
> > module (RCU_TORTURE_TEST) triggers some null pointer dereferences on
> > Alpha when CONFIG_SMP is set, but works successfully when CONFIG_SMP
> > is unset.
> > 
> > That seems likely to be a symptom of the same underlying problem that
> > started this thread, don't you think? If so, I'll focus my attention
> > on that.
> 
> I wonder if that is related to user space segfaults we are now seeing
> on SMP systems but not UP systems while building Alpha debian-ports.
> It's happening in the test-suites of builds of certain software
> (such as autogen and guile) but they always build successfully with
> the test suite passing on a UP system.
> 
> When investigating I seem to recall it was a NULL (or near NULL)
> pointer dereference but couldn't make any sense of how it might
> have got into such an obviously wrong state.

By some miracle, I have avoided any experience with RCU bugs. ;) If
the RCU_TORTURE_TEST Oopses or the segfaults are repeatable and don't
go away with the WARN patch reverted, then perhaps it might be used to
bisect to something closer to the root cause?

Given the similarity to the SMP vs UP stuff and the RCU tests, I'd agree
that does seem like the best path to investigate.

-- 
Kees Cook
