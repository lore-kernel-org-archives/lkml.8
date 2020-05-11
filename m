Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD3EC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49603206D6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589218889;
	bh=RpJNAI2TSDE2kx4CSnDSxMB5BZwRcCWKHCpq3xrCHtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TNZwRBBD4rQgpQkgB+JatKwcGETp+0lwxfwCnD6knSiPtFa8iu9RoEGJr3ReGDMre
	 G53rIJLHY/80qffTdXQmW0hAoeNa0f+p30raw3JFn5zi5BapuhUAx7JgpoNDLCikPM
	 u+z4pQVNTmSRJ1zOl7pe1Fkoua2eVbjEkAiEx89c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgEKRl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726310AbgEKRl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:41:27 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56F38C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:41:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id d21so2794497ljg.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/Wdjb8rOuWHbxd1lGGGIcL4KhK5HO56f22JEfoAX9g=;
        b=MCgCkL9/Q7we/EpmOTNaPA7Jh8tiSE5nwGR7QvQusWJUPL4p8u3PrPguP3IyFWsd2O
         pv4LNZPUxtcWBJhSUzL0kmm4dJFugP9QtN36DpkqftIf9LDWBvS95oODYbeBZgK6wYAk
         eDupKovZnnksOQbc/mTGTHxv9IFoiBK12KGC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/Wdjb8rOuWHbxd1lGGGIcL4KhK5HO56f22JEfoAX9g=;
        b=W2kXRmU9M3UIYyY5UOvh4Dbrk+uINm+ocGuavh1Y4hR+jPdjIFEyrzWS0QGW8NOft8
         mTdjbiW60GUYMQV+NKPKA+YNhTAjNil00nOiYj+yiRJuJBDsXR13OzBDzDjC/PTZh/mk
         mpAONB5pGFhTlMXkW60xVvNlYVWokop34Rp74rU7l+rJMsGrX0Ry56QPfNPP232mnX8L
         s0Y3N2VQmffXS+RnevJ7KU7DDyZtZ7jBOg2eczkZd9j1bBrsLdAJSstLz4JqLhr4M33q
         5Y8UYY+1UmXUAwyvxGgjhcA966XvgcWYiz2DSadTQPia+VMtT4JcE6QxqZuIzUTYDo9f
         yanA==
X-Gm-Message-State: AOAM533nsm97TBeX2G7umDp9LigeoL0WaLsfgjPChWSp+3ntQhmA1+zc
        xVB/3ZBwfVjIzDXDqW1m5k9xPpPRIUQ=
X-Google-Smtp-Source: ABdhPJxOFZIkyKqYKVyAiIuROQws11svoDb5lULMQ1T/oF9YFw4oCfD9b9uxs05RF/zAA3LWzGVQNg==
X-Received: by 2002:a2e:a58e:: with SMTP id m14mr10877792ljp.95.1589218884982;
        Mon, 11 May 2020 10:41:24 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id c4sm11188679lfi.13.2020.05.11.10.41.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 10:41:24 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id a21so10451516ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:41:23 -0700 (PDT)
X-Received: by 2002:a2e:8512:: with SMTP id j18mr11122767lji.201.1589218883308;
 Mon, 11 May 2020 10:41:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
 <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
In-Reply-To: <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 11 May 2020 10:41:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
Message-ID: <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
Subject: Re: I disabled more compiler warnings..
To:     David Laight <David.Laight@aculab.com>, Paul Smith <psmith@gnu.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 12:43 AM David Laight <David.Laight@aculab.com> wrote:
>
> I've not looked inside gmake, but I fixed nmake so that it
> properly used a single job token pipe for the entire (NetBSD)
> build and then flushed and refilled it with 'abort' tokens
> when any command failed.
> That made the build stop almost immediately.

The GNU jobserver doesn't have anything like that, afaik.

I think it always writes a '+' character as a token, so I guess it
could be extended to write something else for the "abort now"
situation (presumably a '-' character).

But at least for external jobserver clients (of which I am not aware
of any, I think we only depend on the internal GNU make behavior), the
documentation states that you should just write back the same token
you read.

I've looked at the low-level jobserver code because I was chasing a
bug there not that long ago, but I've never looked at the interaction
with actually running commands.

Adding Paul Smith to the cc to see if he has any comments..

Paul - the issue is that most of us build the kernel with a "make
-j<bignum>" (in my case "-j32") and if an error happens during the
make, it can take a _looong_ time for make to react. And if there are
warnings in the build, they can hide the actual error fairly easily).

So what David is talking about is to make fatal errors abort much more
quickly by having "jobserver_acquire()" perhaps return an error, and
aborting any jobs when they see that.

I can trivially see how to do it in the jobserver code itself (just
see if the token we get was '-', and if it was, write it back for the
next user and return error), but it's the downstream make code I'm
entirely unfamiliar with.

Any ideas?

                  Linus
