Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67072C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390A220678
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 12:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586260827;
	bh=Uqf4rhYga9NNaBB0Dvwp58Stj1GsGS4Ihxkd+ju3McQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=urmh0iroGJD6vD95Qmf1qXsXaMXkL3ImIaQ9o1MKFVYhWoHOvpjbcIuRELTBxA7q9
	 LVKNWaIIM41Ib58Bffjrk4EQxdsCPo5xJXOivBX5kJKpZu8AzxaCzZFztumA27FJgS
	 TnZJWBjw0B2i9HQnho1w7asM75yBbu9I9N1vcDKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728492AbgDGMA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 08:00:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728209AbgDGMAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 08:00:25 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6A6320936
        for <linux-kernel@vger.kernel.org>; Tue,  7 Apr 2020 12:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586260825;
        bh=Uqf4rhYga9NNaBB0Dvwp58Stj1GsGS4Ihxkd+ju3McQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=E935JBusz1dhcXd3k8A7zx8suuSJMLf0ayQTBsmc45RUI8lyhrdrtTnNAJzYj5xNA
         xLcqMb2m5Wkp9tmsyPfaUElwuRYUAtn0Uzc3nJVlsN0CeeXhByB1bPusMB8jCgB2DI
         L1XZSs/zEpyiinCUV/kxNIp6wYGvhhMxZuAOTsN8=
Received: by mail-wr1-f51.google.com with SMTP id p10so3551177wrt.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 05:00:24 -0700 (PDT)
X-Gm-Message-State: AGi0PuZeQC8SISUijGAS2fyZNnBpbwmGdzwOp0lxmBKB/hLDPYT4uEY/
        a3/XKZF1ammc6aITqZ60UzGBrx3KbEy6CLB0kYL4vA==
X-Google-Smtp-Source: APiQypJI+zUUJefqkI1wPoN1P7O6CrZHHpERpheNKfgg8qCaXTmeul5CgCiQbYpjls0Awj/83RzxNXZ+ny+VOSB9RbA=
X-Received: by 2002:a05:6000:1002:: with SMTP id a2mr2399545wrx.151.1586260823114;
 Tue, 07 Apr 2020 05:00:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200406164121.154322-1-samitolvanen@google.com> <20200406164121.154322-13-samitolvanen@google.com>
In-Reply-To: <20200406164121.154322-13-samitolvanen@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Apr 2020 14:00:12 +0200
X-Gmail-Original-Message-ID: <CAKv+Gu9psVBSdUvcRWNrEvjK4ckyA-vGKmZ33O2NUm-Pt4eJig@mail.gmail.com>
Message-ID: <CAKv+Gu9psVBSdUvcRWNrEvjK4ckyA-vGKmZ33O2NUm-Pt4eJig@mail.gmail.com>
Subject: Re: [PATCH v10 12/12] efi/libstub: disable SCS
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 at 18:42, Sami Tolvanen <samitolvanen@google.com> wrote:
>
> Shadow stacks are not available in the EFI stub, filter out SCS flags.
>
> Suggested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>  drivers/firmware/efi/libstub/Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 094eabdecfe6..fa0bb64f93d6 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -32,6 +32,9 @@ KBUILD_CFLAGS                 := $(cflags-y) -DDISABLE_BRANCH_PROFILING \
>                                    $(call cc-option,-fno-stack-protector) \
>                                    -D__DISABLE_EXPORTS
>
> +#  remove SCS flags from all objects in this directory
> +KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
> +
>  GCOV_PROFILE                   := n
>  KASAN_SANITIZE                 := n
>  UBSAN_SANITIZE                 := n
> --
> 2.26.0.292.g33ef6b2f38-goog
>
