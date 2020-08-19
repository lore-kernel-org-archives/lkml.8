Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47851207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgHSIrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:47:16 -0400
Received: from foss.arm.com ([217.140.110.172]:58544 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726710AbgHSIrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:47:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EBF941FB;
        Wed, 19 Aug 2020 01:47:12 -0700 (PDT)
Received: from [10.163.66.190] (unknown [10.163.66.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 792383F6CF;
        Wed, 19 Aug 2020 01:47:10 -0700 (PDT)
Subject: Re: [PATCH] mm: Fix missing function declaration
To:     Leon Romanovsky <leon@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jinbum Park <jinb.park7@gmail.com>,
        Kees Cook <keescook@chromium.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20200819080026.918134-1-leon@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <65caa520-c7de-2703-f528-b2b1714ade65@arm.com>
Date:   Wed, 19 Aug 2020 14:16:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200819080026.918134-1-leon@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/19/2020 01:30 PM, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> The compilation with CONFIG_DEBUG_RODATA_TEST set produces the following
> warning due to the missing include.
> 
>  mm/rodata_test.c:15:6: warning: no previous prototype for 'rodata_test' [-Wmissing-prototypes]
>     15 | void rodata_test(void)
>       |      ^~~~~~~~~~~
> 
> Fixes: 2959a5f726f6 ("mm: add arch-independent testcases for RODATA")
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>

This build failure appears only with W=1 and gets fixed with this.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/rodata_test.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/rodata_test.c b/mm/rodata_test.c
> index 2a99df7beeb3..2613371945b7 100644
> --- a/mm/rodata_test.c
> +++ b/mm/rodata_test.c
> @@ -7,6 +7,7 @@
>   */
>  #define pr_fmt(fmt) "rodata_test: " fmt
> 
> +#include <linux/rodata_test.h>
>  #include <linux/uaccess.h>
>  #include <asm/sections.h>
> 
> --
> 2.26.2
> 
> 
> 
