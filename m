Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7063C433E2
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90C0F2072D
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 13:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfHARBM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgIENZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Sep 2020 09:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbgIENZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 09:25:38 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E52CC061244
        for <linux-kernel@vger.kernel.org>; Sat,  5 Sep 2020 06:25:38 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 7so5746703pgm.11
        for <linux-kernel@vger.kernel.org>; Sat, 05 Sep 2020 06:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RpTYqJDfCzMfPyaa3uIZG/zj/iG+ilw7s8rADz0kWtk=;
        b=SfHARBM3j8jhbV/5LA1/aP7kB9hdvJOSeRFtFowLgNAgQBaynONoaFZwb9HUjHEVfC
         wcmY7jTzvISdB3K+kKP5J4+t5d/nQ8ru0OERRUs2DsqodpY0rGZu+Om5ZnsTvEM4QjVD
         kvDB/rT7URWrZf61T1OSCS8+FZen8oVEFqHwdfNChGnbwy36AGdeu8pM2kyTZO7YPiSQ
         hL2KzX39FTZutU3lXDywSWHc6ojkUH2SPFaEZrwTf2gMPUCKIVdheQX2LwqxjUn3E1L1
         6zxhPanhEQGuMgrvvE2+AFDF0yo+4I3Rh3J/+mYwX/ho9TkN7lwzN73njlATavMqkEoi
         m4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RpTYqJDfCzMfPyaa3uIZG/zj/iG+ilw7s8rADz0kWtk=;
        b=uEbXkJHdNMD51Yo5Ydu2jsW19zVI6UEH6Rvi1GCrsXTnpOZljOMbPfYmGKXeixlxw/
         f3jVnPEwvMrpkM12rubRdn2BsochF7WaIFjakGCjAErVSkx57x3E8LQsIkvA0fHlQTyt
         sJtK4enoESCxk7b6b+tO8jo4Rua+3OAkQ6pW3qDzU6E7hMtfMzbz2LlF2zMc6ojLlzjA
         6jSrOPkIqSRZVo0tc2HJ0bKHMN+qDEE9DQy/eYEeOkCJ+DwQAO8CmnAjEJpLSNQlXbVf
         /yTgLXJwNFVURD426aQCrfLy4FM4YH+LtBqVaFpY/DJbHSz4B1nOlKcV4lFF2+pAIM6Z
         JaXw==
X-Gm-Message-State: AOAM532zG3sh8c6DEc8yiN8GqBfuXl9iM0QCYRwmHtVYK7AO+anB8wb0
        56iLVv/3QM/1IGNyG0Bn5sWC/oo1eunOYQ==
X-Google-Smtp-Source: ABdhPJzliTb1mfI3tkyrpWY3Qs/hrlwMGgtll10Q3LnFdyJL2Wgap5r1lHol6UW3u5qjIgB+mjgDpg==
X-Received: by 2002:a63:1226:: with SMTP id h38mr10662767pgl.196.1599312337504;
        Sat, 05 Sep 2020 06:25:37 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id j14sm5414362pjz.21.2020.09.05.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2020 06:25:36 -0700 (PDT)
Date:   Sat, 5 Sep 2020 22:25:34 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Mike Rapoport <rppt@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 1/3] openrisc: Reserve memblock for initrd
Message-ID: <20200905132534.GH3562056@lianli.shorne-pla.net>
References: <20200905131935.972386-1-shorne@gmail.com>
 <20200905131935.972386-2-shorne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200905131935.972386-2-shorne@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 05, 2020 at 10:19:33PM +0900, Stafford Horne wrote:
> Recently OpenRISC added support for external initrd images, but I found
> some instability when using larger buildroot initrd images. It turned
> out that I forgot to reserve the memblock space for the initrd image.
> 
> This patch fixes the instability issue by reserving memblock space.
> 
> Fixes: ff6c923dbec3 ("openrisc: Add support for external initrd images")
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
Forgot to mention:

Changes since v1:
  - Updated to use separate variables as suggested by Mike.

>  arch/openrisc/kernel/setup.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
> index b18e775f8be3..13c87f1f872b 100644
> --- a/arch/openrisc/kernel/setup.c
> +++ b/arch/openrisc/kernel/setup.c
> @@ -80,6 +80,16 @@ static void __init setup_memory(void)
>  	 */
>  	memblock_reserve(__pa(_stext), _end - _stext);
>  
> +#ifdef CONFIG_BLK_DEV_INITRD
> +	/* Then reserve the initrd, if any */
> +	if (initrd_start && (initrd_end > initrd_start)) {
> +		unsigned long aligned_start = ALIGN_DOWN(initrd_start, PAGE_SIZE);
> +		unsigned long aligned_end = ALIGN(initrd_end, PAGE_SIZE);
> +
> +		memblock_reserve(__pa(aligned_start), aligned_end - aligned_start);
> +	}
> +#endif /* CONFIG_BLK_DEV_INITRD */
> +
>  	early_init_fdt_reserve_self();
>  	early_init_fdt_scan_reserved_mem();
>  
> -- 
> 2.26.2
> 
