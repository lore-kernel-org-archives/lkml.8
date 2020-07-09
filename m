Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3141BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7E2206DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Em65mrx7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EWQJ2mzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgGILtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:49:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgGILtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:49:03 -0400
Date:   Thu, 9 Jul 2020 13:49:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594295341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/+Hq2OK1EfVodCGmSK8xZprN98olqCNxMqvpIq5Nt4=;
        b=Em65mrx7Yrr88xoOBeslkETE8DoNLVI3wENFy3bHD2euiEJIWqv7TTKBgPWOSBO/gubik+
        Hhwp5ZJiYS04MtRaG1yBdkRTMB6/wefsdUsW59qcFA3Ajun+mgVKbvl5NpaKJXMPsacQjb
        5N40PRxxIPzIvcIsmWjCH7fYLcbTPl4n0J8aljgPrjTgzfPIelvePmOIYMyIEF6r7x+LsF
        ACVXEyLuR26JWnBniBOKuF8aF7UK6Bjbr3v4+ltiel4vqVI7F0DUydZHt4JXfie0Z/lvLm
        xq+USivXCdIGDs+OhcR64/F5LL1NUukTV2oqv8nzydo8yyhN+OnShgELim6g+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594295341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n/+Hq2OK1EfVodCGmSK8xZprN98olqCNxMqvpIq5Nt4=;
        b=EWQJ2mzY07zbTBYIOt3T01wgtud1AQNbQyHydDQVl9HwMFdA7zi2wN+f1cCyYSHV7xinv6
        LTXVZ+bIZv0VHKBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kaitao Cheng <pilgrimtao@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] kernel/smp: Fix an off by one in csd_lock_wait_toolong()
Message-ID: <20200709114900.b475kfqz3447zgfg@linutronix.de>
References: <20200709104818.GC20875@mwanda>
 <20200709105906.GR597537@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200709105906.GR597537@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-09 12:59:06 [+0200], Peter Zijlstra wrote:
> On Thu, Jul 09, 2020 at 01:48:18PM +0300, Dan Carpenter wrote:
> > The __per_cpu_offset[] array has "nr_cpu_ids" elements so change the >
> > >= to prevent a read one element beyond the end of the array.
> > 
> > Fixes: 0504bc41a62c ("kernel/smp: Provide CSD lock timeout diagnostics")
> 
> I don't have a copy of that patch in my inbox, even though it says Cc:
> me.
> 
> Paul, where do you expect that patch to go? The version I see from my
> next tree needs a _lot_ of work.

There is also
 
 https://lkml.kernel.org/r/20200705082603.GX3874@shao2-debian
 https://lkml.kernel.org/r/00000000000042f21905a991ecea@google.com

it might be the same thing.

Sebastian
