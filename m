Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8B1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6425F206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 23:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HYbrvo/x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgGHX0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 19:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHX0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 19:26:11 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFD7C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 16:26:11 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 72so41822ple.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 16:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nH2GS/OTrvCduU0b8tDpOcN6ehsAwEU0onRF+A5Ut5k=;
        b=HYbrvo/xF79bO2B6IrkMMLUkmjKPzdJkvanrMInp8S42k6HBGtzvlMd9S1UMsOPkQq
         kD96OG7jPioQJwVhmcN6AkeMW4/SHyENEHjDe4IuQjxeLq714wlZHE3s1cGSQxT8Jbv7
         MrPitnx0OcckBdRzsOFubqaRZyUAfYAh/ym5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nH2GS/OTrvCduU0b8tDpOcN6ehsAwEU0onRF+A5Ut5k=;
        b=Xcw3ogIzlmaJhowvBUQcmUeottRmgArUZCYDrzps63ALB6Pa44yHX6d+bOcaAR/F3b
         of1qiP9zhPGaE2zlFWDzGUs8EePwZlrUsCOxdbZaUZooKyL4O0NE9NZFRTgqoV58BKTf
         HOrvXUguRJrE3xbm0JQQPJSnyDK4DbbcOvKvDuSMSD38aJMUw/yikmaoSZqgpCuLi8Ff
         uAAwMMIoQwkAMoMTyHhnj5P+jBvrt5Bwk14mabMQkhrRaBPXpsdumMN8U/HgZMqP/0pZ
         g5mS6gUEr6BZYtfu2Ula4sor17koGY8zovNzXDN5T/8nv6M/WVr3d5pjD6hO+j/RNh6R
         Ow+Q==
X-Gm-Message-State: AOAM5317/jpT5GfX3T4uV9hHjYtc0cclBuqIKbVLHvm7QIRrgTSAeF4O
        +tnHE3LyrTqaeseudgksDvd4lQ==
X-Google-Smtp-Source: ABdhPJzniWV9Twx/MX+UzsIO+dG+AvwC8/i/kZk/gvvqhaDExjNsUdeEEAP66hKEdkwugkIW4si31A==
X-Received: by 2002:a17:90a:780f:: with SMTP id w15mr11778381pjk.235.1594250771013;
        Wed, 08 Jul 2020 16:26:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i128sm759010pfe.74.2020.07.08.16.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:26:10 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:26:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Juxin Gao <gaojuxin@loongson.cn>
Subject: Re: [PATCH] MIPS: Prevent READ_IMPLIES_EXEC propagation
Message-ID: <202007081624.82FA0CC1EA@keescook>
References: <1594114741-26852-1-git-send-email-yangtiezhu@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594114741-26852-1-git-send-email-yangtiezhu@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 05:39:01PM +0800, Tiezhu Yang wrote:
> In the MIPS architecture, we should clear the security-relevant
> flag READ_IMPLIES_EXEC in the function SET_PERSONALITY2() of the
> file arch/mips/include/asm/elf.h.
> 
> Otherwise, with this flag set, PROT_READ implies PROT_EXEC for
> mmap to make memory executable that is not safe, because this
> condition allows an attacker to simply jump to and execute bytes
> that are considered to be just data [1].
> 
> In mm/mmap.c:
> unsigned long do_mmap(struct file *file, unsigned long addr,
> 			unsigned long len, unsigned long prot,
> 			unsigned long flags, vm_flags_t vm_flags,
> 			unsigned long pgoff, unsigned long *populate,
> 			struct list_head *uf)
> {
> 	[...]
> 	if ((prot & PROT_READ) && (current->personality & READ_IMPLIES_EXEC))
> 		if (!(file && path_noexec(&file->f_path)))
> 			prot |= PROT_EXEC;
> 	[...]
> }
> 
> By the way, x86 and ARM64 have done the similar thing.
> 
> After commit 250c22777fe1 ("x86_64: move kernel"), in the file
> arch/x86/kernel/process_64.c:
> void set_personality_64bit(void)
> {
> 	[...]
> 	current->personality &= ~READ_IMPLIES_EXEC;
> }
> 
> After commit 48f99c8ec0b2 ("arm64: Preventing READ_IMPLIES_EXEC
> propagation"), in the file arch/arm64/include/asm/elf.h:
> #define SET_PERSONALITY(ex)						\
> ({									\
> 	clear_thread_flag(TIF_32BIT);					\
> 	current->personality &= ~READ_IMPLIES_EXEC;			\
> })
> 
> [1] https://insights.sei.cmu.edu/cert/2014/02/feeling-insecure-blame-your-parent.html
> 
> Reported-by: Juxin Gao <gaojuxin@loongson.cn>
> Co-developed-by: Juxin Gao <gaojuxin@loongson.cn>
> Signed-off-by: Juxin Gao <gaojuxin@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

This seems correct to me.

Reviewed-by: Kees Cook <keescook@chromium.org>

BTW, does MIPS also need similar changes to this series:
https://lore.kernel.org/lkml/20200327064820.12602-1-keescook@chromium.org/

Quoting from there "MIPS may need adjusting but the history of CPU
features and toolchain behavior is very unclear to me."

-- 
Kees Cook
