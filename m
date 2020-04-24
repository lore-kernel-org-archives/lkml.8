Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AF2C5518A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C66CF2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 03:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587699122;
	bh=I1OlM/2njVJD71o/KXJZlf3QxL9rXUikbasofOdfxns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aUhh3c8wbg8PG8cHdHl4QaWLllu0EtIREaayVRxkDfW4zOs5HKK61yxXq7tKzmSIe
	 qWIRFSBCoBXBPFxCqiykgGyZlZRBhYTbD32hz8TaMvGxpWxi0xrNiDRr6gKX+F/OKW
	 SI1MKqHcfDUz+OMIJSuhUKD5E4EoEeAU1z8He1Pc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgDXDcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 23:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbgDXDcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 23:32:00 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F400020715;
        Fri, 24 Apr 2020 03:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587699120;
        bh=I1OlM/2njVJD71o/KXJZlf3QxL9rXUikbasofOdfxns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XSnyfLHvDk/uvkzKgUL1mO83yO7io8HhDylhJG07G2Zc42huWNJb4hBUHXhCNsgPe
         T+0Nuj6seqgc4KBmaCI7A50LRbLpQfjg9xiL9q4GNENySn+tPxP8lNo+H3a1Ea3Ko7
         sYKsE1vkJHmGNY0SfDDOs3oiZx2xF2/vWwGOWOj4=
Date:   Thu, 23 Apr 2020 20:31:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Khazhismel Kumykov <khazhy@google.com>
Cc:     viro@zeniv.linux.org.uk, rpenyaev@suse.de, r@hev.cc,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Baron <jbaron@akamai.com>
Subject: Re: [PATCH] eventpoll: fix missing wakeup for ovflist in
 ep_poll_callback
Message-Id: <20200423203159.c9fc9988649e08d59e13e64d@linux-foundation.org>
In-Reply-To: <20200424025057.118641-1-khazhy@google.com>
References: <20200424025057.118641-1-khazhy@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Apr 2020 19:50:57 -0700 Khazhismel Kumykov <khazhy@google.com> wrote:

> In the event that we add to ovflist, before 339ddb53d373 we would be
> woken up by ep_scan_ready_list, and did no wakeup in ep_poll_callback.
> With that wakeup removed, if we add to ovflist here, we may never wake
> up. Rather than adding back the ep_scan_ready_list wakeup - which was
> resulting un uncessary wakeups, trigger a wake-up in ep_poll_callback.
> 
> We noticed that one of our workloads was missing wakeups starting with
> 339ddb53d373 and upon manual inspection, this wakeup seemed missing to
> me. With this patch added, we no longer see missing wakeups. I haven't
> yet tried to make a small reproducer, but the existing kselftests in
> filesystem/epoll passed for me with this patch.

I'm no longer familiar with this code, so I'll await input from others.

> Fixes: 339ddb53d373 ("fs/epoll: remove unnecessary wakeups of nested epoll")
> Signed-off-by: Khazhismel Kumykov <khazhy@google.com>

However it sounds like a cc:stable would be warranted here, so that
earlier affected kernels get the fix?

