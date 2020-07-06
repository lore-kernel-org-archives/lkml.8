Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFF8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A639F20663
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 21:04:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dlxSHNda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgGFVEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 17:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgGFVEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 17:04:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93BCC061755;
        Mon,  6 Jul 2020 14:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VQZbAsypdz5nTGvJ0jbsKWLVxreIxVFtueOxSKqcRXs=; b=dlxSHNdalP32C7i7q3Zsk4xoIS
        GmyDJ77PEjA8xgJA6aDuC080iku5c8dCCUYfjycwbnAply2G2PK/D0pvYv55CpBgKXCxnrTCMpHvG
        y16UfCk8bZ8QrLvGnxA5umVt1h6th5+Gtsg7LXyK8tKVbSut0leUThF7EKoPfwYC77VURKds4u8c/
        bKLvEa2AprGsrXmQwS6ZBcl10ryPbW4or9EsYiU2/wF7TnOeYEH+Lp3W+VogG+AqzBg6zCql4okrn
        9hk2RiQIdc2/TZArCQpxz8nEP1ddbfdM51SOk78gBQ4f7ETBxtHW/9cMMtJCVQebXLA5jpe6CwpjV
        umdI9+OQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jsYI4-0005so-14; Mon, 06 Jul 2020 21:04:40 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A06B9816EA; Mon,  6 Jul 2020 23:04:39 +0200 (CEST)
Date:   Mon, 6 Jul 2020 23:04:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 01/20] Documentation: locking: Describe seqlock design
 and usage
Message-ID: <20200706210439.GD5523@worktop.programming.kicks-ass.net>
References: <20200630054452.3675847-1-a.darwish@linutronix.de>
 <20200630054452.3675847-2-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630054452.3675847-2-a.darwish@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 07:44:33AM +0200, Ahmed S. Darwish wrote:
> +Sequence counters (:c:type:`seqcount_t`)
> +========================================

> +.. code-block:: c

I so hate RST, of course it's C. Also, ISTR Jon saying you can leave
that all out without issue.
