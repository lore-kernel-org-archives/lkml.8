Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C541C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E84C2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590796693;
	bh=Q+1/rUjOtOMU29frt8owA6ZQwr2kT5PJuZ4F56AH0kg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P3SV6DMu1mydauQ+xzd0cRiDiXnJKT42tkxe6MUjJGQ45ReeXKAvtJt818PTAL/TI
	 UMxKCFyx5k0LIyn6Ey4q9bn30NXo9J7ev9JZcdIQwX3iWeMXBZ8NEDn+8NcQ5RT7ci
	 w/m9aacbE5/7Cl/jRCG7oiPV5Ix8egnL35pMuLrc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgE2X6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgE2X6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:58:12 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA62C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:58:11 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id v16so1320225ljc.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9oRh5gR3+qwNsKnzAdgLcqnQbIduR2IcrLYYdPrX+E=;
        b=Bc015UgtNqPTOb/2Z/1EwgCOiwCzM8LFM0oFPwrImmq9COeq6AaRHeFZ7XNbaJXOzR
         yuIX57HkJ+DvmHyIfYOst/p93Hvbf30yU/xsV+mGG5dsjrRw23QEIGIaKVJCRrgX6t9E
         eiIgE0RztbY+cy0h1XhuzL+q9dBTwYq5UHUrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9oRh5gR3+qwNsKnzAdgLcqnQbIduR2IcrLYYdPrX+E=;
        b=HWzmSo+9TfJUG+zAbFe+i5UyZlCNeIPUl1CXH2kuCvzpZZU7ZZIeVBC7GhCllyhKLX
         elbpCTRgnH1+ECIId3SrY8iPqD/ECrK15BD5XxPp4RSIIOnMrUQGhxghFhXaH9290qpL
         l/21Je3HQu4Bx+MRuzF1NmxF8XKP7lk8zn0NiRk/kSz9T/+KkSxbXulz4xZemoPl9Jp8
         N/P26JzSq7mJ1PXsVmdTif5ltdl7slFZRj2b5cuz4eRPZtwRB3Ko5XxbJPwG3xeOu6+u
         jGaklxmnFZhDc17oFyE6fSdMUI7k9Sd0qIJRUWYVpVM1jTEdmQ81OIEH8kVdO/kK04Qs
         H06Q==
X-Gm-Message-State: AOAM5331evPIfk6F0/56kfk/XvzQ/JjrfERqaWBdy+cao83qOBXNZK8X
        H76U6Xuhbj3VnzOTe8ahd1UJ3ce1F3Q=
X-Google-Smtp-Source: ABdhPJwsfmaBjOe1u2nyM64GczKirCDTryKjB+JOV1YUc/DQmQ/NnUW7yxWSv6+GhDN7XVsEkaYrNA==
X-Received: by 2002:a2e:7c03:: with SMTP id x3mr5029403ljc.113.1590796689829;
        Fri, 29 May 2020 16:58:09 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r8sm846494ljk.107.2020.05.29.16.58.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 16:58:09 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id u10so76647ljj.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:58:08 -0700 (PDT)
X-Received: by 2002:a2e:150f:: with SMTP id s15mr5117882ljd.102.1590796688558;
 Fri, 29 May 2020 16:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200528234025.GT23230@ZenIV.linux.org.uk> <20200529232615.GK23230@ZenIV.linux.org.uk>
 <CAHk-=wgzwp5U4csNhy6rz6CF6tDrnoNOM0tzg_6GhrCzBNRjXQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgzwp5U4csNhy6rz6CF6tDrnoNOM0tzg_6GhrCzBNRjXQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 May 2020 16:57:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjwsgYPUfzRNd3Lm08=+HvfoQ4TjS6UCwZUZ_pFEPey6w@mail.gmail.com>
Message-ID: <CAHk-=wjwsgYPUfzRNd3Lm08=+HvfoQ4TjS6UCwZUZ_pFEPey6w@mail.gmail.com>
Subject: Re: [PATCHES] uaccess misc
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 4:54 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> My only complaint was that kvm thing that I think should have gone even further.

Oh... And the cc list looks a bit odd.

You cc'd fsdevel, but none of the patches were really to any
filesystem code (ok, the pselect and binfmt thing is in fs/, but
that's kind of incidental and more of a "we split core system calls up
by area too" than any "it's filesystem code").

The kvm patch didn't have anybody from kvm-land cc'd, for example. I
added some to my "this shouldn't use double underscores" reply, but..

                  Linus
