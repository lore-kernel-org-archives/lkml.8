Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 038B4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D106A20719
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNt5D6E0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgG0Ixr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgG0Ixq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:53:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7D8C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 01:53:46 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a9so8901922pjd.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 01:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dlbk2wv3IwbKr19nsqbGp2cZk7iHJ7ID8YfsZ80+he0=;
        b=oNt5D6E01AoIzbc4pvn57XvzmtTWDWJ6t2DuiJFoyey0DfLT/XPVmpnSpqaZsiEH4m
         MuARdtorq63WDmi3Cg7BON2satHovIUoaO75IJNdEkPjYIXL/b33r23C34sUFR3zHRRT
         4ijvagufLooaKwPBBJh9tem09s4YAmMLnw5zhfckxgwQA3Rdwy0ekwhOa38xK1Yl4K1U
         hhD08livvjTmYhXwDa8otIdPHAT0nnf8OyZkIWPVNfK3xmQPziZrmFpyAvr6B1s8nO6W
         KWP3kNLxydVtOfIYGSPfmbb/eGRJW9puKFLwAmYxReBzJMwQy3gckH+8swF6zs325zjP
         Pprg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dlbk2wv3IwbKr19nsqbGp2cZk7iHJ7ID8YfsZ80+he0=;
        b=pdOkxpErOEgXqRXgAQkdZUBBIBFkoUFpxNaIuSOhdbxy510o1ZcVc16KjcvMiKXONg
         mJDo6mgGwMQPWC+36VtKkLDeBNpOl47UkyG16zSwv06IWYXMBbE4BGsCO2DfOOGD4Emp
         qJGXrpDo1oQ8GJaWjgJww+iKkjhczLq9lhjKfVu35ETjkfYNKpszAcsoqVHzm+e8zPHn
         Q3gcDGb/mbpoJw85yUuziTR5TXmiL/JPdA7rZdGQTpDNJxQw7ZOBXXg4rK8PO1r+lFll
         +SV7ZG2caHB0NylPeIXJtR8ccsASbvlEsRB5GMzxHx/hm0fwQh5+IRT/UwvM3Fu3DBBN
         ytdQ==
X-Gm-Message-State: AOAM533/+t7AMZUTTgCTSbnWF0wCYXBqoireJSMdp0RtYEWNS5B0btWb
        gmUA5C2ih4ObxyBh35XwUAY=
X-Google-Smtp-Source: ABdhPJw9ONJW+8Y7CSU3U+NA09a/iAa0fYex9PRdJYd9hn+45tASoAqKdztcxPiG7qEzOKHBySa4gQ==
X-Received: by 2002:a17:90a:6acb:: with SMTP id b11mr17506051pjm.71.1595840026121;
        Mon, 27 Jul 2020 01:53:46 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id br9sm13200664pjb.56.2020.07.27.01.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 01:53:45 -0700 (PDT)
Date:   Mon, 27 Jul 2020 17:53:43 +0900
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
Subject: Re: [PATCH v2][next] printk: ringbuffer: support dataless records
Message-ID: <20200727085343.GF1386@jagdpanzerIV.localdomain>
References: <20200721132528.9661-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721132528.9661-1-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/21 15:31), John Ogness wrote:
> With commit ("printk: use the lockless ringbuffer"), printk()
> started silently dropping messages without text because such
> records are not supported by the new printk ringbuffer.
> 
> Add support for such records.
> 
> Currently dataless records are denoted by INVALID_LPOS in order
> to recognize failed prb_reserve() calls. Change the ringbuffer
> to instead use two different identifiers (FAILED_LPOS and
> NO_LPOS) to distinguish between failed prb_reserve() records and
> successful dataless records, respectively.
> 
> Fixes: ("printk: use the lockless ringbuffer")
> Fixes: https://lkml.kernel.org/r/20200718121053.GA691245@elver.google.com
> Reported-by: Marco Elver <elver@google.com>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Applied to printk-rework, thanks.

	-ss
