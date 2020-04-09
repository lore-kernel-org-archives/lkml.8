Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F8BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93B882166E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 14:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586442796;
	bh=3+Zb6M1LO8bxSudxy74spWM89URB5+zxt0fMp+g2c2M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=n0qCWy/Q0giDtR66WWZV+RJyXEk+fObFEbXsu1SFpDGSGS7LleGWwIkt+YPq0su8d
	 ldJexAuEEVUwmc9XxOPbN0nRPQXwritO8JuTT7MK7Txy9za2HgaktN3Vs2OTgn4ZJt
	 1usZLOmDiau3ExoIix7mRX/bIeD1fGwodjK2D/88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgDIOdO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 10:33:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727368AbgDIOdN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 10:33:13 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BA5221556;
        Thu,  9 Apr 2020 14:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586442793;
        bh=3+Zb6M1LO8bxSudxy74spWM89URB5+zxt0fMp+g2c2M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lQZM+Yc7QY6xoJz3nXaEitzMyneYs8Qi987N/VjnZXaGKMvsQc68jXXQ7vHltWz65
         ShQd87qd//MYMzErHlJIThsvkJMktMzE9LS+PUxy4tlikVOaMlAMF6tj+r0uBM8iwl
         0TCDDazcYXz315dLJF9kJYL288u6P8zDaiqKMdzw=
Date:   Thu, 9 Apr 2020 23:33:08 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH -tip V5 0/4] kprobes: Fixes mutex, rcu-list warnings and
 cleanups
Message-Id: <20200409233308.d69c0545747dec2619f0156a@kernel.org>
In-Reply-To: <158583483116.26060.10517933482238348979.stgit@devnote2>
References: <158583483116.26060.10517933482238348979.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Could you pick this series or give me your comment?

Thank you,

On Thu,  2 Apr 2020 22:40:31 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is the 5th version of the series for kprobes.
> I just updated the series on the latest tip/master branch and
> add Fixes and Cc tag to [3/4].
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (4):
>       kprobes: Suppress the suspicious RCU warning on kprobes
>       kprobes: Use non RCU traversal APIs on kprobe_tables if possible
>       kprobes: Fix to protect kick_kprobe_optimizer() by kprobe_mutex
>       kprobes: Remove redundant arch_disarm_kprobe() call
> 
> 
>  kernel/kprobes.c |   37 ++++++++++++++++++++++++-------------
>  1 file changed, 24 insertions(+), 13 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
