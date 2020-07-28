Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C796C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 603762065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="feIz9NzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgG1T1U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgG1T1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:27:19 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1DBC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:27:19 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id l2so5193045pff.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ADR3sxjOiI8EIqhLZSouL3EW3hA1BdmVXcyDJSxtf1g=;
        b=feIz9NzYxqlqeBvyyAc1jflhjVzz8J4U13VpEpSwtoe0a5xoAHqa5zj9JZPoaGp9OI
         Gtguyun+XZ7PxMgQn9grw1fuZwRkkSo0A9fVzds0NXyOPE6iFJqPUmLdunNhxWJFIFNX
         VsHJ+53FL3iwFfhSpElXpHgVF+wVhBTxQxVB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ADR3sxjOiI8EIqhLZSouL3EW3hA1BdmVXcyDJSxtf1g=;
        b=HfrLAXq0AMZIV62KDUY5Bi3y2+LfzYT+9HLQnTGTLeekUNbv9GeNwOwpsnSTomoYE7
         FT1YH5ju02eTbIIbRG+wGGNRY/2guDTf4XS/7nU2+c3b5SJZZpQJJD58coqbl4+k8gp2
         UERad92vHr/RoI5vCvjLPP6OiBqc2Mk7DYDpLgldoCOslUqJAUavnSzTFQXMMDpAZc7m
         cbhR+WoYmo5lSnK/b0hYi29dZBfnDf//C7rMUPLs0JjVYOpNRAM/qdshWsJ7+aZXiGJl
         d2Z/Xbi4heUCgf+9XlMHIwKTJ84NsUhSIFCVn6gAShPQOBzwbCnJgxNAzeWusmkZ1qvp
         OrSQ==
X-Gm-Message-State: AOAM533TIQdWdHB4g9tG+wmS8AJG4zJHYh1K4qcv3WqfZzhdzL7T1yrh
        eAzWrxNFj+RaN723FL+MqJKZdA==
X-Google-Smtp-Source: ABdhPJwoP+V2zTNbY5IIvsECqP+Psg0tENJtJc3/AQU1OrFGWLJNdvykxNYrHgKY3PRLF79keD3pLA==
X-Received: by 2002:aa7:8557:: with SMTP id y23mr25596453pfn.148.1595964438941;
        Tue, 28 Jul 2020 12:27:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y8sm3912560pjj.17.2020.07.28.12.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:27:18 -0700 (PDT)
Date:   Tue, 28 Jul 2020 12:27:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/8] x86/kaslr: Simplify process_gb_huge_pages
Message-ID: <202007281225.C24B966D7@keescook>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
 <20200727230801.3468620-7-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727230801.3468620-7-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 07:07:59PM -0400, Arvind Sankar wrote:
> Short-circuit the whole function on 32-bit.
> 
> Replace the loop to determine the number of 1Gb pages with arithmetic.
> 
> Fix one minor bug: if the end of the region is aligned on a 1Gb
> boundary, the current code will not use the last available 1Gb page due
> to an off-by-one error.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Can you add some KUnit tests could be written to do validation of the
refactorings? Touching this code is so painful. :)

-Kees

> +++ b/arch/x86/boot/compressed/kaslr.c
> @@ -546,49 +546,43 @@ static void store_slot_info(struct mem_vector *region, unsigned long image_size)
>  static void
>  process_gb_huge_pages(struct mem_vector *region, unsigned long image_size)
>  {
> -	unsigned long addr, size = 0;
> +	unsigned long pud_start, pud_end, gb_huge_pages;
>  	struct mem_vector tmp;
> -	int i = 0;
>  
> -	if (!max_gb_huge_pages) {
> +	if (IS_ENABLED(CONFIG_X86_32) || !max_gb_huge_pages) {
>  		store_slot_info(region, image_size);
>  		return;
>  	}

Won't max_gb_huge_pages always be false for 32-bit?

-- 
Kees Cook
