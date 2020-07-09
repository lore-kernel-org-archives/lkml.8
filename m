Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46026C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18D5E2065D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YxVpPnUM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TWsmltBc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgGIHDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:03:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33022 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726140AbgGIHDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:03:44 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594278222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b094mquuzsSv4LF1uZkVaKAu65Nvlb3yg5Y2rgetvew=;
        b=YxVpPnUMWW4M+ckySVPwnqBLPQAXP016ktzDOSgX8oNn0pBLjg0MJaFhSiH1c0nHqSSSdD
        NeqCk9ylTuciVG+UX7a5SykXAuqNBVHEKWuSE3HyKhQvJwHEqNtdJQeUDpnilr9fb/s8hG
        klu9I89PX5PzxjTNlXkvdtBbi/kVbiDvRBxyHmeuTVEtOQAK+Wvrx2azj/0etXfBeJAupa
        EIAs5Udhe7RhXN/WM9SlkHD0vKo8tiogzWsV02zwPgS0+1PjYC7/iyfrz0iPHckwlEXoQ0
        uroTd8dzJoS5kC7a0ftoaWTRkofUtGAPPFD2+ESs8BdlhPn2czpU3TAmmDPPWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594278222;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b094mquuzsSv4LF1uZkVaKAu65Nvlb3yg5Y2rgetvew=;
        b=TWsmltBcjmai5IXExwbUPLpMSO6iux3fbPrn3VWNrZt/gq8jwf9v2v1v7GCgZ55VwTacdn
        RYgSVEC+VXjoiVAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] printk: replace ringbuffer
In-Reply-To: <20200708152005.GF4751@alley>
References: <20200707145932.8752-1-john.ogness@linutronix.de> <20200708152005.GF4751@alley>
Date:   Thu, 09 Jul 2020 09:09:31 +0206
Message-ID: <87wo3d9nlo.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-08, Petr Mladek <pmladek@suse.com> wrote:
> OK, I think that we are ready to try this in linux-next.
> I am going to push it there via printk/linux.git.
>
> [...]
> 
> Of course, there are still many potential problems. The following comes
> to my mind:
>
> [...]
>
>    + Debugging tools accessing the buffer directly would need to
>      understand the new structure. Fortunately John provided
>      patches for the most prominent ones.

The next series in the printk-rework (move LOG_CONT handling from
writers to readers) makes some further changes that, while not
incompatible, could affect the output of existing tools. It may be a
good idea to let the new ringbuffer sit in linux-next until the next
series has been discussed/reviewed/merged. After the next series,
everything will be in place (with regard to userspace tools) to finish
the rework.

As reminder, here are all the steps planned for the full rework:

1. replace ringbuffer
2. implement NMI-safe LOG_CONT (i.e. move handling to readers)
3. remove logbuf_lock
4. remove safe buffers
5. implement per-console printing kthreads
6. implement emergency mode and write_atomic() support
7. implement write_atomic() for 8250 UART

Some of the steps may be combined into a single series if the changes
are not too dramatic.

John Ogness
