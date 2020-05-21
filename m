Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7A4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7306520756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FyxMI4ZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgEUWoh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730371AbgEUWoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:44:37 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D24C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:44:37 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w19so3573288ply.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kJu9W8td60dlHtHyi+5unK6gpeAXqJ29SHAWsL9RWAs=;
        b=FyxMI4ZZl0PURR7iCViveWuP5CK3+qS4CaqRsugrQpFszxBJL5lNbPEfcYs6PLFYKw
         t4P6z1zwwxuglPfFfbOr206BbUh0XV5gWoMaTusRIwTt8dC2nkbrAqsX8XwXGuSU4oFw
         wte7+rxUaQ1tKXsuGjW/mJUFSlFiUGJKJ/7O8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kJu9W8td60dlHtHyi+5unK6gpeAXqJ29SHAWsL9RWAs=;
        b=MatTXjjzhkm7tkXo4eVDlBQQWLiDy3yO+4m9ofSmfLo6KYdmDsPqLdg4KyWfq3Gh2R
         25Fft1OX7ewnsEgFI8Q+imqplpha7HdT8/p2gZfVjY6pqM+M0U6wJS8sOX4KWCawPSyM
         CrqVSsWGFnBPh68nrJeZeAvd2zQ1WpeQh9KbYjTrQpDLaILNSWoaXBpkRVfDOr3k1+rJ
         D0+UwlBigL6M0vNSncw5zjH3r+dAIDrbLFAoVvO32s7WhLjo1LHlluXwwkcIwMIYJdVj
         J13h54cSrBXJau+gKfu5tsdYVRpuD8gde8c0HZ9Z1penABLdBCEwieD4Mv4O4oDIlRIo
         I/2Q==
X-Gm-Message-State: AOAM530rF11v9dCxN4PLJHFsF0SgTfRZSl3y476m2RtEQYo4HuH+2nUR
        a7H5Gn9Dd6g41XTuyCZt1DuApw==
X-Google-Smtp-Source: ABdhPJwbfzhVpxvrN3j/MRFGPobDoa0suCLVnXlB5gXgmrcSLI+uy6mgMoBKtenCAwI+gnf27dKTyQ==
X-Received: by 2002:a17:902:b904:: with SMTP id bf4mr7752059plb.89.1590101076912;
        Thu, 21 May 2020 15:44:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 196sm5311016pfx.105.2020.05.21.15.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 15:44:36 -0700 (PDT)
Date:   Thu, 21 May 2020 15:44:35 -0700
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Subject: Re: [RFC PATCH 2/5] selftest/x86: Enable CET for selftests/x86
Message-ID: <202005211544.26CD475832@keescook>
References: <20200521211720.20236-1-yu-cheng.yu@intel.com>
 <20200521211720.20236-3-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521211720.20236-3-yu-cheng.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 02:17:17PM -0700, Yu-cheng Yu wrote:
> To build CET-enabled applications, GCC needs to support '-fcf-protection'.
> Update x86 selftest makefile to detect and enable CET for x86 selftest
> applications.
> 
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
