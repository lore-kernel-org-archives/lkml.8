Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E737C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 338B82077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2GpQouO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgGUCyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUCyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:54:54 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F38C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 19:54:54 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id 72so9606323ple.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 19:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z2RSfMnvW+syz3YOB+XHzd61RaRTKVl0CYaYMTeo2IM=;
        b=g2GpQouOZ0by46nzuuPXea+3qTk65JlELWYwrLcFira2dq1gxPskSRkGhgMXt+ExwO
         +awvuQyhVyzF9/xfYXWP9qyv+dZP5JStWkJeREbMr+TyyiBYb7wB5l5b1hQxxK/gCo+s
         2rgtqIRk4yQLfYd6dD0AxGOpscqE+7C5j2qas5SATLGP5OupzS/9ulh8XFKb3o3DipBv
         b44Lio6mR/B1vVtuuQtvb2wuzxvJisY4s4SDsdNz0l6DsFi9DL2Ha2RPrBcftIEZEZ3E
         EjXoZpgThsglU6ku+Q7JgJiyotqa8Ipu0ILPJdHhOxRBgKn+n/vhtGyQC7My9vw5YYnk
         ncVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z2RSfMnvW+syz3YOB+XHzd61RaRTKVl0CYaYMTeo2IM=;
        b=X7Q6mo4YC2229SeSBqKAzlIlsONEe8LhDy2iMZQjPSl58vF9ARYfiCmmaA/8GOuoMI
         cySkVq2YZGg+sCjzF5PX8V69Na/6X+9N08C12ajA3dl3P10ujz8/MtXD/y7VKck5JkoK
         6we3LhkfqnyiFOonxSUwX7YfGUumXpJVIGxmF13GtjaSFeELArxx4ZbFxuzjlslHH39R
         zWvdjTQjARWuB2ARc5ETcckNPQPgCTl6+tTGnMXEAss3tNIsBdNm2vaLU4kuDCGej1yZ
         DD/I1Ei0zQNnrXUdR5LV8qQ9BJYA9WUVbljQymjDHC8N2zlkxSujRpPerWXnJf8xUeqx
         T+2g==
X-Gm-Message-State: AOAM533gP9b+FFMC3PlCHV2E3b3BlG6q7a6BhjhIn+6cDBNnB9BCuc6s
        0DDBu90HNTaLIhuOpBk3d7U=
X-Google-Smtp-Source: ABdhPJwWbe6de+I3xkaE1Q3ZDm3nbXKT4+42Pk8apBXAvEa0eBHeueusDPk90W9rlpPugT0jDs8CWw==
X-Received: by 2002:a17:902:ff10:: with SMTP id f16mr20624644plj.277.1595300093875;
        Mon, 20 Jul 2020 19:54:53 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id m26sm18223314pff.84.2020.07.20.19.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 19:54:53 -0700 (PDT)
Date:   Tue, 21 Jul 2020 11:54:50 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] printk: ringbuffer: support dataless records
Message-ID: <20200721025450.GA5678@jagdpanzerIV.localdomain>
References: <20200720140111.19935-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720140111.19935-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/20 16:07), John Ogness wrote:
>  
> +/* Determine if a logical position refers to a data-less block. */
> +#define LPOS_DATALESS(lpos)		((lpos) & 1UL)
> +

[..]

> @@ -1402,7 +1396,9 @@ static int prb_read(struct printk_ringbuffer *rb, u64 seq,
>  	/* Copy text data. If it fails, this is a data-less record. */
>  	if (!copy_data(&rb->text_data_ring, &desc.text_blk_lpos, desc.info.text_len,
>  		       r->text_buf, r->text_buf_size, line_count)) {
> -		return -ENOENT;
> +		/* Report an error if there should have been data. */
> +		if (desc.info.text_len != 0)
> +			return -ENOENT;
>  	}

If this is a dataless record then should copy_data() return error?

Otherwise, looks good to me
Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

	-ss
