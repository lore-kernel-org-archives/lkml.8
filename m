Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73309C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFF4214F1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LicXS2JV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgHGTea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgHGTe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:34:29 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23335C061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Subject:Cc:To:From:Date:Message-ID:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=8B3vcTdKxdTXdjxQQXeqQU3fplBogydFUAU3MnPnOKc=; b=LicXS2JVVk1dhQl0sH6K5VlxAp
        o5+KoHy6yMO8JIXAd75BKyo3Sp5U4rxtTDWVkFCPzh33RQ/0g5az/c67YPZLKDuTn9zVEMzHq6e6J
        2sXVbiM9x5Nbsc584O0uYEhmGt47+nYo/fgyf+T+7/VhFpzSXMvFdkM9o8GB6zsFH5SdnrY7iuFqI
        +QrDsT0iYOoXgBk2U4oF508cb39zD9RCkkT/fxJbhUI2/uxJSHEHXkS7/lbTHJVCU3OZc2rZX/xGQ
        iEWGTvOF4Mwc00S6ZizVw6YZ/4PSSao7Tg8VvR34u3m2lTf8B3Q9tvr1f31micNmWGkaBU9uOsNVP
        MYiLBwig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k4889-0005Jc-Ew; Fri, 07 Aug 2020 19:34:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0831D30015A;
        Fri,  7 Aug 2020 21:34:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A0E4621F9221F; Fri,  7 Aug 2020 21:34:13 +0200 (CEST)
Message-ID: <20200807192336.405068898@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 07 Aug 2020 21:23:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, mingo@kernel.org, will@kernel.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, elver@google.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        peterz@infradead.org
Subject: [RFC][PATCH 0/3] Tracing, Idle, RCU and such goodness
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Syzbot report:

  https://lkml.kernel.org/r/000000000000e3068105ac405407@google.com

triggered a whole bunch of fallout.

These 3 patches are in reverse order of discovery. With them applied the
reproducer no longer triggers and the machine boots without errors.

I also spend half the day trying to rewrite TRACE_IRQFLAGS, but so far haven't
had success. I have the feeling that there's something slightly simpler hiding
in there, but so far it doesn't want to come out.

Please, look carefully, this is all tricky code, and it's been a long and hot
day here, mistakes are almost guaranteed :/

I also want to remove the _rcuidle() from trace_preemptirq.c, but given
this was quite enough, I didn't touch those.

