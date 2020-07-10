Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FF7C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC072206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BxG2YXJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbgGJXFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbgGJXFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:05:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA57C08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:05:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so3173813pgh.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 16:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DLqqu28iK3HzfVLGGSoyKiRaazrB3YV5o+GyyPDcf8I=;
        b=BxG2YXJwxKR8pGptobhdQW7F2cokdhIUEK0pentOHtqsGFs0l5C6wyOwvMDVJvtLlL
         IAn72LMcghNaqBFq1qWndZWJjD55ymLU35HWW2AkHYPI2O3i+2U7D4V4VE1wfTgLVR48
         HjQRAnLCBxTgZV9MnTDtq84Oj08DfvM0rU2TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DLqqu28iK3HzfVLGGSoyKiRaazrB3YV5o+GyyPDcf8I=;
        b=rTxppGwnuIaP9nS7WgsuJFnvDmJwTanhleMuBG4TUzHoCwVHjimTEAxXrS+G+TAWaU
         TAn1e18/rcEyxPKISekzh0J68ntECSealjbDf+O6cxxZKn0lGdqu4IXRbOtkB9yi++DF
         F4hhgkpRYm2SfGHFwJ6Wbs9IbQwNfie040QLz6JR87X6H/ZYkhBxB9bUZelGqlCp5jFd
         ABzjbPLtICM6jNtL33ho+rW5gZtuPS3sSmXUPKQccW7uwzUlCg4fNqY2QdU2SdRGITlS
         TesxuEar4gHqK8l8R7dmcKTdH4+KrAZ/IjtQ+paJdtmRUo4QeTpvTI6YtMbJtXepKvFK
         2rpg==
X-Gm-Message-State: AOAM532lhnFSo0kcrTQyKdMYBXT5KGJzIP5DBrJBYscjSvg1nJJDIby1
        6cX2ojJak+wbo2fHe6QltWdsWQ==
X-Google-Smtp-Source: ABdhPJyY4By66SxxJjGgHuwSmbeFsHxHWrdvMxyYZpjgw6ythZ4sp6ulqZ9xn4+83lV07MB94vmjmg==
X-Received: by 2002:a62:3204:: with SMTP id y4mr36745409pfy.50.1594422342212;
        Fri, 10 Jul 2020 16:05:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c207sm7013552pfb.159.2020.07.10.16.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 16:05:41 -0700 (PDT)
Date:   Fri, 10 Jul 2020 16:05:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Geoffrey Thomas <geofft@ldpreload.com>, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <202007101604.9ED99CCAED@keescook>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200710062803.GA1071395@kroah.com>
 <20200710125022.alry7wkymalmv3ge@wittgenstein>
 <202007100905.94A79A7A76@keescook>
 <CAFRnB2WNo45J8h3-ncopLKENvcO0rf7J3xsy_eRKwFSpDD-5sQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFRnB2WNo45J8h3-ncopLKENvcO0rf7J3xsy_eRKwFSpDD-5sQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:28:30PM -0400, Alex Gaynor wrote:
> :wave:,
> 
> Hey Kees, that's Geoffrey Thomas and I, we're both on this thread :-)

*face palm* Hello! I swear I can read. Though perhaps not well enough
before lunch. :)

-- 
Kees Cook
