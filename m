Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2771FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0428520656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592847196;
	bh=x+nJq9gBtXYA1xAuga1Ifi6I0GiG1Wy8FhcZBatiajU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kPoHTrh1Ck7hTE7W7GLgXFnUrfXn5oB6Vx3DLCXJRIwIZbM1aCLXWEmkIQmq//aoR
	 eFM/ZNs2ILC0jlUTZ1zywdrlw+RT15mf74QuOpAp5RGUimhiW+fjaoNsZWsahNXLMD
	 sVZoqd/22Z+IBt0262lrMOgSqo/Nm2UmQnn/AzJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730196AbgFVRdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730122AbgFVRdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:33:13 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC768C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:33:11 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x18so20264545lji.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qS8rlq857F7iYBSfMLLx4hHB6U15Rzq9z9mfZC7Kzmg=;
        b=I6DrtN0aEZ1W7G8qhKoDRvFtV8oR6SUv/fT89Zl+kYuExEWbeXrbKlekNYD8YjK+Re
         hGi2TPi7oDDzqdReS/8xUqBJI4sr7q8HWyWwIPVcQhLOm+rtNiQTpKq/qm7AePg7IHEI
         EsDHb5+NobzF/ucrDtFaRnWi0RW6vptXh0x+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qS8rlq857F7iYBSfMLLx4hHB6U15Rzq9z9mfZC7Kzmg=;
        b=uP+u6npUpmRqcG7pbDdXjcDlKWrQaPyxxun20nLlUI4+SVHD+C7k+wety69NN7tsiJ
         q+tjnLbziPpP71VPsD7Cannc6TGlgnQczPq0U1eslF4ccgomjuKsza3Sk/+InqxL7sYA
         KJ0Y6XENNeOEBeZvpZl4Akn5O8nrSFay0CAULUaMwGwdZat7kZ62I7LpGn9rR77Oohev
         xc2mGbXasJCHnPu/2Mohl8Cf6ceuDdNkd+5lSXVOsf+61kPfpyp7rD0TtqOeCzJA73JX
         KdOXSrpr9pqQPqeK0107UmLpVU/WNkxBwLto49FxCM4mqS6t60wvMrHXXGNEdsyg4+2I
         8kpA==
X-Gm-Message-State: AOAM530zvMIGKCaxEC/nTsum45zKHpx4mrk7jx/W/BzTN1QP3Chok8NZ
        iPl+6wTDwy6hbPSaVNh4ozvWRqMXT3c=
X-Google-Smtp-Source: ABdhPJyLs13zSk5PJ1d65xa3RrW6zfUvQYQl9Pn+h1ZBoC5QSrKJ2ysE64eWH01J5bQXWnwP6VKymA==
X-Received: by 2002:a2e:b5bc:: with SMTP id f28mr8834789ljn.394.1592847189251;
        Mon, 22 Jun 2020 10:33:09 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s18sm3292488ljj.63.2020.06.22.10.33.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 10:33:08 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id a9so20268143ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:33:07 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr8590245ljn.70.1592847187519;
 Mon, 22 Jun 2020 10:33:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200622030222.1370098-1-Jason@zx2c4.com> <CAHk-=wj5TPoHih-8m+s9UNShiKavUFLacmHFmNbDrXQem43kSA@mail.gmail.com>
 <20200622133747.GD2850@glitch> <CAHk-=wgR8TZi_M4p3PZQh5nGjUjNBeXqhGyxUe8eykyf8g6p=A@mail.gmail.com>
 <20200622171001.GF2850@glitch>
In-Reply-To: <20200622171001.GF2850@glitch>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 22 Jun 2020 10:32:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg6vtnyxW6DR6_pTmMowjd9SuULu4C0DJBXCzJz8XgyXg@mail.gmail.com>
Message-ID: <CAHk-=wg6vtnyxW6DR6_pTmMowjd9SuULu4C0DJBXCzJz8XgyXg@mail.gmail.com>
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

On Mon, Jun 22, 2020 at 10:10 AM Bruno Meneguele <bmeneg@redhat.com> wrote:
>
> Although both options are pretty fine by me too, I "fear" (not really)
> we can end up stacking special behavior interfaces, forcing userspace to
> keep a "table of special case files". Personally, I prefer to return
> something _valid_ to userspace rather than _fail_ with special meaning.

Well, what's even worse if user space has to handle two different
things just because behavior changed in different kernels..

So at some point "odd behavior" is much better than "odd behavior in
two different ways"..

                    Linus
