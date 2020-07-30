Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8024BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6170C2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596133508;
	bh=Rpa2YU6Nh9isKYnSSxgyBPdzs5S12wJaRTj/SSPsqio=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DxzYugToGmEKznawu+8LvsmNFDs+UEYjAO0xAWWppxRc6rQe6g6B7djwt8AG/l6C0
	 t7H1mdS3evrhZBhfKhgz/FDWPNT1107VFoDVZy9P01TA4v1GyteTJsLkcUo6MW2MqY
	 LMYMTZJPbZfrBKu805RKqbJ2zWorTtQhIPqIMwmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgG3SZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgG3SZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:25:04 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7823C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:25:03 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x1so2967072ilp.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8HJPemEM+DsX1ym3tw6eDYthggE6P8XVpHiArahohvw=;
        b=LhoHToaNhTqfFNAglQSgfcTA/R0qG2CUkLAO0ke6yQ9Uhl6H4WM2Q/V0+507Qqu3w3
         HJcLPzVRHx8KSGSR4P/r05Nvll7YyAdcfKR3R5Iqqv5MkEx1+ahjaYBErUMC/uMGNIzB
         QXHFg9FsehPLhU1OyG99/4mmHLMVOqOb/T4zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8HJPemEM+DsX1ym3tw6eDYthggE6P8XVpHiArahohvw=;
        b=acVoLgpYPLM+ry0hwwVzW7OB3UMvbBqJNWPvNf0EXOsw2SJD12b7q9DZpzl5Hyd9sZ
         PQ61itfUJQzVxYjPhREWUGrwf+0+GVAtYjPAq/SvA2w6Bjq5T/7R3y1NR+7uF+un01Jr
         u8CHmobA3jRAsshdobcVdSdiuy6fFWdk9zSweuuAGHXkeXUApDt6ys5Dde33E4UvTqXa
         9XFZ4IzSNpMQFOklq6S9MAZ8lJU1gWL6UGjGP+z2RbC4ypfSUylwb+P+V29KZgOhr6Pl
         bdT0VcZpnONLd9cSP6TJCt3DMHkMqOEn18MBIxhez0aaIm4CjCWTXfgHDv4pSGm4xY2r
         Js1g==
X-Gm-Message-State: AOAM530WNAT5OYQz1sV8s8zPMM6ruf4oyq1KvQwrfDuMLX7XNeXNWC6R
        /fJAiWzXxMw+YYDQYkJjG+rhDDDzIrg=
X-Google-Smtp-Source: ABdhPJyqFgWnH/wcNgZvR0cOwZ4hngH8LY40kM7NM+9OpIzY/1tnh8OMJ/ayspgvxVuzjaxesIuaIA==
X-Received: by 2002:a92:8e4f:: with SMTP id k15mr5740403ilh.59.1596133502772;
        Thu, 30 Jul 2020 11:25:02 -0700 (PDT)
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com. [209.85.166.47])
        by smtp.gmail.com with ESMTPSA id h9sm3215114ilc.59.2020.07.30.11.25.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 11:25:02 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id w12so15594473iom.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:25:01 -0700 (PDT)
X-Received: by 2002:a02:852c:: with SMTP id g41mr599301jai.58.1596133500947;
 Thu, 30 Jul 2020 11:25:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200730090828.2349e159@canb.auug.org.au> <CAHk-=wjK8+12i8iDC41LXfZBcMjGsF+WyW_+ncPFmrexRT0yxw@mail.gmail.com>
 <202007292007.D87DBD34B@keescook>
In-Reply-To: <202007292007.D87DBD34B@keescook>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jul 2020 11:24:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivHdh7yWmPMLDLVWzO-gVtu94KBq5RETPeU8EoBR2Qqg@mail.gmail.com>
Message-ID: <CAHk-=wivHdh7yWmPMLDLVWzO-gVtu94KBq5RETPeU8EoBR2Qqg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the origin tree
To:     Kees Cook <keescook@chromium.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Emese Revfy <re.emese@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 8:17 PM Kees Cook <keescook@chromium.org> wrote:
>
> I'll look into this more tomorrow. (But yes, __latent_entropy is
> absolutely used for globals already, as you found, but this is the first
> percpu it was applied to...)

Note that it was always per-cpu.

The only thing that changed was that it was declared static in
lib/random.c vs being externally visible.

So it's not about the percpu part - although that then showed the
arm64 circular include file problem. It's literally that now the exact
same thing is declared in a header file and not marked "static".

Now, I don't think the __latent_entropy code ever really worked all
that well for per-cpu initializations. It ends up generating one
single initializer, which obviously isn't optimal. But I guess it's as
good as it gets.

Unrelated side note: I notice that the plugins could be simplified a
bit now that we require gcc 4.9 or later. There's a fair amount of
cruft for the earlier gcc versions.

I'm not sure how seriously the gcc plugins are actually maintained (no
offense) aside from just keeping them limping along. Does anybody
actually use them in production? I thought google had mostly moved on
to clang.

                Linus
