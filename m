Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117A8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD4082067B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 00:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591229640;
	bh=wJt/E3KOzAbfjnU6Afr8qP51B0SkXgeMthZGOmvjbFk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GbdlMJ46+zN39J4tMpHle1wzENrZx71Ujyh3Po2MRVYjvTcZ1BeomcVR+EYS2xK7F
	 5QwqKHOHrniLrdSKNgxqh3yM/J85MsdbWagE1RadzrJb08Yav9vLkFT1MyYm716BY1
	 chAbzH3vF+Nkvnz9qoHlv7cpjsMVKx0g5huVM8Tk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgFDAN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 20:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgFDAN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 20:13:58 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FBC8C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 17:13:58 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z9so5000355ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 17:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rWe2Q0RVzrp4gR0EET85HSpI5Y5evJHsyhPkQ14mL0k=;
        b=bt0TGPg3m1SCTLBdHymXFLfl3E3L3r+udH7rn8D+EBhHjSsJezRKQc5I44quK2Ep95
         n7O9rGE+x0OuzzxK9JDFKVEZNlNil/zWzB2OtsPvSkq3h3Byx+1A/PbyAJD8T+ACtvtF
         KVePdWwwaM3XuFRkXqkGtRQjsVdhDo42Nx8Z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rWe2Q0RVzrp4gR0EET85HSpI5Y5evJHsyhPkQ14mL0k=;
        b=ZoCkascaD4PXlHIwDb3puZVEbip8cR7HgUdQvE/Nbm6uWWPAdS46QvwyN9qaTDcPga
         LX64d/uwfl5C5jErpbFmEJuC3nnx3dK1fnZTeTEGSaNjJi7LXahDhmCzRpj6lj+bgn4+
         BcIfZ+pWpulW8G9pMQ8ePDXWwr2noq1AtdH7/GCzuhjLnDXIeFhmLEEg/mY/1sNI9acx
         xEU8s5rhCE+FS78CiQaqcYWio135jZhscf0M6EDyQTtAbmtOe8+ZlMH1f/ElaI2+es4r
         H8Q3N1uES+OI0yIS1kgciPBTWaBDkRYcoFzHakETNUuQAsBoAUDv/TmN7+cYlc59yGjb
         AdBg==
X-Gm-Message-State: AOAM532bSIdk3u8YrkEdxhGutGa9E3X5qseGO+VLNzibZmqdmfOm2NOJ
        gfG7sYiVvbkV7vcyceJZSWC7ZwUDTQk=
X-Google-Smtp-Source: ABdhPJwZYDfDLZVIm4Br+CGgDfQtwpj6uJFNLyR/DN3sUl4t5yxG1FVOWXZ3AhROm1+a6s+mbCM6pQ==
X-Received: by 2002:a05:651c:544:: with SMTP id q4mr832295ljp.310.1591229635982;
        Wed, 03 Jun 2020 17:13:55 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id t7sm1059215lfq.64.2020.06.03.17.13.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 17:13:52 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id b6so5063114ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 17:13:52 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr790807ljc.314.1591229631853;
 Wed, 03 Jun 2020 17:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200602204219.186620-1-christian.brauner@ubuntu.com>
 <CAHk-=wjy234P7tvpQb6bnd1rhO78Uc+B0g1CPg9VOhJNTxmtWw@mail.gmail.com>
 <20200602233355.zdwcfow3ff4o2dol@wittgenstein> <CAHk-=wimp3tNuMcix2Z3uCF0sFfQt5GhVku=yhJAmSALucYGjg@mail.gmail.com>
 <20200603232410.i3opsbmepv5ktsjq@wittgenstein>
In-Reply-To: <20200603232410.i3opsbmepv5ktsjq@wittgenstein>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Jun 2020 17:13:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTpLOeMjpLOc8hY7KC6Qv+jR-hBacyBSajJ6iUKasmKA@mail.gmail.com>
Message-ID: <CAHk-=wgTpLOeMjpLOc8hY7KC6Qv+jR-hBacyBSajJ6iUKasmKA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] close_range()
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Evans <self@kyle-evans.net>,
        Victor Stinner <victor.stinner@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        "Dmitry V. Levin" <ldv@altlinux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 4:24 PM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> Ok, here's what I have. Does the below look somewhat sane?

Probably. Needs lots of testing. But this one looks wrong:

> +int __close_range(unsigned fd, unsigned max_fd, unsigned int flags)
>  {
> +               if ((max_fd + 1) >= cur_max)
> +                       max_unshare_fds = fd;

A normal value for "close everything starting at X" would have a
max_fd value of ~0.

So "max_fd+1" would overflow to 0, and then this would never trigger.

Other than that it looks what what I imagine my feverdreams were about.

              Linus
