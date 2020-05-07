Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E69C35280
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E5B921473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 23:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588895176;
	bh=v7cjrS6d93OQFBJhTl5Ioe67MhGi9wE72gyBF2JkO/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ASJfSifFSfuXtnJJpi84LNw67ZoW6rWysZEBlhhgtfEvMfF1ZDteOjC5ELF+qeHcm
	 S4xkMKYJY+y1mgxao160hf1iB7IRT2yGkF5vekCANtDv4QNPckwzUyrmYbAYwlxN6m
	 9m0B/ZXttZskv+oUDkYw/8thI+ee8f5A67/p4BpM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgEGXqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 19:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726476AbgEGXqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 19:46:15 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EDA6208E4;
        Thu,  7 May 2020 23:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588895174;
        bh=v7cjrS6d93OQFBJhTl5Ioe67MhGi9wE72gyBF2JkO/o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i+7a50XW0+kgIesPy+uhKFEt/MwSiX4KDSnPrT1IbL1Ji3cwSSFIM1KxGMSR5/IhI
         e+6g8kvlz/fGJxFniZpvI89OEsEFakhTSTJ6GH174nvOYiJP4FVoJoW8RklFOVdijC
         cn4P1n0OhzztdqwqzfxOZvxxGcskT7pZHCHQVybc=
Date:   Thu, 7 May 2020 16:46:14 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tan Hu <tan.hu@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, wang.liang82@zte.com.cn,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] lib/flex_proportions.c: aging counts when fraction
 smaller than max_frac/FPROP_FRAC_BASE
Message-Id: <20200507164614.4a816d2aa1b341be937b128a@linux-foundation.org>
In-Reply-To: <1588746088-38605-1-git-send-email-tan.hu@zte.com.cn>
References: <1588746088-38605-1-git-send-email-tan.hu@zte.com.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 14:21:28 +0800 Tan Hu <tan.hu@zte.com.cn> wrote:

> If the given type has fraction smaller than max_frac/FPROP_FRAC_BASE,
> __fprop_inc_percpu_max should follow the design formula and aging
> fraction too.
> 
> Signed-off-by: Tan Hu <tan.hu@zte.com.cn>
> ---
>  lib/flex_proportions.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/flex_proportions.c b/lib/flex_proportions.c
> index 7852bfff5..451543937 100644
> --- a/lib/flex_proportions.c
> +++ b/lib/flex_proportions.c
> @@ -266,8 +266,7 @@ void __fprop_inc_percpu_max(struct fprop_global *p,
>  		if (numerator >
>  		    (((u64)denominator) * max_frac) >> FPROP_FRAC_SHIFT)
>  			return;
> -	} else
> -		fprop_reflect_period_percpu(p, pl);
> -	percpu_counter_add_batch(&pl->events, 1, PROP_BATCH);
> -	percpu_counter_add(&p->events, 1);
> +	}
> +
> +	__fprop_inc_percpu(p, pl);
>  }

(Cc Jan)
