Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE74C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3694D22C9C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vK1PKtYG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgGTOT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgGTOT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:19:57 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE61C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:19:56 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 22so22458793wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 07:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8woIlJHkLgAsPI3cD2JJ3LOe13MSqtQkks1ZSw5oXCw=;
        b=vK1PKtYG3VjFM/C83cSvIO4JZh12eSa0T3vZioL+lMlhihnQQNQMj8nGLau/10mJFb
         zj+uQAF4FWLQvDehSL26Lmc0aE4DQf2/e3Q/F3flUyGxOmKTkNzj7Ly7x1bpNEUTfdZN
         pjo1mJoPCBcvi5n4Qu8QljjTv4syD8BeDpnDrxNjjiewZ1ZHrPKL3oX12DuDhrPlKg2M
         gtdHlCCZzneMz5y+RPsc+a3K7C7S5zyzLIV6Z0CuUuTHtu/ae4if8TFpipf6oq4lbmqO
         F0w01TZr/YoWLuDFJhrRChFeedenxzOjOThlzr5XP2eB4TYZDMbX/PySsl0DvO7QMy5D
         9LaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8woIlJHkLgAsPI3cD2JJ3LOe13MSqtQkks1ZSw5oXCw=;
        b=jznUwXnAQzOQk+oN+5zcJ0DU6dn19Euu5mU172647g8kPqxYCBLxvpHCyhGYxJo8ip
         CLhUWxtjZ0WgInA2KtGtq2mVH5rIpMW8Y3Qatwo9eaTmyFUr0wI0ao9kMnDcsfJH/Ri/
         UBEpLIa4PD6nbpO3A4iI9KBr0JgMSASyw+R4KGLC9f+9HMpEG1/C89zuf58fufZF1sea
         tNKYxlfSZ+rI3FNJMPtG1RvGaNKK/XwMev0QOFNtht8HFm4x3bbv49qroC50oRXjgUyD
         QSIRYhwTPLxziNZMcpJ9MDSL9qmDmPp92S65PVBUFV+Bur7vgF55m2YyK4kS9TozzXzC
         QN8A==
X-Gm-Message-State: AOAM530zCtbL7OAFdVNUtKiO3kNP8y26c1wXs4VYo77tmNh6OzmNGhih
        fdI5zjCsXSbXzZt3/ovNz3Gukg==
X-Google-Smtp-Source: ABdhPJzKmUSHDmS2ctRAuFDqI/v2Bp1Kwr3JpNiyYztfiSBIDB+ZEnb4r3Jc1qqf9fQApz2WBAZa0g==
X-Received: by 2002:a7b:c857:: with SMTP id c23mr23327825wml.155.1595254795443;
        Mon, 20 Jul 2020 07:19:55 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id s14sm20544955wrv.24.2020.07.20.07.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 07:19:54 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:19:49 +0200
From:   Marco Elver <elver@google.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] printk: ringbuffer: support dataless records
Message-ID: <20200720141949.GA2471546@elver.google.com>
References: <20200720140111.19935-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720140111.19935-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 04:07PM +0206, John Ogness wrote:
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
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  based on next-20200720
> 
>  kernel/printk/printk_ringbuffer.c | 58 ++++++++++++++-----------------
>  kernel/printk/printk_ringbuffer.h | 15 ++++----
>  2 files changed, 35 insertions(+), 38 deletions(-)

Thanks! Ran a couple tests and sanitizer report blank lines are back
where they're expected.

Tested-by: Marco Elver <elver@google.com>
