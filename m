Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0746C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753852087E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 13:39:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="IzFUeFd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbgATNja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 08:39:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:44972 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726626AbgATNja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 08:39:30 -0500
Received: by mail-io1-f68.google.com with SMTP id b10so33674013iof.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 05:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hIrVa5Zc0Y/8LAMmD5SZvjRBvVBDNVksOBYzGDIjeGU=;
        b=IzFUeFd5PB/JBWIOe0W6aNsohUdczCpj/2A+NCFNQV1PCD4k8IiMCsj0y4medcFiod
         UOdDI6kkDpko2uv5p9+mt2IJvULy5y994Np+zBxZNg9WXRR88FY5wCH5KdFXe8USsNaQ
         qgFQgEvEAZaoC6Y/fUZvTvD6WnQQivrHL6ggA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hIrVa5Zc0Y/8LAMmD5SZvjRBvVBDNVksOBYzGDIjeGU=;
        b=b2zVs6w/+e4FUGe3z0EF4iO/H7pOV9u1CZl1m36s+0a1D8RRfLIKuufxBaBTnvQDlo
         0C6BlU98BxwQERsCOzH7T3FPwfMUg673/vLgqbmcacfqA8LSfwRsgzHd8SxzciixVbVQ
         znOMX+mr9455IBxP3ospLEX0cYY55FWu2Z7Yemc/lX3A49XVEdK+7i3BtomrRB2YL8fh
         AHXxSlMt2nPrhOM49jIzygqJ6rm7s8rBX0eKPCWJaL/L6Dh3eZdq+jqHXA5C6ZSqGNP+
         IAw9JujfRvs83RwVFpcseEz0tIACFjef30L2senPMIz+y9zwr9FoVhA+i9tc10JSSMqp
         014g==
X-Gm-Message-State: APjAAAVNThhlSUyBTWGLLiSPOaBIg9ZKuNJ1Mfnomc2S9PMnqHhJBY1Z
        lZMR6cwdP4xoiVlm3p01RRLUBVsOX4ZMaLmdnaqpLg==
X-Google-Smtp-Source: APXvYqwEFZa85NxoMnRlOMhpXhYC2XLWu2JDUCN0jpUzaBvGuWPPt8kZnzhiKP0UadsI0kv6WYMCekP+h1yfdZL806Y=
X-Received: by 2002:a6b:b74a:: with SMTP id h71mr18380016iof.212.1579527569452;
 Mon, 20 Jan 2020 05:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20200120121310.17601-1-cengiz@kernel.wtf>
In-Reply-To: <20200120121310.17601-1-cengiz@kernel.wtf>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 20 Jan 2020 14:39:18 +0100
Message-ID: <CAJfpegtOOCVrNkSmpmMY0dVH-359jc3RqXJ7K6dzvUqxtCxBtg@mail.gmail.com>
Subject: Re: [PATCH] fs: fuse: check return value of fuse_simple_request
To:     Cengiz Can <cengiz@kernel.wtf>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 1:13 PM Cengiz Can <cengiz@kernel.wtf> wrote:
>
> In `fs/fuse/file.c` `fuse_simple_request` is used in multiple places,
> with its return value properly checked for possible errors.
>
> However the usage on `fuse_file_put` ignores its return value. And the
> following `fuse_release_end` call used hard-coded error value of `0`.
>
> This triggers a warning in static analyzers and such.
>
> I've added a variable to capture `fuse_simple_request` result and passed
> that to `fuse_release_end` instead.

Which then goes on to ignore the error, so we are exactly where we
were with some added obscurity, which will be noticed by the next
generation of static analyzer, when you'd come up with an even more
obscure way to ignore the error, etc...  This leads to nowhere.

If this matters (not sure) then we'll need a notation to ignore the
return value.  Does casting to (void) work?

Thanks,
Miklos
