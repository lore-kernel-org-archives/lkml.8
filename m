Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED744C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA10A2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NaEJCuH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgHRTYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbgHRTYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:24:43 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BA67C061342
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:24:43 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 128so10205981pgd.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 12:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6hayTTGEbr1/YdVLWNP0d/mHo2iUAS7x2PZOqNynkQk=;
        b=NaEJCuH9gbmOM5fin2j7WXtbMmkBDrhuG7HtZ/z20dwk7dxw3hxcsGAbq0Zs7NDcLn
         r4oH+YkgiaBZs3qHpQNy8seqFrsOBGaiNMQgBTxu2M1WnB+Eh6gbb4VEHpQx7y0RS4so
         VDF2GTC3rXza7Mh/mAMNu0CDReeyjyK4GPT0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6hayTTGEbr1/YdVLWNP0d/mHo2iUAS7x2PZOqNynkQk=;
        b=UTpDTw3RjM5CdJnZVXkg+D+VfG+fnOxeMOm9vePowVAnXeKrPHIOiRYLypa/yFFkTb
         k6AzlCgWkksGg/tIAnL/5r9t7SWKxlKMYFDujXwe6h2EDqoh/nDw/JS14UJ7xQ8G1ZeB
         9XsR1JR7cd81l9SN2uNYvmXq9Xbfg3jH11Ykc+Sx1AvqP3PZ7nsurfldgnV1Ck+JKVYA
         MVEIYU/FtnWbdd91HX4OYWyOSPlhg7+sD0Vrpn4LnRz3OgpnzE5Nkl4KONBWCozlu7fq
         ynwtGJKrkaTlwjX42e2JkP2RVOkzk8gjpDXE5/0Gk3UQ/f7JGSnsRr4T8uln7KRHqGEc
         Jywg==
X-Gm-Message-State: AOAM530xnMAAbgBDCOZfmyWnKDvDX2fpgllTP0KZbzoWn4xXMHIZBSh6
        nOyk+aPQxSh/DLDDbahlOdJFmQ==
X-Google-Smtp-Source: ABdhPJxROH1AJL8y95bXyAdrCrDPPEfnq6nYi8o0CBmaUfSkJDB2y+UuzO66imuSYjuDnkJBfKQ4xg==
X-Received: by 2002:a63:4955:: with SMTP id y21mr13917271pgk.180.1597778682761;
        Tue, 18 Aug 2020 12:24:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c10sm25101551pfc.62.2020.08.18.12.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 12:24:41 -0700 (PDT)
Date:   Tue, 18 Aug 2020 12:24:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Joe Perches <joe@perches.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Daniel Axtens <dja@axtens.net>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Yury Norov <yury.norov@gmail.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Marco Elver <elver@google.com>,
        Vamshi K Sthambamkadi <vamshi.k.sthambamkadi@gmail.com>,
        Andi Kleen <ak@suse.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?iso-8859-1?Q?D=E1vid_Bolvansk=FD?= <david.bolvansky@gmail.com>,
        Eli Friedman <efriedma@quicinc.com>
Subject: Re: [PATCH 3/4] x86/boot: use -fno-builtin-bcmp
Message-ID: <202008181224.4C682B38@keescook>
References: <20200817220212.338670-1-ndesaulniers@google.com>
 <20200817220212.338670-4-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817220212.338670-4-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 03:02:11PM -0700, Nick Desaulniers wrote:
> We're reverting
> commit 5f074f3e192f ("lib/string.c: implement a basic bcmp")
> in favor of -fno-builtin-bcmp. Remove the additional definition here,
> too.
> 
> arch/x86/purgatory/Makefile uses -ffreestanding, so there's no risk of
> this libcall optimization occurring for arch/x86/boot/purgatory.ro.
> 
> arch/x86/boot/Makefile resets KBUILD_CFLAGS, so make sure to reset this
> flag that was set for the top level Makefile.
> 
> Fixes: 4ce97317f41d ("x86/purgatory: Do not use __builtin_memcpy and __builtin_memset")
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
