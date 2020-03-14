Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF35C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC5172074C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584145714;
	bh=aEyIah5anxqxw7dr2IcrDi3LMEkx1zYZ239mnRvw7qU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hEBxNxlZa2DLzgVq0slvCWQsLd3O0EjNRn0VdSLrcpRHOCXTGgeOgTzp8Clz7fdYN
	 LlMBmei5VGompOyLesJR52EsCHBrFSC0afDyT/arQtpNvcJlxxCiRJ/t6MaBm8/CO8
	 xHqGNjnV9iMK2lNDtwRjHH65wf7FZ70dVptsuf2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbgCNA2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:28:32 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33060 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgCNA2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:28:32 -0400
Received: by mail-lj1-f194.google.com with SMTP id f13so12520816ljp.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pRmNolcxLqc+tNnnflJ/n3joETbYpRnOE13OAQ+0j2c=;
        b=cRJcS5iL6D7pulFWso9kzk1dWyABFXOyNGG88VjNsF84X0gt+v0c11QVPFVDYWRXf8
         CSOkNeWYjeGmaUh0kvfgC6E3MPHJd255SwAfMJz6MgK/ZxktMeYvYYYvDiu8QvNb7sTV
         +GznvZmF4/9MkIGyzdbamSO0U+8fhQMTk7x0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pRmNolcxLqc+tNnnflJ/n3joETbYpRnOE13OAQ+0j2c=;
        b=obo0h2wCvgTnqHh8H4be0fT6hM/jDNVuK57ZyabJqCb2Gh2jn9ggxyc3L4vubvZGpU
         St1DD+M/9hIw4g58MNvPRcJJ2DoEAUlWg3Oyw2xA2kdbRU4IhZipKNvloJyAClXZRQXw
         f3kRdxZSFd/GXwFOvyfJT/U6juaGEj3jjKovnLwB8MImmBhG+xYfv5E6i3XmPmhVL80l
         Ow2j6Z3hdOoxOdwwpe/XuzdA/PcJMJdJhnSXKefHnBkt1nn0Juebw93gMxCO0UJ1rZL/
         rs5P9Ce3v62za2UjirRVMiS5DYhGtWHimbhUKOQI1EybtM+EvHMXM4relRrN9T6u5cmd
         pbZg==
X-Gm-Message-State: ANhLgQ2bDU8NvzY/AwVoJvvLxoXyTIdh0mElEJ66JOAICx8sxg7IHQNe
        76QHEZ6Jfz0BwylWxgeW07IVy0zocvI=
X-Google-Smtp-Source: ADFU+vsAjRnugkgsTd/wyEtcNZ+GLLTtHtNMjWUhXi6o37V8Yc2rGzYgSjabuODpNUBXOl/Xj/Zhgw==
X-Received: by 2002:a2e:86ca:: with SMTP id n10mr799673ljj.219.1584145709134;
        Fri, 13 Mar 2020 17:28:29 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id v18sm20158499lfe.73.2020.03.13.17.28.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Mar 2020 17:28:28 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id n20so5987313lfl.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 17:28:28 -0700 (PDT)
X-Received: by 2002:a05:6512:3044:: with SMTP id b4mr1855996lfb.10.1584145708028;
 Fri, 13 Mar 2020 17:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200313235303.GP23230@ZenIV.linux.org.uk> <20200313235357.2646756-1-viro@ZenIV.linux.org.uk>
 <20200313235357.2646756-12-viro@ZenIV.linux.org.uk>
In-Reply-To: <20200313235357.2646756-12-viro@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Mar 2020 17:28:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGqaTtjP-0PkWrTsbbwPihazCx1oeSsLTSB6itZzbZiA@mail.gmail.com>
Message-ID: <CAHk-=whGqaTtjP-0PkWrTsbbwPihazCx1oeSsLTSB6itZzbZiA@mail.gmail.com>
Subject: Re: [RFC][PATCH v4 12/69] teach handle_mounts() to handle RCU mode
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, and here you accidentally fix the problem I pointed out about
patch 11, as you move the code:

On Fri, Mar 13, 2020 at 4:54 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> +               if (unlikely(!*inode))
> +                       return -ENOENT;

Correct test added.

> -                       if (unlikely(!inode))
> -                               return -ENOENT;

Incorrect test removed.

And again, maybe I'm misreading the patch. But it does look like it's
wrong in the middle of the series, which would make bisection if
there's some related bug "interesting".

                Linus
