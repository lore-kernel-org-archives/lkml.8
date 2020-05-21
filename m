Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FB8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B06820756
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 00:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZD0AuMOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgEUA6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 20:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgEUA6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 20:58:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD54FC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:58:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 5so2194642pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 17:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jT9Di9Gytbq5y3irbSRWLGGaMPsV1xwHwqo+qbRkmvA=;
        b=ZD0AuMOUJeZZYN5K3BnGKSMjdNdT2svIAbct2lS5ofpASdahojBgZugHzq4HXpT6kP
         lctIj0S7YwAeJytKW+zRgUMlM7zDMhNjSiNz7sLZVMwn8qct4B0+2SyWadqBP9GqFr5S
         gzBkVVWnHpeXf2KK5jBfSLIV/tmuiHsLQbteUJzBtEhSUiBy8foULBExdkN8NShL5Y2I
         QvSzsBswo8h1j4qu7QiV8jG1nBqZm6jSC8yCoRLoKzq4tuDC6imeN5iXxvd4KeDgqsnR
         xVZuC84tr1wAC0daZgJXVi7HSrOc/JWtVf8fEtJFKf5kDmhZmv93SAl01yMTE01g0/gv
         a63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jT9Di9Gytbq5y3irbSRWLGGaMPsV1xwHwqo+qbRkmvA=;
        b=RKwx1p6Vr+t0n6BfBsMygSVjN/j2Zbcba9vkEqzBGY5NJrQFVtKXDiF4fb3880VhIh
         Tgjw+ZxGtMRDdKzKxFXpF5Q6D5nAgHu57aKIUJ6GfmjU7HtCccWPxvr4m3SA6G4DcjZM
         WvfhmZtdN2Zq3xy0N8NzfzVGHL7hE0NXF5+nJO8NVP06Ti8sHT64tcELt4ECYFm8T6TV
         enOptqS2zhSGvm8J9jJTTMxpTjmGOd9Ot5wc7SmcXYwUK1YcmVn5fj1tZnw3MV/22Xpt
         aNMWXIA2FORBB4/P+d9pTCqqMyCR5oEg3xTFo9ToZCTb4GI673mJfSzFpszI+0z0TBzQ
         FO4w==
X-Gm-Message-State: AOAM531lo1nG6EbHxZcozW5f2YBwtTi47sTZ6zyprtDM23ATfdT8BoLp
        kicSLHizEIh6yTZKwe4IIaHX3vTttbY=
X-Google-Smtp-Source: ABdhPJyqaheBLcOYU9lOJA35SoEg76xrJC9edD8SKVD3HBDVWnj4x/iACsRGIbmMmP3H4CpvHf7qpQ==
X-Received: by 2002:a17:90a:930c:: with SMTP id p12mr9212902pjo.64.1590022734334;
        Wed, 20 May 2020 17:58:54 -0700 (PDT)
Received: from [192.168.86.156] (cpe-75-85-219-51.dc.res.rr.com. [75.85.219.51])
        by smtp.gmail.com with ESMTPSA id o201sm3309618pfd.115.2020.05.20.17.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2020 17:58:53 -0700 (PDT)
Subject: Re: [PATCH]: splice fix opipe_prep() full check
From:   Jens Axboe <axboe@kernel.dk>
To:     David Howells <dhowells@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <cf341c51-ba8c-4f81-fe4e-6bf8190293e3@kernel.dk>
Message-ID: <cc017cbc-9c28-66bb-8af6-4390b5110aa9@kernel.dk>
Date:   Wed, 20 May 2020 18:58:52 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <cf341c51-ba8c-4f81-fe4e-6bf8190293e3@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/20/20 6:42 PM, Jens Axboe wrote:
> The patch converting pipes to head and tail pointers mistakenly
> turned the splice pipe-to-pipe opipe check into something
> nonsensical. It's supposed to check if we have room in the pipe,
> and return success if we do. If not, wait for room in the pipe.
> Instead it's now returning success for a full pipe, and entering
> the slow path for a non-full pipe.

Forgot to CC Linus - Linus, could you pick this up, or do you want
me to queue it up. Moving to 5.6 internally at FB triggers this
pretty easily, causing a hard hang as we'll get stuck in an infinite
busy loop in splice_pipe_to_pipe().

> 
> Cc: stable@vger.kernel.org
> Fixes: 8cefc107ca54 ("pipe: Use head and tail pointers for the ring, not cursor and length")
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> I didn't check if the offending commit had other logical fumbles.
> 
> diff --git a/fs/splice.c b/fs/splice.c
> index fd0a1e7e5959..4e53efbd621d 100644
> --- a/fs/splice.c
> +++ b/fs/splice.c
> @@ -1494,7 +1494,7 @@ static int opipe_prep(struct pipe_inode_info *pipe, unsigned int flags)
>  	 * Check pipe occupancy without the inode lock first. This function
>  	 * is speculative anyways, so missing one is ok.
>  	 */
> -	if (pipe_full(pipe->head, pipe->tail, pipe->max_usage))
> +	if (!pipe_full(pipe->head, pipe->tail, pipe->max_usage))
>  		return 0;
>  
>  	ret = 0;
> 


-- 
Jens Axboe

