Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF5BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECF8D20738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 07:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sQPs0i7L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C5Ml3HGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgHSHLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 03:11:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgHSHK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:10:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5987C061389
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:00:25 -0700 (PDT)
Date:   Wed, 19 Aug 2020 09:00:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597820424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B1zUwx2pLAnRGU5u67tZdctm2NefQ1yx0G/oZpzGA/8=;
        b=sQPs0i7LK+fy6qwgYxr3ZQshmtbaJogx7ElIj7A1Ei90S93UsHrRpEHYERLfd9Kt/LZzZZ
        3J1gssXj4KuwzRoZqd7IrVywsvod2RR8CvCvRuyJEyh2ZcZRvEDp9dCn5Sh3jkIfYz3BEw
        /zt+Ymn4y+ehCPu5WgK1uA2x532THoryxNkKtl1bEbZ/K1dvym/6rpVl4lvmAo7QkvS/1Z
        AWo1EZHT3f4+Rt6xVC1lx76LUTWKZYMLtDWf46VJXWeoLfAaC597TrbmHHbM91nNkInjA8
        DNF+i2t4AKaJgHVi2sgP7fCib/Ommw2atrJFmZToN87Mpp33i9nh6KeMBNtGMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597820424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B1zUwx2pLAnRGU5u67tZdctm2NefQ1yx0G/oZpzGA/8=;
        b=C5Ml3HGENuPGyezU4zCjbew0sp8tOT83GfPlQLcX2Za42WXLxCVskhiVhiP5GuCT6FFkun
        uju+b4jflL7Z27Cw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Mark Starovoytov <mstarovoitov@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, paulmck@kernel.org,
        peterz@infradead.org, rostedt@goodmis.org, tglx@linutronix.de,
        will@kernel.org
Subject: Re: [PATCH] Revert "seqlock: lockdep assert non-preemptibility on
 seqcount_t write"
Message-ID: <20200819070022.semyxepadnvtmtcr@linutronix.de>
References: <20200810085954.GA1591892@kroah.com>
 <20200810095428.2602276-1-a.darwish@linutronix.de>
 <20200810100502.GA2406768@kroah.com>
 <bcf94ea2-05e6-2212-f732-b9a79a142f7e@roeck-us.net>
 <169454.1597791078@turing-police>
 <fa442483-00b5-169e-dac2-71fbf8307117@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fa442483-00b5-169e-dac2-71fbf8307117@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-18 17:56:49 [-0700], Guenter Roeck wrote:
> Nice catch. FWIW, there is no obvious reason why this would need to be atomic.
> The calling code does not set a lock, meaning there can be two (or more)
> callers entering this code. Weird, especially since the code looks like it
> would actually need a mutex to work correctly. It might be interesting to
> see what happens if there are, say, half a dozen scripts/processes trying
> to read the hwmon attribute introduced by this patch at the same time.

=> https://lkml.kernel.org/r/20200818161439.3dkf6jzp3vuwmvvh@linutronix.de

> Guenter

Sebastian
