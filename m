Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3151EC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09E592076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636271AbgDONvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:51:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391656AbgDONv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:51:28 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC942074F;
        Wed, 15 Apr 2020 13:51:27 +0000 (UTC)
Date:   Wed, 15 Apr 2020 09:51:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        clang-built-linux@googlegroups.com,
        Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [PATCH] x86: mmiotrace: Use cpumask_available for cpumask_var_t
 variables
Message-ID: <20200415095125.5efc372e@gandalf.local.home>
In-Reply-To: <20200408205323.44490-1-natechancellor@gmail.com>
References: <20200408205323.44490-1-natechancellor@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  8 Apr 2020 13:53:23 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> When building with Clang + -Wtautological-compare and
> CONFIG_CPUMASK_OFFSTACK unset:
> 
> arch/x86/mm/mmio-mod.c:375:6: warning: comparison of array 'downed_cpus'
> equal to a null pointer is always false [-Wtautological-pointer-compare]
>         if (downed_cpus == NULL &&
>             ^~~~~~~~~~~    ~~~~
> arch/x86/mm/mmio-mod.c:405:6: warning: comparison of array 'downed_cpus'
> equal to a null pointer is always false [-Wtautological-pointer-compare]
>         if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
>             ^~~~~~~~~~~    ~~~~
> 2 warnings generated.
> 
> Commit f7e30f01a9e2 ("cpumask: Add helper cpumask_available()") added
> cpumask_available to fix warnings of this nature. Use that here so that
> clang does not warn regardless of CONFIG_CPUMASK_OFFSTACK's value.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/982
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
> 

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
