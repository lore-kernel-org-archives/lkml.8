Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9272BC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C909206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0w7ILuCO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H0KeTd5M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgGWLFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgGWLFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:05:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9B2C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 04:05:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595502343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fjNQnRr+PLXGWuqJIRgfEY3dHkkwSU6OeDLEJC6zHaU=;
        b=0w7ILuCOsU+q6cAvnFciKIjC6lOtkPOdP1mFAlaPIa3RCbQ0kiqregseFWaOUQwlaalsbi
        tL225qNfXtK2OTjUGv3RKCEoVuT5AEmNfBzNhIU6TDpJro70xfDGzpHvmH3vpCjLzUTb9j
        NZyrpTsSCNVCdDQp/OyQ7SgztxbVqNwzu/8LB2ErQ7kFoH79z3TP/wYiFwWd4cB/o4Y7P4
        bNfGgGYpOz/mGuyOqRtgj7EtSah5pFt1bphEghiwCrXtkHpcevcVZPCd1bG7I6OKMonDsS
        EnWylYPHXNjReLjVZGFIwVWWXIHAHBgxGh0Cm+6FvjcGFB4QDHFDdZMXzxBVHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595502343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fjNQnRr+PLXGWuqJIRgfEY3dHkkwSU6OeDLEJC6zHaU=;
        b=H0KeTd5M266Wi2nZjS0oCiCykvFLQ+TgQGVsAS8NNlVYTj8niILORkwgLsKryYY2090Lxj
        21A6xj/owiKao5Cg==
To:     Christoph Hellwig <hch@lst.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "H.J. Lu" <hjl.tools@gmail.com>, x86@kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH] x86/dumpstack: Dump user space code correctly again
In-Reply-To: <20200723081900.GA16138@lst.de>
References: <bug-208655-6666@https.bugzilla.kernel.org/> <87h7tz306w.fsf@nanos.tec.linutronix.de> <20200723081900.GA16138@lst.de>
Date:   Thu, 23 Jul 2020 13:05:43 +0200
Message-ID: <87sgdixzi0.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:
> On Wed, Jul 22, 2020 at 07:54:15PM +0200, Thomas Gleixner wrote:
>> +	/*
>> +	 * Make sure userspace isn't trying to trick us into dumping kernel
>> +	 * memory by pointing the userspace instruction pointer at it.
>> +	 */
>> +	if (__chk_range_not_ok(src, nbytes, TASK_SIZE_MAX))
>> +		return -EINVAL;
>> +
>> +	return copy_from_user_nmi(buf, (void __user *)src, nbytes);
>
> copy_from_user_nmi already contains a:
>
> 	if (__range_not_ok(from, n, TASK_SIZE))
> 		return n;
>
> what is the reason it checks for TASK_SIZE vs TASK_SIZE_MAX, and why
> do we need both checks?

TBH, I just kept it because being lazy. But you are right, the check is
redundant and TASK_SIZE_MAX is inaccurate as it does not take compat
tasks into account. I'll rip that out.

Thanks,

        tglx
