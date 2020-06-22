Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AD9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FA52073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 16:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592844167;
	bh=j9RmD9qEztTmkv8IrXZ4rpp60ujK/IENdtE9b0ttDHA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=O7PlNUE4LtHCpdBzULUNNvDnSrmSpkrN1uGRZ8AIBH1aMYxmKa/YruS8RfN5l61bB
	 5wje9k557gMSu7e+JPP62b97XMC45g5B/sgccmtXulUQlmnRTT+oeVg0dOmVTb/0Rs
	 xvGuAFgnJzV0JHhgIjOSbr/vnMxOLOkpiZMv9Ybs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgFVQmq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 12:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbgFVQmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 12:42:45 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1601EC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:42:45 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n24so20049017lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bioh+BBjrn8lfhGJU2vSscKrqgHvIa0YiWgSVaXIKk0=;
        b=L+z0IZKykUBFS0YqWDjAmY+wO4YVKJ/tRwgisWQle1k44UsBmPcahzs8ifuDU8djes
         OJGNCtXFOfX/eo/OdCIa2SQT08iS+s4+eexRbyPteoxEgHXyBvNxhXTALA0LFUiK516K
         5LxY5wqnTstVM8qg8SRRWqsqYEFko76b/eRgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bioh+BBjrn8lfhGJU2vSscKrqgHvIa0YiWgSVaXIKk0=;
        b=imylYud0Jc45/MwVHtX0QTLiYucdHsrVKrgvAdbTXr1OhvLudXpV7BO+w+R1iogMxD
         VrkTRzISkidUncSuBNsr6Ge8K6XLRxDNAmyJ+r3T7Gu9nhXaDDyyM6kitN0x3FEWIYSK
         V9Z8yZxFNtFoGPIXiX+jU5WQAQoJX3jkCwhpa1h3ucNVbCKVB8TIt9UytJ0LQ4/iycOg
         mtSg4BBmine2czZnIy7As+QJFFZYvofRIo0WbMSaVrBL7POSw6MpslxQuKqGL8/+FJAv
         ww5vxrLe90FrA+6z5oNwsmvT5zVv66y7xzyz30gLn3OuMY+V5EJ3w1BLMtOtx5fOlJsV
         RBnw==
X-Gm-Message-State: AOAM530u/mZNSUvnwyZDxtWHSvCSFQHLo+MoBlihHSVFQlqcTLbhfpAn
        nE1AuPqFRlcNi9e9BUl9afgSV4RHhX0=
X-Google-Smtp-Source: ABdhPJyMAw0BMCKHhUo19cg+Bpi5ZYcmSYiiBnHBJxx+5BUBB/W+lvHkyXOHU0YTTZ+P5vFKkhrJmA==
X-Received: by 2002:a2e:6e17:: with SMTP id j23mr9483555ljc.194.1592844163244;
        Mon, 22 Jun 2020 09:42:43 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id b6sm3570458lfe.28.2020.06.22.09.42.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 09:42:42 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id o4so10023976lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 09:42:41 -0700 (PDT)
X-Received: by 2002:a19:ae0f:: with SMTP id f15mr10345309lfc.142.1592844161606;
 Mon, 22 Jun 2020 09:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200622030222.1370098-1-Jason@zx2c4.com> <CAHk-=wj5TPoHih-8m+s9UNShiKavUFLacmHFmNbDrXQem43kSA@mail.gmail.com>
 <20200622133747.GD2850@glitch>
In-Reply-To: <20200622133747.GD2850@glitch>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Jun 2020 09:42:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgR8TZi_M4p3PZQh5nGjUjNBeXqhGyxUe8eykyf8g6p=A@mail.gmail.com>
Message-ID: <CAHk-=wgR8TZi_M4p3PZQh5nGjUjNBeXqhGyxUe8eykyf8g6p=A@mail.gmail.com>
Subject: Re: [PATCH] Revert "kernel/printk: add kmsg SEEK_CUR handling"
To:     Bruno Meneguele <bmeneg@redhat.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Petr Mladek <pmladek@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 6:38 AM Bruno Meneguele <bmeneg@redhat.com> wrote:
>
> However, the issue with glibc is their fd checking on dprintf using:
>
> lseek(offset == 0, whence == SEEK_CUR)
>
> Which, technically, isn't a relative seek operation in my opinion, thus
> I'm also not sure that returning EINVAL is correct.

Well, I'm not sure there is a "correct". Normal file descriptors are
seekable or not, this is kind of a special one. It's not like you can
read it byte for byte anyway.

There is a "historical behavior".

> Would it make sense to return the next buffer index instead? Basically
> the same as SEEK_END does? The first "if (offset)" in the function would
> prevent any real relative move while SEEK_CUR would return a valid
> address following this buffer behavior of specific points it could seek
> to.

Maybe. At the same time, the way we don't actually return a real
position means that that's very dangerous too. We'll always return
"we're at position zero".

And we never accept byte-by-byte reads and require a "get the whole
record" model.

So I think we might as well accept "kmsg is special".

I don't have hugely strong opinions on it - I certainly agree that
"SEEK_CUR with offset zero could be a no-op", but I also don't think
there's a huge reason to try to change it, considering just _how_
special kmsg is.

               Linus
