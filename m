Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7259C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 12:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE4CE2075B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 12:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgHBMBZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 08:01:25 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51464 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728179AbgHBMBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 08:01:25 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 640651C0BD4; Sun,  2 Aug 2020 14:01:21 +0200 (CEST)
Date:   Sun, 2 Aug 2020 14:01:15 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        kernel@collabora.com, willy@infradead.org, luto@kernel.org,
        gofmanp@gmail.com, keescook@chromium.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
Subject: Re: [PATCH v4 0/2] Syscall User Redirection
Message-ID: <20200802120115.GC1289@bug>
References: <20200716193141.4068476-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716193141.4068476-1-krisman@collabora.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This is v4 of Syscall User Redirection.  The implementation itself is
> not modified from v3, it only applies the latest round of reviews to the
> selftests.
> 
> __NR_syscalls is not really exported in header files other than
> asm-generic for every architecture, so it felt safer to optionally
> expose it with a fallback to a high value.
> 
> Also, I didn't expose tests for PR_GET as that is not currently
> implemented.  If possible, I'd have it supported by a future patchset,
> since it is not immediately necessary to support this feature.
> 
> Finally, one question: Which tree would this go through?

Should it come with Documentation?

How does it interact with ptrace, seccomp and similar?
									Pavel

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
