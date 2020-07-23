Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A65C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 227622086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KSg83ZoQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yJLLfTbz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbgGWNlw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgGWNlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:41:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBEAC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:41:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595511710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7OjnkZ2xJU71jNjrdw2oXGsBAeiO+oLsLemJQYKcWo=;
        b=KSg83ZoQejdV8fiucONJSoBCJ1yg4LU9dUOCWzFYtxgkkqySVUgxXIYcfmK4Tiohcy4GX6
        wpsR2y+E7h1v6WtCf7Q51jT56l/ahbQ81vOs4IUnjb3edt2Qpjs37cjNhSnSONv7l2o5TW
        enG7DK81HCGGc2t+haLSJuPWFcl7OiHoAq+C9HlQ7AkfaQfWKaOxtt8A6nAHnxs76iaES1
        FylGCBgmk7bod6XMwfG453zhMF5ThhRlFY/oflsyYYsfVf6lIMgwmwXDhqRAlATlOIJyRI
        QiPsgI/aKMi2X6hg9TO4e4kJN6wMiRK2HbSkltEEigfBKdypwDuzksxj4DalEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595511710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=V7OjnkZ2xJU71jNjrdw2oXGsBAeiO+oLsLemJQYKcWo=;
        b=yJLLfTbzJaUoSb1F1OZDIW17E3bhVzZblbSPEIPFdMNvKvH9C6zhfNblmtv6PgYBqpOANv
        cT1ap1lH1D4LEDBw==
To:     qianjun.kernel@gmail.com, peterz@infradead.org, will@kernel.org,
        luto@kernel.org, urezki@gmail.com, linux-kernel@vger.kernel.org
Cc:     laoar.shao@gmail.com, jun qian <qianjun.kernel@gmail.com>
Subject: Re: [PATCH V3] Softirq:avoid large sched delay from the pending softirqs
In-Reply-To: <1595480041-10597-1-git-send-email-qianjun.kernel@gmail.com>
References: <1595480041-10597-1-git-send-email-qianjun.kernel@gmail.com>
Date:   Thu, 23 Jul 2020 15:41:50 +0200
Message-ID: <87d04mxs9t.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qianjun.kernel@gmail.com writes:
> From: jun qian <qianjun.kernel@gmail.com>
> +		/*
> +		 * the softirq's action has been running for too much time
> +		 * so it may need to wakeup the ksoftirqd
> +		 */
> +		if (need_resched() && ktime_get() > end)
> +			break;

As per my reply on V2 this is leaking non handled pending bits. If you
do a V4, can you please use sched_clock() instead of ktime_get()?

Thanks,

        tglx
