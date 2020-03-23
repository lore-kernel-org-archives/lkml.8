Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FD6C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5C420774
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fakhOYIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbgCWOCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:02:24 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33742 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728542AbgCWOCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 10:02:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/I7B0tzAtReOmABokxdYw2sP4Cvmki3tkll9Zuz78Zg=; b=fakhOYIOdEHCnEWwuH0q+wgIgB
        Ns6xdNIZDgXP1f70rKH0o4D5MGnh/wkghxxxbm3t6wwzk2tJldKPgwVmZAfsg7HiFSPoroOLFlycL
        oaoSC1BFD4DiU5oJmoavUe08DKf/4YGFTcL8IXZ25EiiXob8wp31HEmncwUKI+ORmzh+LfayvKKe3
        3VWNesnVjavY7nr7YYaiGembtpTF83x7JD3XtaEFVnNIz+UbqlQgF09109wjtEB5vgRXqolqeZXMk
        mt9wkSKRZ1Q/9Lr//Oe7zxW+p11h+GIjpq3XKMNki3WWobWPm6T+gjoDzPbgazOOJc6V6w058iyIe
        NgkGnUcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGNeo-0006aL-8p; Mon, 23 Mar 2020 14:02:22 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CD56983504; Mon, 23 Mar 2020 15:02:20 +0100 (CET)
Date:   Mon, 23 Mar 2020 15:02:20 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 2/3] lockdep: Merge hardirq_threaded and irq_config
 together
Message-ID: <20200323140220.GK2452@worktop.programming.kicks-ass.net>
References: <20200323033207.32370-1-frederic@kernel.org>
 <20200323033207.32370-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200323033207.32370-3-frederic@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 04:32:06AM +0100, Frederic Weisbecker wrote:
> These fields describe the same state: a code block running in hardirq
> that might be threaded under specific configurations.
> 
> Merge them together in the same field. Also rename the result as
> "hardirq_threadable" as we are talking about a possible state and not
> an actual one.

What isn't instantly obvious is that they cannot overlap. For instance
mainline with force threaded interrupt handlers on, can't that have the
irq_work nest inside a threaded handler ?

I *think* it just about works out, but it definitely wants a little more
than this.
