Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14AFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D6502176B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595245225;
	bh=9qq8bjEm5fsXIN2xvcRfAkCefRjp9TgzWYUfp2xA8cE=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=Waa8H0RynKCwdcpQawWnxyAUM97ru5kBw0FJ/1xnRF5sp87bRcVvRTJ8f1lhBg/xn
	 B6JxYbJ72ZC96BaXsO2P9zI7LJ7gChs/9/3IFjkV+lVE8rXGJvgx7AboYTAUHNQ3+A
	 zHYwJK5Rik8U40tSaAV3Yv5vxG0zMjb+XPD8bs90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgGTLkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 07:40:24 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:45678 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727887AbgGTLkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 07:40:23 -0400
Received: by mail-ej1-f50.google.com with SMTP id a1so17653885ejg.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 04:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hqiX6Q87pkqMHVPDuaXOUOL1+RdGGgT/OYosWJBzCRQ=;
        b=EGIefytrwKSR1jyNJJxQ1/9PeSvY71H1AsFdanvspxHJrgA9yNzJeJtdHwk4ewFzvp
         12H9nAORZ6TgPoMn2X5qSokTKkc+m3Q8LyC4KVu6HOrDq98qUDosngqqBszPddT9nVfQ
         B3HMCZS/VTMZTKUnSnUBTQWf7/6dqDm8wP6DjW5FOIvIIc2PZfz8S+UiK0GmZa0Yndk7
         9Md4FOnDpXld6X20eqXFb6fQ/ttTUdgrZJR4mRpuFpXA8XbEPMS5bFJ0yyxO2grfZcY0
         I0S+oPtg6/mrLR/EGqzZ88Q3CqJRxVxQ4nY0CLDP3Tp3rR+0BqkfN/P2xLVxZWdsAYvA
         yQdw==
X-Gm-Message-State: AOAM532NsmS2HyQoa8IE61z8tjt5HysDaCqHVZTVMIVgS8A37KkP956p
        XaLus8LOa+kzk8zylSBvdLU=
X-Google-Smtp-Source: ABdhPJzqDnlnjpT7UoaOluX3p7nLmkjbafdBqvjuwFTUbYCDqqUlCUjW6sWNIKim1cKAg3f+cMmKXw==
X-Received: by 2002:a17:906:1ec3:: with SMTP id m3mr20599958ejj.197.1595245222089;
        Mon, 20 Jul 2020 04:40:22 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id b11sm15422489edw.76.2020.07.20.04.40.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 04:40:21 -0700 (PDT)
Subject: Re: 5.8-rc*: kernel BUG at kernel/signal.c:1917
To:     peterz@infradead.org, Oleg Nesterov <oleg@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        christian@brauner.io, "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Dave Jones <davej@codemonkey.org.uk>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
References: <20200717122651.GA6067@redhat.com>
 <20200717124017.GB6067@redhat.com>
 <2c8ef23c-43b4-39d4-8e84-92769c948da9@kernel.org>
 <20200718171406.GB16791@redhat.com>
 <20200718174448.4btbjcvp6wbbdgts@wittgenstein>
 <badcb9d5-f628-2be1-7a72-902cf08010bd@kernel.org>
 <20200720064326.GA6612@redhat.com> <20200720082657.GC6612@redhat.com>
 <20200720084106.GJ10769@hirez.programming.kicks-ass.net>
 <20200720105924.GE43129@hirez.programming.kicks-ass.net>
 <20200720112623.GF43129@hirez.programming.kicks-ass.net>
From:   Jiri Slaby <jirislaby@kernel.org>
Message-ID: <4df1e23a-8b07-8439-c54b-6ef9864aa78a@kernel.org>
Date:   Mon, 20 Jul 2020 13:40:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720112623.GF43129@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 07. 20, 13:26, peterz@infradead.org wrote:
> On Mon, Jul 20, 2020 at 12:59:24PM +0200, peterz@infradead.org wrote:
>> On Mon, Jul 20, 2020 at 10:41:06AM +0200, Peter Zijlstra wrote:
>>> On Mon, Jul 20, 2020 at 10:26:58AM +0200, Oleg Nesterov wrote:
>>>> Peter,
>>>>
>>>> Let me add another note. TASK_TRACED/TASK_STOPPED was always protected by
>>>> ->siglock. In particular, ttwu(__TASK_TRACED) must be always called with
>>>> ->siglock held. That is why ptrace_freeze_traced() assumes it can safely
>>>> do s/TASK_TRACED/__TASK_TRACED/ under spin_lock(siglock).
>>>>
>>>> Can this change race with
>>>>
>>>> 		if (signal_pending_state(prev->state, prev)) {
>>>> 			prev->state = TASK_RUNNING;
>>>> 		}
>>>>
>>>> in __schedule() ? Hopefully not, signal-state is protected by siglock too.
>>>>
>>>> So I think this logic was correct even if it doesn't look nice. But "doesn't
>>>> look nice" is true for the whole ptrace code ;)
>>>
>>> *groan*... another bit of obscure magic :-(
>>>
>>> let me go try and wake up and figure out how best to deal with this.
> 
> This then? That seems to survive the strace thing.

FWIW for me too.

thanks,
-- 
js
