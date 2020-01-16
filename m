Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB9FC33CB7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77EEC246D9
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196834;
	bh=g9FrjlnHZx2YHv0E1GAai0ePZg5VSIR3e6f0Xo8Hfx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=P+4JjsWdkF2ZCyL9VyVxyTdSlvgKyj/RH9JHXllpMlIZMf2oKYEGJzc5jSkqkSBkI
	 G7UdiYKRDHCAVQ9rgEY3yj2DfNKRcUUmYrKnPcIHO407hgsXX187VwlZvKv/oWgh8S
	 uCuX68mfhB+7+ZuniNSYLo7zV7IMtGifLzaNqgA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394135AbgAPRrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:47:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:40120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406834AbgAPRqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:46:55 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F022246E1;
        Thu, 16 Jan 2020 17:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196815;
        bh=g9FrjlnHZx2YHv0E1GAai0ePZg5VSIR3e6f0Xo8Hfx8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRF4GWYwu4KTn0wK6JqSUYnpny+8KzACx6jIDJ17e1cg0wXkOsa42jn5t85QAZqih
         A3g4GB7bOEbx2Pvnmc0VKCx7ssyg6vsPowSMuj3C1wVOP3lttu8Je0Pq7Z6LMwGBeV
         UrfEmujro2DbMUdZu4/vFQ/0C+J7D7cx6Ay07dyA=
Date:   Thu, 16 Jan 2020 17:46:49 +0000
From:   Will Deacon <will@kernel.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 12/15] arm64: vdso: disable Shadow Call Stack
Message-ID: <20200116174648.GE21396@willie-the-truck>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20191206221351.38241-1-samitolvanen@google.com>
 <20191206221351.38241-13-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206221351.38241-13-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 02:13:48PM -0800, Sami Tolvanen wrote:
> Shadow stacks are only available in the kernel, so disable SCS
> instrumentation for the vDSO.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
> index dd2514bb1511..a87a4f11724e 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -25,7 +25,7 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING
>  
>  VDSO_LDFLAGS := -Bsymbolic
>  
> -CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os
> +CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS)

Should we be removing -ffixed-x18 too, or does that not propagate here
anyway?

Will
