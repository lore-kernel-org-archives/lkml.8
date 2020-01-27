Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B8BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 132362067C
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 12:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbgA0MVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 07:21:09 -0500
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:35412 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgA0MVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 07:21:08 -0500
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 7A5CF3C0594;
        Mon, 27 Jan 2020 13:21:06 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kE-ke1A_4OPT; Mon, 27 Jan 2020 13:21:01 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 2978E3C00C5;
        Mon, 27 Jan 2020 13:20:43 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.93.66) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.468.0; Mon, 27 Jan
 2020 13:20:42 +0100
Date:   Mon, 27 Jan 2020 13:20:39 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     John Ogness <john.ogness@linutronix.de>
CC:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <andrea.parri@amarulasolutions.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        <kexec@lists.infradead.org>, Eugeniu Rosca <erosca@de.adit-jv.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH v5 0/3] printk: new ringbuffer implementation
Message-ID: <20200127122039.GA2358@lxhi-065.adit-jv.com>
References: <20191128015235.12940-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191128015235.12940-1-john.ogness@linutronix.de>
X-Originating-IP: [10.72.93.66]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Thu, Nov 28, 2019 at 02:58:32AM +0106, John Ogness wrote:
> Hello,
> 
> This is a follow-up RFC on the work to re-implement much of the
> core of printk. The threads for the previous RFC versions are
> here[0][1][2][3].
> 
> This RFC includes only the ringbuffer and a test module. This is
> a rewrite of the proposed ringbuffer, now based on the proof of
> concept[4] from Petr Mladek as agreed at the meeting[5] during
> LPC2019 in Lisbon.
> 
> [0] https://lkml.kernel.org/r/20190212143003.48446-1-john.ogness@linutronix.de
> [1] https://lkml.kernel.org/r/20190607162349.18199-1-john.ogness@linutronix.de
> [2] https://lkml.kernel.org/r/20190727013333.11260-1-john.ogness@linutronix.de
> [3] https://lkml.kernel.org/r/20190807222634.1723-1-john.ogness@linutronix.de
> [4] https://lkml.kernel.org/r/20190704103321.10022-1-pmladek@suse.com
> [5] https://lkml.kernel.org/r/87k1acz5rx.fsf@linutronix.de
> 
> John Ogness (3):
>   printk-rb: new printk ringbuffer implementation (writer)
>   printk-rb: new printk ringbuffer implementation (reader)
>   printk-rb: add test module

As a follow-up to the discussion started in [*], I would like to stress
once again that it is extremely convenient to have the context of the
console drivers detached from the printk callers, particularly to
mitigate the issue described in [*].

I gave the test module from this series a try, by running it overnight
on R-Car H3ULCB, and spotted no issues whatsoever. I won't post any
signatures, as this is RFC, but I would be willing to do so for any
upcoming non-RFC series. Looking forward to that!

[*] https://lore.kernel.org/linux-serial/20200120230522.GA23636@lxhi-065.adit-jv.com/

-- 
Best Regards
Eugeniu Rosca
