Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA44BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 802AF20639
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 02:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWXxYMOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgHKCf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 22:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbgHKCfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 22:35:25 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9428CC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 19:35:25 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so5997107pgf.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 19:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z9jehXK3gLpgKXa/WyLATazWg9phkL5fkuhKoj9EKrA=;
        b=SWXxYMOg0UN0OoSdpHaaXNVvA0q8TN8kkjrWZWFUsXPzyxF9wkV83mbcSEDQiCHFii
         iwHjRUZjdmfINRLdOeBVKNiqGB973Ld0/GgUuQGorgmkMrncY7y8IfpqPwKvBrnY7nSe
         m3KS6n3byWoiwM/8XtL9cHz6aLicHo3ANbhonOnEHLAEJYWe4xxEHJXgm/7E5OJoXGJF
         igKmWLr/KYp4S1JE18y+HX0Bamf5QprfzIRkH6Q+nHnmPLvZb74Ns9SXWGU34OYX/XNG
         kqso62mjJc7DRB07Mi2ATLNBM5uBh5IFsdLBkbsTEeIiWeQc8qi/xbt1cmiCRKm59lQg
         D7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z9jehXK3gLpgKXa/WyLATazWg9phkL5fkuhKoj9EKrA=;
        b=cz6JYRvMOIJwYs5CDnrmQfLC03AcNVmgypClS0504N0Bj5i1zMcjoDfqpAcaU1tGis
         JWH6ky8534ZBt0OjxjzXma2sez+qv1gGmmy23MGQNVcuNO8dvbQXFAw2Y1goVrTVdViC
         qiLURZVhxQJ0XCx5b0A24S//EYkQWr7UYy1005CkZjuOQGKRuxSoeyAZDtVpa8PyrpGI
         JAyxbDyCINFMtNn0H75tTeO24fwU45v7whODVIS7MAl4QtUtp7e4LgmTCJU0BD8wMOP3
         bb5kJjJ8y1oFjmqIOEwqff/GnMjmGgudy47WIF1gzJgAFuMF61hbxrNpKHCRvjO5cAJ2
         gr5w==
X-Gm-Message-State: AOAM531dXnITIHNbvQq+yisjfZIKNri9+dcYgPSLj7LndFSDj0eUKNA+
        KDdkiZiaGqHwkXR66+QffQ4tAjky
X-Google-Smtp-Source: ABdhPJwTmC5hq784a2K1lxM6uFvkUY1h4wx7mRkxd3ew1Qswi8JiZBx2rptsvodhlTBkEYkzRDQGiw==
X-Received: by 2002:a63:5350:: with SMTP id t16mr15696260pgl.35.1597113324612;
        Mon, 10 Aug 2020 19:35:24 -0700 (PDT)
Received: from JosephdeMacBook-Pro.local ([47.89.83.89])
        by smtp.gmail.com with ESMTPSA id o192sm26829135pfg.81.2020.08.10.19.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 19:35:23 -0700 (PDT)
Subject: Re: [Ocfs2-devel] [PATCH] fs: ocfs2: delete repeated words in
 comments
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     ocfs2-devel@oss.oracle.com
References: <20200811021845.25134-1-rdunlap@infradead.org>
From:   Joseph Qi <jiangqi903@gmail.com>
Message-ID: <bae514ce-1cd6-0a60-9117-b8c7f2827940@gmail.com>
Date:   Tue, 11 Aug 2020 10:35:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200811021845.25134-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/8/11 10:18, Randy Dunlap wrote:
> Drop duplicated words {the, and} in comments.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Mark Fasheh <mark@fasheh.com>
> Cc: Joel Becker <jlbec@evilplan.org>
> Cc: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: ocfs2-devel@oss.oracle.com

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>

> ---
>  fs/ocfs2/alloc.c      |    2 +-
>  fs/ocfs2/localalloc.c |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20200807.orig/fs/ocfs2/alloc.c
> +++ linux-next-20200807/fs/ocfs2/alloc.c
> @@ -6013,7 +6013,7 @@ int __ocfs2_flush_truncate_log(struct oc
>  		goto out;
>  	}
>  
> -	/* Appending truncate log(TA) and and flushing truncate log(TF) are
> +	/* Appending truncate log(TA) and flushing truncate log(TF) are
>  	 * two separated transactions. They can be both committed but not
>  	 * checkpointed. If crash occurs then, both two transaction will be
>  	 * replayed with several already released to global bitmap clusters.
> --- linux-next-20200807.orig/fs/ocfs2/localalloc.c
> +++ linux-next-20200807/fs/ocfs2/localalloc.c
> @@ -677,7 +677,7 @@ int ocfs2_reserve_local_alloc_bits(struc
>  		/*
>  		 * Under certain conditions, the window slide code
>  		 * might have reduced the number of bits available or
> -		 * disabled the the local alloc entirely. Re-check
> +		 * disabled the local alloc entirely. Re-check
>  		 * here and return -ENOSPC if necessary.
>  		 */
>  		status = -ENOSPC;
> 
> _______________________________________________
> Ocfs2-devel mailing list
> Ocfs2-devel@oss.oracle.com
> https://oss.oracle.com/mailman/listinfo/ocfs2-devel
> 
