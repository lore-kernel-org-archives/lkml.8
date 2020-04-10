Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394E9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 13:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067052078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 13:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDJNo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 09:44:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:56948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbgDJNo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 09:44:29 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ECC8420679;
        Fri, 10 Apr 2020 13:44:28 +0000 (UTC)
Date:   Fri, 10 Apr 2020 09:44:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jason Yan <yanaijie@huawei.com>, Tom Zanussi <zanussi@kernel.org>
Cc:     <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: make some symbols static in tracing_map.c
Message-ID: <20200410094427.1f1ede4d@gandalf.local.home>
In-Reply-To: <20200410073312.38855-1-yanaijie@huawei.com>
References: <20200410073312.38855-1-yanaijie@huawei.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tom,

Care to ack this?

-- Steve


On Fri, 10 Apr 2020 15:33:12 +0800
Jason Yan <yanaijie@huawei.com> wrote:

> Fix the following sparse warning:
> 
> kernel/trace/tracing_map.c:286:6: warning: symbol
> 'tracing_map_array_clear' was not declared. Should it be static?
> kernel/trace/tracing_map.c:297:6: warning: symbol
> 'tracing_map_array_free' was not declared. Should it be static?
> kernel/trace/tracing_map.c:319:26: warning: symbol
> 'tracing_map_array_alloc' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>
> ---
>  kernel/trace/tracing_map.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/tracing_map.c b/kernel/trace/tracing_map.c
> index 9e31bfc818ff..74738c9856f1 100644
> --- a/kernel/trace/tracing_map.c
> +++ b/kernel/trace/tracing_map.c
> @@ -283,7 +283,7 @@ int tracing_map_add_key_field(struct tracing_map *map,
>  	return idx;
>  }
>  
> -void tracing_map_array_clear(struct tracing_map_array *a)
> +static void tracing_map_array_clear(struct tracing_map_array *a)
>  {
>  	unsigned int i;
>  
> @@ -294,7 +294,7 @@ void tracing_map_array_clear(struct tracing_map_array *a)
>  		memset(a->pages[i], 0, PAGE_SIZE);
>  }
>  
> -void tracing_map_array_free(struct tracing_map_array *a)
> +static void tracing_map_array_free(struct tracing_map_array *a)
>  {
>  	unsigned int i;
>  
> @@ -316,7 +316,7 @@ void tracing_map_array_free(struct tracing_map_array *a)
>  	kfree(a);
>  }
>  
> -struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
> +static struct tracing_map_array *tracing_map_array_alloc(unsigned int n_elts,
>  						  unsigned int entry_size)
>  {
>  	struct tracing_map_array *a;

