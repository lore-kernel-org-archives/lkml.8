Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189F0C10DAA
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9D4E20716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 22:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lJIfcDz7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgICWnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 18:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728294AbgICWnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 18:43:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11154C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 15:43:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m5so3265600pgj.9
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x2xuRKyyLJWi/1UackWdCkMB4cqQZJ4+/7t+T3jGKh8=;
        b=lJIfcDz7WioC0cxPF2mcu4r4CpHJqN+NQMfhDVOZMDBJjVlbujjOIztvgAAg+FLLZl
         OQLArQHvfuAUFWnT+Br9hn0eKYi/T1OqGrNfJkgbHQQkXC6PnVXOP14VrZKCoiAx6sGj
         N08DlYuf2tSmgQZcy/X6jmQw8+vZKntUZzYMc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x2xuRKyyLJWi/1UackWdCkMB4cqQZJ4+/7t+T3jGKh8=;
        b=uV8fJ58DGJlkognzen5m4YHaHjrTCc/K9eACDgABnSXHTpaqLqm/EoAXsDOG4u49tG
         Oyi+CzvbeknTURJX/kqwTPwxvLIWdnMp8QRlL+8fGz0ERgJcuu/tAnb9yHzys7aQXIWb
         Xw9mtUHdQzp1weWxE7TrFg/G/r1zfGMJI3CiM93ITEbBn2c7ggkk4hYn5a1XF9cbapoZ
         Ut2coUfJB3BkvyZQkvIBRbiYbowb9tmb9D5i/hLIPlq1brJ/PqKqfc04ED1dN35VK7L5
         xbCNyR8FXuRkJkuBi6ZEIib56Fm5I6JjxSS95PNa8vu8tZkchHbevn5QOzbVno2mq2j/
         7+iQ==
X-Gm-Message-State: AOAM530lUJ3RPsZYgEzWazb1KpWPvsl9tjS+LqyVOIO0UGL8FjwMiqKO
        dH/qOhFUsK6ZweJrQiOHJQEfOw==
X-Google-Smtp-Source: ABdhPJxsKeiM9lZAcQ/0JJhv0k/hyo346z/156yZaTdrOqzHtGfq/qkV1ZHNDgZ+unL1v+eZfT0LrA==
X-Received: by 2002:a17:902:326:: with SMTP id 35mr6096909pld.1.1599173018675;
        Thu, 03 Sep 2020 15:43:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w16sm4354057pfq.13.2020.09.03.15.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 15:43:37 -0700 (PDT)
Date:   Thu, 3 Sep 2020 15:43:37 -0700
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
Subject: Re: [PATCH v2 20/28] efi/libstub: disable LTO
Message-ID: <202009031543.47CF616F@keescook>
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200903203053.3411268-1-samitolvanen@google.com>
 <20200903203053.3411268-21-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903203053.3411268-21-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 01:30:45PM -0700, Sami Tolvanen wrote:
> With CONFIG_LTO_CLANG, we produce LLVM bitcode instead of ELF object
> files. Since LTO is not really needed here and the Makefile assumes we
> produce an object file, disable LTO for libstub.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
