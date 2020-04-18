Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A47C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 00:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF6F320857
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 00:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="DxOAiy05"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbgDRAWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 20:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbgDRAWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 20:22:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DFBC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 17:22:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id kb16so1782974pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 17:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=afxKpHVPJ9OCNJjnzznWMPUeHi7w37qRBk8EQYOsjnM=;
        b=DxOAiy05X+29I8lWqeIvpPOcZiu4xGocSRX1lH03Tu0XGDnfF8dpp6MxjdXvA89wdt
         RlFc+beNI9S9jO54AYMy30tvXF/arxKwQvwCpfLIyaRKUxVXdOQ2Wu4gqH9NRxl7kIAG
         InJXSF/aqskcmEzOsmvKDuGGl1h0tr1pGCCeqtanShIUoonEoJGQnT9Mry6fIuCn4lc6
         XfNMxm0bUnJA1CT8qLFzutbpXXLgNj5YVoQE4Npx7I2WkS19v0/ez2MkV3pMv008GauA
         2J3XUF3WCu8dGmcnZrIl5o9513W/EQVPcUTDiJeglb4Rs3dNRktilOL1XFELMk2LAd7J
         GoXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=afxKpHVPJ9OCNJjnzznWMPUeHi7w37qRBk8EQYOsjnM=;
        b=NO78zItboHIPSmtMv/tBJ3UOg+ey/35HuFkPpqEgQDn+VrZSJAMQIx6S4t4EPKQuzg
         SRkMbYmYoOFOJ4Jg7AwdBRHGWJcEdmJGUuYsvJwdCAIkUeFJ7sC+Hp5aNq/JsaLqoPze
         AmKMvpMA5WXdlV5GjPCiqfTJInSgTAEWKyJxqzretRHHv+GfgndSACTEjUaVotwztbjS
         hj9GJ5lc/RO8m30DM71wOEti+9vzF7zzIF8JpZt6wABmbRdwtF7en/jKjd2IJ87KTvJo
         SQJNkpfdEnd+f3enTFCHRqVBbHWOaCNGI6o5hwrPc6nSV7o2T+W/Z0DV3TPnRfq2pHgp
         Z5BA==
X-Gm-Message-State: AGi0PuZRD91eGUJ3dAwoN/ylAlW63fFYSS9kjPxXN48OiRoMmdIsuTaE
        HqguIM2YqwXVTAC7NMUhMrX2Mw==
X-Google-Smtp-Source: APiQypJODew0rL5ev8Z0CEdigTLWWwDg8051oBwyl6A851EcA+/LZ73fUL78Y5zPuNN6kuKO5OX09Q==
X-Received: by 2002:a17:90b:380d:: with SMTP id mq13mr7281871pjb.145.1587169365190;
        Fri, 17 Apr 2020 17:22:45 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 18sm20943127pfv.118.2020.04.17.17.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 17:22:44 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:22:44 -0700 (PDT)
X-Google-Original-Date: Fri, 17 Apr 2020 17:02:23 PDT (-0700)
Subject:     Re: [PATCH v5 1/9] riscv: add macro to get instruction length
In-Reply-To: <621303b9cdea215af57329b401b15750c1f683ab.1586332296.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        mhiramat@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-7b1c250c-84ed-4432-816a-5a1ac6d0a7e3@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Apr 2020 00:56:56 PDT (-0700), zong.li@sifive.com wrote:
> Extract the calculation of instruction length for common use.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/include/asm/bug.h | 8 ++++++++
>  arch/riscv/kernel/traps.c    | 3 ++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
> index 75604fec1b1b..d6f1ec08d97b 100644
> --- a/arch/riscv/include/asm/bug.h
> +++ b/arch/riscv/include/asm/bug.h
> @@ -19,6 +19,14 @@
>  #define __BUG_INSN_32	_UL(0x00100073) /* ebreak */
>  #define __BUG_INSN_16	_UL(0x9002) /* c.ebreak */
>
> +#define GET_INSN_LENGTH(insn)						\
> +({									\
> +	unsigned long __len;						\
> +	__len = ((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) ?	\
> +		4UL : 2UL;						\
> +	__len;								\
> +})
> +
>  typedef u32 bug_insn_t;
>
>  #ifdef CONFIG_GENERIC_BUG_RELATIVE_POINTERS
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index ffb3d94bf0cc..a4d136355f78 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -118,7 +118,8 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
>
>  	if (probe_kernel_address((bug_insn_t *)pc, insn))
>  		return 0;
> -	return (((insn & __INSN_LENGTH_MASK) == __INSN_LENGTH_32) ? 4UL : 2UL);
> +
> +	return GET_INSN_LENGTH(insn);
>  }
>
>  asmlinkage __visible void do_trap_break(struct pt_regs *regs)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
