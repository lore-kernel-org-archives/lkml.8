Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276FFC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 06:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC8F20CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 06:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580453036;
	bh=q97/U5on2lXCtm8KVUoshh+lvbqdJOc+eBhqIiovquE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=v04aSNJrAtiIyEKWmAdDvhYYdNdbuJWrUJzqSJj/6jFc/LcwwfYeOwO5K0txcywvM
	 FPXTQfLC+/jvaQ4apLeCpJZsyzuSYCufKOoOmQbiN2AzWl7gk17lfr+SaBGdXxPFa4
	 X5Razasoh6DbthNYBWUvittQwdhfP/kUjSCWVSsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgAaGnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 01:43:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:44232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgAaGny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 01:43:54 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0EC02082E;
        Fri, 31 Jan 2020 06:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580453034;
        bh=q97/U5on2lXCtm8KVUoshh+lvbqdJOc+eBhqIiovquE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTk1r0KJvplTnYt4Q8z2Oxpp8vxWqxWHGxDFBQcCvy8PXKmn4numomDxHs2VGG3KR
         6dLR136ThsGyRXvBH9SkFejodw7aDRZQ4Mt63601DyRQIX4j0Kc/ch/2Zt+5SkLgzY
         vgsGHaUVWdI47Rv/bArl5vBe6qqlqKnVjnrrknX4=
Date:   Fri, 31 Jan 2020 15:43:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>, paulmck@kernel.org,
        joel@joelfernandes.org,
        "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip V3 0/2] kprobes: Fix RCU warning and cleanup
Message-Id: <20200131154349.5ff9436bd53633dad6270f83@kernel.org>
In-Reply-To: <157905963533.2268.4672153983131918123.stgit@devnote2>
References: <157905963533.2268.4672153983131918123.stgit@devnote2>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

Could you pick these patches for fixing RCU warnings by
CONFIG_PROVE_RCU_LIST?

Thank you,

On Wed, 15 Jan 2020 12:40:35 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is v3 patches which fix suspicious RCU usage warnings
> in kprobes. In this version I just updated the series on top
> of the latest -tip and add Joel's reviewed-by tag.
> 
> Thank you,
> 
> ---
> 
> Masami Hiramatsu (2):
>       kprobes: Suppress the suspicious RCU warning on kprobes
>       kprobes: Use non RCU traversal APIs on kprobe_tables if possible
> 
> 
>  kernel/kprobes.c |   32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)
> 
> --
> Masami Hiramatsu (Linaro) <mhiramat@kernel.org>


-- 
Masami Hiramatsu <mhiramat@kernel.org>
