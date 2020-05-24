Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB11C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59CD42073B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 17:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbgEXRiG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 13:38:06 -0400
Received: from smtprelay0221.hostedemail.com ([216.40.44.221]:40222 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387656AbgEXRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 13:38:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5E2D5100E7B40;
        Sun, 24 May 2020 17:38:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bean88_3a0fbd626d3a
X-Filterd-Recvd-Size: 1808
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Sun, 24 May 2020 17:38:03 +0000 (UTC)
Message-ID: <d65ee15211aa69a815bdc7cc4fc9e7c2e1bcba43.camel@perches.com>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Sun, 24 May 2020 10:38:02 -0700
In-Reply-To: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-24 at 23:50 +0900, Tetsuo Handa wrote:
> syzbot found a NULL pointer dereference bug inside mptcp_recvmsg() due to
> ssock == NULL, but this bug manifested inside selinux_socket_recvmsg()
> because pr_debug() was no-op [1].
> 
>   pr_debug("fallback-read subflow=%p",
>            mptcp_subflow_ctx(ssock->sk));
>   copied = sock_recvmsg(ssock, msg, flags);

> Since console loglevel used by syzkaller will not print KERN_DEBUG
> messages to consoles, always evaluating pr_devel()/pr_debug() messages
> will not cause too much console output. Thus, let's allow fuzzers to
> always evaluate pr_devel()/pr_debug() messages.

While I think this is rather unnecessary,
what about dev_dbg/netdev_dbg/netif_dbg et al ?


