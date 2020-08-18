Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FE7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5274020786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597776709;
	bh=5aj6WCl7jg0yhKZxBLruvn30JvT8Avfp6BW+nPoSpAI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FpS8h3g2B4aTaar9tgC64VmxU9reRneXOQ74YT3yR3RKqqOhCSgAj3F/iNdu/e7eE
	 e/Sj+C15gDvcuAd+79l/JhF/9pD3Pd8IgO+EBrC8odKADX0RwmFAQKMETs6GsKaag+
	 rMKT6MNPHSzGAk8eXrLLUhw2DCBXAOut922L7KYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgHRSvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726552AbgHRSvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:51:45 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82610C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:51:44 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c15so10780807lfi.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U7uYPAcT0a2iCnawB895QmRQ5uyxHh+JN3tvANE4Kno=;
        b=OfpfhktcB0EPTZRtZL54l/zyIACV/6gX4M1jGmcmJz+vzsbzEUHkXqlwyyhXnVEw/b
         pb0mQNipDGcNuotJJcAm05QIjnugVLc3nSBHazWgWqbIC1R7nPjSnZAExUgdxpbrDVDF
         qQ/ANj0NRdAF1Kakd5EKBxqxVxEd2U/8zf13I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U7uYPAcT0a2iCnawB895QmRQ5uyxHh+JN3tvANE4Kno=;
        b=hOJaqNgjUaT2QVZTsmBJgddG6LAfgScam51jlBSiGBNtdNEKjiiwqJW3nF/lsrPn6v
         Nk61dfGw50VJr9fZSm0AZUuj/Sk22gYLyY1z7/Vg1UnZ9gBYHlxb77UGdlpO+R/EFX03
         b16SmkJlUk58LCSQKMbg9LSOAoqROpDgQyYA+KsCEZnoSIFlXwUHIHt8zmYPp2ZHEqbr
         6PyTQ0IvLjjANwhqYjxbRZF9J1Zk6RdB9IsKw1oaYK+4FMt8HLbkx7OjDXDU55GHsBTB
         vXa5RgZTN2aS4ij2cAd8R8bEbDa6rQfj+T40SYGL9RxFjbfKHqdIUd/BZurWAVUsc8Vm
         GzDg==
X-Gm-Message-State: AOAM533TymvyI7ZSY7BHdpQ4of6/vu7AJdmwAZQPjEaWLMerKjEIbxdD
        YEbmlN0pQmW/NNM6SjIC2MVp2boZeYd7fA==
X-Google-Smtp-Source: ABdhPJzN2+zAZTyr6dcdEHWQM2lNv2oXHDafc06ClspL7RD6xS81cwZ9V6iqu6ae4vFteiXzaYD9BA==
X-Received: by 2002:a19:4094:: with SMTP id n142mr10371879lfa.166.1597776702601;
        Tue, 18 Aug 2020 11:51:42 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id w19sm6096267ljd.112.2020.08.18.11.51.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2020 11:51:42 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id d2so10775315lfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 11:51:42 -0700 (PDT)
X-Received: by 2002:ac2:46d0:: with SMTP id p16mr10615970lfo.142.1597776701601;
 Tue, 18 Aug 2020 11:51:41 -0700 (PDT)
MIME-Version: 1.0
References: <1842689.1596468469@warthog.procyon.org.uk> <1845353.1596469795@warthog.procyon.org.uk>
 <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <52483.1597190733@warthog.procyon.org.uk> <CAHk-=wiPx0UJ6Q1X=azwz32xrSeKnTJcH8enySwuuwnGKkHoPA@mail.gmail.com>
 <066f9aaf-ee97-46db-022f-5d007f9e6edb@redhat.com> <CAHk-=wgz5H-xYG4bOrHaEtY7rvFA1_6+mTSpjrgK8OsNbfF+Pw@mail.gmail.com>
 <94f907f0-996e-0456-db8a-7823e2ef3d3f@redhat.com> <CAHk-=wig0ZqWxgWtD9F1xZzE7jEmgLmXRWABhss0+er3ZRtb9g@mail.gmail.com>
 <CAHk-=wh4qaj6iFTrbHy8TPfmM3fj+msYC5X_KE0rCdStJKH2NA@mail.gmail.com> <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com>
In-Reply-To: <CAJfpegsr8URJHoFunnGShB-=jqypvtrmLV-BcWajkHux2H4x2w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Aug 2020 11:51:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
Message-ID: <CAHk-=wh5YifP7hzKSbwJj94+DZ2czjrZsczy6GBimiogZws=rg@mail.gmail.com>
Subject: Re: file metadata via fs API
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 5:50 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> How do you propose handling variable size attributes, like the list of
> fs options?

I really REALLY think those things should just be ASCII data.

I think marshalling binary data is actively evil and wrong. It's great
for well-specified wire protocols. It's great for internal
communication in user space. It's *NOT* great for a kernel system call
interface.

One single simple binary structure? Sure. That's how system calls
work. I'm not claiming that things like "stat()" are wrong because
they take binary data.

But marshalling random binary structures into some buffer? Let's avoid
that. Particularly for these kinds of fairly free-form things like fs
options.

Those things *are* strings, most of them. Exactly because it needs a
level of flexibility that binary data just doesn't have.

So I'd suggest something that is very much like "statfsat()", which
gets a buffer and a length, and returns an extended "struct statfs"
*AND* just a string description at the end.

And if you don't pass a sufficiently big buffer, it will not do some
random "continuations". No state between system calls. It gets
truncated, and you need to pass a bigger buffer, kind of like
"snprintf()".

I think people who have problems parsing plain ASCII text are just
wrong. It's not that expensive. The thing that makes /proc/mounts
expensive is not the individual lines - it's that there are a lot of
them.

                     Linus
