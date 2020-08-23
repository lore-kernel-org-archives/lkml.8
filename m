Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A05EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7297A2074D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WlWtikpH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ln3r4P2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgHWInw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 04:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726303AbgHWInv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 04:43:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E09C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 01:43:51 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598172230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LiyeTmcMdc7lsZMK/zJAPcH7kTE5SNsnk/r5N185EyM=;
        b=WlWtikpH+T2aF0/WJ3dxXWiQTPTfPbH+OLOMbNQXEwxJltekzyA/7h4SipuADYdBpxKyI6
        AOpsD3Rjnhj4DMQR/a8lCSfe/7BmSIxHID/jgEgiBgaqKPbsd95DMZcHUbyHuZPgNSjyyW
        +BnfR66YavgkfQcB4PRW3pvOl4nqpuQfiSBBRBqD+5m1GDVfr5r7+9pFpX0A1TN2QfEkOC
        6uNdHS8BkJV5spFxpRSWSBqhF9qs9EvMH6kUfrtaxH1OwHyl4uRo8kO1lrJD74Q97FJGdD
        YybB6Li5JCg4ddg7iHspdkldZHigEmlxv+GldMQLOP1Jd+El9/veUJO+Cqis0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598172230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LiyeTmcMdc7lsZMK/zJAPcH7kTE5SNsnk/r5N185EyM=;
        b=Ln3r4P2hi05MUgA7evFM3yo1jpsZ2pMctnAfGbDyGI7mymQzdIleQRU3yUrOnF3T8X8Sxm
        Q9Ow+r7Pjk6IsBAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kexec@lists.infradead.org
Subject: Re: [patch 0/2] timekeeping: NMI safe timekeeper enhancements
In-Reply-To: <20200820104348.GF4353@alley>
References: <20200814101933.574326079@linutronix.de> <20200820084738.GD4353@alley> <878se9ip7k.fsf@nanos.tec.linutronix.de> <20200820104348.GF4353@alley>
Date:   Sun, 23 Aug 2020 10:43:49 +0200
Message-ID: <87364dsqey.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Petr,

On Thu, Aug 20 2020 at 12:43, Petr Mladek wrote:
> On Thu 2020-08-20 12:30:55, Thomas Gleixner wrote:
>> Good. So I suggest that I apply that on top of rc1 somewhere in tip and
>> tag the top commit. So you can pull that tag into your printk branch and
>> go wild.
>
> Sounds good to me.

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timekeeping-for-printk-2020-08-23

Have fun!

Thanks,

        tglx

