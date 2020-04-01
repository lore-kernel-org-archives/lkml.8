Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C5B1C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:12:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E994720776
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 11:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uu3ng+uZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732277AbgDALMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:12:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:46026 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731343AbgDALMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 07:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gp2YqlkY4pv8hkp+Y9HeAoM9N130azc4jQ8Q+utG8J8=; b=Uu3ng+uZNxSDRt8Ayhjx+9es78
        OSKNmvUX9WZ/y9pA+W6imaBcfoZNS5icnFyTzGwmIYjEFzH7hvj9YWknqCRHCd0jAkECoAY2Ox/GU
        qUDr4YPcQwAV9qonwJSRbwCfHDqLlp6SI+mRO0VVDg+vMmk4N+nQaAD7vHVprkxj4UD5Gty/9K9P8
        gkzFZMqq6M0lHIDSOQtbSKtSlcrMgy29gfJfH9udCvygTuTwc1GGg3XlpYzujkiKbjdHGRC9mnj5W
        VQuGUN0yjRegeDaoyaQ+4Bwq4+B2vOUyh04A9awc1unPO/Gx89sqKLap/7P1ItAR30kJxhFczk/+E
        qp7Xwlfg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJbIB-0002Tm-1R; Wed, 01 Apr 2020 11:12:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 79C653025C3;
        Wed,  1 Apr 2020 13:12:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EE5929DB2527; Wed,  1 Apr 2020 13:12:17 +0200 (CEST)
Date:   Wed, 1 Apr 2020 13:12:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Li Yueyi <liyueyi@live.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        liyueyi <liyueyi@xiaomi.com>
Subject: Re: [PATCH] kthread: set kthread state to TASK_IDLE.
Message-ID: <20200401111217.GC20713@hirez.programming.kicks-ass.net>
References: <DM6PR11MB3531D3B164357B2DC476102DDFC90@DM6PR11MB3531.namprd11.prod.outlook.com>
 <20200401093904.GX20713@hirez.programming.kicks-ass.net>
 <DM6PR11MB3531904888FBD86F4ED43009DFC90@DM6PR11MB3531.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB3531904888FBD86F4ED43009DFC90@DM6PR11MB3531.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

On Wed, Apr 01, 2020 at 10:40:28AM +0000, Li Yueyi wrote:
> I create a kthread to do some work will trigger system restart, i don`t wake it up immediately but wakeup it in a HW irq handler.
> So this kthread sleeps in TASK_UNINTERRUPTIBLE state until the HW irq coming up.
> 
> Did i do something wrong?
> Should i wake it up immediately and then call wait_event_xxxx function to sleep it?

This!
