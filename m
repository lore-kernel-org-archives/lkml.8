Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE963C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C36722076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 00:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585183791;
	bh=7rLc8IKWjDGZOPL02QzrS+USTRjwCLbUdZevHtKiRDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=eOVwVsWnWgMUfZOd9wrsWHsjvZKYiRof/2cW0KMsBBqlVEsQ1Xm0RJZIBa9mAG32o
	 FdQBbbUoy91TxLvuvGQqf3n7ARIz7NVtRxdkmpDqCBl/VMo6adYd2X0m/6+EY+v775
	 js0mrL29WFu/d3ZXR4GGMxtiSgVyghmkRqYJV8uU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCZAtu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 20:49:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727539AbgCZAtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 20:49:50 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A59420714;
        Thu, 26 Mar 2020 00:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585183789;
        bh=7rLc8IKWjDGZOPL02QzrS+USTRjwCLbUdZevHtKiRDU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U/lPbhw/wVpEepyJvRrV+BsjnRnkD3OL+HDw5AJY0m3j4bd+hIA1AksaF3Cz/MKPq
         53pofo7EM+cl1gDbjO6U9JmV/2kI89t27d2J/W794Zeo5fQ5JW6Bhtejl8yZrs3e/Z
         WGZzsRDhacmTiCCFecCn8fQjpvhn1sMyeaZ0IUJA=
Date:   Wed, 25 Mar 2020 17:49:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Eric B Munson <emunson@akamai.com>
Subject: Re: [PATCH] tools/testing/selftests/vm/mlock2-tests: fix mlock2
 false-negative errors
Message-Id: <20200325174949.95d8a9de61c6a30a7e0f4582@linux-foundation.org>
In-Reply-To: <20200324154910.GM23364@optiplex-lnx>
References: <CALvZod7LiMiK1JtfdvvU3W36cGSUKhhKf6dMZpsNZv6nMiJ5=g@mail.gmail.com>
        <20200323075208.GC7524@dhcp22.suse.cz>
        <20200323144240.GB23364@optiplex-lnx>
        <20200323145106.GM7524@dhcp22.suse.cz>
        <20200323150259.GD23364@optiplex-lnx>
        <20200323151256.GP7524@dhcp22.suse.cz>
        <20200323154159.GF23364@optiplex-lnx>
        <20200323155111.GQ7524@dhcp22.suse.cz>
        <20200323155449.GG23364@optiplex-lnx>
        <20200324154218.GS19542@dhcp22.suse.cz>
        <20200324154910.GM23364@optiplex-lnx>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Mar 2020 11:49:10 -0400 Rafael Aquini <aquini@redhat.com> wrote:

> Thanks Michal!
> 
>  
> Acked-by: Rafael Aquini <aquini@redhat.com>

I'll add
Fixes: 9c4e6b1a7027f ("mm, mlock, vmscan: no more skipping pagevecs")
and cc:stable to this.  Any kernel which has 9c4e6b1a7027f will benefit
from this change.

We're getting quite late in the cycle now so I think I'll hold off
merging this up until post-5.7-rc1.  It will still get into the stable
trees, but a bit later.
