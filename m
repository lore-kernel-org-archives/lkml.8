Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9390EC2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC9F20786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCaSMz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:12:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:59384 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgCaSMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:12:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DE461B11A;
        Tue, 31 Mar 2020 18:12:53 +0000 (UTC)
Date:   Tue, 31 Mar 2020 11:10:53 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Omar Kilani <omar.kilani@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Weird issue with epoll and kernel >= 5.0
Message-ID: <20200331181053.qyt32mgraa4q6iep@linux-p48b>
References: <CA+8F9hhy=WPMJLQ3Ya_w4O6xyWk7KsXi=YJofmyC577_UJTutA@mail.gmail.com>
 <34206eb5-1280-4aac-9a50-76f967646ca1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <34206eb5-1280-4aac-9a50-76f967646ca1@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Mar 2020, Randy Dunlap wrote:

>On 3/28/20 11:10 AM, Omar Kilani wrote:
>> Hi there,
>>
>> I've observed an issue with epoll and kernels 5.0 and above when a
>> system is generating a lot of epoll events.
>>
>> I see this issue with nginx and jvm / netty based apps (using the
>> jvm's native epoll support as well as netty's own optimized epoll
>> support) but *not* with haproxy (?).
>>
>> I'm not really sure what the actual problem is (nginx complains about
>> epoll_wait with a generic error), but it doesn't happen on 4.19.x and
>> lower.
>>
>> I thought it was a netty problem at first and opened this ticket:
>>
>> https://github.com/netty/netty/issues/8999
>>
>> But then saw the same issue in nginx.
>>
>> I haven't debugged a kernel issue in something like 20 years so I'm
>> not really sure where to start myself.
>>
>> I'd be more than happy to provide my test case that has a very quick
>> repro to anyone who needs it.
>
>Hi,
>Please do.
>
>> Also happy to provide a VM/machine with enough CPUs to trigger it
>> easily (it seems to happen quicker with more CPUs present) to test
>> with.

Yeah, more than a VM, an actual reproducer would be much welcome here.

>
>
>There have been around 10 changes in fs/eventpoll.c since v5.0 was
>released in March, 2019, so it would be helpful if you could test
>the latest mainline kernel to see if the problem is still present.
>
>Hm, it looks like you have identified this commit:
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.1-rc5&id=c5a282e9635e9c7382821565083db5d260085e3e
>as the/a problem.

As this been bisected down to this? As you mention there are more
commits in there that are dependent of each other, so I'd like
to be certain this is actually the broken change.

Thanks,
Davidlohr
