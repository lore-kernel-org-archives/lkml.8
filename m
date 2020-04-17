Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D8EC38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BD921D95
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587123574;
	bh=yDWjQPKFuTxGjOCr1wtpkgDzpcNZINtogloaPn7YMwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ml6TSRNDGzZoRYAn/SCw1WsTeEirR6n4R4Rn6I8p3Pv60hJHVPMdQQ8gcPeoGw5/m
	 k4o+D1JT/Qholuqib0jlC9Mh8Mfa0ThpLFIxEzi3dBUlnthLwG+5u6lS3MojP6IIjD
	 xSAsH4W+QUT2nk5jAFotHJLnZ6W3JiNQ+aTlws9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbgDQLjd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:39:33 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41961 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730267AbgDQLjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:39:32 -0400
Received: by mail-wr1-f66.google.com with SMTP id g13so639885wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 04:39:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kBuWPWQm1wctgOvEVFG4EmTdG+sTyc89IGQTtRi58b8=;
        b=jb1oJ2M9uFzUMhEkw0PR+OvtgvYISZhGD1yD2w+uIBUxK1Wl6hgxliFTVltevHybi4
         1/fymt4+pHJMZQ7WH4EbO0WZ2DRkhfKqAIsxsBtrPQ2tDfEbLzDCb6wPETDYqh8UYGwM
         8AChikKiMsjckiHrbbarQhrinjhJKMiwQij59N6AvjN1OuTP/fuat1LyMuHlfBHynp9/
         aSX+H6NeeqLl26XPgmVFhX7EcD0v5pXTsL6m146pe3GwFxWpuMlP8eQ88y1Z30gZ9dx+
         hWG9A1m3V1oYgHtr3RIfgB+ldoMMq0j8yQAOOusJfqecyX1UB8qE0APENu8xav8pSKRI
         xuwg==
X-Gm-Message-State: AGi0PuadFU7z9WqfnN5j+LO3RS7J10o6VWK943OTItmWlezwSx6rJR0O
        olIWBRKYkJGnobuPACBInP0=
X-Google-Smtp-Source: APiQypI+3rlyh18QlRyTQI3omYi3JCU4feJrIdVaw8k6cjbXR4q99DqkbijzzW5smV56bHvnhxzTRw==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr3646224wrj.419.1587123570819;
        Fri, 17 Apr 2020 04:39:30 -0700 (PDT)
Received: from localhost (ip-37-188-130-62.eurotel.cz. [37.188.130.62])
        by smtp.gmail.com with ESMTPSA id s11sm11371644wrw.71.2020.04.17.04.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 04:39:30 -0700 (PDT)
Date:   Fri, 17 Apr 2020 13:39:28 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH] kmalloc_index optimization(add kmalloc max size check)
Message-ID: <20200417113928.GL26707@dhcp22.suse.cz>
References: <1587107376-111722-1-git-send-email-bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587107376-111722-1-git-send-email-bernard@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-04-20 00:09:35, Bernard Zhao wrote:
> kmalloc size should never exceed KMALLOC_MAX_SIZE.
> kmalloc_index realise if size is exceed KMALLOC_MAX_SIZE, e.g 64M,
> kmalloc_index just return index 26, but never check with OS`s max
> kmalloc config KMALLOC_MAX_SIZE. This index`s kmalloc caches maybe
> not create in function create_kmalloc_caches.
> We can throw an warninginfo in kmalloc at the beginning, instead of
> being guaranteed by the buddy alloc behind.

I am sorry but I do not follow. What does this patch optimizes? AFAICS,
it adds a branch for everybody for something that is highly unlikely
usage. Btw. we already do handle those impossible cases. We could argue
that BUG() is a bit harsh reaction but a lack of reports suggests this
is not a real problem in fact.

So what exactly do you want to achieve here?

> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  include/linux/slab.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 6d45488..59b60d2 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -351,6 +351,10 @@ static __always_inline unsigned int kmalloc_index(size_t size)
>  	if (!size)
>  		return 0;
>  
> +	/* size should never exceed KMALLOC_MAX_SIZE. */
> +	if (size > KMALLOC_MAX_SIZE)
> +		WARN(1, "size exceed max kmalloc size!\n");
> +
>  	if (size <= KMALLOC_MIN_SIZE)
>  		return KMALLOC_SHIFT_LOW;
>  
> -- 
> 2.7.4
> 

-- 
Michal Hocko
SUSE Labs
