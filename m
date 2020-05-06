Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BDFC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85656208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSvcn+XK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbgEFQ4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729669AbgEFQ4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:56:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3D0C061A0F;
        Wed,  6 May 2020 09:55:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id g4so3159556ljl.2;
        Wed, 06 May 2020 09:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kKFHMEDldcqtXJZZom1e30Amb1qemItMYb+MfCtBaYc=;
        b=RSvcn+XK7KXsFDU2UWTo0nn4GunXCH3M1sBF466RPl9CipiaPdqOXkPr33Bzr87dFS
         yHmjxYF7HZIuOvk7jbYZT18BVjEHENbdaOU+3Zn/Hh0GgTJ1u9EC/zddjRIyqPDAaTIj
         LIvvWSLNuQKzhI0pqEeg/G8YcSM93UrSjqy3Ekgb7Qhtbmrg4o4czUgITq/wnEkV1HXy
         /oPLLpBj0FDGaef1mpzQRz862cAf5yMsDIxGBz2w8VVPWTjdkWDENSy++K0DnHLYNACc
         SFZV336JVkkCupWK5uqZBE9sTYfYqn6rKHrULB15nja4aip0hkmK+oRCxCLu+l7YcNe5
         hEPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kKFHMEDldcqtXJZZom1e30Amb1qemItMYb+MfCtBaYc=;
        b=Tl9dLKbj67bopg1ksEZp8SS5nF0El0VgNPsUYIub4l7rCuoNIancI6Vl0lZxmdrnnU
         1Zqk+qofiUXZOY24+BXi/xJ+vvypSCapT8zUvVPPt8/5aespKnyKUF4v6/OhRqSOVSJ0
         EToeXkD8ruYpuhZn7NM5zzxfCuyLgOy2fwrlXsGgw57DLgxm2omOTU9aTtMsoqeyRHUL
         0B9o0Ajlcne5OXlP1jtNZTlNSrDdLeZ+rkXdEw7/p+lJ/FyUoj/X3T4rMBGKxxqzUqgR
         MSsTbApOxBTIREn1op+HipLYcaa8QbG+sxdQ0L0UoeNPtyUMptEvTb/z37QZoKXXGZ0Y
         HtnQ==
X-Gm-Message-State: AGi0PuYfzjupuvwxUMcHs6pPYW7bz5B5rQUfxbfWziDxyyjcKIDXqMtd
        4dM4F9H8zfI5+KMKldguMNlLMSHZ4xgCq9VB1PA=
X-Google-Smtp-Source: APiQypJSGqQFZrYSVlxj4O3QDJmolUapNzhi6DyiuhGkMYuyMxW2YbZUfsnf2KMWRUkgnxjvZY1YXTBUg/8cRorApDw=
X-Received: by 2002:a2e:a176:: with SMTP id u22mr5680710ljl.177.1588784158471;
 Wed, 06 May 2020 09:55:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200505174423.199985-1-ndesaulniers@google.com>
 <20200506043028.GA663805@ubuntu-s3-xlarge-x86> <CAKwvOd=c6gzpUsRgh-XmKEh0xHkZUWfXNW52EpqfrbH+XhH5fQ@mail.gmail.com>
In-Reply-To: <CAKwvOd=c6gzpUsRgh-XmKEh0xHkZUWfXNW52EpqfrbH+XhH5fQ@mail.gmail.com>
From:   Ilie Halip <ilie.halip@gmail.com>
Date:   Wed, 6 May 2020 19:55:47 +0300
Message-ID: <CAHFW8PQ1jusUS9xNUmiwwTU3x=GCqL3AJwwirhJOAgZUjx9wVA@mail.gmail.com>
Subject: Re: [PATCH] x86: bitops: fix build regression
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        "kernelci . org bot" <bot@kernelci.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Axtens <dja@axtens.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

> Ilie, may I put your authorship and signed off by tag on the V2?

Yes, of course. With the current global situation I took some time off
and didn't follow the latest discussion.

Feel free to credit/rework the code as you see fit.

Thanks,
I.H.
