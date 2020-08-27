Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31F1AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE6A20738
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 09:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sd8cSLTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbgH0Jn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 05:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0Jn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 05:43:57 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57620C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:43:56 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id s13so4548291wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 02:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=0Mp4vwB7y9LU8GtwQRrtrye3uKg2KIT3OOAY7NOPu+0=;
        b=sd8cSLTLtYkkZJYoDgr+FWUxOWvMXi5MvokLu2oD5lLWIyg9hbLkzIgwHhFdw4tlPQ
         Q5FjkUc5aUrcRZDht8aIOBOncAVxDEWmVAnzbPYGtuH9nn4RPgcgYsC1wgolLNoQMXh3
         J+aaQVfzd0kZmHmPsmpL3rllIw2XJ5XNQEhE9nswYsXQVFLIWsep38QIzIagYzEQozna
         8m/rpOFVq0ffZ8cseNWZ2Ni2Zlt9KCXeEPGShCoQ0Jyu6eJK6lYviyyWZVUaK2zti1mm
         czg0O9khDtK8M5hKZ+M6nt0QEuJ5zyAq5DEFIGud/FLeGrj1zcHb4wzirEJykcquWMPv
         XDSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=0Mp4vwB7y9LU8GtwQRrtrye3uKg2KIT3OOAY7NOPu+0=;
        b=daE3xhtw+/7M+7WBZ7tPFWETBWTkDreUBwYXLalh1P/BrX6CK1rikoKyXUrfZqUO15
         lrlVUeL0yI+HyBpX3aRnhpdww4vLcTGUUe8fMZ+UZ6leSi/rD7RCBiKVySl7D1UpzGbb
         jsmrUgTjsJogkpt3J2b94CVy/M3mOQbo5M6jgjHBaLnO/pmnq3HjRPe9VOtA3JGboAfr
         Dpg+HRGevmIJ2/HiYdzPXl82SYoiZQqQTqUAUwJNzt0ay3CWYa8AeUJ9XtJOH+FN9kLY
         nL/3ZO9WuoX0uSxNsUn5XTTVTlH6dCIirpQN8Pj7YpU586g6Oj+9gworeqLD6z+F/NJj
         R3Sg==
X-Gm-Message-State: AOAM530BGfs1ZfKrsGHvavfW4bXwqw6uDZABRfhc3H8LYEirHmnVhdSI
        3hS4QjwF2MWAd7BkoXy6/OI=
X-Google-Smtp-Source: ABdhPJzHbaO7j+S6dZhZHa8jn7wWSY0SjT/CyHpx8DgKmaMmjFWA1ZsANehPNT7ssJULncGvZv+maA==
X-Received: by 2002:a7b:c04a:: with SMTP id u10mr10662824wmc.46.1598521435021;
        Thu, 27 Aug 2020 02:43:55 -0700 (PDT)
Received: from felia ([2001:16b8:2d0c:fc00:340b:71b8:4541:aa75])
        by smtp.gmail.com with ESMTPSA id 128sm3965741wmz.43.2020.08.27.02.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 02:43:54 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Thu, 27 Aug 2020 11:43:53 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add LLVM maintainers
In-Reply-To: <20200825143540.2948637-1-ndesaulniers@google.com>
Message-ID: <alpine.DEB.2.21.2008271137040.25858@felia>
References: <20200825143540.2948637-1-ndesaulniers@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Aug 2020, 'Nick Desaulniers' via Clang Built Linux wrote:

> Nominate Nathan and myself to be point of contact for clang/LLVM related
> support, after a poll at the LLVM BoF at Linux Plumbers Conf 2020.
> 
> While corporate sponsorship is beneficial, its important to not entrust
> the keys to the nukes with any one entity. Should Nathan and I find
> ourselves at the same employer, I would gladly step down.
>

Please only step down if someone else is there to step up, though.
I rather trust two people in one company than just one person in one 
company...

> Cc: clang-built-linux@googlegroups.com
> Cc: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I certainly support to have two compilers building the kernel! It opens a 
number of interesting options on code analysis and verification work.

Acknowledging that Clang-Built Linux exists and is WELL supported by Nick 
and Nathan is on point and well deserved.

Acked-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

I hope to continue to see the community grow, and clang warnings decrease :)

Keep up the good work.

Lukas

> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 33aab0c88118..0cbb24753153 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4249,6 +4249,8 @@ S:	Maintained
>  F:	.clang-format
>  
>  CLANG/LLVM BUILD SUPPORT
> +M:	Nathan Chancellor <natechancellor@gmail.com>
> +M:	Nick Desaulniers <ndesaulniers@google.com>
>  L:	clang-built-linux@googlegroups.com
>  S:	Supported
>  W:	https://clangbuiltlinux.github.io/
> -- 
> 2.28.0.297.g1956fa8f8d-goog
> 
> -- 
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200825143540.2948637-1-ndesaulniers%40google.com.
> 
