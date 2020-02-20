Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3015BC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A84120722
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX4BJedh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbgBTRmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:42:01 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44423 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgBTRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:42:00 -0500
Received: by mail-oi1-f194.google.com with SMTP id d62so28330067oia.11;
        Thu, 20 Feb 2020 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uUxjn0JHsnAyYM3s9DI1K/kaI5mGJzrCsTVv+Xjv7Dk=;
        b=IX4BJedhmchHA9YJvdmyTmSWNUHntSHnz9o8MZzYqLZ6y6/zNJzwv0IO8QKbDPENIk
         h4DH+G04LlwIJ+wqVXoQLcg/pkzoYXgbDVIghHAHUc9KPSZ1eAaoyPB7c2Cr9ATTfu1Z
         2M0MdtHGapQzXzuILjhi/pcjM442NW/cMqa/Xp87ZrX3u2k7Tb7ZZ9mGAzkoELyZOGEA
         LtqrETLMz7s4+rt+GhOXl/VfEdILVFyPBYn7ZB2UiLy90uXo+mZetLrP5JhQzeY9daga
         wKwdRrPtUKueSkSuWFOLun+PAn/Fkz9gYD3Q7Or1rSnuujBeReDLSFgwyRivv6lN9eMo
         irJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uUxjn0JHsnAyYM3s9DI1K/kaI5mGJzrCsTVv+Xjv7Dk=;
        b=ZVPskKbvAvy3Jzk1q5pTrHkPb41UfXM1ZoPbnLLm4q6SzPEUWpFp3sgVZUzZ8ucj0E
         F1ZUOHbeFCj8NBpp8brFj+Mp8yJlqF/ndqrpgckGdqQ3Y3pEkEFLH8Pp4eorLxdwmT/A
         qnRmofUbq+nm9gw1Ukj7dYwQ+uF+yYp2VNxhIaO9osW2FS6nDxgsFnz1tfJyDDEH3Qnk
         H5iAhEnDmoZxXtUJoXBbSqpkqhufzJUY9ZePtFBMTCi7FzbaALjuluRqiN1PafNX1wwK
         JvTKWG/kMDaDCqjqLEZz8vBR5XiTeo2AJnMQOW3U2ScQ7pVAsZAtvb6fZPplae1lM3rH
         ptiw==
X-Gm-Message-State: APjAAAXjBRt+xlIsS1OutlZ6xFlTX8bin6F2mcVFiXJFbzZGJf8tj8mN
        ztWEJcwKvQ5WvCvUm0HajkM=
X-Google-Smtp-Source: APXvYqxeUUXchx/l8Pxm9C6gQ5n984EMw1xRLgCcXNTCerN04zUwxFrsKQ9U63ZOSjLCmpLsm/ZFew==
X-Received: by 2002:aca:2b04:: with SMTP id i4mr2935125oik.21.1582220517946;
        Thu, 20 Feb 2020 09:41:57 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id s128sm1321002oia.4.2020.02.20.09.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Feb 2020 09:41:57 -0800 (PST)
Date:   Thu, 20 Feb 2020 10:41:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        clang-built-linux@googlegroups.com,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        sparclinux@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sparc,x86: vdso: remove meaningless undefining
 CONFIG_OPTIMIZE_INLINING
Message-ID: <20200220174155.GA40621@ubuntu-m2-xlarge-x86>
References: <20200220110807.32534-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220110807.32534-1-masahiroy@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 08:08:06PM +0900, Masahiro Yamada wrote:
> The code, #undef CONFIG_OPTIMIZE_INLINING, is not working as expected
> because <linux/compiler_types.h> is parsed before vclock_gettime.c
> since 28128c61e08e ("kconfig.h: Include compiler types to avoid missed
> struct attributes").
> 
> Since then, <linux/compiler_types.h> is included really early by
> using the '-include' option. So, you cannot negate the decision of
> <linux/compiler_types.h> in this way.
> 
> You can confirm it by checking the pre-processed code, like this:
> 
>   $ make arch/x86/entry/vdso/vdso32/vclock_gettime.i
> 
> There is no difference with/without CONFIG_CC_OPTIMIZE_FOR_SIZE.
> 
> It is about two years since 28128c61e08e. Nobody has reported a
> problem (or, nobody has even noticed the fact that this code is not
> working).
> 
> It is ugly and unreliable to attempt to undefine a CONFIG option from
> C files, and anyway the inlining heuristic is up to the compiler.
> 
> Just remove the broken code.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
