Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6C3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BA8E2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp/qFx/2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGJIrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgGJIrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:47:47 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BB0C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:47:47 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a14so2262837pfi.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VPfdSIBiY/LrF+RSBVzZYCylwvTBI1ptCzEHHop17wc=;
        b=Yp/qFx/2p3EnnUXrm7VR17WLr/E0UGcn2WAJYARa1v29kwp46zEK61WBXCqsUFGdzk
         FvSQGWy98bgp+OyRgC/WkUXex0Npmd/wtI/XqKzOpPPJIKN3lRHn0ZDYm+iFhYPiwoFU
         bdlHwmeOZt06Grc+L5wT4V+5Mxw/rJfphrpIHjPe8lXB9wvW9TPeT1EmEnG02FyJuCLu
         KeJY0xHdp7Ogi8PjAFqq7SeQSEmtWHg1PkvGRs4kdYMa4YsOf8LuqTd48d2DHTKm3LZM
         NM4ywnjqZxD4ZXByAK5jexK0NCHduL8lyR60tdUclVKWzKddvT6rHjXOkHCiDn0C0Tqz
         sb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VPfdSIBiY/LrF+RSBVzZYCylwvTBI1ptCzEHHop17wc=;
        b=quK/A6f9/xRF/tMabrrAPxs5/mDraJie4eyJvxpJ5amLbnHpwPy4JY46AB95ynYbnK
         Nmz7yY6GkdgKUCgqssOjR81Sj3/WdeZ/OZw1Vx35E7pXLPUzhDLFcubYvGqs0yQbDf9h
         CDNCna1ChZo0H8pSk/amluTVRmY6eTMRJOpImOovQejYcmILWBF+MyuUbemvRdMqywQQ
         TYJUakUMAhaef2vpM4ed22aRnvFDbAnozpcGQtAADn81+qJfomRuXU1/8Dv+uht2tKQc
         Kyk0DhCRFPzWVZA3mGdwkmj3dnMXtaV9lIOI76W6Wr9qn3M6XjP10qqp084DwZz8f51k
         HTgA==
X-Gm-Message-State: AOAM533nIPwSDLBhlmv2357hNXtgvTje17052BFdaHRUk6JXwUKt5HNI
        +tteMIfE5TelFGFFv/oMXuY=
X-Google-Smtp-Source: ABdhPJxlGdcOsq9bVPMes8Lj9TnAWAK301Wx0rVMH5xXzJ8S1/sxAgVMmymfG4j0XmGUrIthSBDX9Q==
X-Received: by 2002:a65:584e:: with SMTP id s14mr56018153pgr.151.1594370867124;
        Fri, 10 Jul 2020 01:47:47 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id z1sm5131769pgk.89.2020.07.10.01.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 01:47:46 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 10 Jul 2020 17:47:44 +0900
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] printk: add lockless ringbuffer
Message-ID: <20200710084744.GA488397@jagdpanzerIV.localdomain>
References: <20200709132344.760-1-john.ogness@linutronix.de>
 <20200709132344.760-3-john.ogness@linutronix.de>
 <20200710084305.GA144760@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710084305.GA144760@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/10 17:43), Sergey Senozhatsky wrote:
> [..]
> 
> > +void prb_init(struct printk_ringbuffer *rb,
> > +	      char *text_buf, unsigned int textbits,
> > +	      char *dict_buf, unsigned int dictbits,
> > +	      struct prb_desc *descs, unsigned int descbits)
> > +{
> > +	memset(descs, 0, _DESCS_COUNT(descbits) * sizeof(descs[0]));
> > +
> > +	rb->desc_ring.count_bits = descbits;
> > +	rb->desc_ring.descs = descs;
> > +	atomic_long_set(&rb->desc_ring.head_id, DESC0_ID(descbits));
> > +	atomic_long_set(&rb->desc_ring.tail_id, DESC0_ID(descbits));
> > +
> > +	rb->text_data_ring.size_bits = textbits;
> > +	rb->text_data_ring.data = text_buf;
> > +	atomic_long_set(&rb->text_data_ring.head_lpos, BLK0_LPOS(textbits));
> > +	atomic_long_set(&rb->text_data_ring.tail_lpos, BLK0_LPOS(textbits));
> > +
> > +	rb->dict_data_ring.size_bits = dictbits;
> > +	rb->dict_data_ring.data = dict_buf;
> > +	atomic_long_set(&rb->dict_data_ring.head_lpos, BLK0_LPOS(dictbits));
> > +	atomic_long_set(&rb->dict_data_ring.tail_lpos, BLK0_LPOS(dictbits));
> > +
> 
> Just a side note: some people want !CONFIG_PRINTK builds. I wonder
> how many people will want !CONFIG_PRINTK_DICT. The core logbuf/dict
> logbuf split is really cool.

We also may be can add a dedicated logbuf for the user-space logs,
as opposed to current "user space can write to the kernel logbuf".
Some folks really dislike that systemd, for instance, can trash
the core kernel logbuf doing a lot of /dev/kmsg writes.

	-ss
