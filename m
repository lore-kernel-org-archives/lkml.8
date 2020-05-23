Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D473C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A2EB2072C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 01:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EP3CkkiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387630AbgEWBvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 21:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387615AbgEWBvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 21:51:32 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7118EC061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:51:32 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c24so9866335qtw.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 18:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dl+KxsROb4cPj2iQZSsr1bvDaOCEwSXc+9sPYn2MtWc=;
        b=EP3CkkiMjXBNO33JU9tRJ5LOwWZYredBb+mvwPWhXXCKQAWAlsiQQsQRPkFQPC0nRx
         ZkbxSuoT6LV4EXeZ4pWL3Yhlfo8nx80UCABTT4KAbIxUlWTcaOC87qRpVUQnN1IlECSU
         /f+YDMuL2deibxh4BYYOUk4wDVykqh2S0uUepuWSGiRzpC4QkrCSzFjtTeDpiepWSJeA
         69mziKBIWAi7G48ZvWI8Rlrg0FIyT63r8u1qZR+xIGts5r6/I3G/fPw2tZOQnL8WoJLm
         RhlPUh8PkYbfgy0f++xZ7SI/Er7oQu6UxF6+uaIp1H+2mLVxKbQZCpilU8MEltoMVjjs
         8dlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dl+KxsROb4cPj2iQZSsr1bvDaOCEwSXc+9sPYn2MtWc=;
        b=SpQygXVL6fZip4VBvUL04023Y8J8n++sR/zxktQHp2YHNGkCQCJSZRLt4kYW+ssyZI
         i+7e75a5aigU/ue0WGolu8+61fNm7JY/L44Z9id4R+1SihZrjSwfbQfpEc5p/h2Dj3Fi
         7IvH+6iRqyc2ixt+zzvOUsLxfbYFAI1Gat/gvRzrALnFRNE2vsz/tLQoIridL7+hPl69
         Z8UT1MxePR+o2Oeii1PryndG3BNF1EsTcr5fFkccP1yFX9CT5E3rSpLc/4g/ItS9G91x
         Ozx1ClOsQuvsgkH7R4MQ4eHZbp9Yr/G0kjOvpch31fIZOb3L48ybDayjSfHvxY083P5H
         cNAA==
X-Gm-Message-State: AOAM533hK7hfOCATN276/7C3pJO68pZFxX63SCWVHVansrei4Fi37VJY
        IB1FAuOL42tPpy0773mEJAc=
X-Google-Smtp-Source: ABdhPJwzByhTsHMepg7YrKn+Hzag2OKQNukvBSM7yD5thAMQVpVOrtmWv5O46EbvlNY9CVs+/Upmng==
X-Received: by 2002:ac8:699a:: with SMTP id o26mr18085807qtq.92.1590198691654;
        Fri, 22 May 2020 18:51:31 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o18sm9859239qtb.7.2020.05.22.18.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 18:51:30 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 22 May 2020 21:51:29 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     "Tobin C . Harding" <me@tobin.cc>, Tycho Andersen <tycho@tycho.ws>,
        kernel-hardening@lists.openwall.com,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mm/init: Stop printing pgt_buf addresses
Message-ID: <20200523015129.GA717759@rani.riverdale.lan>
References: <20200229231120.1147527-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200229231120.1147527-1-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 29, 2020 at 06:11:20PM -0500, Arvind Sankar wrote:
> This currently leaks kernel physical addresses into userspace.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/mm/init.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index e7bb483557c9..dc4711f09cdc 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -121,8 +121,6 @@ __ref void *alloc_low_pages(unsigned int num)
>  	} else {
>  		pfn = pgt_buf_end;
>  		pgt_buf_end += num;
> -		printk(KERN_DEBUG "BRK [%#010lx, %#010lx] PGTABLE\n",
> -			pfn << PAGE_SHIFT, (pgt_buf_end << PAGE_SHIFT) - 1);
>  	}
>  
>  	for (i = 0; i < num; i++) {
> -- 
> 2.24.1
> 

Ping.

https://lore.kernel.org/lkml/20200229231120.1147527-1-nivedita@alum.mit.edu/
