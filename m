Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56778C54FCF
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C21D206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pxDYmGnK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgCYH7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:59:41 -0400
Received: from mail-wm1-f73.google.com ([209.85.128.73]:41738 "EHLO
        mail-wm1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgCYH7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:59:41 -0400
Received: by mail-wm1-f73.google.com with SMTP id f207so567931wme.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 00:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=hfFzAgFLiPhJI7PNYPoebZUNl36WTAu03kIuyGPpbI8=;
        b=pxDYmGnKOS3Ef4pWxZN1Ura0RIq7zlN5bDScyl2R/APyLXHYdrpVd4JasW3YV8ovxc
         tpv/HetTuguGF2H9tM3EvvcPvihKmJPH0GAI7CyAMdHHbiHlPMjp9wavU26rHP4DHW/W
         zBVkQ5hFebZocWV/Qqa2rZe6/J0hHu3a+w7KlxBT/8Kw94DRetTSnjwc8Q/bXg9wLEyU
         oo/upaNvUI8DEAdrH2pO3OGukNsyZu8Ah8ClzpJvH/KSBHHt1Ok1j2sdN44M1BJOdyT3
         FgMckxzlWTQdyPx5Zp6Gl6LhzLUmL71QUe5ZoyfuuLdN7t97o03NpOgsXPOxFHZ58pzh
         KvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=hfFzAgFLiPhJI7PNYPoebZUNl36WTAu03kIuyGPpbI8=;
        b=m3sP7y1DSc+AybqaFn6zIMvykYNkduhzuM9GfZ9NL0pdsi/cgjI8P72783rjuCV0aK
         NOvdzo7IzSM5tUymvmcxN6A9rqNr2oEukxlpUO/UOtF5HBVxYdbjGFzBBqMJjMSjBmky
         Ck7v31gQ5ZZ2kmCD8LJBYYM6nqiGJYyggYck/gNGg6bxXxVu9kqj2XaZGw7wZovgoXOs
         L1Cli1PLjwW37jkprYE+feZhOdrtafutz5Y9+uuC+4M0r3hiB0UHuVGwALkVH9qtZP3m
         D3JalZ+RqDZ9aUxZwnUEzeT2c4ZkFsdyd9eqUoiJo9ICkEB9syuX9qrIwsRQdfDcbc3Z
         PP0g==
X-Gm-Message-State: ANhLgQ3oSxyAanXl0Ey1VRlI2oygyL7ORCw2Sh8xQe66Zv4bVnB/ZXsM
        GAtSBq+/+Vy+DPfZDOXURC8RsNAnLdk6
X-Google-Smtp-Source: ADFU+vvI6XyoMyOeAgHW/3T8UjZKl0NtKhNkhRAdej9UofBhaJtmEZYsJcg7YIcnaa8TV0KGL5nKoIKvc1pX
X-Received: by 2002:adf:cf09:: with SMTP id o9mr1950627wrj.74.1585123179453;
 Wed, 25 Mar 2020 00:59:39 -0700 (PDT)
Date:   Wed, 25 Mar 2020 08:59:22 +0100
In-Reply-To: <20200323114207.222412-1-courbet@google.com>
Message-Id: <20200325075924.109330-1-courbet@google.com>
Mime-Version: 1.0
References: <20200323114207.222412-1-courbet@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH]     x86: Alias memset to __builtin_memset.
From:   Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Clement Courbet <courbet@google.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Not sure we should modify this for someone's downstream tree to work
> around an issue they introduced.  If you want to file a bug
> internally, I'd be happy to comment on it.

I don't have a strong opinion on that. I don't know the policy of the
linux kernel w.r.t. this. There is an internal bug for this, where
kernel maintainers suggested I upstream this patch.

> Does __builtin_memset detect support for `rep stosb`, then patch the
> kernel to always use it or not?

__builtin_memset just allows the compiler to recognize that this has the
semantics of a memset, exactly like it happens when -freestanding is not
specified.

In terms of what compilers do when expanding the memset, it depends on
the size.
gcc or clang obviously do not generate vector code when -no-sse is
specified, as this would break promises.

clang inlines stores for small sizes and switches to memset as the size
increases: https://godbolt.org/z/_X16xt

gcc inlines stores for tiny sizes, then switches to repstos for larger
sizes: https://godbolt.org/z/m-G233 This behaviour is additionally
configurable through command line flags: https://godbolt.org/z/wsoJpQ

> Did you verify what this change does for other compilers?

Are there other compilers are used to build the kernel on x86 ?

icc does the same as gcc and clang: https://godbolt.org/z/yCju_D

> yet it doesn't use vector operations for the general case

I'm not sure how vector operations relate to freestanding, or this change.

> Adding -ffreestanding to optimize one hot memset in
> one function is using a really big hammer to solve the wrong
> problem.

-ffreestanding was not added to optimize anything. It was already there.
If anything -ffreestanding actually pessimizes a lot of the code
generation, as it prevents the compiler from recognizing the semantics
of common primitives. This is what this change is trying to fix.
Removing -ffreestanding from the options is another (easier?) way to fix
the problem. This change is a stab at accomodating both those who want
freestanding and those who want performance.

The hot memset I mentionned was just the hottest one. But as you can imagine
there are many constant-size memsets spread across many functions, some of
which are also very hot, the others constituting a long tail which is not
negligible.


