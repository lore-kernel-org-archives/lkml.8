Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F26C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DD12083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgEGRQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:16:12 -0400
Received: from foss.arm.com ([217.140.110.172]:35860 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726356AbgEGRQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:16:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5E5FC30E;
        Thu,  7 May 2020 10:16:11 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 80E833F305;
        Thu,  7 May 2020 10:16:10 -0700 (PDT)
Date:   Thu, 7 May 2020 18:16:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and
 call_rcu()
Message-ID: <20200507171607.GD3180@gaia>
References: <45D2D811-C3B0-442B-9744-415B4AC5CCDB@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45D2D811-C3B0-442B-9744-415B4AC5CCDB@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 12:22:37PM -0400, Qian Cai wrote:
> What do you think about adding some aux call traces for kmemleak in
> general? For example, if the tracking object is a task struct, it
> would save call traces for the first and last call of both
> get_task_struct() and put_task_struct(). Then, it could be expanded to
> track other refcount-based leaks in the future.

I don't mind adding additional tracking info if it helps with debugging.
But if it's for improving false positives, I'd prefer to look deeper
into figure out why the pointer reference graph tracking failed.

Thanks.

-- 
Catalin
