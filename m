Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3112C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C902720684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UrFac4aR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbgGQTm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQTm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:42:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE09C0619D2;
        Fri, 17 Jul 2020 12:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=w+bq4RshJLiCcx3ZJiAXeqOaXAfRjHWx+2g7K4rbcBY=; b=UrFac4aRL4TFKqaprB2JEw+T5T
        dgmDbckp2q9m5lSHOO32G/y1WBvuJaqNc/S1P/5jEqmE6v7wAj7HirZweJuPB6ksZbMs1nmGUAwAG
        Gs3pMZqrTjOoQwVOwRsd8USBPlnzz66ZCrOuHeEEQezm0/D474AwwLvC03UxmdcMzCEbGImFENvbv
        /Y1Js8BRNRCFozkpeO4cz25FeqNmu8SOY5oKM8v7puZYBgAZAUnC7XXo3IiuLny3tLp31eifHrsqX
        lfySpDI7/IZ4TFZSl1v165oBSdcorj/+qqF3fO1mf+Jzo+PiLfnMDTmI9Kx6rboEmBDBUklPcySRR
        WFGMxdaA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwWG0-0002pY-Fn; Fri, 17 Jul 2020 19:42:56 +0000
Subject: Re: [PATCH 13/25] Documentation: watch_queue.rst: fix sphinx warnings
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, corbet@lwn.net,
        mchehab@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
 <20200717185624.2009393-13-dwlsalmeida@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cf5f2227-c473-442b-7ad4-5ca3718a6672@infradead.org>
Date:   Fri, 17 Jul 2020 12:42:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717185624.2009393-13-dwlsalmeida@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/20 11:56 AM, Daniel W. S. Almeida wrote:
> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Fix the following warnings:
> 
> watch_queue.rst:107: WARNING: Inline literal start-string
> without end-string.
> 
> watch_queue.rst:107: WARNING: Inline emphasis start-string
> without end-string
> 
> watch_queue.rst:184: WARNING: Inline literal start-string
> without end-string.
> 
> watch_queue.rst:184: WARNING: Inline emphasis start-string
> without end-string
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  Documentation/watch_queue.rst | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/watch_queue.rst b/Documentation/watch_queue.rst
> index 849fad6893efa..4c3098b8fa947 100644
> --- a/Documentation/watch_queue.rst
> +++ b/Documentation/watch_queue.rst
> @@ -103,8 +103,7 @@ watch that specific key).
>  
>  To manage a watch list, the following functions are provided:
>  
> -  * ``void init_watch_list(struct watch_list *wlist,
> -			   void (*release_watch)(struct watch *wlist));``
> +  * ``void init_watch_list(struct watch_list *wlist, void (*release_watch)(struct watch *wlist));``
>  
>      Initialise a watch list.  If ``release_watch`` is not NULL, then this
>      indicates a function that should be called when the watch_list object is
> @@ -179,9 +178,9 @@ The following functions are provided to manage watches:
>      driver-settable fields in the watch struct must have been set before this
>      is called.
>  
> -  * ``int remove_watch_from_object(struct watch_list *wlist,
> -				   struct watch_queue *wqueue,
> -				   u64 id, false);``
> +  * ``int remove_watch_from_object(struct watch_list *wlist,``
> +				 ``struct watch_queue *wqueue,``
> +				 ``u64 id, false);``
>  
>      Remove a watch from a watch list, where the watch must match the specified
>      watch queue (``wqueue``) and object identifier (``id``).  A notification
> 

Wow. If that's what it takes, well, OK, but it's sad IMHO.

-- 
~Randy

