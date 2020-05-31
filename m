Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F47CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DB1E2073B
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 19:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeJE+sRN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgEaThf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 15:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgEaThf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 15:37:35 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B48C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 12:37:34 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id y1so6125282qtv.12
        for <linux-kernel@vger.kernel.org>; Sun, 31 May 2020 12:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=3xp/CX4ZXzyXsreYB+Mkkdy0o2I1FNvVPwlUiEbvMCk=;
        b=VeJE+sRNuq7WuF1Wpz7fnSmopdwXjKw+9J9t/FQhLIAilYRJf+pMFBQQLyMzNg6hH1
         c3fvWUvCVpHFZIw4Tc6Z7+uUWTymK4TH/+lcAqFeJYrnzC9pp3D9czoK5HurbkazwFTQ
         kWOyWq5IxDC6mkKUwjXZYSp3dE+BS66nQo/WXkjUZT347NAlmes7f1FcWEU0pyMlvT6/
         7RicZDX+WplnYOsdXuWiXCBEFsB64zNzHscgslxzy6mRDmQVfljBVIU9Rdswd7nA6aKi
         vKTojLvq1ZjDSsiPmZQklTkFhiJjzgyOsFsXlYe87ShxACrrRFDYclU9RQrAHd2DqJqx
         qzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=3xp/CX4ZXzyXsreYB+Mkkdy0o2I1FNvVPwlUiEbvMCk=;
        b=Oc9aS/sGbXeGedkHxMgaIgwQG80dNFFNBsf9P30QO+z5jTUL0JzA3XABTpp9s26YtZ
         XWNuYZg7O+Y3zZyAZinDW9hJJm1r0yC9qXv7YWF2XDU6mYgpn7fHRmNwuKmYVgNtLZt0
         VXG9FVOTgU/UDQ2m7bXwJpy9LeLxwgFapJ/n6ZEKts9JESq8EoSBbQpzZnpIjbgDjtDo
         twLmtmcJ/dsJlQeMyYiJ179ljS/yCIgSrJYErWk5GQyg7frXx9+Wk1drLkckk7zo17xg
         b9Ot1nUTilWVm60fI5lYvk89DjXvA1isNtttrGoWaTDQSA+It2UiOcoXepYdegW93U0B
         1y6w==
X-Gm-Message-State: AOAM532wiuF8Z6hpu2NHIcQ1KFuQV6g5HegNJriJZ9gD+B7yHl/nqGQe
        NpeDui1lIMmT+Q7vgoOCRR8=
X-Google-Smtp-Source: ABdhPJzJEr4qwo6aN9qH/1NWBZIdeYudDQNHBFCXFerWgPGYIqcuDgcmDRNyoPIBItdBhwQkGrpPsQ==
X-Received: by 2002:ac8:4e8c:: with SMTP id 12mr18667331qtp.20.1590953853494;
        Sun, 31 May 2020 12:37:33 -0700 (PDT)
Received: from [192.168.1.62] (89-178-168-199.broadband.corbina.ru. [89.178.168.199])
        by smtp.gmail.com with ESMTPSA id l69sm5268280qke.112.2020.05.31.12.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 12:37:32 -0700 (PDT)
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory
 areas
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Zebediah Figura <zfigura@codeweavers.com>,
        Matthew Wilcox <willy@infradead.org>
References: <85367hkl06.fsf@collabora.com>
 <079539BF-F301-47BA-AEAD-AED23275FEA1@amacapital.net>
 <50a9e680-6be1-ff50-5c82-1bf54c7484a9@gmail.com>
 <CALCETrX+CEN7Sq=ROP33MAGn2dTX=w0JHWb6f4KAr-E9FE4YPQ@mail.gmail.com>
 <a14be8b0-a9a2-cf96-939e-cedf7e0e669a@gmail.com>
 <CALCETrV+rYnUnve09=n+Zb8BR8mDBq6txX9LmEw7r8tAA7d+2Q@mail.gmail.com>
From:   Paul Gofman <gofmanp@gmail.com>
Autocrypt: addr=gofmanp@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <38da7b26-8ff4-419a-c848-5eebf4969647@gmail.com>
Date:   Sun, 31 May 2020 22:37:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrV+rYnUnve09=n+Zb8BR8mDBq6txX9LmEw7r8tAA7d+2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/20 21:57, Andy Lutomirski wrote:
>
> I think that the implementation may well want to live in seccomp, but
> doing this as a seccomp filter isn't quite right.  It's not a security
> thing -- it's an emulation thing.  Seccomp is all about making
> inescapable sandboxes, but that's not what you're doing at all, and
> the fact that seccomp filters are preserved across execve() sounds
> like it'll be annoying for you.

Yes, sure, preserving those filters (more broadly, lack the ability to
change them any time in an arbitrary way) is the major problem
preventing us from using seccomp filters as is for a generic solution.
If not that, growing the table too much (which might be the case if we
mark all the denied address ranges there) may potentially be a
performance problem, but not necessarily, that's something to be tested.

>
> What if there was a special filter type that ran a BPF program on each
> syscall, and the program was allowed to access user memory to make its
> decisions, e.g. to look at some list of memory addresses.  But this
> would explicitly *not* be a security feature -- execve() would remove
> the filter, and the filter's outcome would be one of redirecting
> execution or allowing the syscall.  If the "allow" outcome occurs,
> then regular seccomp filters run.  Obviously the exact semantics here
> would need some care.

Yes, absolutely, we are not implementing any sandboxing in Wine and are
not seeing this as a security feature.

Is the approach discussed in another branch of this thread [1] is some
way similar to what you suggest? If instead of the list of memory
addresses we can use some single flag which we can set by thread when
crossing Windows program / native boundary, we won't have to grow the
lookup table indefinitely. Otherwise I am afraid the list of addresses
might be growing big, but I don't have reasons to think it necessarily
won't work, that's something we could evaluate further and also test
performance given some brief proof of concept implementation.


1. https://lkml.org/lkml/2020/5/31/199


