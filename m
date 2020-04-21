Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C08B8C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98282206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:11:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZmEwJudQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDUULI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDUULI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:11:08 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85A1C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:11:06 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k18so5676320pll.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rg/1A+4U43U5EOL/v/NgygBVRBFD+ceNMw+8mO/ZlOk=;
        b=ZmEwJudQDGKZFuCSnCwtR86q2s8RKjSon9tq3AuCGHEaBUNiQ8YI+0bvvY45gEbwlQ
         GiXTW2fXH2ohgAytkoyexl0jRRRW043BeKNlTSiWDrBasnSYOrQedwoITgWkIr4tPLJB
         +up6P0ZW7q4qNQ8IVm9qtNx8XJv2iRTlbv348=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rg/1A+4U43U5EOL/v/NgygBVRBFD+ceNMw+8mO/ZlOk=;
        b=J5ysapDkEAZ/mj82pEC2cTUb2UJSndnk8fTdsOffddmCYKaoRkxni3QscFUe89yamg
         p77EUyMFhigX1Ng/UVWc9FCCHn6H1jyy37ZKhsB7n370p8f66tqRZPQH2yZIwrBthjQF
         ZuN1eCde6RepO4g2Sb1PDxwEU4KICKgM/6nCJeSy4CXWgd1irxpX/pbKlfaXjyZUD8DT
         9n15U9kI0KjOvPWwM7J1jM2Tjw2DviuWdKmxs0mbxfBbVKOCKBavX3GQ2x2Z2IgAQkF3
         1Yd4z61g6MRVuEpV0wNTCjt4kbr5MiNFRRGFoejYKqIllS+3/HYpKsL/j9i9Nghsgz0T
         VfIg==
X-Gm-Message-State: AGi0PuaUiMLyIX7LKhg4cBIvxqtAc5cde/Bh9qe3jGMbaAHWNhzpmczw
        24kvhbQ1Mn5+bTomB5qMu/5s8Q==
X-Google-Smtp-Source: APiQypLhPhGWbmUH2D5kHI6WIZ08RkqCu0rwC69zV3iN4sy/Bl/alWKpFVYXuyxH5HeV8CuWHxG6BQ==
X-Received: by 2002:a17:90a:ad02:: with SMTP id r2mr5027425pjq.63.1587499866540;
        Tue, 21 Apr 2020 13:11:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p2sm2283072pgh.25.2020.04.21.13.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 13:11:05 -0700 (PDT)
Date:   Tue, 21 Apr 2020 13:11:04 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: Re: [PATCH 0/3] objtool: add support for >64k sections
Message-ID: <202004211310.BF5AE73@keescook>
References: <20200421180724.245410-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421180724.245410-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:07:21AM -0700, Sami Tolvanen wrote:
> This series fixes objtool for binaries with >64k sections, and
> includes optimizations to reduce the runtime for a binary with
> ~130k sections from >15 minutes to ~4 seconds.
> 
> Sami Tolvanen (3):
>   objtool: use gelf_getsymshndx to handle >64k sections
>   objtool: optimize insn_hash for split sections
>   objtool: optimize add_dead_ends for split sections
> 
>  tools/objtool/check.c | 48 ++++++++++++++++++++++++++-----------------
>  tools/objtool/check.h |  9 ++++++++
>  tools/objtool/elf.c   | 24 +++++++++++++++-------
>  tools/objtool/elf.h   |  1 +
>  4 files changed, 56 insertions(+), 26 deletions(-)
> 
> 
> base-commit: ae83d0b416db002fe95601e7f97f64b59514d936

Awesome; thanks for sending these. I suspect they'll help with FGKASLR
as well.

-- 
Kees Cook
