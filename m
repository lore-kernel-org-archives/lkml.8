Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF1BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2981122BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 19:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QSdc2PgK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C6eP+wFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728345AbgHJTzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 15:55:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53132 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgHJTzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 15:55:23 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597089321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lOcjKXTHefZnEQA7ggbOF1BPRNwtfZ0tlgkz2hBjXY=;
        b=QSdc2PgKCB35vUVmt9BKR3SO4O2pMKcYQqhkPsdRKgFaW7J7AEOmjxy3BIwBdPa24L8aAi
        hUI3+/SP0iGlR8k8F7YIxfS7aCBwEk4zAxQVG7fw5rhyGOeUi3aOoFPtt1bwR8A4aqs397
        LTiOhxNghZv/FSV1vVBBgc/j7IrStYeHtCr2Je/iLSNGDm0NtONqWi0ryCSB5fKhz33003
        YlDqO4YCXF6F923/y1vjFKgw6GDOua1i7Xunz2TiH3wMBcLAz/HN9gMzH0oC2zKq6gC+6Q
        AY8vBAKHAdiYAgnqfppC4dASPFRbQVA1Kc9m5y2xQuVXyVEJgJ0RkhGgV82v9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597089321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5lOcjKXTHefZnEQA7ggbOF1BPRNwtfZ0tlgkz2hBjXY=;
        b=C6eP+wFynMmaCF2lReixwl/osKyftYw17ccyc0kUk2UXQ6D8IRH8P30kkaxH6N/vlVWdiQ
        rUe9Vp+636uL8JAQ==
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 08/24] seqlock: lockdep assert non-preemptibility on seqcount_t write
In-Reply-To: <20200810085954.GA1591892@kroah.com>
References: <20200519214547.352050-1-a.darwish@linutronix.de> <20200720155530.1173732-1-a.darwish@linutronix.de> <20200720155530.1173732-9-a.darwish@linutronix.de> <20200808232122.GA176509@roeck-us.net> <20200809184251.GA94072@lx-t490> <20200810085954.GA1591892@kroah.com>
Date:   Mon, 10 Aug 2020 21:55:20 +0200
Message-ID: <87v9hqxolz.fsf@nanos>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:
> On Sun, Aug 09, 2020 at 08:42:51PM +0200, Ahmed S. Darwish wrote:
>> On Sat, Aug 08, 2020 at 04:21:22PM -0700, Guenter Roeck wrote:
>> > Reverting it fixes the problem. Is this being addressed ?
>> >
>> 
>> @Peter, I think let's revert this one for now?
>
> Please do, it's blowing up my local builds as well :(

Peter and Ingo sorted the header mess last week and I just sent a pull
request to Linus.

Thanks,

        tglx
