Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB7AC33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83C25208CD
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 23:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579305552;
	bh=zAUirHknzyCrPw3f1vqCRAaZQ5jKzbFghZwz7UyEeqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=lGZcCHn/Z8x8AuT2VJlsUQoZbMwQynYfgKfYUtQ9Xx6Y0/JCAlxU13EnInZ59bOKw
	 W9M8q1pdfUgvBy9r4wMQU0wcpKnGOaPccIKMMMznmtdiRjVxlLLjoMKHjN1FxDUq89
	 GVurRWGaMhIx/UtNrFAnZTpa8OUJZQxkYz9euSOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730357AbgAQX7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730232AbgAQX7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 18:59:11 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D4F720717;
        Fri, 17 Jan 2020 23:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579305551;
        bh=zAUirHknzyCrPw3f1vqCRAaZQ5jKzbFghZwz7UyEeqc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NQybTlf/azDADcURHNKH3sGwDthlr59qbYTOA3BzvTP70SOQTY6KnrxRha9c1ojrE
         NWylGX/ckg6nhGNvX6v13PoAllyq6t5exFW5h7jkm7FcpffUxsHdm5sP95MWHZBjeq
         6/BPNznXU1vsGgSNaHA723ZXXR7Els/ktBMrCvdU=
Date:   Sat, 18 Jan 2020 08:59:07 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] tracing/boot: Fix an IS_ERR() vs NULL bug
Message-Id: <20200118085907.639cd8d683f961bb9310239d@kernel.org>
In-Reply-To: <20200117053007.5h2juv272pokqhtq@kili.mountain>
References: <20200117053007.5h2juv272pokqhtq@kili.mountain>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Jan 2020 08:30:07 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The trace_array_get_by_name() function doesn't return error pointers,
> it returns NULL on error.

Good catch! It used to use trace_array_create() which returns err_ptr,
but trace_array_get_by_name() doesn't anymore.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thank you!


> 
> Fixes: 4f712a4d04a4 ("tracing/boot: Add instance node support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  kernel/trace/trace_boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_boot.c b/kernel/trace/trace_boot.c
> index fa9603dc6469..cd541ac1cbc1 100644
> --- a/kernel/trace/trace_boot.c
> +++ b/kernel/trace/trace_boot.c
> @@ -322,7 +322,7 @@ trace_boot_init_instances(struct xbc_node *node)
>  			continue;
>  
>  		tr = trace_array_get_by_name(p);
> -		if (IS_ERR(tr)) {
> +		if (!tr) {
>  			pr_err("Failed to get trace instance %s\n", p);
>  			continue;
>  		}
> -- 
> 2.11.0
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
