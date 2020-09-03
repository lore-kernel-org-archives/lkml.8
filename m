Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF4C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E62B20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zx5KJ4dv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgICWpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbgICWpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:45:34 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DCDC061247
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 15:45:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 17so3493762pfw.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LpH2+c3Q5/rnXgDQMsrsJ9HiSsfoyzj1qvyyccEruIs=;
        b=Zx5KJ4dvVR2kYJ0RF1K2y79qhIcjc7yrsCRJoTz5s2zCxiKL8II6gShD3dRiuI5JuE
         CAqlIg/RCYIqxwgBTCdJCoxlCyAR33IC7dws/kSOZM0OWTmWQqku5KG5vBN3wHaXWX2J
         L3kWlvlx6YmS4Z9tOt3VwHxiD169ei5sQPoz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LpH2+c3Q5/rnXgDQMsrsJ9HiSsfoyzj1qvyyccEruIs=;
        b=SjRYMp0DJVfG19KD1ahUci288tP97AELRwt9MBCv8jQicvCWWzTX5Xgq9NdLj8YehX
         3TCwBH8bsbJJwxfemvarHQS0nUoxCfD5nytj0y/Io2uC+CYkkz8pUiFLuW5J03QPdrSb
         +CsutqPz7G6E5cG6PSl44eo93YgVkDLcfhCJK5tDxd8bN6VxZMjafBW+JSNZfou3uIvi
         QB54MwpQ0YX0Lrv73OlQFpTcG4nvjZ9oCR+ypjbSN0edPn3GayDCxwATuTnWCPtXPnll
         A6wHOf53J92X8d0UEFegevg3rX/F20kxQ8RpEOv6+RARb0i7bQLFDAa75oQLpFht5SYb
         K5nQ==
X-Gm-Message-State: AOAM533nz0BDWIUX31IZyl7Cp+0DR6sFvgTaegcnMbqAjPOrHVXwEGHE
        2BvkVXDBS9PbNL2G/ZcEwnVt7Q==
X-Google-Smtp-Source: ABdhPJw+gsOOUY6Clu21aqvi2zeFtbK32caDaCf93/U25KjvZIefQe4UypsHJhKhOKzenMYzI/0+7Q==
X-Received: by 2002:a17:902:82c7:: with SMTP id u7mr1398150plz.240.1599173133340;
        Thu, 03 Sep 2020 15:45:33 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r123sm4320262pfc.187.2020.09.03.15.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:45:32 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:45:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2 24/28] KVM: arm64: disable LTO for the nVHE directory
Message-ID: <202009031545.42ECDC8F7F@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-25-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-25-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:49PM -0700, 'Sami Tolvanen' via Clang Built Linux wrote:
> We use objcopy to manipulate ELF binaries for the nvhe code,
> which fails with LTO as the compiler produces LLVM bitcode
> instead. Disable LTO for this code to allow objcopy to be used.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
