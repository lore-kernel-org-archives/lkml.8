Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169D5C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 20:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFCF02063A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 20:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580588211;
	bh=Cphzme7FJDa/dMLNujqQClVMgMlU0vm1Jshw6MLTCl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=sCoH2IV5gg9dts/CauSSyjnLz5Wc0uVj41Wwck+XeV4usIfyDgyM7Uu2yhiK45F4i
	 BLCndevWs7a4L8by0XmjDcYAtMMg+rf5NPQzvyoe9lR8QKUginaljFx8IplE7CvRxJ
	 TO/OnBa95xJ8iM3BAgs7u9nSfJ/ihUd2TZtaIYHk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgBAUQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 15:16:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:55114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbgBAUQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 15:16:49 -0500
Received: from cakuba.hsd1.ca.comcast.net (c-73-93-4-247.hsd1.ca.comcast.net [73.93.4.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB2AE2063A;
        Sat,  1 Feb 2020 20:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580588208;
        bh=Cphzme7FJDa/dMLNujqQClVMgMlU0vm1Jshw6MLTCl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zRT1I2ddoCsdYinizDObWHOjl8gPlNGlCKclMvV7Xut57v71PPe+QdOJiSdxsDrKj
         ViHVnbIl9wSvCzfiXicsxEtEMKp2FO4kiQF+8JWCr9VH+kj7MuUazeZY4raX6eDxuV
         tdeoJx7kmX8hurFK/cxkvuOSjHbskPQ4NpwW/UFc=
Date:   Sat, 1 Feb 2020 12:16:47 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Max Neunhoeffer <max@arangodb.com>
Cc:     netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: epoll_wait misses edge-triggered eventfd events: bug in Linux
 5.3 and 5.4
Message-ID: <20200201121647.62914697@cakuba.hsd1.ca.comcast.net>
In-Reply-To: <20200131135730.ezwtgxddjpuczpwy@tux>
References: <20200131135730.ezwtgxddjpuczpwy@tux>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 14:57:30 +0100, Max Neunhoeffer wrote:
> Dear All,
> 
> I believe I have found a bug in Linux 5.3 and 5.4 in epoll_wait/epoll_ctl
> when an eventfd together with edge-triggered or the EPOLLONESHOT policy
> is used. If an epoll_ctl call to rearm the eventfd happens approximately
> at the same time as the epoll_wait goes to sleep, the event can be lost, 
> even though proper protection through a mutex is employed.
> 
> The details together with two programs showing the problem can be found
> here:
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=205933
> 
> Older kernels seem not to have this problem, although I did not test all
> versions. I know that 4.15 and 5.0 do not show the problem.
> 
> Note that this method of using epoll_wait/eventfd is used by
> boost::asio to wake up event loops in case a new completion handler
> is posted to an io_service, so this is probably relevant for many
> applications.
> 
> Any help with this would be appreciated.

Could be networking related but let's CC FS folks just in case.

Would you be able to perform bisection to narrow down the search 
for a buggy change?
