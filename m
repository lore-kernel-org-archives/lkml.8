Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E24C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7122120842
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgBKLqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:46:31 -0500
Received: from relay.sw.ru ([185.231.240.75]:54860 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgBKLqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:46:31 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1j1Tzj-0007T9-WC; Tue, 11 Feb 2020 14:46:24 +0300
Subject: Re: [PATCH] mm: Add missed mem_cgroup_iter_break() into
 shrink_node_memcgs()
To:     Kirill Tkhai <ktkhai@virtuozzo.com>, akpm@linux-foundation.org,
        guro@fb.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <158142103093.888182.8911729633457501747.stgit@localhost.localdomain>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <792e25d0-413f-28e0-1fd0-560523b63a45@virtuozzo.com>
Date:   Tue, 11 Feb 2020 14:46:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <158142103093.888182.8911729633457501747.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/20 2:38 PM, Kirill Tkhai wrote:
> Leaving mem_cgroup_iter() loop requires mem_cgroup_iter_break().
> 
> Fixes: bf8d5d52ffe8 "memcg: introduce memory.min"
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  mm/vmscan.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index b1863de475fb..f6efe2348ba3 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2653,8 +2653,9 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  				continue;
>  			}
>  			memcg_memory_event(memcg, MEMCG_LOW);
> -			break;

It is not cycle break, it is switch/case break.

> +			/* fallthrough */
>  		case MEMCG_PROT_NONE:
> +			mem_cgroup_iter_break(target_memcg, memcg);
>  			/*
>  			 * All protection thresholds breached. We may
>  			 * still choose to vary the scan pressure
> 
> 
