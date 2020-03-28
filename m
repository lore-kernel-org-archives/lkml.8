Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2487FC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E129C206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hQ6CxFS/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbgC1TV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 15:21:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57138 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgC1TV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 15:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:Cc:From:References:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=V/dqXbIkvlLRHwSTVCJaQGAGws4sXl8nCiGBMMHev8Y=; b=hQ6CxFS/MpFp7tJXVz8ZW9IjKN
        ot1jxHe5xGMxdkveaEsSLhMsiDk7Ng+W+2shgzRZmf/5TJz8KvW2bgFe50l6epSV36X5NMGjk3ws3
        5MBoCIqy3J4g+435JLdRTgOfTbpTezACw4o70wbDBpOBMv6xLXN1GlPV3iqRDBA7Aa8URSPUll5ya
        wT8zmYoh+FzBzGkHLN0xngxyVz57IZAVCiTQFdaA/l38qg2CWsSXgd1XxZmmapZL6g970ZKCzMpE0
        FZi9YUC9lPA1MjpClYT6QRmQBTo6xU9jOcjtmHXrquXxtbVLQKVw8pyPIdV5X186S7PPCt+FestgV
        lNOFwjuw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jIH1o-0005EL-QB; Sat, 28 Mar 2020 19:21:56 +0000
Subject: Re: Weird issue with epoll and kernel >= 5.0
To:     Omar Kilani <omar.kilani@gmail.com>, linux-kernel@vger.kernel.org
References: <CA+8F9hhy=WPMJLQ3Ya_w4O6xyWk7KsXi=YJofmyC577_UJTutA@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>
Message-ID: <34206eb5-1280-4aac-9a50-76f967646ca1@infradead.org>
Date:   Sat, 28 Mar 2020 12:21:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CA+8F9hhy=WPMJLQ3Ya_w4O6xyWk7KsXi=YJofmyC577_UJTutA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/20 11:10 AM, Omar Kilani wrote:
> Hi there,
> 
> I've observed an issue with epoll and kernels 5.0 and above when a
> system is generating a lot of epoll events.
> 
> I see this issue with nginx and jvm / netty based apps (using the
> jvm's native epoll support as well as netty's own optimized epoll
> support) but *not* with haproxy (?).
> 
> I'm not really sure what the actual problem is (nginx complains about
> epoll_wait with a generic error), but it doesn't happen on 4.19.x and
> lower.
> 
> I thought it was a netty problem at first and opened this ticket:
> 
> https://github.com/netty/netty/issues/8999
> 
> But then saw the same issue in nginx.
> 
> I haven't debugged a kernel issue in something like 20 years so I'm
> not really sure where to start myself.
> 
> I'd be more than happy to provide my test case that has a very quick
> repro to anyone who needs it.

Hi,
Please do.

> Also happy to provide a VM/machine with enough CPUs to trigger it
> easily (it seems to happen quicker with more CPUs present) to test
> with.


There have been around 10 changes in fs/eventpoll.c since v5.0 was
released in March, 2019, so it would be helpful if you could test
the latest mainline kernel to see if the problem is still present.

Hm, it looks like you have identified this commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.1-rc5&id=c5a282e9635e9c7382821565083db5d260085e3e
as the/a problem.

I have Cc-ed the patch author also.

-- 
~Randy

