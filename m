Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8500FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573A020707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QQ+WNZuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgA3Ns6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:48:58 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA3Ns6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KWeJ60yy7ZEEaAUYkcnvwcBr+M2J16KKlBnyHKEQ2N0=; b=QQ+WNZuW3RFOQGsjn5mwpYQ+b
        e1psPbIVvHVIMA2GEkO3sYhH+MPRKGTUCQsNxC0lOi+rlvWpKtCj8cxd7A3KBExRFrlM/unRp2VzC
        5iNdG0OjFxVwQHVkNWub1088RIwgYdKyrW9oecGEEGQ3Tp5BYIETHz9mcRrl9HLDYpVmMlNZUore+
        m/4YLOa9LK+z6F5q0pzF246neVoRTqud1dNCzUSwnvcRhXVehAj0tmUAh+lyiaAjln+UIhvSnvHTz
        5aMu0yRhDHaGE3F88xvHOhxDDte3t8y5VZlY013nJrJseS8KhvFJ0swhWaN/r/NK6kkHlS92thMEU
        SbrBvi/0g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixABh-0001R1-T0; Thu, 30 Jan 2020 13:48:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6EA86304BDF;
        Thu, 30 Jan 2020 14:47:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AE96120147130; Thu, 30 Jan 2020 14:48:51 +0100 (CET)
Date:   Thu, 30 Jan 2020 14:48:51 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, Qian Cai <cai@lca.pw>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200130134851.GY14914@hirez.programming.kicks-ass.net>
References: <20200122223851.GA45602@google.com>
 <A90E2B85-77CB-4743-AEC3-90D7836C4D47@lca.pw>
 <20200123093905.GU14914@hirez.programming.kicks-ass.net>
 <E722E6E0-26CB-440F-98D7-D182B57D1F43@lca.pw>
 <CANpmjNNo6yW-y-Af7JgvWi3t==+=02hE4-pFU4OiH8yvbT3Byg@mail.gmail.com>
 <20200128165655.GM14914@hirez.programming.kicks-ass.net>
 <20200129002253.GT2935@paulmck-ThinkPad-P72>
 <CANpmjNN8J1oWtLPHTgCwbbtTuU_Js-8HD=cozW5cYkm8h-GTBg@mail.gmail.com>
 <20200129184024.GT14879@hirez.programming.kicks-ass.net>
 <CANpmjNNZQsatHexXHm4dXvA0na6r9xMgVD5R+-8d7VXEBRi32w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNZQsatHexXHm4dXvA0na6r9xMgVD5R+-8d7VXEBRi32w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 02:39:38PM +0100, Marco Elver wrote:
> On Wed, 29 Jan 2020 at 19:40, Peter Zijlstra <peterz@infradead.org> wrote:

> > It's probably not terrible to put a READ_ONCE() there; we just need to
> > make sure the compiler doesn't do something stupid (it is known to do
> > stupid when 'volatile' is present).
> 
> Maybe we need to optimize READ_ONCE().

I think recent compilers have gotten better at volatile. In part because
of our complaints.

> 'if (data_race(..))' would also work here and has no cost.

Right, that might be the best option.

