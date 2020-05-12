Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 965EBC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFF0206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 00:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728267AbgELAWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 20:22:23 -0400
Received: from fieldses.org ([173.255.197.46]:55248 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgELAWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 20:22:23 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id EED9623E4; Mon, 11 May 2020 20:22:22 -0400 (EDT)
Date:   Mon, 11 May 2020 20:22:22 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the nfsd tree
Message-ID: <20200512002222.GB17212@fieldses.org>
References: <20200508104720.5c7f72a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508104720.5c7f72a5@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 10:47:20AM +1000, Stephen Rothwell wrote:
> After merging the nfsd tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> kernel/trace/trace_hwlat.c:329:12: error: conflicting types for 'kthread_fn'
>   329 | static int kthread_fn(void *data)
>       |            ^~~~~~~~~~
> In file included from kernel/trace/trace_hwlat.c:40:
> include/linux/kthread.h:60:7: note: previous declaration of 'kthread_fn' was here
>    60 | void *kthread_fn(struct task_struct *k);
>       |       ^~~~~~~~~~
> 
> Caused by commit
> 
>   7df082e85764 ("kthread: save thread function")
> 
> I have used the nfsd tree from next-20200507 for today.

Whoops, I forgot to say thanks for this report.  I renamed the
kthread_fn in my patches to kthread_func.

--b.
