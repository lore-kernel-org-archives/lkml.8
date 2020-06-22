Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22816C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA23B2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rKyi28V8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgFVWAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730764AbgFVWAs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:00:48 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16761C061795
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:00:48 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id h22so553424pjf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+ibN7k/GXiEaOSwLAh6eIG551wxCB5ccPWNe8L96H7k=;
        b=rKyi28V8bhsI6UdHiPApRpohgn8p9zbUYrz2P0iYhKTjCcEJ0SOmXPvMi9V0vqatco
         3zGbkaHV1kl3gjnsYSypuWOI+JtV9XpVsv3Jeu0SnNN+SeL0YE0KynN2aVt1nh04yijm
         G/C/99Dy4+IUjMHHYJ8lWES1GjdSu8WOBoyF3D+RYqCj3m4myhdwFBquvPI2hsmIKrmL
         33wQPAhshvvESXgStFXk9rxa2pjnZaUkd+Q9aIz9ygCq46QtquvxTGU/990uwrOkfAER
         0cwAeoV+9N8KJqc7YQRvBKbadq3s7A4/URqpvXSyDalxch6c40Ae3ataIYbj3r3H0OcS
         0uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+ibN7k/GXiEaOSwLAh6eIG551wxCB5ccPWNe8L96H7k=;
        b=BI1aVMj8oD3oSXMRg5cK5Sibqb6lE+mDD1m+sDSVx8db+SQ0h8Qi34DM2pwY4z6TqK
         Ei8QzPwxLu7ls40wfCP/SCdwv3cKt0EaKLUoXE5MrLzWTQsRWBjmYLnVf/v0MA7stiWI
         aNBth2qW+5seqHvMFLN/fknm5FSgV4aQEDYiBatErp7ZSKrAK17Y0CmPjKXT/0NRrtUH
         4oLFB+3Nvp7yVMkDEYrKTmzveCUS52Zi92cCAMShmhyB6aJv+sn8uz2VREez1FlrZC+A
         T1f69dSOYavJwR0uI1HBaUpupiwMSdXyy9MVVXeOm2dX5mmRPKC49ToFmyM9NQJdr+F5
         O0tg==
X-Gm-Message-State: AOAM533td4nDOKPveqEKIL0Ki9xKdKh7Un4hVZG9L3bHIZgpDptpM6C7
        mOuwlwC0MaaOzuRiBxwV4JDh8Q==
X-Google-Smtp-Source: ABdhPJymp3j075dghUf8mE+rb8FWDpg5HB71a1UeOscamGOdT4UZapUDia7WzmBwV1WReNldwXQ4fw==
X-Received: by 2002:a17:902:ee15:: with SMTP id z21mr21435821plb.233.1592863247373;
        Mon, 22 Jun 2020 15:00:47 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:9efe:9f1:9267:2b27])
        by smtp.gmail.com with ESMTPSA id 130sm14647760pfw.176.2020.06.22.15.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:00:46 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:00:43 -0700
From:   Fangrui Song <maskray@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Borislav Petkov <bp@suse.de>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] vmlinux.lds.h: Add .gnu.version* to DISCARDS
Message-ID: <20200622220043.6j3vl6v7udmk2ppp@google.com>
References: <20200622205341.2987797-1-keescook@chromium.org>
 <20200622205341.2987797-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200622205341.2987797-2-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-22, Kees Cook wrote:
>For vmlinux linking, no architecture uses the .gnu.version* section,
>so remove it via the common DISCARDS macro in preparation for adding
>--orphan-handling=warn more widely.
>
>Signed-off-by: Kees Cook <keescook@chromium.org>
>---
> include/asm-generic/vmlinux.lds.h | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
>index db600ef218d7..6fbe9ed10cdb 100644
>--- a/include/asm-generic/vmlinux.lds.h
>+++ b/include/asm-generic/vmlinux.lds.h
>@@ -934,6 +934,7 @@
> 	*(.discard)							\
> 	*(.discard.*)							\
> 	*(.modinfo)							\
>+	*(.gnu.version*)						\
> 	}
>
> /**
>-- 
>2.25.1

I wonder what lead to .gnu.version{,_d,_r} sections in the kernel.

tools/lib/bpf/libbpf_internal.h uses `.symver` directive and
-Wl,--version-script, which may lead to .gnu.version{,_d}, but this only
applies to the userspace libbpf.so

libperf.so has a similar -Wl,--version-script.

Linking vmlinux does not appear to use any symbol versioning.
