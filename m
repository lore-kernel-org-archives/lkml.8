Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FEE3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3952078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g2s1CDwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGJInJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726768AbgGJInI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:43:08 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90981C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:43:08 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so2308347pjc.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hhtnEx6dVeh1pIqAmosCNZhZcA/Z3fpbgOYNTfBYRV4=;
        b=g2s1CDwYeUKSsFf51AeXZTtmaoN9C4VL/GLDNi2YxoJEHHm64z71k/YlwJ7Xw2+G9g
         jRxc27VwsInmy99MCVdvieVe7uMtwAFnMdP+4YjAey7hG6Ju9XXlR1yorkrHJW1V10hE
         YZyPxgHk6FxjvRFL7J9P+BeLiahGfuLHbSWPgtTlrLSnPSTJWb2m3qA92FY3+eBagapw
         sKo5GfhJPWMI1uFxPYG0EXuXe2me2P3d8YdXcL1T+y0eV2Iqv9dZHZ/gP9KIvz5WtV6B
         ZX2aM26bCnBrzlHWi1moZ67gTAmUOW4x45MDto6Bvb1OE/Bg0fzNcHaTxdYlKJ+ARJWA
         lmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hhtnEx6dVeh1pIqAmosCNZhZcA/Z3fpbgOYNTfBYRV4=;
        b=Cv/uRlYYWgtl9UJFW+m14nFmYigsWqOhHb4qnIpY0lrU+vmmhqLq72aqs5B/8Cmj2T
         2jRYel35jYroG5W5Dm4Yu+M8aii6CwV//pqNp7+pwhB7gL2nSSJSYj3HA67u/bkz/QNi
         aQOLp/+yfe3Q2H6eznhv+ZQeBcZzeJNA5/1c1Bk1MXCVHw5Kw2lZ4+dVkwo3BhGPtHRO
         ygds4Bqu8SjBx+B/iLuSdSP3uL3s3eEx6NpGzFd/sE6dN1ql75MogPj3SKP8xCjcwj1m
         RSnKUPwm+8AfSp6eeUcB3zr9llIK+EZ+LfriWckGEolfnewawcfZRXK7cOXuuMDQr1pK
         bn2Q==
X-Gm-Message-State: AOAM530v4f7vLgafHsnhkMoxdWVILZY+zz93C46vXy6mqPJR0Ma41l6n
        bEEF1mucOlJX7oaRrEjohwE=
X-Google-Smtp-Source: ABdhPJxBLRQw26sPOP45jGvpadgol3owKYDArwzGTR3fAUpm3H+PFbQX2BpsL1pSy+mq7KBNO7W0Lw==
X-Received: by 2002:a17:90b:300d:: with SMTP id hg13mr4764487pjb.212.1594370588081;
        Fri, 10 Jul 2020 01:43:08 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id j70sm5123354pfd.208.2020.07.10.01.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 01:43:07 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 10 Jul 2020 17:43:05 +0900
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] printk: add lockless ringbuffer
Message-ID: <20200710084305.GA144760@jagdpanzerIV.localdomain>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709132344.760-3-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/09 15:29), John Ogness wrote:
[..]
> +/*
> + * A data block: mapped directly to the beginning of the data block area
> + * specified as a logical position within the data ring.
> + *
> + * @id:   the ID of the associated descriptor
> + * @data: the writer data
> + *
> + * Note that the size of a data block is only known by its associated
> + * descriptor.
> + */
> +struct prb_data_block {
> +	unsigned long	id;
> +	char		data[0];
> +};

A nit: I think someone will send "Replace zero-length arrays with
flexible array member" soon enough:

-	char		data[0];
+	char		data[];

[..]
> +/*
> + * Sanity checker for reserve size. The ringbuffer code assumes that a data
> + * block does not exceed the maximum possible size that could fit within the
> + * ringbuffer. This function provides that basic size check so that the
> + * assumption is safe.
> + *
> + * Writers are also not allowed to write 0-sized (data-less) records. Such
> + * records are used only internally by the ringbuffer.
> + */
> +static bool data_check_size(struct prb_data_ring *data_ring, unsigned int size)
> +{
> +	struct prb_data_block *db = NULL;
> +
> +	/*
> +	 * Writers are not allowed to write data-less records. Such records
> +	 * are used only internally by the ringbuffer to denote records where
> +	 * their data failed to allocate or have been lost.
> +	 */

A nit: The same data-less records comment is some 5 lines earlier. But OK.

> +	if (size == 0)
> +		return false;

[..]

> +void prb_init(struct printk_ringbuffer *rb,
> +	      char *text_buf, unsigned int textbits,
> +	      char *dict_buf, unsigned int dictbits,
> +	      struct prb_desc *descs, unsigned int descbits)
> +{
> +	memset(descs, 0, _DESCS_COUNT(descbits) * sizeof(descs[0]));
> +
> +	rb->desc_ring.count_bits = descbits;
> +	rb->desc_ring.descs = descs;
> +	atomic_long_set(&rb->desc_ring.head_id, DESC0_ID(descbits));
> +	atomic_long_set(&rb->desc_ring.tail_id, DESC0_ID(descbits));
> +
> +	rb->text_data_ring.size_bits = textbits;
> +	rb->text_data_ring.data = text_buf;
> +	atomic_long_set(&rb->text_data_ring.head_lpos, BLK0_LPOS(textbits));
> +	atomic_long_set(&rb->text_data_ring.tail_lpos, BLK0_LPOS(textbits));
> +
> +	rb->dict_data_ring.size_bits = dictbits;
> +	rb->dict_data_ring.data = dict_buf;
> +	atomic_long_set(&rb->dict_data_ring.head_lpos, BLK0_LPOS(dictbits));
> +	atomic_long_set(&rb->dict_data_ring.tail_lpos, BLK0_LPOS(dictbits));
> +

Just a side note: some people want !CONFIG_PRINTK builds. I wonder
how many people will want !CONFIG_PRINTK_DICT. The core logbuf/dict
logbuf split is really cool.

	-ss
