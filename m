Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7A8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111A12064C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BT4qck7V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgGQTjT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728183AbgGQTjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:39:19 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A446C0619D2;
        Fri, 17 Jul 2020 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=hzdlVvQMtzIBkE/D2VVZleLL6KJlUH87rag70+GkCA0=; b=BT4qck7V5ehsRMRcOt5ngIW+GI
        FrQBLDwSmSfng4CIhx+101dBgZUolsdNVpNhPRoeC5q+hrGKnRk1qNBflWAAaY3KrJsFa6WI7+AMr
        bBoaPIYs8N4fG2WP1uUEUuoQflTeXU6SXfWzWGGY8LR2faymKLQt0Vl31jMAlT6xh9vjabPeFORg2
        Bq8V+9CFbMsK02ya32aSOq4HtafnOBt/qDhfAobocGYwZFryW8SygMV1ghejtlcAxqQHcegJoLwuW
        mkUVwcUqkL1H2O5rU+vyhhwWX2jSI6TK85j485KYigQRoSDOXGD/z1pjikH7fCnr7EsRyW3/SOHYI
        DGDd+Tvw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwWCT-0002b0-0M; Fri, 17 Jul 2020 19:39:17 +0000
Subject: Re: [PATCH 08/25] Documentation: events/block.h: fix sphinx warning
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, corbet@lwn.net,
        mchehab@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
 <20200717185624.2009393-8-dwlsalmeida@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7424fc52-9b37-1b66-ca7f-4e95d35d880c@infradead.org>
Date:   Fri, 17 Jul 2020 12:39:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717185624.2009393-8-dwlsalmeida@gmail.com>
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
> Fix the following warning:
> 
> warning: Excess function parameter 'error' description in
> 'trace_block_bio_complete'
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>

I have already fixed this one and it has been merged.

It seems that you should be using a more recent tree to make
patches against...

Thanks.

> ---
>  include/trace/events/block.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/trace/events/block.h b/include/trace/events/block.h
> index 1257f26bb887b..f69569b70d44d 100644
> --- a/include/trace/events/block.h
> +++ b/include/trace/events/block.h
> @@ -254,7 +254,6 @@ TRACE_EVENT(block_bio_bounce,
>   * block_bio_complete - completed all work on the block operation
>   * @q: queue holding the block operation
>   * @bio: block operation completed
> - * @error: io error value
>   *
>   * This tracepoint indicates there is no further work to do on this
>   * block IO operation @bio.
> @@ -639,4 +638,3 @@ TRACE_EVENT(block_rq_remap,
>  
>  /* This part must be outside protection */
>  #include <trace/define_trace.h>
> -
> 


-- 
~Randy


