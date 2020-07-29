Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AFD4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 453942070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LmCSkNmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbgG2WEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgG2WEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:04:45 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91109C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:04:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id p3so15234583pgh.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HjociY7OAB6oMEemFlGGf0Ydinx3jHC68l3tE+c8Rt8=;
        b=LmCSkNmGEKE4QdJu/HP6QGJvsB/o5q79hwyaVXIFJHxUXG87os6TCyKewrhbx9XAbM
         69xsJa10/QOSwlEOlW2z5Le1mxysvgtLLHnJbO8usIFtuiL/1qY+pV8TujgZKKCYI/0u
         /jeRW3d9b1uhhrsMkP6JO+21mfnkUKlqzL1Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HjociY7OAB6oMEemFlGGf0Ydinx3jHC68l3tE+c8Rt8=;
        b=lvWbcSINe+tVSQwWYeo42BWUPuFQhDSzgk3kKTQD9rFoNcH6cGqN+QQTDjiXcLttc9
         JmrjctxhAZ1yt66p4/KxRTVhS9yxjy4JnCp5MY0skA6dB7uTnJCkx/j945tAR67rgcWO
         Y/nhPIML6fyNLZKQmVHVTT1cLPsiqVD/JvnQ8nkJiadUKxGDR8Ro94jzIOjbZUEKZmXC
         VliL8MNwx47wLuQZ+U0ThMNnXmJQOXvagIFxX7U3IZosQ+a8Eeu3VBop7Dw9fTKmGF5T
         /hLgg6BkSXiTidF2WECFU/qz5SSL6l2tJ7xQOYjEHtlUL9kzp3kuLaZkgH2iJhwU8cgK
         PUsQ==
X-Gm-Message-State: AOAM533FIvEMUTGvEhsDTa4IB+ad2UvJw1s85dTojMHYZKmW4nQp2MIH
        fzWPe90Aqci6pnJ9rTdbLKVOAw==
X-Google-Smtp-Source: ABdhPJyimSXlShA82ax0CME0Kw+5UaN5LiJYIZcLV01qEHptUEr9G08uucfcktpyk8JwBKnQoCuxmw==
X-Received: by 2002:a63:4543:: with SMTP id u3mr29084995pgk.398.1596060285159;
        Wed, 29 Jul 2020 15:04:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j94sm3165634pje.44.2020.07.29.15.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 15:04:44 -0700 (PDT)
Date:   Wed, 29 Jul 2020 15:04:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH-next v5 0/7] x86/boot: Remove run-time relocations from
 compressed kernel
Message-ID: <202007291502.18DC4C0F@keescook>
References: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
 <20200717201801.3661843-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717201801.3661843-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 04:17:54PM -0400, Arvind Sankar wrote:
> Same as v5 previously posted, but rebased onto next-20200717.
> 
> v5: https://lore.kernel.org/lkml/20200715004133.1430068-1-nivedita@alum.mit.edu/

BTW, some bits of feedback on process:

- please don't re-use version numbers, this is confusing :)
- please fix whatever is happening with the "In-Reply-To:" headers, the
  threading is extremely hard to understand (each patch isn't a reply to
  the cover letter, and everything is a reply to a single earlier email)

-- 
Kees Cook
