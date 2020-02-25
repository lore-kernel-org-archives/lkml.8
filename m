Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB0BC35E1C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E731D2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cj56T07V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgBYVSw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:18:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45775 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgBYVSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:18:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so317882pls.12
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 13:18:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kyC0S3nLXyzsm81BmepVIhQQuTKauVa1MWg7QJig8D4=;
        b=cj56T07Vxz1sEPwIo3vVc5PooAdcznhQsty9r8ixIE9RubODSoaWcDP2HBH9jPQGlx
         /7rHVj2yFZT9RXQMd3lF5rVMfDwAHKOIMF77nrf0FzlsY88ywGty6oodRzq8mCK7hwcB
         8TWDHsJlmJVw/q9GyDy58o63aR2THnmItLT20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kyC0S3nLXyzsm81BmepVIhQQuTKauVa1MWg7QJig8D4=;
        b=diVmnj6NbtlOBgHu6J9YJDnPM0dVwKlTL04816HMxVcLsgi4AwwAtGzeidNRuFK6Hw
         /XcHVl8ZF0YzcLDtKWVyqQxdb3zFJWPKUiFrLdJ1IYcq97pN1Iiwbt7M1WS1llEWbUd6
         yY5OApjJmLzov6lWhkoaAZWrM352cmnCgfJ09rKfh7+JtgAl/ijM8heKF4fWRtiP+hGQ
         7jLjkvKhYz2uY32W53FMma+wpHTZKrGaN3hipI1qlTHGQhLUcFT28TH6IDfDd+T97m+a
         ogXnShrlqUFQUNY54WD25sQFUDeowRaJi1kmyh6QnUxzUT0kjmgTPBR0THFl2oS0gDSt
         /XtA==
X-Gm-Message-State: APjAAAUdrSvRy/NNUJVmn08zEWMJX454TNJiavmrPllzVDhBGCXPY/R3
        RmSOtWi7fH1Hqh/gskG7rGxROg==
X-Google-Smtp-Source: APXvYqz4GuEOOMi8is/0gSue/XsQsxclLpaHaOpRccPjkZmlxITRd7oCZSiK+0IE0z6s634MjgXOuA==
X-Received: by 2002:a17:902:343:: with SMTP id 61mr493496pld.332.1582665529931;
        Tue, 25 Feb 2020 13:18:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m101sm28988pje.13.2020.02.25.13.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 13:18:48 -0800 (PST)
Date:   Tue, 25 Feb 2020 13:18:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>, x86-patch-review@intel.com
Subject: Re: [RFC PATCH v9 21/27] binfmt_elf: Define
 GNU_PROPERTY_X86_FEATURE_1_AND
Message-ID: <202002251318.EF0E98EA0@keescook>
References: <20200205181935.3712-1-yu-cheng.yu@intel.com>
 <20200205181935.3712-22-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205181935.3712-22-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 10:19:29AM -0800, Yu-cheng Yu wrote:
> An ELF file's .note.gnu.property indicates architecture features of
> the file.  Introduce feature definitions for Control-flow Enforcement
> Technology (CET): Shadow Stack and Indirect Branch Tracking.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Why not merge with patch 20?

-Kees

> ---
>  include/uapi/linux/elf.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index c37731407074..61251ecabdd7 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -444,4 +444,11 @@ typedef struct elf64_note {
>    Elf64_Word n_type;	/* Content type */
>  } Elf64_Nhdr;
>  
> +/* .note.gnu.property types */
> +#define GNU_PROPERTY_X86_FEATURE_1_AND		0xc0000002
> +
> +/* Bits of GNU_PROPERTY_X86_FEATURE_1_AND */
> +#define GNU_PROPERTY_X86_FEATURE_1_IBT		0x00000001
> +#define GNU_PROPERTY_X86_FEATURE_1_SHSTK	0x00000002
> +
>  #endif /* _UAPI_LINUX_ELF_H */
> -- 
> 2.21.0
> 

-- 
Kees Cook
