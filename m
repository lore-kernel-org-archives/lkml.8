Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5010BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BDA720767
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:20:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="baBP6LaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgFPIUs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFPIUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:20:46 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C7FC05BD43
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 01:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=v6Kvrp5YxuyE3OJwdnbigwu/+C45nCnzYkGt6Fojw88=; b=baBP6LaRRx2Up9n+9WmJ8N8s8s
        2KtsEvci5rCKwB48U7G2BX757UAP2/Xg9OYvJMvMmx3quRdEe2OTW3e8eUUIWokI74WT8dGRd9wtZ
        5e+oH8qXbV4YA3YS7LenFNzN1vJSPblLYQWDGvxmHJJWQ7C74v12CNZrsUQCRV5hb8ZtcwwUWVkR5
        XgVhleAlugPl4S3Eef/1p/3tEuQV+QMcXqVQsvcI8pbfYdhNm5ONU50EQZGzSJsK7Bk8snfh9+Obr
        LEfceChZaWqed0rqt+E/GkvORRDGE/r0q2xqWVm0AwJIvHzdiRXgYZOpISvkRp8D7wstNp90qpboA
        3Anv67+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jl6pE-0003eU-4Z; Tue, 16 Jun 2020 08:20:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D734430018A;
        Tue, 16 Jun 2020 10:20:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 672A72B9CA588; Tue, 16 Jun 2020 10:20:03 +0200 (CEST)
Date:   Tue, 16 Jun 2020 10:20:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        luca abeni <luca.abeni@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+119ba87189432ead09b4@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: WARNING in enqueue_task_dl
Message-ID: <20200616082003.GM2531@hirez.programming.kicks-ass.net>
References: <000000000000b5e346057af4da06@google.com>
 <alpine.DEB.2.21.1811190921190.9459@nanos.tec.linutronix.de>
 <20181119130718.69eddf46@luca64>
 <20181119125241.GC9761@hirez.programming.kicks-ass.net>
 <20181119134349.GA2119@localhost.localdomain>
 <20181119153201.GB2119@localhost.localdomain>
 <a9d18394-250b-98e4-e66d-57622dbaf247@redhat.com>
 <CACT4Y+bcug1SpLS6RfpJ8gTVm0vXm_S_1s_BG9n=zrEVdaffFw@mail.gmail.com>
 <20190724044516.GA643@sol.localdomain>
 <20200616065359.ugoismxzpkkkkwjp@beryllium.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616065359.ugoismxzpkkkkwjp@beryllium.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 08:53:59AM +0200, Daniel Wagner wrote:
> I've tested this patch against 5.8-rc1. Without the fix, after around 2 hours
> the warning was triggered by the reproducer. With the patch, it survived
> roughly 12 hours without the warning.
> 
> Tested-by: Daniel Wagner <dwagner@suse.de>

Thanks, have it now.
