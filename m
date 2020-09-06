Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF9DC43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 22:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B049D20838
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 22:34:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="dtZ+SYi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgIFWeo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 18:34:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgIFWem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 18:34:42 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B83C061573
        for <linux-kernel@vger.kernel.org>; Sun,  6 Sep 2020 15:34:41 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id q21so10979945edv.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 15:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q3I4Xb+dvzUZjaK45rP5aIV88B6tEM45ow1sWsJEZNA=;
        b=dtZ+SYi2xe/BJCfjBjKnpaAohUS4FGYBEH3jMp0QikwzIU4ecQ5uW3DjozAnQnXWrl
         JH7gzJmi0prV8c85BQ7l61Ju9dmHhrOfd0Emn63toaaWkQgdB/dasj3Vsy5n02ROuEmW
         GZc9btPupVDY0nVX8i9m9DygY/q/Yld7Q9jTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q3I4Xb+dvzUZjaK45rP5aIV88B6tEM45ow1sWsJEZNA=;
        b=Fh+1Bgz7rYggbnWt51QzMzwoisE6lqO2NORgOCvlQQ8xk4/sjAu9hTrJHF/A+X1Nwy
         r9wkVukjFRA0efep8JHek0VdktgXLfLhDXpjwLjC0f2aryxrxgUyrjWPNF4HYW3OEiNI
         evSn+vtMGiUPTudterGBYIFSAGtbVXOHV3MyohF86QlMtvIav6GLIs21Lz4ZszQlMWvY
         hT6XfWuKrNFzkrK4iCrfePAYJZcqHQvL231NSO6LG9Eo/ru6zSwlnxY6nQmlQUllgBMU
         xuS3g+FRafChsKYdhlRZq9biTgVlqv7gel9g8hM1QxkX9ELAgjHSnMw6j3Ms4meJ0xxY
         K8ng==
X-Gm-Message-State: AOAM530NkGTRM+HudQt3ECxCxF1Nd3tFkYIxpoB0fXrCEbZafoM/9I6l
        Bntc6ums3zAPqi1QeJ8Sb4HzOhpN2svM/ec8
X-Google-Smtp-Source: ABdhPJxfx9TKrEIikLtjeL4PJG/cr49Kbbe6swwUvDGGCbYC+/l2tQ166HqI5/jx4o6yZCzIlNbYzg==
X-Received: by 2002:a50:fd19:: with SMTP id i25mr19289568eds.142.1599431678688;
        Sun, 06 Sep 2020 15:34:38 -0700 (PDT)
Received: from [192.168.1.149] (5.186.115.188.cgn.fibianet.dk. [5.186.115.188])
        by smtp.gmail.com with ESMTPSA id l26sm13517648ejr.78.2020.09.06.15.34.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Sep 2020 15:34:38 -0700 (PDT)
Subject: Re: [PATCH] /dev/zero: also implement ->read
To:     Christoph Hellwig <hch@lst.de>, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org
References: <20200903155922.1111551-1-hch@lst.de>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <8d430999-b155-dbfa-e7db-f414b48014b1@rasmusvillemoes.dk>
Date:   Mon, 7 Sep 2020 00:34:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200903155922.1111551-1-hch@lst.de>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2020 17.59, Christoph Hellwig wrote:
> Christophe reported a major speedup due to avoiding the iov_iter
> overhead, so just add this trivial function.  Note that /dev/zero
> already implements both an iter and non-iter writes so this just
> makes it more symmetric.
> 
> Christophe Leroy <christophe.leroy@csgroup.eu>

?-by ?

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/char/mem.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/char/mem.c b/drivers/char/mem.c
> index abd4ffdc8cdebc..1dc99ab158457a 100644
> --- a/drivers/char/mem.c
> +++ b/drivers/char/mem.c
> @@ -726,6 +726,27 @@ static ssize_t read_iter_zero(struct kiocb *iocb, struct iov_iter *iter)
>  	return written;
>  }
>  
> +static ssize_t read_zero(struct file *file, char __user *buf,
> +			 size_t count, loff_t *ppos)
> +{
> +	size_t cleared = 0;
> +
> +	while (count) {
> +		size_t chunk = min_t(size_t, count, PAGE_SIZE);
> +
> +		if (clear_user(buf + cleared, chunk))
> +			return cleared ? cleared : -EFAULT;

Probably nobody really cares, but currently doing

read(fd, &unmapped_page - 5, 123);

returns 5, and those five bytes do get cleared; if I'm reading the above
right you'd return -EFAULT for that case.


> +		cleared += chunk;
> +		count -= chunk;
> +
> +		if (signal_pending(current))
> +			return cleared ? cleared : -ERESTARTSYS;

I can't see how we can get here without 'cleared' being positive, so
this can just be 'return cleared' (and if you fix the above EFAULT case
to more accurately track how much got cleared, there's probably no
longer any code to be symmetric with anyway).

Rasmus
