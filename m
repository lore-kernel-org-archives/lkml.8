Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30593C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 024FD2088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 09:02:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dm6t6Oj3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jzif+nd6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgGBJCF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:02:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGBJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 05:02:05 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593680523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iSHp+qL8jlCnfx+lpGtQHzsTwnPkgJZ+hzplODbpLis=;
        b=Dm6t6Oj3BbIVrKAKyTPjW9LF/T6t9Bdmutb1cDd//FSn6oQed1lqlut+QZ/bL6vcaNKAmJ
        z0JGzBsNfDxwFugQRGwERqzKuxAK3zrNqmSLEQ2pdwKWeClLJCsnQZKmxgOiIdd1ftbaQW
        WlKM7WI3QfY26qqotnC2lsXHy7rhQRghAbA+3li6yeObek2Ek+dXKjK4UXsZAfoOhfnKVK
        1r8SBDbFHUYJBrENZduuXCsHqzEGTfM+oDtvoSQ3nqff6jUoPfhcM++KrFwNh8q7bMYXfq
        /4I3bzmlge/U+LaUPvcl+ROpiqtDlKixRwaTPUM4finRSAVGrP6/1W4U8DfulQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593680523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iSHp+qL8jlCnfx+lpGtQHzsTwnPkgJZ+hzplODbpLis=;
        b=Jzif+nd6FqtafDb6f+2yMZZidwaOxAfVki88jUDsJxCrf3uwlXuFSQCViQifPGUGQtg947
        TVMYm9euQgiGUHCA==
To:     lijiang <lijiang@redhat.com>, Petr Mladek <pmladek@suse.com>
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
Subject: Re: [PATCH v3 3/3] printk: use the lockless ringbuffer
In-Reply-To: <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com>
References: <20200618144919.9806-1-john.ogness@linutronix.de> <20200618144919.9806-4-john.ogness@linutronix.de> <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com>
Date:   Thu, 02 Jul 2020 11:08:02 +0206
Message-ID: <87zh8imgs5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-02, lijiang <lijiang@redhat.com> wrote:
> About the VMCOREINFO part, I made some tests based on the kernel patch
> v3, the makedumpfile and crash-utility can work as expected with your
> patch(userspace patch), but, unfortunately, the vmcore-dmesg(kexec-tools)
> can't correctly read the printk ring buffer information, and get the
> following error:
>
> "Missing the log_buf symbol"
>
> The kexec-tools(vmcore-dmesg) should also have a similar patch, just like
> in the makedumpfile and crash-utility.

Yes, a patch for this is needed (as well as for any other related
software floating around the internet).

I have no RFC patches for vmcore-dmesg. Looking at the code, I think it
would be quite straight forward to port the makedumpfile patch. I will
try to make some time for this.

I do not want to patch any other software for this. I think with 3
examples (crash, makedumpfile, vmcore-dmesg), others should be able to
implement the changes to their software without needing my help.

John Ogness
