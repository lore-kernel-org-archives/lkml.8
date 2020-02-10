Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2F5EC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 898C621739
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:50:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="q5bW3e8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBJJus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:50:48 -0500
Received: from ozlabs.org ([203.11.71.1]:59425 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgBJJus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:50:48 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48GLkX74C9z9s3x;
        Mon, 10 Feb 2020 20:50:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1581328246;
        bh=/99kW1JQGU81EUDk9dEhG3syiErSyCdbWBPlGCa1TtU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=q5bW3e8G2nPTRl3I1hb/mWWlvFYW/MohWC7bBx/YnxetK3mITRksR+nJtKXr5mqRq
         RM7h5SOiDScKEdK9Oe4022L9Mgt6eW73TEwuflc6wigMz3FMh4QdW5mM2fJrqCERma
         CB7sMtQgAONga+wTyXpyEMX3+zOHBiHn5oYx73MlffakkdCPmROVmDsl8jzPlcnBjO
         517gziquLB6h9vLGSl3oQCZPrsJhlxCdkL/q7Cw5WRBHnX6/o74oVsNC7/m6uWvLGs
         00qRanXg2+kwdIxsr+hsB2WmyVkJ8nGFaTBrXUd2dzD+bY5gtILYSpL9RpF8vZ4a3X
         Zft2yhwhz+nqw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tools/bootconfig: Fix wrong __VA_ARGS__ usage
In-Reply-To: <158108370130.2758.10893830923800978011.stgit@devnote2>
References: <87o8ua1rg3.fsf@mpe.ellerman.id.au> <158108370130.2758.10893830923800978011.stgit@devnote2>
Date:   Mon, 10 Feb 2020 20:50:42 +1100
Message-ID: <87y2tazs7h.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <mhiramat@kernel.org> writes:
> Since printk() wrapper macro uses __VA_ARGS__ without
> "##" prefix, it causes a build error if there is no
> variable arguments (e.g. only fmt is specified.)
> To fix this error, use ##__VA_ARGS__ instead of
> __VAR_ARGS__.
>
> Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
> Reported-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/bootconfig/include/linux/printk.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/bootconfig/include/linux/printk.h b/tools/bootconfig/include/linux/printk.h
> index 017bcd6912a5..e978a63d3222 100644
> --- a/tools/bootconfig/include/linux/printk.h
> +++ b/tools/bootconfig/include/linux/printk.h
> @@ -7,7 +7,7 @@
>  /* controllable printf */
>  extern int pr_output;
>  #define printk(fmt, ...)	\
> -	(pr_output ? printf(fmt, __VA_ARGS__) : 0)
> +	(pr_output ? printf(fmt, ##__VA_ARGS__) : 0)
>  
>  #define pr_err printk
>  #define pr_warn	printk

Tested-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
