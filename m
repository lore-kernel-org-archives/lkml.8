Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAF5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 551E9217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 15:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583508082;
	bh=xSBKyG4v2fBVl3hrmfT6nidsIk7FItZaTu3DdclpsZw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gjZktTzN8TLJ7F41hYeepjCjymxTGvGnqCVs9gN75OtlNDNmK0cDBUhDxizCdL2vp
	 2C69Z3Gz+9Zj/Wck/rCDo/xPx7KVcp8+qkWvsuB4QKiZ89PiDGJkahTJFgVtFtU0+y
	 /RJPPtG87oTuF/kj9KRR0U7ECTzfjPEMwoeNmZrQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCFPVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 10:21:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:39002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725873AbgCFPVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 10:21:20 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F1292072A;
        Fri,  6 Mar 2020 15:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583508080;
        bh=xSBKyG4v2fBVl3hrmfT6nidsIk7FItZaTu3DdclpsZw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VoL8HU7eRNEpGt2Yv5JYMXvKHexhk9sppF+kvQSs2AW8FeDd0UfqilTwRaJd4rnhF
         V9qttbvc0ufjySsmBUw8Etr8ip5sQNfqn9g5zsZUabSf0LQ0ImZjIDVIdd0z7jH8IX
         3H72ExwJbxaWKEg9NqqQNt6/Oih6axVIEGUvoss4=
Date:   Sat, 7 Mar 2020 00:21:15 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Cheng Jian <cj.chengjian@huawei.com>,
        Ingo Molnar <mingo@kernel.org>
Cc:     <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <bobo.shaobowang@huawei.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>
Subject: Re: [PATCH] kretprobe: check re-registration of the same kretprobe
 earlier
Message-Id: <20200307002115.b96be2310cc553a922e1ba31@kernel.org>
In-Reply-To: <1583487306-81985-1-git-send-email-cj.chengjian@huawei.com>
References: <1583487306-81985-1-git-send-email-cj.chengjian@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cheng,

On Fri, 6 Mar 2020 17:35:06 +0800
Cheng Jian <cj.chengjian@huawei.com> wrote:

> Our system encountered a use-after-free when re-register a
> same kretprobe. it access the hlist node in rp->free_instances
> which has been released already.
> 
> Prevent re-registration has been implemented for kprobe before,
> but it's too late for kretprobe. We must check the re-registration
> before re-initializing the kretprobe, otherwise it will destroy the
> data and struct of the kretprobe registered, it can lead to memory
> leak and use-after-free.

I couldn't get how it cause use-after-free, but it causes memory leak.
Anyway, if we can help to find a wrong usage, it might be good.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

BTW, I think we should use WARN_ON() for this error, because this
means the caller is completely buggy.

Thank you,

> 
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> ---
>  kernel/kprobes.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2625c24..f1fc921 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1946,6 +1946,11 @@ int register_kretprobe(struct kretprobe *rp)
>  		}
>  	}
>  
> +	/* Return error if it's being re-registered */
> +	ret = check_kprobe_rereg(&rp->kp);
> +	if (ret)
> +		return ret;
> +
>  	rp->kp.pre_handler = pre_handler_kretprobe;
>  	rp->kp.post_handler = NULL;
>  	rp->kp.fault_handler = NULL;
> -- 
> 2.7.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
