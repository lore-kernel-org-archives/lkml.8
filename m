Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E9FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A169208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 01:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597885453;
	bh=0SiGCBScRYPXi3AwdI79bgh6dUViQxpzY3UfosvwmM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oHNvjnsNqRt18xOBrwzISOFnrHOdbRmquy1XoiNLJFU9JZJ0g0AFr7c65ViGqHPfK
	 Zs33RBxjRwt08dhb2gJLOy7BBB46EbeBboxdJjFiBh2+5p1NhhDxTS0RZFb71vyTZz
	 pP1bnrUJ/L/foF0EATjsI0MLttfG4EOGcqt7Mmto=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgHTBEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 21:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgHTBEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 21:04:10 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0FDC061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 18:04:09 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m22so350396ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 18:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X6P/FNagdqkkpSy7AqyDBRJaYe+0TWTMAJVZbzJ7bIE=;
        b=D4qu7B5wNxkh7Z/r4vioR1rca1gGDrJYQ4JsOdhT2sCSAaHbVr5cAo/ZZXtSwKczrO
         Re3Q38z9hDs07kd4Jgyr+z11lPQvMrnHqRWRtrWMpThs+G696okXU5oKGMTJAy4R0AoX
         WXIFCpBT71NAC6LGG/ZRB3r6+4J0y9mZyAc/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X6P/FNagdqkkpSy7AqyDBRJaYe+0TWTMAJVZbzJ7bIE=;
        b=c+mNOdBUhB7+agcvhwE4FBgZ/ryUgxYHTNRkMCPfaPy2adrRsSspHpKVG8I3uehn5T
         yWW9RRsiI2kdTzuYKDlAmuY+hcbPph0X9zNkxZFZjdyb/KLGgVSc2/Q1U+4yzCnOPRWo
         HGc3pHRW+pT2b4+TYbXACnoj4kwG0fvgB+0e/BylDlfEIfgF25RsgY95ulLe6wnacefo
         b1fqAsJ5jXpDqBNiGVEfxlH4RhJkLYd+npRFn5JXrpRoVTDELoJhyLhOeH6ynsDun6HN
         MfDIhREW8cUCOR7rQfTH2wsHIGgo+WJ5QB+G+Ee8hf9VaRTMisgQFLZmu2c4ovnVlG2D
         qxgA==
X-Gm-Message-State: AOAM532qD4XTGD4Rj0s9Pd5MLj8G2I7S7/tArNOnNJQqq+B/AOJp9dcl
        FWeoI3DL0KVhviewBW8j8/zNHZ7n3aPjDg==
X-Google-Smtp-Source: ABdhPJzqQ7Geagv3rebyj8Id3Glw/u3np+PV6iTTZNW4uQrwQm0LR1c5tMUaJnVSN7WqskXyXQ/cnQ==
X-Received: by 2002:a2e:8702:: with SMTP id m2mr355357lji.183.1597885447839;
        Wed, 19 Aug 2020 18:04:07 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id r19sm116371ljc.59.2020.08.19.18.04.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 18:04:06 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id f26so334808ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 18:04:06 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr363648lju.102.1597885446188;
 Wed, 19 Aug 2020 18:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200819232632.13418-1-john.ogness@linutronix.de> <20200819232632.13418-3-john.ogness@linutronix.de>
In-Reply-To: <20200819232632.13418-3-john.ogness@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Aug 2020 18:03:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com>
Message-ID: <CAHk-=wj_b6Bh=d-Wwh0xYqoQBhHkYeExhszkpxdRA6GjTvkRiQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/5] sysrq: use pr_cont_t for cont messages
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 4:26 PM John Ogness <john.ogness@linutronix.de> wrote:
>
> Use the new pr_cont_t mechanism.

This looks actively much worse than the old code.

Don't do this.

Just make pr_cont() do what it used to do.

                 Linus
