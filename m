Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5DBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E18CC2078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fMuNysL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgHZPbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgHZPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:31:31 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C3DC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:31:30 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w186so1197527pgb.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9zs23ZhZ8ODz+nwQb6O4UO1P/7U3n6533OiIueYs3+4=;
        b=fMuNysL9TRE9tjmnJj7r871P+3ghVsjGqk6g7RFH/IMtzNKXM0FISK5rAJ/OiHsYza
         rFrCws4uMg3/z/CeginhE5eK1vSkV2xXtEH4MX0f7MVYE3ra3I8AdosYGwQdeejofVMH
         B47IJdSMOhiEr2mcypKdSVI9cDZ3sDdqfl2jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9zs23ZhZ8ODz+nwQb6O4UO1P/7U3n6533OiIueYs3+4=;
        b=rq57ZAUlP3klaJ5avUM9fZ0e/KROjT15iZuHL1M9mmiqG6ccH63v/7A4HQSnN6/t88
         bnpJ0jafE+E5VtEanEv0rxp5JsQ0Sr3eXa2h1A/yOPhuF15vA6QqZXZWLKqUNlTY/sTF
         uwcRDcsXha6rOxtoE69EXlax+yreGJ5lT4Ji4y4ni9a7Pq4vb1aGvh5E17AwmJTIXHJx
         JtcD6j18W5U9ahO4GoDf8LA9JASpxDLLIjwjQMbCm4y7ZLg+hC/bBaIDgOQ8ihcJst8h
         XTIEI5+uledSumgtSbJzpRQrphp5xZ+I82VbXnBAnlfb7BRgECHzKdomlKRZtrxaA32q
         3IbA==
X-Gm-Message-State: AOAM531482c2zpvwc4L0veCbqwk2j1eQdru70oQ34uKe0IwRcXllji8c
        SCS/t3Pow6IuBB1p4VkH1lx0fA==
X-Google-Smtp-Source: ABdhPJww4NdRyKAu7yXQIwgpisUvht3AHwC/Rz7IL1gREdefK8/VL//78URle+k83Q4oxX3OrEJTeg==
X-Received: by 2002:a63:f305:: with SMTP id l5mr10176512pgh.421.1598455889714;
        Wed, 26 Aug 2020 08:31:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j14sm2487110pgl.48.2020.08.26.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 08:31:28 -0700 (PDT)
Date:   Wed, 26 Aug 2020 08:31:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>, Will Deacon <will@kernel.org>,
        Borislav Petkov <bp@suse.de>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        clang-built-linux@googlegroups.com, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: add minimum clang/llvm version
Message-ID: <202008260830.A10CCF80F@keescook>
References: <20200825222552.3113760-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825222552.3113760-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 03:25:51PM -0700, Nick Desaulniers wrote:
> Based on a vote at the LLVM BoF at Plumbers 2020, we decided to start
> small, supporting just one formal upstream release of LLVM for now.
> 
> We can probably widen the support window of supported versions over
> time.  Also, note that LLVM's release process is different than GCC's.
> GCC tends to have 1 major release per year while releasing minor updates
> to the past 3 major versions.  LLVM tends to support one major release
> and one minor release every six months.
> 
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Yay! :)

With the typo Will found fixed:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
