Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39C08C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:21:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ED82206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 03:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHaDVg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 23:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgHaDVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 23:21:33 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16326C061573;
        Sun, 30 Aug 2020 20:21:32 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCaNr-007qZv-1n; Mon, 31 Aug 2020 03:21:27 +0000
Date:   Mon, 31 Aug 2020 04:21:27 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuqi Jin <jinyuqi@huawei.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [NAK] Re: [PATCH] fs: Optimized fget to improve performance
Message-ID: <20200831032127.GW1236603@ZenIV.linux.org.uk>
References: <1598523584-25601-1-git-send-email-zhangshaokun@hisilicon.com>
 <20200827142848.GZ1236603@ZenIV.linux.org.uk>
 <dfa0ec1a-87fc-b17b-4d4a-c2d5c44e6dde@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa0ec1a-87fc-b17b-4d4a-c2d5c44e6dde@hisilicon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 09:43:31AM +0800, Shaokun Zhang wrote:

> How about this? We try to replace atomic_cmpxchg with atomic_add to improve
> performance. The atomic_add does not check the current f_count value.
> Therefore, the number of online CPUs is reserved to prevent multi-core
> competition.

No.  Really, really - no.  Not unless you can guarantee that process on another
CPU won't lose its timeslice, ending up with more than one increment happening on
the same CPU - done by different processes scheduled there, one after another.

If you have some change of atomic_long_add_unless(), do it there.  And get it
past the arm64 folks.  get_file_rcu() is nothing special in that respect *AND*
it has to cope with any architecture out there.

BTW, keep in mind that there's such thing as a KVM - race windows are much
wider there, since a thread representing a guest CPU might lose its timeslice
whenever the host feels like that.  At which point you get a single instruction
on a guest CPU taking longer than many thousands of instructions on another
CPU of the same guest.

AFAIK, arm64 does support KVM with SMP guests.
