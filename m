Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3006C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9873214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 16:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NUg4BVZs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgA1Q5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 11:57:02 -0500
Received: from merlin.infradead.org ([205.233.59.134]:42418 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgA1Q5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 11:57:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xqLkdksTAn4mILhz/FZa+hmKnpwus5eIvV60Ofg9aS8=; b=NUg4BVZsRLcDW8vceLF6gpUIi
        K1OUx/lu58nbCdAQAShaQzFYekDOd4diN9PmDPkPrmB0fAnagGqVimOATQD1esrt8wVO0qIpGIxkk
        QZ6MR3liE953VMAIR/pKag6xTBer8R80wNDA3ZzRkUExDI+rs0cTw+Z/t5eZEHUCcwFY/xgHl60Cn
        GSuv8er4ATv3T3gdEPLpExZ/0cy3i13pM7vk/z5x4w+bVCSktJlH0XMhXAMu/dIuRKrGkMpG0EDWG
        n5a+MwKIXIlgZdzYn7IOvDqJ9e8eLAtXUUh8RV0v27SLIFGL+YAZmAQF6uk8SxFZKhjXzDl+lTIrr
        Pdh+cnCVw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iwUAa-0001KE-Ju; Tue, 28 Jan 2020 16:56:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 96E16302524;
        Tue, 28 Jan 2020 17:55:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0CBB3201F06F7; Tue, 28 Jan 2020 17:56:55 +0100 (CET)
Date:   Tue, 28 Jan 2020 17:56:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200128165655.GM14914@hirez.programming.kicks-ass.net>
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com>
 <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net>
 <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
 <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 12:46:26PM +0100, Marco Elver wrote:

> > Marco, any thought on improving KCSAN for this to reduce the false
> > positives?
> 
> Define 'false positive'.

I'll use it where the code as written is correct while the tool
complains about it.

> From what I can tell, all 'false positives' that have come up are data
> races where the consequences on the behaviour of the code is
> inconsequential. In other words, all of them would require
> understanding of the intended logic of the code, and understanding if
> the worst possible outcome of a data race changes the behaviour of the
> code in such a way that we may end up with an erroneously behaving
> system.
> 
> As I have said before, KCSAN (or any data race detector) by definition
> only works at the language level. Any semantic analysis, beyond simple
> rules (such as ignore same-value stores) and annotations, is simply
> impossible since the tool can't know about the logic that the
> programmer intended.
> 
> That being said, if there are simple rules (like ignore same-value
> stores) or other minimal annotations that can help reduce such 'false
> positives', more than happy to add them.

OK, so KCSAN knows about same-value-stores? If so, that ->cpu =
smp_processor_id() case really doesn't need annotation, right?

> What to do about osq_lock here? If people agree that no further
> annotations are wanted, and the reasoning above concludes there are no
> bugs, we can blacklist the file. That would, however, miss new data
> races in future.

I'm still hoping to convince you that the other case is one of those
'simple-rules' too :-)
