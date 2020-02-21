Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6864DC11D25
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EDCE2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:16:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZBFAmZG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgBUAQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:16:05 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34275 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729410AbgBUAQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:16:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so108725plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 16:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bSOXy59NaxNEGkVUjyIUAzgGlKx0xSBMnajwRhUlBTg=;
        b=oZBFAmZGwNpWsKFxlgvf0mX4lmV48p5sBFBFmkb2qY6JOGXSZchINliLWhfrC0TSPH
         iXbmiJf/r0fGxptXI0Y1O+CIU1KGPjXLE+pqPw3xWLyGNqbzxhQ8vR5Bm1+ZWRNYo4xx
         FjnYi/0OovC17X8MrsPBCFUf3oa4HURWyd09w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bSOXy59NaxNEGkVUjyIUAzgGlKx0xSBMnajwRhUlBTg=;
        b=F2nZd+bWv76YEsQyIR8OL7Iib4IdEoLC/6gLGCLEfhlSfBHOYLIuTxThCkqSLZkqBj
         NAbsmyMvKzTc2J1g82DxzOocCiCVlLP0xZ1749Q/VLaHTHJxYo0e9mVoBIqukOw9RaOj
         4TFzFbUckT/7+sesM0y4CZA1dJwV0CNAmOmIwV75DFr6NFNXFbwtlp11ay2wSwBYeVK5
         A+Ktzx2m8CTatq/564ear5TeyYC2idvZ4zBTmSS7HhoJEk4t2Xf6+tdUPmwGzBo09Djc
         GXyX7YnN5ZOvckQvQ36ySxshwdV9daDPMxAvaUqp78Ew71wtndkkes0pt5pUyDgxhAOR
         GSZA==
X-Gm-Message-State: APjAAAXmySP/HwoGfKZo1Tk3Q+bFRH0vsZvMk98imBOfXn2hUZCEMdQx
        0UafBbIZzbDqt6bpbuEaDcJRbg==
X-Google-Smtp-Source: APXvYqyF2qNqnrPkSbjfbjdMr5QKa3bRBq5Ixq8bcwoCyGhS3AdmZJfxbkBEwtliGl9osRgA4SNgIw==
X-Received: by 2002:a17:902:ab8f:: with SMTP id f15mr33566822plr.280.1582244163881;
        Thu, 20 Feb 2020 16:16:03 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id fz21sm523554pjb.15.2020.02.20.16.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 16:16:03 -0800 (PST)
Date:   Thu, 20 Feb 2020 16:16:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     shuah <shuah@kernel.org>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>, ankita@in.ibm.com,
        Will Deacon <will@kernel.org>, ardb@kernel.org,
        "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>
Subject: Re: selftests: Linux Kernel Dump Test Module output
Message-ID: <202002201610.2B149A6D@keescook>
References: <CA+G9fYu3682XJ2Kw2ZvQdUT80epKc9DWWXgDT1-D_65ajSXNTw@mail.gmail.com>
 <fcb799d4-f316-60d6-9fd0-0bc1c174e63c@arm.com>
 <31b066c2-d1c9-1592-48cd-bccb4b3a624a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31b066c2-d1c9-1592-48cd-bccb4b3a624a@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 09:16:03AM -0700, shuah wrote:
> On 2/17/20 8:36 AM, Cristian Marussi wrote:
> > Hi
> > 
> > n 17/02/2020 11:09, Naresh Kamboju wrote:
> > > The selftest lkdtm test failed on x86_64 and arm64.
> > > am I missing any pre-requisite?
> > > 
> > > Boot log:
> > > [    3.297812] lkdtm: No crash points registered, enable through debugfs
> > > 
> > 
> > from your logs I cannot deduce anything useful, but in our CI I've got similar issues
> > since the 10/12th of Feb...
> > 
> > TAP version 13
> > 1..71
> > # selftests: lkdtm: PANIC.sh
> > # Cannot find /sys/kernel/debug/provoke-crash/DIRECT (missing CONFIG_LKDTM?)
> > not ok 1 selftests: lkdtm: PANIC.sh # SKIP
> > # selftests: lkdtm: BUG.sh
> > # Cannot find /sys/kernel/debug/provoke-crash/DIRECT (missing CONFIG_LKDTM?)
> > 
> > so I suppose this and a bunch of other (probably new) tests are simply
> > missing a bit of CONFIGs... (but I have still to look into this properly)
> > (not sure if this also is your case either...)
> > 
> > Regards
> > 
> > Cristian
> > 
> 
> Hi Kees,
> 
> Any ideas on what this is about? Missing config or something else?

In the first case, I'm not sure what's happening -- the logs don't seem
to show anything, but the lkdtm should be available (from the boot log).

In the second case, yes, it looks like missing CONFIG_LKDTM (the test
even has a "config" file). Either CONFIG_LKDTM=y or CONFIG_LKDTM=m will
work (the test running will attempt to load the lkdtm module if it's
missing).

A final option is that either the debug filesystem isn't mounted, or is
mounted somewhere "non-standard"? (I'd expect a lot of things to fail...)

-Kees

-- 
Kees Cook
