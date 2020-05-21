Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22889C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:56:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6AFA206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="qUdQosRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgEUO4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgEUO4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:56:52 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6274CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:56:52 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id m64so5696101qtd.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=G9Psnzsqr5VKgtx05DHL3JYrFSonqGokS9sH18CNhzY=;
        b=qUdQosRe9xMOd8y6xVjLah2ogskEpGyaowjZqZ2ysCcVrQ7v677+mLvEvQyKfCbMJH
         9As8EhSGu/QKMwgVhEDOvw0WT7R+3zzu/8cUCZhwlI/oCFo0rFyNQxNR4xVP9IxL0aFO
         FwxoBrnN6F3vHr4+j49d92PfVZ8mQiCV/D+n9Jpw36XUsioliclVlJtjAsWCfhjbHvhQ
         bX8rvitH+JYUsKOCCokLbRvBiRbeWoEWUaxPRHi1kdliyK3zPM/jFrpX2eAfWwdgfFNZ
         X+6Q3pcQZp333wentKWGk8DI5T0l3zdkDgsNVVvmDLeymow34nq0oNur2Xt7eDUiaRxN
         xRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G9Psnzsqr5VKgtx05DHL3JYrFSonqGokS9sH18CNhzY=;
        b=EaulIkjH7XcRrCFzVjf6YJ+16h/3SlbQo9+oEEftWn/aTVbxyWkEslkMXMvoIfRGCk
         cqDUkeiaoGIXOSn4s521ygNMkbgSU1gWf6Jd6uuNkpDZ0xnsfcmZra6zPqtF49zGOFdn
         YSDDENRYayyL+vc7ZoQnaFyHe83Ot4BVlwe9KGPGv0i+xNQx1JGTxdSmLYqjEuvPEZAC
         gN4aZMKDMX0Esd9okQuJcKvNBSvh43qH8yPwtn3ZAsCEGtHDEt/R1whdGDgY8Ea5siLM
         aJidrJD1Mwus0X6QySmym5xbDtVdGXcnz1/USF6dTbNLX8pxxiXC2slGHHiQrQowbfFO
         0wRQ==
X-Gm-Message-State: AOAM533aM+R75sOBj1AT+jd2zV48UlqO89sJ8rz/fQJsDivcAEFxu4mz
        GYc+SzwjGYA1xWhXRwTTEBpM9Rfj1MCFYg==
X-Google-Smtp-Source: ABdhPJxBhJDx28pKWR7xXWxMLBwZXgh00PunywtqLWb8CRgzUCd7tliqoCplpIoVYvFvUpHscbZlXA==
X-Received: by 2002:ac8:8f7:: with SMTP id y52mr11249715qth.104.1590073011568;
        Thu, 21 May 2020 07:56:51 -0700 (PDT)
Received: from ovpn-112-192.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k57sm5366872qta.20.2020.05.21.07.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 07:56:50 -0700 (PDT)
Date:   Thu, 21 May 2020 10:56:44 -0400
From:   Qian Cai <cai@lca.pw>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC linux-next PATCH] mm: khugepaged: remove error message when
 checking external pins
Message-ID: <20200521145644.GA6367@ovpn-112-192.phx2.redhat.com>
References: <1589317383-9595-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589317383-9595-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 05:03:03AM +0800, Yang Shi wrote:
[]
>  mm/khugepaged.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 1fdd677..048f5d4 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -602,12 +602,6 @@ static bool is_refcount_suitable(struct page *page)
>  	if (PageSwapCache(page))
>  		expected_refcount += compound_nr(page);
>  
> -	if (IS_ENABLED(CONFIG_DEBUG_VM) && expected_refcount > refcount) {
> -		pr_err("expected_refcount (%d) > refcount (%d)\n",
> -				expected_refcount, refcount);
> -		dump_page(page, "Unexpected refcount");
> -	}
> -
>  	return page_count(page) == expected_refcount;
>  }

mm/khugepaged.c: In function 'is_refcount_suitable':
mm/khugepaged.c:575:25: warning: variable 'refcount set but not used [-Wunused-but-set-variable]
  int expected_refcount, refcount;
                         ^~~~~~~~ 

--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -572,9 +572,8 @@ static void release_pte_pages(pte_t *pte, pte_t *_pte,
 
 static bool is_refcount_suitable(struct page *page)
 {
-	int expected_refcount, refcount;
+	int expected_refcount;
 
-	refcount = page_count(page);
 	expected_refcount = total_mapcount(page);
 	if (PageSwapCache(page))
 		expected_refcount += compound_nr(page); 
