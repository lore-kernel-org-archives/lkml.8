Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0
	tests=BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18CFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB796206B6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 11:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nINZe0Wk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mFdMw9wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgGCLyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 07:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGCLyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 07:54:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D520C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 04:54:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593777288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tqsPqORaw9Q178d54A+8BgwdJHYrzEiA8iUXpX8kYzc=;
        b=nINZe0WknDYQsTzPNQZsKNTifXY2Ch3I5dT0PAGllDaHe+WkK++GpKN8LDDU271AfWGiax
        zLcxxLPdDraYlifN/XSGzv3F9jWK9Qoxabpztre4iv+PVaaqPJ79nBDIWFk2Nb+Bo+zICS
        4dVBbsT1v5bN1EmLVSSUck5wgoyNJgDkuF5XgEYHTx7Mrxq5M4P0HrP7y5QEpIh7Vq4tOq
        odXcAON6TTbpdlFplDmvWQwCE0Oy3WZJD8snziiG/mRwxrQvMvw8+QBMNUuWXFnCQafGko
        2m8rzcFgdcbx7mzIAlvLcV6KTrSUQoUmMLIJp3jDDnA2xJeiy8MyVIWp6fMR+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593777288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tqsPqORaw9Q178d54A+8BgwdJHYrzEiA8iUXpX8kYzc=;
        b=mFdMw9wxfKXp10wnG/GF5CJpEOzicAbwqZNhRSiqBp/by425+oGhGe6L+jqPHGF6dnjMwj
        WWWW1/P0Ytz/iVCw==
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
In-Reply-To: <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
References: <20200618144919.9806-1-john.ogness@linutronix.de> <20200618144919.9806-4-john.ogness@linutronix.de> <ba338fab-9e98-366b-8fd4-05d4daa14f6d@redhat.com> <87zh8imgs5.fsf@jogness.linutronix.de> <585a6a1b-931c-1034-e2cc-da2c4381751e@redhat.com>
Date:   Fri, 03 Jul 2020 14:00:47 +0206
Message-ID: <87lfk0stiw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-02, lijiang <lijiang@redhat.com> wrote:
> About the VMCOREINFO part, I made some tests based on the kernel patch
> v3, the makedumpfile and crash-utility can work as expected with your
> patch(userspace patch), but, unfortunately, the
> vmcore-dmesg(kexec-tools) can't correctly read the printk ring buffer
> information, and get the following error:
>
> "Missing the log_buf symbol"
>
> The kexec-tools(vmcore-dmesg) should also have a similar patch, just like
> in the makedumpfile and crash-utility.

A patched kexec-tools is available here [0].

I did not test using 32-bit dumps on 64-bit machines and vice versa. But
it should work.

John Ogness

[0] https://github.com/Linutronix/kexec-tools.git (printk branch)
