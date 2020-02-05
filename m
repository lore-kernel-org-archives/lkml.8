Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52D1C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A96642082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qYSqDxYv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgBEJso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:48:44 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55126 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbgBEJso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=i+zytyj69Qc0YTysrdJq3nfacpChGQrNJ0scgz8j2x4=; b=qYSqDxYv6hnea4MbJShZxSiCKy
        ec88T2frL2VRNu8qwlC2YvSUa3x0fbRjrZp4XBx4T+jpbgbfhWeX92AZD2NNdIsYCSzyvusq8eeNo
        oZDqT5+vIADM7OTQipLJHmUru6iYgb+80PCDbi9sZj7CQ2I1qO0ygx00WCsPesaoao+sATy6TVPK3
        8UiRZ+CXvBRG+55kwzSppwBkT2EtdQrEbqIS6Y41oRbtMUcxAz9PKGQ+gjNw8ClU2rviw6PWX9dZH
        LJb7c5aTzt9jMpGy21SyGPpKBMsnYQYKIjdbg3cdJ327LuF+LgfB2xYwtIaYLf6p5DKat+3AkckY6
        3OAYvCTQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izHIW-0007Ny-FV; Wed, 05 Feb 2020 09:48:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 248293016E5;
        Wed,  5 Feb 2020 10:46:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 07A112B76AF48; Wed,  5 Feb 2020 10:48:39 +0100 (CET)
Date:   Wed, 5 Feb 2020 10:48:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200205094838.GI14879@hirez.programming.kicks-ass.net>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-7-longman@redhat.com>
 <20200204154236.GE14879@hirez.programming.kicks-ass.net>
 <c1af8458-7269-53c3-59f4-b87c5d51c208@redhat.com>
 <16125cbf-09ee-919e-4b7a-33dabb123159@redhat.com>
 <f7f4151d-6514-be7b-1915-37f19411ca96@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7f4151d-6514-be7b-1915-37f19411ca96@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 11:57:09AM -0500, Waiman Long wrote:

> Wait, it is possible that we can have deadlock like this:
> 
>   cpu 0               cpu 1
>   -----               -----
>   lock A              lock B
>   <irq>               <irq>
>   lock B              lock A
>  
> If we eliminate 1-entry chain, will that impact our ability to detect this
> kind of deadlock?

I'm thinking that should trigger irq-inversion (irq-on vs in-irq) on
either A or B (depending on timing).

AFAICT the irq-state tracking is outside of validate_chain().

This is also why I think your separate_irq_context() change is not
needed.

validate_chain() really only checks the per-context lock nesting, and
there, a single lock doesn't do very much. Hence my proposed patch.
