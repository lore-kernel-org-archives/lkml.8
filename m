Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B995AC3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BFEE2087E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 19:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOo3HD1v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbgBDTfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 14:35:42 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41468 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbgBDTfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 14:35:42 -0500
Received: by mail-pg1-f194.google.com with SMTP id l3so6067353pgi.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 11:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZBYf/F2Io0atf7tGD69pezEGXYzc+ynKJmxs01qZzAA=;
        b=QOo3HD1vuYYlz+4sD+zhB2tClXMUNBEVMlO7WB2JZ9IV9rmn7SF/rbwkwtEq2KhqH6
         JflMkH64e2XW0chioVXoRklQSjZ1ThVCqfFd4QNQZvy3cCKTKktltJOOJYcsi+dOXsiA
         xyKnNbIPPvpQIbEox4KqyaNXHcxW2y550fV9m69L6uSplE435tmpgX9LGNn5cxycQCX2
         WnL4rVBZyAfqQEJjgaX6r9LnrYU1cW8yz106G9HwDqFdmwyb5weFPXRl0cmTQUDEgiOT
         IuHegvLBA08oEM5t1e51IBhTgVFYRvE/0qHfcPD02u5/ihsaye3NxsNp4XwMhOnq9rty
         pXjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZBYf/F2Io0atf7tGD69pezEGXYzc+ynKJmxs01qZzAA=;
        b=FWzRhPMKa8kdjYkR0DTt4s2VuKYMV4FoZX2Q3w2ao8Ob9rsFN6HpatKc36jxb6d9hz
         gnF4211xyic4r+RgZ3FH8k0ihZKrjQ7OHQFBFEVw8FL0pm6dNvSh1hBcUcFbZdRXdl2l
         7ibuyQ7Naj1f/JCpTkO5mWMjehxC7XgZlFy2o5ssFTVAK09vl5kFrZUlRB9ccKos3soD
         yUf0OsL1NiuEyLL84h/L/jEMLXJb8jGGcZKCqVHbJHhEreHSTL/7umPw/qj9l3KyrpkS
         GLtXmLI4dGeuqaYgxeLNIYuMeklvp3ndptzHZ5vkT/OBBIs3CUNaK5JdLqanwtVt4lxo
         2EIw==
X-Gm-Message-State: APjAAAXe/0ZHxi9PmotFvwcfM0OQVJiQ2NtrRLSGqXYR03h9yELs/y3y
        /GS5e36+ixQYeFDWp+b7DKiofqn5+r2WvUCMph6W7w==
X-Google-Smtp-Source: APXvYqw4q+KWhmmtYLJvBYiGMg4pK4goKHR2pzDq2KQ/ueAn46fzf63AjOWVV2VKJzLV/wvMXo/IxMlPJ94Rwb3Ob+8=
X-Received: by 2002:a63:3754:: with SMTP id g20mr17958855pgn.384.1580844941362;
 Tue, 04 Feb 2020 11:35:41 -0800 (PST)
MIME-Version: 1.0
References: <20200130230812.142642-1-brendanhiggins@google.com> <20200204071915.AF32B21582@mail.kernel.org>
In-Reply-To: <20200204071915.AF32B21582@mail.kernel.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 4 Feb 2020 11:35:30 -0800
Message-ID: <CAFd5g44ZG+E==gT24w49oKc6nHv4nBQFeipikKxXJH3oHdO99Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] kunit: create a centralized executor to dispatch
 all KUnit tests
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Jeff Dike <jdike@addtoit.com>,
        Kees Cook <keescook@chromium.org>,
        Richard Weinberger <richard@nod.at>, rppt@linux.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Knut Omang <knut.omang@oracle.com>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 11:19 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Brendan Higgins (2020-01-30 15:08:05)
> > ## TL;DR
> >
> > This patchset adds a centralized executor to dispatch tests rather than
> > relying on late_initcall to schedule each test suite separately along
> > with a couple of new features that depend on it.
>
> Is there any diff from v1 to v2? I don't know what changed, but I see
> that my Reviewed-by tag has been put on everything, so I guess
> everything I said was addressed or discussed in the previous round.

Oh yes, sorry about that. I have gotten a bit lazy in regard to
changing logs. I noticed that a lot of people don't seem to care. I'll
make a note that you do.

Changes since last revision:
- On patch 6/7, I flipped the include order and removed braces from the if
  statements.
- On patch 7/7, I removed the periods from the short descriptions.
