Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE398C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B707020B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkraU/yj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGTBRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgGTBR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:17:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA386C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:17:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id md7so9210462pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WuW5d1jB5KD6N3BqpJQs04uvX1XFk7NR5Qj1TtnWOVg=;
        b=dkraU/yjZybQYujNvdt8quyce4ltQyx95EnEKgKgE7TYaMhESifIPwrOMgzCYwTUrI
         onbV1VJii1Nc0kkiYJkv95jYL+xws7hQmrqDXTmNy73qc4l9AAZxoj5ADx0VcT7ZVhvG
         rJrPaMcxrZe8M0YKSpp+QfOTHi+GcrBNeAoj0R317yTQj3t1edsZpbgmGkIQ/JXHWdFq
         b+lcwi58eiWBBFeyzyKqyKU4Mjb4ajFRympiqeoMw+zBQB1ST23JvAQBcMQ97NzlUCFS
         O5FfsK2UaVIayHtNCsnft72kZ2UyKddfjJgrAcHRcMjw5B2Ki26sCIrGIkyDzfw1oVGr
         M0rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WuW5d1jB5KD6N3BqpJQs04uvX1XFk7NR5Qj1TtnWOVg=;
        b=bQWDooJb+1LFyYIiihluLihpZN8h6o4PPLw7P2d0qKlmwo6Ksh9Ur43x4tNDNynx84
         OtyT5aGqKi18ddLNXLekpxjnF39oOaDBUu8BkLwj4NAgT2t+m6qjF1T++0BL4Pz+kiYH
         SYYmUln08/9U85zWPAKuKji51iSjUUlVsp6/bmTW2zBU6IWFAH+aEh/jvmxptEpvADNv
         nPzflabxast82H4flJ1KxhwFBhDOqxAbnBdJbwaZEcu0Fgwvczp32ohVGSIz2J6Ime9j
         /l96pDXy/5W2FJAlNJ0NQdipvspiKkpH0voCwh5orMCsQw4jeSR4QUr/f8cuo/42g58a
         FlLg==
X-Gm-Message-State: AOAM530wgT9yVIsamQkbhIQP/i9l/tRh4mWI8+//J+xLGM7Au5CDKic8
        jc6+kycEqxwl+whrOJVcqYqADHAc
X-Google-Smtp-Source: ABdhPJw6pgDS8NLFKicH5nikdCA0l/1dReD+zG4qLuOEkti51UPxm2N1av31uvdnw/qPtw4SZ7uGdQ==
X-Received: by 2002:a17:902:7787:: with SMTP id o7mr16328815pll.327.1595207849437;
        Sun, 19 Jul 2020 18:17:29 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([47.89.83.80])
        by smtp.gmail.com with ESMTPSA id j8sm15061279pfd.145.2020.07.19.18.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 18:17:28 -0700 (PDT)
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: suballoc.h: delete a duplicated word
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     ocfs2-devel@oss.oracle.com,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200720001421.28823-1-rdunlap@infradead.org>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <540ab401-d7a3-1b94-7acf-3852ce2292b7@gmail.com>
Date:   Mon, 20 Jul 2020 09:17:22 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720001421.28823-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/20 08:14, Randy Dunlap wrote:
> Drop the repeated word "is" in a comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: ocfs2-devel@oss.oracle.com

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/suballoc.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- linux-next-20200717.orig/fs/ocfs2/suballoc.h
> +++ linux-next-20200717/fs/ocfs2/suballoc.h
> @@ -40,7 +40,7 @@ struct ocfs2_alloc_context {
>  
>  	u64    ac_last_group;
>  	u64    ac_max_block;  /* Highest block number to allocate. 0 is
> -				 is the same as ~0 - unlimited */
> +				 the same as ~0 - unlimited */
>  
>  	int    ac_find_loc_only;  /* hack for reflink operation ordering */
>  	struct ocfs2_suballoc_result *ac_find_loc_priv; /* */
> 
> _______________________________________________
> Ocfs2-devel mailing list
> Ocfs2-devel@oss.oracle.com
> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
> 
