Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C6FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6844F207BC
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598430724;
	bh=+zgvqau40KD6zoirbrmJVE9a/bFPfvd4D/v0f4gdpg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QWkgdHZ8xJcVJjGZYGjnfyFxo+jmjVIcqTny3D0mVxg3R5T38w9genj9BPeF3JXRR
	 vmf8mJydFlMSzqmF3pbZN+rhDyMAvQImNfVf92scZ+VQbMNdFrUkUI+fBFvIRVDneM
	 xBP5LuIM75pdVDKwR3fhLnSx1Ouvuyr7Xqah7WNg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgHZIcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:49634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgHZIcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:32:02 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6328F20707;
        Wed, 26 Aug 2020 08:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598430722;
        bh=+zgvqau40KD6zoirbrmJVE9a/bFPfvd4D/v0f4gdpg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eHNvNWFO+gU8BFaCL0EtG2rT/AVfXwkqWtRtCRSY59S9Sz/5O1xW+6E138Fj1pyOa
         F8gswCtGY64ln7vX1d1Q9rUXCdgacbqatvlhfTfqJmwxLEhyrlOLNXLR5EeoXXDps3
         jfUAbaiG0OQXxHBXg1qXgy3Tn1g+CFIff66n92Mg=
Date:   Wed, 26 Aug 2020 17:31:58 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-Id: <20200826173158.19bc6f5c3b05fbb3f6d0aa3e@kernel.org>
In-Reply-To: <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
        <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
        <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
        <20200825151538.f856d701a34f4e0561a64932@kernel.org>
        <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, 25 Aug 2020 14:09:11 +0200
peterz@infradead.org wrote:

> 
> @@ -1934,50 +1884,28 @@ unsigned long __weak arch_deref_entry_point(void *entry)
>  static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  {
>  	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
> -	unsigned long hash, flags = 0;
>  	struct kretprobe_instance *ri;
> +	struct llist_node *llist;
>  
> -	/*
> -	 * To avoid deadlocks, prohibit return probing in NMI contexts,
> -	 * just skip the probe and increase the (inexact) 'nmissed'
> -	 * statistical counter, so that the user is informed that
> -	 * something happened:
> -	 */
> -	if (unlikely(in_nmi())) {
> +	llist = llist_del_first(&rp->free_instances);
> +	if (!llist) {
>  		rp->nmissed++;
>  		return 0;
>  	}

Would we need a lock around llist_del_first(&rp->free_instance) here?

linux/llist.h said,

 * Cases where locking is not needed:
 * If there are multiple producers and multiple consumers, llist_add can be
 * used in producers and llist_del_all can be used in consumers simultaneously
 * without locking. Also a single consumer can use llist_del_first while
                               ^^^^^^^^^^^^^^^^^^^^^^^
 * multiple producers simultaneously use llist_add, without any locking.
 *
 * Cases where locking is needed:
 * If we have multiple consumers with llist_del_first used in one consumer, and
                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 * llist_del_first or llist_del_all used in other consumers, then a lock is
 * needed.

pre_handler_kretprobe() can be invoked simultaneously on the different CPUs
if those are calling the same probed function.


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
