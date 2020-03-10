Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E10C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F0A24649
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 01:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCJBH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 21:07:29 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:45939 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgCJBHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 21:07:25 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Ts9xOYP_1583802441;
Received: from JosephdeMacBook-Pro.local(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0Ts9xOYP_1583802441)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 10 Mar 2020 09:07:21 +0800
Subject: Re: [PATCH][next] ocfs2: dlm: Replace zero-length array with
 flexible-array member
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
References: <20200309202016.GA8210@embeddedor>
From:   Joseph Qi <joseph.qi@linux.alibaba.com>
Message-ID: <cd617e6e-20bc-1757-1e44-ed2d0d761b90@linux.alibaba.com>
Date:   Tue, 10 Mar 2020 09:07:21 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309202016.GA8210@embeddedor>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/10 04:20, Gustavo A. R. Silva wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last in the structure, which
> will help us prevent some kind of undefined behavior bugs from being
> inadvertently introduced[3] to the codebase from now on.
> 
> Also, notice that, dynamic memory allocations won't be affected by
> this change:
> 
> "Flexible array members have incomplete type, and so the sizeof operator
> may not be applied. As a quirk of the original implementation of
> zero-length arrays, sizeof evaluates to zero."[1]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] https://github.com/KSPP/linux/issues/21
> [3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> ---
>  fs/ocfs2/dlm/dlmcommon.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ocfs2/dlm/dlmcommon.h b/fs/ocfs2/dlm/dlmcommon.h
> index 0463dce65bb2..c8a444622faa 100644
> --- a/fs/ocfs2/dlm/dlmcommon.h
> +++ b/fs/ocfs2/dlm/dlmcommon.h
> @@ -564,7 +564,7 @@ struct dlm_migratable_lockres
>  	// 48 bytes
>  	u8 lvb[DLM_LVB_LEN];
>  	// 112 bytes
> -	struct dlm_migratable_lock ml[0];  // 16 bytes each, begins at byte 112
> +	struct dlm_migratable_lock ml[];  // 16 bytes each, begins at byte 112
>  };
>  #define DLM_MIG_LOCKRES_MAX_LEN  \
>  	(sizeof(struct dlm_migratable_lockres) + \
> @@ -601,7 +601,7 @@ struct dlm_convert_lock
>  
>  	u8 name[O2NM_MAX_NAME_LEN];
>  
> -	s8 lvb[0];
> +	s8 lvb[];
>  };
>  #define DLM_CONVERT_LOCK_MAX_LEN  (sizeof(struct dlm_convert_lock)+DLM_LVB_LEN)
>  
> @@ -616,7 +616,7 @@ struct dlm_unlock_lock
>  
>  	u8 name[O2NM_MAX_NAME_LEN];
>  
> -	s8 lvb[0];
> +	s8 lvb[];
>  };
>  #define DLM_UNLOCK_LOCK_MAX_LEN  (sizeof(struct dlm_unlock_lock)+DLM_LVB_LEN)
>  
> @@ -632,7 +632,7 @@ struct dlm_proxy_ast
>  
>  	u8 name[O2NM_MAX_NAME_LEN];
>  
> -	s8 lvb[0];
> +	s8 lvb[];
>  };
>  #define DLM_PROXY_AST_MAX_LEN  (sizeof(struct dlm_proxy_ast)+DLM_LVB_LEN)
>  
> 
