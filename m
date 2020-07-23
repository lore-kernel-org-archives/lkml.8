Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B1DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4301620771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CeYogT9e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbgGWOXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgGWOXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:23:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D06C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 07:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=fd23tMQ4fScQVgcj20AlO1yCA9h4LPjFStij0v1Yu5U=; b=CeYogT9eTNmmAHwL/FSrc5y4pP
        ZKr9+eb6oYAgoi83p8vGg1EQ/Q8e3r6BjNrUx2XcRYmLtSwgY6sri/RvN9jFBpoSozSVaK2H93Oxc
        EjyhGPc47RX/wYp9ocKfb5EQamC+aAvUTP5fcIwGCzyMZ07L/9z8WLGPaVKaPNsl84WJaLsDDjgUN
        ZBEvaEIhln5LKtaqVEVu9RppdVAqTTUmTTtqInChZVTuZcVVo0XD29EcIYvRNsxsEO6p6BQ3X0LMA
        zbBaelghCNqoK5bEvhJDOtSTGbBdU7UgURXXj6iiDe403RU5ZF6XCI8RAgxWjRfsVGbtiiky1iFu1
        oF58oY7Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyc7d-0006As-B6; Thu, 23 Jul 2020 14:22:57 +0000
Subject: Re: [PATCH] lib: Verify array index is correct before using it
To:     Huang Guobin <huangguobin4@huawei.com>, haren@us.ibm.com,
        ddstreet@ieee.org, herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org
References: <20200723134807.35027-1-huangguobin4@huawei.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <08cc095f-bf31-c4e3-0658-f4dfec1d4958@infradead.org>
Date:   Thu, 23 Jul 2020 07:22:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723134807.35027-1-huangguobin4@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 6:48 AM, Huang Guobin wrote:
> This code reads from the array before verifying that "c" is a valid
> index. Move test array offset code before use to fix it.
> 
> Fixes: 2da572c959dd ("lib: add software 842 compression/decompression")
> Signed-off-by: Huang Guobin <huangguobin4@huawei.com>

Hi,
Why shouldn't these locations use array_index_nospec() from
#include <linux/nospec.h>
?


> ---
>  lib/842/842_compress.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/842/842_compress.c b/lib/842/842_compress.c
> index c02baa4168e1..10f9f8a0d05b 100644
> --- a/lib/842/842_compress.c
> +++ b/lib/842/842_compress.c
> @@ -222,12 +222,13 @@ static int add_bits(struct sw842_param *p, u64 d, u8 n)
>  static int add_template(struct sw842_param *p, u8 c)
>  {
>  	int ret, i, b = 0;
> -	u8 *t = comp_ops[c];
> +	u8 *t = NULL;
>  	bool inv = false;
>  
>  	if (c >= OPS_MAX)
>  		return -EINVAL;
>  
> +	t = comp_ops[c];
>  	pr_debug("template %x\n", t[4]);
>  
>  	ret = add_bits(p, t[4], OP_BITS);
> @@ -379,12 +380,14 @@ static int add_end_template(struct sw842_param *p)
>  
>  static bool check_template(struct sw842_param *p, u8 c)
>  {
> -	u8 *t = comp_ops[c];
> +	u8 *t = NULL;
>  	int i, match, b = 0;
>  
>  	if (c >= OPS_MAX)
>  		return false;
>  
> +	t = comp_ops[c];
> +
>  	for (i = 0; i < 4; i++) {
>  		if (t[i] & OP_ACTION_INDEX) {
>  			if (t[i] & OP_AMOUNT_2)
> 

thanks.
-- 
~Randy

