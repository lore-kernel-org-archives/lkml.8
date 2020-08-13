Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AC2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D1DF2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 10:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZEmNC8Cy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KtVnvZmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgHMK3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 06:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHMK3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:29:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB0EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 03:29:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597314588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjpp9eleIyzGL+JwIGEJlxa1DyXWdi6E0d/oVHCyIo4=;
        b=ZEmNC8Cya9AegY9XNvI3FOnt3Sg6/cRMGJcuuDS910wHPzY2Pllw46Lq4UArSAkVOTUUm8
        tgNCESnlsWi2LNnkb4BaZnujDSu2uLnNMZyReU5kZ+nZ2yZOTy24CmVEtxpWjS+rMm3DtC
        BSrN57dCXZJEW/031xj9m6QbLNKSBilOal+RogIDaV6l9Nn35Viv4qIVrlvurHtem4cNcN
        3H17z4vgh0IZok4+Tcp/nb5OH4cLIYWjDeHzGd8OCl/mM0rrVuhJb+u26Eda28UgSFFE1f
        BXXRDdX1VrzyCMbUdToXyL8aph2T9ltyp/tjjMaHVSZHo83WnbVfGQpy3h81Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597314588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vjpp9eleIyzGL+JwIGEJlxa1DyXWdi6E0d/oVHCyIo4=;
        b=KtVnvZmyZrIJucrDOuAXlXs8Xah6q+ZIFQtwnRMCezGPgdmvJNbFbGHTtqbhUpHnDoT2Ut
        elUwpGBo+/gNc3CA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement LOG_CONT handling
In-Reply-To: <20200813084136.GK12903@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de> <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com> <87blkcanps.fsf@jogness.linutronix.de> <20200811160551.GC12903@alley> <20200812163908.GH12903@alley> <87v9hn2y1p.fsf@jogness.linutronix.de> <20200813051853.GA510@jagdpanzerIV.localdomain> <875z9nvvl2.fsf@jogness.linutronix.de> <20200813084136.GK12903@alley>
Date:   Thu, 13 Aug 2020 12:35:47 +0206
Message-ID: <87v9hmrg84.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-13, Petr Mladek <pmladek@suse.com> wrote:
> On Thu 2020-08-13 09:50:25, John Ogness wrote:
>> On 2020-08-13, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
>> > This is not an unseen pattern, I'm afraid. And the problem here can
>> > be more general:
>> >
>> > 	pr_info("text");
>> > 	pr_cont("1");
>> > 	exception/IRQ/NMI
>> > 		pr_alert("text\n");
>> > 	pr_cont("2");
>> > 	pr_cont("\n");
>> >
>> > I guess the solution would be to store "last log_level" in task_struct
>> > and get current (new) timestamp for broken cont line?
>> 
>> (Warning: new ideas ahead)
>> 
>> The fundamental problem is that there is no real association between
>> the cont parts. So any interruption results in a broken record. If we
>> really want to do this correctly, we need real association.

I believe I failed to recognize the fundamental problem. The fundamental
problem is that the pr_cont() semantics are very poor. I now strongly
believe that we need to fix those semantics by having the pr_cont() user
take responsibility for buffering the message. Patching the ~2000
pr_cont() users will be far easier than continuing to twist ourselves
around this madness.

Here is an example for a new pr_cont() API:

    struct pr_cont c;

    pr_cont_alloc_info(&c);
       (or alternatively)
    dev_cont_alloc_info(dev, &c);

    pr_cont(&c, "1");
    pr_cont(&c, "2");

    pr_cont_flush(&c);

Using macro magic, there can be the usual dbg, warn, err, etc. variants
of the alloc functions.

The alloc function would need to work for any context, but that would
not be an issue. If the cont message started to get too large, pr_cont()
could do its own flushing in between, while still holding on to the
context information. If for some reason the alloc function could not
allocate a buffer, all the pr_cont() calls could fallback to logging the
individual cont parts.

I believe this would solve all cont-related problems while also allowing
the new ringbuffer to remain as it already is in linux-next.

John Ogness
