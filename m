Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE29C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:29:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5BB12076F
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q3u295ya"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgCOB3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:29:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54712 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgCOB3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:29:40 -0400
Received: by mail-wm1-f65.google.com with SMTP id n8so13872053wmc.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Mar 2020 18:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRfG0mwZMLjMl4FPHbusrIQaUL5wynktLP8666hh0Ic=;
        b=q3u295yaWvJtyF0nX+itH6MgcSpzhi/WW183Rq9wGLBRLMK9E1D9n+YozKtG8wr/cW
         prWRdLnb5KqNYxGwbMr9NT1YXCcGu+szlyiWm3eF1GxPkmszRZ18gO9IH9tgVp4xnEHl
         scK3h4clMAHm72HKMPZn1BizqC782jmNPtEXG1D4qfrS9CitoHmvo7uLkih+M323gton
         nO57LOy9ng7Dlbj9WkBQ3/La2796jyVvUbYmYQKdMUxXLySTdoqmzQ9A61v8r/5qr4zm
         NPI6P9Hm96BHEFikcg2n9El7/tXtLB0Fv20UfC/MYXkAjVYXE3ib9ukBOvtb0Hicd8lN
         ow8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRfG0mwZMLjMl4FPHbusrIQaUL5wynktLP8666hh0Ic=;
        b=Vyj8atNhJcPA4tfhziISSaLLkKUZWgSJ32mjDh1yj6yjxINUiTLNnneXTu0pidvZga
         xea4F+XBieOOHwX/+Xk8HzGynNqwsgmzuwdKA/GWTxElXAiGw6YF7nHkDoGmPSDMPMz0
         6sQ3qXwjlj54VU3dIKaqYriD5FNOJce99f+v1LWybase7j4S+3jJ1qICg8U/CpxXn4gk
         DFUdRa1HBsKastgXe5221VJt6QZ15t5Joe9xLsK9x7DpZnaBLwrVkSuJ4YXVbrA1XWKt
         pKdZQSZtmS0bfCvs4/qaFEvtzv4jh++Trfsk70dqQ74LT6I/IJFxVQ4qThjySRJ7oyOX
         igxg==
X-Gm-Message-State: ANhLgQ29N9d7Hd7v9F9ZaVCkNA/FKgk2Tl7yckY+siAoBc6WRNoAAdEC
        P57roWhIS0ZSTT1eTsbgrFpNH3iy
X-Google-Smtp-Source: ADFU+vusw/MooirDZ5px6QSB4Q7IrKYKrBAJeE9hSb0Jn2vYN866yAQB9P7y0dj2KFOY68fFzrfwmg==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr19096815wmf.160.1584235440708;
        Sat, 14 Mar 2020 18:24:00 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id h18sm22200107wmm.6.2020.03.14.18.23.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 14 Mar 2020 18:24:00 -0700 (PDT)
Date:   Sun, 15 Mar 2020 01:23:59 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/swap_state.c: use the same way to count page in
 [add_to|delete_from]_swap_cache
Message-ID: <20200315012359.uebl54wauvcpd5j4@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200314215912.1554-1-richard.weiyang@gmail.com>
 <20200315002101.GT22433@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315002101.GT22433@bombadil.infradead.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 05:21:01PM -0700, Matthew Wilcox wrote:
>On Sat, Mar 14, 2020 at 09:59:12PM +0000, Wei Yang wrote:
>> Function add_to_swap_cache() and delete_from_swap_cache() are counter
>> parts, while currently they use different way to count page.
>> 
>> It doesn't break any thing because we only have two size for PageAnon,
>> but this is confusing and not a good practice.
>> 
>> This patch corrects it by both using compound_nr().
>
>You're converting in the wrong direction.  hpage_nr_pages() is optimised
>away when CONFIG_TRANSPARENT_HUGEPAGE is undefined, whereas compound_nr()
>is not.

Ok, I didn't think about the optimisation.

Will use hpage_nr_pages() in v2.

>
>I also have this patch pending:
>http://git.infradead.org/users/willy/linux-dax.git/commitdiff/192b635b428ae74f680574cdcc3d5e9d213fcb64

-- 
Wei Yang
Help you, Help me
