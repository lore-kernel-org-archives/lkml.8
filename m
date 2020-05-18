Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2353C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D93C207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 09:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1TMree/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgERJbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 05:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbgERJbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 05:31:19 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE863C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:31:19 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id y85so3628576oie.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O6tYQNQfN78A6bzbWtio5TYkldgCYo0BB7b2XSCJBMk=;
        b=T1TMree/1YLPWrkoq6Z8petN+kO36f1BK6/qBviVqTSj9mMWyqRORWclISpps35h+/
         IHe9pE5b/ZaRNkXr0REpmeeIDYWGMV93n/BLobJQoC1iLbLzsbwnHUCiyVsiIGI+CtL9
         KOalfjWxuoYgUhalQOGVHrfPz4xk0ToUQg0YMjUzVzyHlGT+5v6A+LNVcaCo5bcRX/8O
         HTbJTb+WrRhkreT8gS2wx9VuY2dYFxjMiqUP//uChmfa99BM8Orc4a+a7RxNP5/3ypuu
         WyJNHUsDXlYGIVcpZN+0Ysny7s1mHbOIAI7i9c98HVoCJnS2ru6+zQzdG+yXrhHRGPgh
         DreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O6tYQNQfN78A6bzbWtio5TYkldgCYo0BB7b2XSCJBMk=;
        b=p3Be0gUq4xslbGP/RMeNFLRaDWiAz9SL6vkHh0zM2UwODLtWz4cS4AAWLNAKoSFx58
         YEmZlDwtnOL1YG1dcoZGVGISWTvelGbaz8Fg+cTAZljrFtyz9+QNLBXFLudQRKojZOvi
         S4GBTgo2oyChr7gdCwOPNiLQcbd6NPHXROicFsOMeLDKVlba97NxpWnc5W8161bFl53P
         EDlip+MaM4UM/MKCAdUzNHn5ii1CNRPJRjMb1O+p9/D5SVvw47jigot1+NaPzOf+fKhy
         vKdbmO6C9c1OByvx4FG+JJ2TFQGInUL5HVqLWfvzA6a/dmkoJhMzez8SxISgw/1YXrfA
         0Twg==
X-Gm-Message-State: AOAM532PEfRJHbqOg0oiCkFvhoCUGyhWaVDQTeps4HGGxfL4uU4xs28S
        +e8WsS/JTdyWhV9nxkl8rA4BGMjs
X-Google-Smtp-Source: ABdhPJzKm7BZT5vgWhPubWJimcr9S3wPHuSJt7UgfTouHp6vSHFYodla2PbiA01meAkR+JRV9bEvoA==
X-Received: by 2002:aca:f551:: with SMTP id t78mr10568633oih.24.1589794279115;
        Mon, 18 May 2020 02:31:19 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id s69sm2810432otb.4.2020.05.18.02.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 02:31:18 -0700 (PDT)
Date:   Mon, 18 May 2020 02:31:17 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        clang-built-linux@googlegroups.com,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] x86: mmiotrace: Use cpumask_available for cpumask_var_t
 variables
Message-ID: <20200518093117.GA719849@ubuntu-s3-xlarge-x86>
References: <20200408205323.44490-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408205323.44490-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 01:53:23PM -0700, Nathan Chancellor wrote:
> When building with Clang + -Wtautological-compare and
> CONFIG_CPUMASK_OFFSTACK unset:
> 
> arch/x86/mm/mmio-mod.c:375:6: warning: comparison of array 'downed_cpus'
> equal to a null pointer is always false [-Wtautological-pointer-compare]
>         if (downed_cpus == NULL &&
>             ^~~~~~~~~~~    ~~~~
> arch/x86/mm/mmio-mod.c:405:6: warning: comparison of array 'downed_cpus'
> equal to a null pointer is always false [-Wtautological-pointer-compare]
>         if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
>             ^~~~~~~~~~~    ~~~~
> 2 warnings generated.
> 
> Commit f7e30f01a9e2 ("cpumask: Add helper cpumask_available()") added
> cpumask_available to fix warnings of this nature. Use that here so that
> clang does not warn regardless of CONFIG_CPUMASK_OFFSTACK's value.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/982
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/x86/mm/mmio-mod.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
> index 109325d77b3e..43fd19b3f118 100644
> --- a/arch/x86/mm/mmio-mod.c
> +++ b/arch/x86/mm/mmio-mod.c
> @@ -372,7 +372,7 @@ static void enter_uniprocessor(void)
>  	int cpu;
>  	int err;
>  
> -	if (downed_cpus == NULL &&
> +	if (!cpumask_available(downed_cpus) &&
>  	    !alloc_cpumask_var(&downed_cpus, GFP_KERNEL)) {
>  		pr_notice("Failed to allocate mask\n");
>  		goto out;
> @@ -402,7 +402,7 @@ static void leave_uniprocessor(void)
>  	int cpu;
>  	int err;
>  
> -	if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
> +	if (!cpumask_available(downed_cpus) || cpumask_weight(downed_cpus) == 0)
>  		return;
>  	pr_notice("Re-enabling CPUs...\n");
>  	for_each_cpu(cpu, downed_cpus) {
> 
> base-commit: ae46d2aa6a7fbe8ca0946f24b061b6ccdc6c3f25
> -- 
> 2.26.0
> 

Gentle ping for acceptance, I am not sure who should take this.

Cheers,
Nathan
