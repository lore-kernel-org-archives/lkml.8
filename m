Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C6EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C49F20814
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nawu1sY9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgEUWSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbgEUWSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:18:41 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3590C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:18:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t16so3546702plo.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rf4tJm2txvY5na/8+j5CB7aTOYv72GPVmDh1yfq7cjU=;
        b=nawu1sY9brEek06PsqlCx+dbEytS8R+cmmspJLrpOj7ZS9sHjIk6H1Lgz/bOXZVdlY
         hVWs8bylJ6//TXJYlfSVYjhJ5c2vTijIs2jhfEJYhE4VPJQcHaVZ7nilo2rtsqNzvhfK
         JAgr+3J4j1Ziz7r8bPjyU7gqc4nmxNZSPYeK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rf4tJm2txvY5na/8+j5CB7aTOYv72GPVmDh1yfq7cjU=;
        b=Yx+PQHnsOa7ePKZDX+kdSD66vOS9ATUiNg6ELmRddhhk+ieTp8VrBBm/+kc63JdFec
         bu9Nz/rhkgLIiD+A0N932DfjEh+a3ZitKtxsFTjsXTa1Z2j9Xsg8YdUADnMR4Erzphrc
         ohh4+bl3IqDGdJE4EOwwZTdDt4MeU8OXKNBRbojGs5TFLwit3esTABAq1pqxyBhTPTnF
         iD3O/iUgwoM8ZnjkwXCKWwjk6ihH3WteZRxC9tHDbwxgT9pTVfPAFMEsmFflxzgWDmmw
         +jphXYh63qHau7w3ICn2+SIfP6qTEOLVac4aCVkVu6xfDdoo7BGjIKriDF2ovTBxh5YA
         Uc8A==
X-Gm-Message-State: AOAM533YxF2jN543Q1yIiyQ+vc4zgy+gnmjAe9dJArR+/ovaGGgQEanh
        GjM5Q7jpJhzBXGgVWjRXyJIAcw==
X-Google-Smtp-Source: ABdhPJyXuTchiohxG/7qxMaOU9EGc8YbdDOkrtNLspmWALVB8rZMgnEet6n6kLKmBpBwp5T//sQtpg==
X-Received: by 2002:a17:90a:3d49:: with SMTP id o9mr754082pjf.26.1590099519333;
        Thu, 21 May 2020 15:18:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a6sm5284031pfa.111.2020.05.21.15.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 15:18:38 -0700 (PDT)
Date:   Thu, 21 May 2020 15:18:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: reuse vmlinux.o in vmlinux_link
Message-ID: <202005211515.481BD90@keescook>
References: <20200521202716.193316-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521202716.193316-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 01:27:16PM -0700, Sami Tolvanen wrote:
> Instead of linking all compilation units again each time vmlinux_link is
> called, reuse vmlinux.o from modpost_link.
> 
> With x86_64 allyesconfig, vmlinux_link is called three times and reusing
> vmlinux.o reduces the build time ~38 seconds on my system (59% reduction
> in the time spent in vmlinux_link).

BTW, I'll see this most in that it knocks about 6% off my "I changed
1 .c file and now I'm rebuilding" workflow time (which is obviously
dominated by linking), from 25 seconds to 23.5 seconds. And since most
of those seconds are spent staring at the build, it feels like a lot
more. ;)

-- 
Kees Cook
