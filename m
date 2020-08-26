Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92367C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3EC2078B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 16:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CNAj0WU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHZQ6Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 12:58:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgHZQ6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:58:13 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A55C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:58:13 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id j11so1170734plk.9
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 09:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ruBxf096ym9usi++FSuEPp4K8G47UnSV5rxmh+VEh4=;
        b=CNAj0WU7APXwzXX7Pgh0wY1PTwPfSLIPM5Jil5o+T5N4jUGo5+EKR/ChLR9FR90DTb
         adL6ook8RKLqITnw6Uh9udX1zaxH4UMUnmaO9hKk849lcueGmnYaaxPsY/Jao2lDUFIx
         9jFJKxNUCI1Xy/sGKlKpYagCZRlRYeSgkYeag8jL7QlgMlHj+d31DaUd3w3X5Wp7cJth
         r//+rpBCTWorGq8bX9LyNC+pNGHmqBpgYaK+Q+iniIAaKUrmBdUlI3hbpSKf96WQ3fBO
         /mr836uIMuRWulestTquHy5rOEhED5XzSDvnMOV9X4c0IHYkdjzoM9OGPkaSE5Ca7w0G
         pWTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ruBxf096ym9usi++FSuEPp4K8G47UnSV5rxmh+VEh4=;
        b=Esk+PlIZ+M6Q09ft03aj9Mj39HMoSMOxACZ5x/XOjF0iJ+X1Kkr+16rX90RLtIf1R3
         Tspaamn0dCgjJMl6520BrP09ciktalNMC16WqhTXrQH6eJL5Ad2GMqh/HyNHNgGtytga
         +/4qNqy/vZr9wHRwZKSC3ZmDtCBMF+lYe3pNTZau0R/DqmW8OARGr3vm2BgaPU6pQKar
         JrezQ7kDiJpKbRQGZCne+unU/ea0Xst998XCKZKAAGxWa/+a25xMW/X5wd1FG0Nt7oal
         sCw7tG2GwoK0dz9rsu5uUW43VNJKuag4zsw7IbnP9JR8o/QvddX+lqu1rF3JZ8QMaVdO
         hHhw==
X-Gm-Message-State: AOAM533oxR6b5+FHP9sZRY437r65PbIhnIborQnB9+YbDhOLB59d6PtA
        nt7qa8ufYqG8KWEQHfWHsKLkir+vyuUaXnn0gLs75Q==
X-Google-Smtp-Source: ABdhPJzTSgzt4IMtUGn18bHtBzPXj8CcOOTUT4AYBvrGLdEOW3RKHpfc5ZfYx8biM/CSPtPDInAtTaQtC+a7s9SwTpE=
X-Received: by 2002:a17:902:be0f:: with SMTP id r15mr12843216pls.84.1598461092696;
 Wed, 26 Aug 2020 09:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200825135838.2938771-1-ndesaulniers@google.com>
 <CAK7LNAQXo5-5W6hvNMEVPBPf3tRWaf-pQdSR-0OHyi4RCGhjsQ@mail.gmail.com> <d56bf7b93f7a28c4a90e4e16fd412e6934704346.camel@perches.com>
In-Reply-To: <d56bf7b93f7a28c4a90e4e16fd412e6934704346.camel@perches.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Aug 2020 09:58:01 -0700
Message-ID: <CAKwvOd=YrVtPsB7HYPO0N=K7QJm9KstayqqeYQERSaGtGy2Bjg@mail.gmail.com>
Subject: Re: [PATCH v3] lib/string.c: implement stpcpy
To:     Joe Perches <joe@perches.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        stable <stable@vger.kernel.org>, Andy Lavr <andy.lavr@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sami Tolvanen <samitolvanen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 9:57 AM Joe Perches <joe@perches.com> wrote:
>
> On Thu, 2020-08-27 at 01:49 +0900, Masahiro Yamada wrote:
> > I do not have time to keep track of the discussion fully,
> > but could you give me a little more context why
> > the usage of stpcpy() is not recommended ?
> >
> > The implementation of strcpy() is almost the same.
> > It is unclear to me what makes stpcpy() unsafe..

https://lore.kernel.org/lkml/202008150921.B70721A359@keescook/

>
> It's the same thing that makes strcpy unsafe:
>
> Unchecked buffer lengths with no guarantee src is terminated.

-- 
Thanks,
~Nick Desaulniers
