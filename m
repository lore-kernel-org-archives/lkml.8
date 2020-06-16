Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF5BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08FD20FC3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:16:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PVcJo7R8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgFPNQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgFPNQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:16:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF83C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d2Qi6sbKjWlfxvdSKWGefEgTU/TERTHm/fKo82Nv+0Y=; b=PVcJo7R83vnv37pVgSyHEVhXNQ
        LWIAs9quZ4MfrjQ9rQ7SjzRvww5SvZ1d6CEQTBPOBDVr0Bg1YEa2lGPlsnWtg4KHFHmhPRVwfqzHf
        5G/vhVKV7uXjVSsmVjZfaoQFoojhHCWbRU8DNMGB7F1nDDOhbpODqyMAmfJsYvrbFNonJtDhFa41u
        3KFDXNxzGzMXFr8U8eRBVzc7IB38k2rxCuPSjeiTgMtkw62chUgsvJ3aF8dFP8X3zSzei5IYEmmYo
        0ss0k3mvEUpBWbJEUmIX9dS9oJaGNiZC0CZYgkMSHbWej2gy/FnHhNN0SIHAEnSFjcTKoBQmNMEr9
        D+jjrKmw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlBRV-0002vs-OM; Tue, 16 Jun 2020 13:15:57 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 70DEA3017B7;
        Tue, 16 Jun 2020 15:15:55 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 551C929C11D5E; Tue, 16 Jun 2020 15:15:55 +0200 (CEST)
Date:   Tue, 16 Jun 2020 15:15:55 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [BUG] divide error select_idle_sibling+0x36b
Message-ID: <20200616131555.GU2531@hirez.programming.kicks-ass.net>
References: <CAMGffEmgLbd8mjEE4xM-U7MGCsWsdHEHCqs2erMdJ7+CUCFaCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEmgLbd8mjEE4xM-U7MGCsWsdHEHCqs2erMdJ7+CUCFaCA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:07:00PM +0200, Jinpu Wang wrote:

> [7623813.970839] CPU: 10 PID: 46544 Comm: qemu-2.7 Tainted: G
>  O    4.14.154-1-pserver #4.14.154-1.1~deb9

Please try on a kernel from this century.
