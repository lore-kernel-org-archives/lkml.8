Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F97AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6928B22C9F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 15:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596815350;
	bh=+79DjXqJq467nWyEMrQ7Wicx0Dq0aRYQg03ZnQJ0pHU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eGGj+ONcL9tSKwdRtF/BNy3dPaO2qhLJWNYHUL2Y7J0clYxz+YlqPrVJRESE3fZII
	 dImv5SqmsEsEcegmSzgzSzr3zbYnlmtvSGcZD4exIokkXkAISyNFlAWnO6JhxG1Rzb
	 rFYt+7/PA5Nii9TAEeFLP+7U9ZNOu92apjWzJQGg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHGPtI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 11:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGPtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 11:49:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CFDC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 08:49:07 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 185so2697512ljj.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 08:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nW9gy27inwpkC+1GYPEkBMTfy+lAqJwHqmAyLxbBUQM=;
        b=g8L6ASPoD/SmN3mLEDH+wI5dwvr9ep/kObCJHvGkDE0FeYvDsrBej+Mq/yCHPL+651
         Xgckegp1goMEN5E+bp4qlt3yuX/21WZQNb58ka+OcZxIkYi5tlwrtWXFwhxFcwOoXUag
         ASepnoVUfEocQ7C/wpoIZMZlR/HjpIrE2/Nng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nW9gy27inwpkC+1GYPEkBMTfy+lAqJwHqmAyLxbBUQM=;
        b=D2VuuaIzEvVRdEVLPDqazQKCLotKxBPNLJDZEC7xExARQaE4K/JQpYanuA+TGPpzcA
         hwhGYFTvN80y2xq9E8i7ZeFh1i2V4T2gnnfwyKGPK3bPjaqL2KJot8yja6NQDYgawxym
         nmmpdjFGCkek0wS3caC7oCT8jCPQt7kcFi8MiIYkDz3VI1n0hHiLG4FR9f+msZbEjhK4
         fPAtqWjYwrzXMOupDFwGI3/jWStsNJIzob6o/n+9ck5vCe8ynwfr8Bpuk0c7vN0nJVk+
         eUPGqnwcoyBKbDpHV7gmooCq6BDNTQHDbVcHX5DAJPy6bPU27G6NT7qb8HI5noFYgh0r
         3BDw==
X-Gm-Message-State: AOAM531hJT2wHQs54ZRyNZD7mudWx1iwufskIWCUbipjHDqSNyAaWayD
        xB6b58TxIh+8DxXCMiCs/Ds2LDmb+Uw=
X-Google-Smtp-Source: ABdhPJz8RupcCJ5WKALLSTS4UW+Wde42drXFmhk+Px4BDbfUSdXTKk74NCfliqDtuTNzi5aWtefVuA==
X-Received: by 2002:a2e:91d2:: with SMTP id u18mr6913815ljg.436.1596815344612;
        Fri, 07 Aug 2020 08:49:04 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id 9sm4313560lff.82.2020.08.07.08.49.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 08:49:03 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id v9so2698680ljk.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 08:49:02 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr6222774ljc.371.1596815342274;
 Fri, 07 Aug 2020 08:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <1596812929.lz7fuo8r2w.none.ref@localhost> <1596812929.lz7fuo8r2w.none@localhost>
In-Reply-To: <1596812929.lz7fuo8r2w.none@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Aug 2020 08:48:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi41L-OXCPQJi4dtc_7SmYTzXGz0XM=39rjiTNAi2gn3g@mail.gmail.com>
Message-ID: <CAHk-=wi41L-OXCPQJi4dtc_7SmYTzXGz0XM=39rjiTNAi2gn3g@mail.gmail.com>
Subject: Re: wine fails to start with seccomp updates for v5.9-rc1
To:     "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Chris Palmer <palmer@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christoph Hellwig <hch@lst.de>,
        Matt Denton <mpdenton@google.com>,
        Robert Sesek <rsesek@google.com>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Sargun Dhillon <sargun@sargun.me>,
        Shuah Khan <shuah@kernel.org>, Tycho Andersen <tycho@tycho.ws>,
        Will Deacon <will@kernel.org>, Will Drewry <wad@chromium.org>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 8:19 AM Alex Xu (Hello71) <alex_y_xu@yahoo.ca> wrote:
>
> On Linus' master, wine fails to start with the following error:
>
> wine client error:0: write: Bad file descriptor
>
> This issue is not present on 5.8. It appears to be caused by failure to
> write to a pipe FD received via SCM_RIGHTS. Therefore, I tried reverting
> 9ecc6ea491f0, which resolved the issue.

Would you mind trying to bisect exactly where it happens?

I don't think any of the commits in that pull are supposed to change
semantics, and while reverting the whole merge shows that yes, that's
what brought in the problems, it would be good to pinpoint just which
change breaks so that we can fix just that thing.

Kees, ideas?

                 Linus
