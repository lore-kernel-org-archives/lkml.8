Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66571C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 469602173E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgEGRqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:46:34 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40842 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgEGRqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:46:34 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AF2001C025A; Thu,  7 May 2020 19:46:32 +0200 (CEST)
Date:   Thu, 7 May 2020 19:46:31 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Javier Malave <javier.malave@narfindustries.com>
Cc:     bx@narfindustries.com, linux-kernel@vger.kernel.org,
        ah@narfindustries.com
Subject: Re: [RFC 0/9] Popcorn Linux Distributed Thread Execution
Message-ID: <20200507174631.GE1216@bug>
References: <0>
 <cover.1588127445.git.javier.malave@narfindustries.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1588127445.git.javier.malave@narfindustries.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-04-29 15:32:47, Javier Malave wrote:
> This patch set adds the Popcorn Distributed Thread Execution support
> to the kernel. It is based off of Linux 5.2 commit 72a20ce. We are
> looking for feedback on design and implementation from the community.

You may want to cc linux-api mailing list...?

> Popcorn Linux is a Linux kernel-based software stack that enables
> applications to execute, with a shared code base, on distributed hosts.
> Popcorn allows applications to start execution on a particular host and
> migrate, at run-time, to a remote host. Multi-threaded applications may
> migrate any particular thread to any remote host. 

Sounds like a lot of fun.

> Popcorn Linux implements a software-based distributed shared memory 
> by extending Linux's virtual memory subsystem and it enables processes 
> on different machines to observe a common and coherent virtual address
> space. Coherency of virtual memory pages of different hosts is ensured 
> using a reader-replicate/writer-invalidate, page-level consistency protocol.

Sounds interesting. I guess this needs very, very fast network. Do you have some performance numbers 
somewhere?

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
