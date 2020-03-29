Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70DAC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 15:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B2420733
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 15:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Biyyy2e6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728308AbgC2PzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 11:55:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47604 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC2PzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 11:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=pCwJdZ4oYpHCHMibmOReVF7N6gE+KCAvIUWmyMKKDe4=; b=Biyyy2e6QDZHit2SaG/SI/h2i8
        JiXmMVOgEmVgajT3SKlXid6Nu93gzv87MQ8nFzhn0kFJWUCytKNeQihL6Eo49Ib5bwsdZkNCpmR8d
        ojYkju1VZgzgq2FouODPi5LIKgzPxmYboWX4wJkcJkTVyVNzPod0vPXfDzJo/jmwal0FnqdjN/uyF
        B0lIl3+lL9oMA2D85lcp/BG/15yQI22QLiVwBiD4usQSJ+xqbYOt7w4Vusk1Yo/yqIvEkE7/GU1uG
        aN13HSOHk/EhoESRMQufJnzbzKBineK9zqBfQfyQuoTqzoLp0c8ido5bRy/5Hz29NCXRoK2Jt1lzU
        KC6Lspiw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIaHJ-0004FD-M2; Sun, 29 Mar 2020 15:55:13 +0000
Subject: Re: Weird issue with epoll and kernel >= 5.0
To:     David Laight <David.Laight@ACULAB.COM>,
        Omar Kilani <omar.kilani@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>
References: <CA+8F9hhy=WPMJLQ3Ya_w4O6xyWk7KsXi=YJofmyC577_UJTutA@mail.gmail.com>
 <34206eb5-1280-4aac-9a50-76f967646ca1@infradead.org>
 <e31f945d6d854398b4236872d1636c41@AcuMS.aculab.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f38f7f31-90f9-cd74-a56e-4119e43cb8f1@infradead.org>
Date:   Sun, 29 Mar 2020 08:55:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <e31f945d6d854398b4236872d1636c41@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/20 5:09 AM, David Laight wrote:
> From: Randy Dunlap
>> Sent: 28 March 2020 19:22
> ...
>> There have been around 10 changes in fs/eventpoll.c since v5.0 was
>> released in March, 2019, so it would be helpful if you could test
>> the latest mainline kernel to see if the problem is still present.
> 
> Is there any info about the scenarios that the fixes affect?
> We've an application that can use epoll() or poll() and I wonder
> if I should not default to epoll() on 5.0+ kernels that might be dodgy.

5.0 was released on 2019-03-03. The following patches have been merged
since then.

> git log --oneline fs/eventpoll.c | more ### latest patches first
1b53734bd0b2 epoll: fix possible lost wakeup on epoll_ctl() path
39220e8d4a2a eventpoll: support non-blocking do_epoll_ctl() calls
58e41a44c488 eventpoll: abstract out epoll_ctl() handler
339ddb53d373 fs/epoll: remove unnecessary wakeups of nested epoll
f6520c520842 epoll: simplify ep_poll_safewake() for CONFIG_DEBUG_LOCK_ALLOC
c8377adfa781 PM / wakeup: Show wakeup sources stats in sysfs
eec4844fae7c proc/sysctl: add shared variables for range check
b772434be089 signal: simplify set_user_sigmask/restore_user_sigmask
97abc889ee29 signal: remove the wrong signal_pending() check in restore_user_sigmask()
2874c5fd2842 treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 152
a218cc491420 epoll: use rwlock in order to reduce ep_poll_callback() contention
c3e320b61581 epoll: unify awaking of wakeup source on ep_poll_callback() path
c141175d011f epoll: make sure all elements in ready list are in FIFO order


> It rather depends whether wakeups just get lost - but the next
> rx data will wake things up, or whether the linked lists get
> completely hosed and 'all hell' breaks out (or doesn't).
> 
> In our case there is only one reader and the fd are all
> UDP sockets (added and removed when the socket is created/closed).


-- 
~Randy

