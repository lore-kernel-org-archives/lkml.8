Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EFEAC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4790921534
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kVl69r1L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgHaPuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbgHaPuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:50:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165A7C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 08:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=Q2fmjWOqML3J93lLPzsO/5fosKHTpEL7oawS3DEChd0=; b=kVl69r1Ld4MkR6op1ATnOt/IXk
        j8CXY3O+RXHJ9nQvNEg1OyzCkgS+a6EDqfOs+3S5SDOipvPKq1oE8twLkIPdJNd58RL3BUEvZyxFj
        ovFKcDnlnC0QcYCCg76JgkeuPENZjpXFm0pfLOatk03JQh3DFH/Q8wlYUXIiSh6fWH40CT5TANTRQ
        DNMuefopcJTIfqfWdnnF0K754p/6zGa5dgA31gSQg+9pPdM7FL/wFHtpOLqjB/pZCNshvJ2zHqPEw
        B6yyoGJsAwKxFARSCXTKyaandSAMWzggVu5IZtzsc/BKn1owBswlDTtP8ZqZm3gYcIsI2Kzbe+RBA
        fMUICqeg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCm4D-00046g-3e; Mon, 31 Aug 2020 15:49:57 +0000
Subject: Re: [PATCH] drivers: optee: fix i2c build issue
To:     Jorge Ramirez-Ortiz <jorge@foundries.io>, jens.wiklander@linaro.org
Cc:     sumit.garg@linaro.org, tee-dev@lists.linaro.org,
        linux-kernel@vger.kernel.org, ricardo@foundries.io
References: <20200831152359.9122-1-jorge@foundries.io>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <52448a13-f3fd-d9d1-8e1f-e029db91cf5e@infradead.org>
Date:   Mon, 31 Aug 2020 08:49:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200831152359.9122-1-jorge@foundries.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/20 8:23 AM, Jorge Ramirez-Ortiz wrote:
> When the optee driver is compiled into the kernel while the i2c core
> is configured as a module, the i2c symbols are not available.
> 
> This commit addresses the situation by disabling the i2c support for
> this use case while allowing it in all other scenarios:
> 
>  i2c=y, optee=y
>  i2c=m, optee=m
>  i2c=y, optee=m
>  i2c=m, optee=y (not supported)
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> ---
> 
>   This patch applies on top of
>   https://git.linaro.org/people/jens.wiklander/linux-tee.git/tag/?h=optee-i2c-for-v5.10
> 
>  drivers/tee/optee/rpc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> index 64a206c56264..96e91d5f0a86 100644
> --- a/drivers/tee/optee/rpc.c
> +++ b/drivers/tee/optee/rpc.c
> @@ -51,6 +51,7 @@ static void handle_rpc_func_cmd_get_time(struct optee_msg_arg *arg)
>  }
>  
>  #if IS_ENABLED(CONFIG_I2C)
> +#if !defined(CONFIG_I2C_MODULE) || defined(CONFIG_OPTEE_MODULE)

Looks like
#if IS_REACHABLE(CONFIG_I2C)

should work here.

>  static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>  					     struct optee_msg_arg *arg)
>  {
> @@ -140,6 +141,7 @@ static void handle_rpc_func_cmd_i2c_transfer(struct tee_context *ctx,
>  	arg->ret = TEEC_ERROR_NOT_SUPPORTED;
>  }
>  #endif
> +#endif
>  
>  static struct wq_entry *wq_entry_get(struct optee_wait_queue *wq, u32 key)
>  {
> 
	

-- 
~Randy

