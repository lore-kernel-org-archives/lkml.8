Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2928AC83006
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEBC206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 13:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgD1NTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbgD1NTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 09:19:17 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3A2A206A1;
        Tue, 28 Apr 2020 13:19:16 +0000 (UTC)
Date:   Tue, 28 Apr 2020 09:19:15 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     <acme@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] tools lib traceevent: Remove unneeded semicolon
Message-ID: <20200428091915.7bead67f@gandalf.local.home>
In-Reply-To: <1588065121-71236-1-git-send-email-zou_wei@huawei.com>
References: <1588065121-71236-1-git-send-email-zou_wei@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Apr 2020 17:12:01 +0800
Zou Wei <zou_wei@huawei.com> wrote:

> Fixes coccicheck warning:
> 
>  tools/lib/traceevent/kbuffer-parse.c:441:2-3: Unneeded semicolon
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  tools/lib/traceevent/kbuffer-parse.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/lib/traceevent/kbuffer-parse.c b/tools/lib/traceevent/kbuffer-parse.c
> index b887e74..27f3b07 100644
> --- a/tools/lib/traceevent/kbuffer-parse.c
> +++ b/tools/lib/traceevent/kbuffer-parse.c
> @@ -438,7 +438,7 @@ void *kbuffer_translate_data(int swap, void *data, unsigned int *size)
>  	case KBUFFER_TYPE_TIME_EXTEND:
>  	case KBUFFER_TYPE_TIME_STAMP:
>  		return NULL;
> -	};
> +	}

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Arnaldo, can you take this?

Thanks!

-- Steve

>  
>  	*size = length;
>  

