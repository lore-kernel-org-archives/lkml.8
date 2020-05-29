Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B486AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93B7C208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbgE2NVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgE2NVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:21:45 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B58EF20721;
        Fri, 29 May 2020 13:21:42 +0000 (UTC)
Subject: Re: [PATCH 2/2] m68k,nommu: fix implicit cast from __user in
 __{get,put}_user_asm()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
References: <20200528202514.27175-1-luc.vanoostenryck@gmail.com>
 <20200528202514.27175-3-luc.vanoostenryck@gmail.com>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <8e2f9ac6-b277-0b80-c150-eb372fbeaf0a@linux-m68k.org>
Date:   Fri, 29 May 2020 23:21:38 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528202514.27175-3-luc.vanoostenryck@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On 29/5/20 6:25 am, Luc Van Oostenryck wrote:
> The assembly for __get_user_asm() & __put_user_asm() uses memcpy()
> when the size is 8.
> 
> However, the pointer is always a __user one while memcpy() expect
> a plan one and so this cast creates a lot of warnings when using     ^^^^
Did you mean "plain"?


> Sparse.
> 
> So, fix this by adding a cast to 'void __force *' at memcpy()'s
> argument.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>   arch/m68k/include/asm/uaccess_no.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/uaccess_no.h b/arch/m68k/include/asm/uaccess_no.h
> index 9651766a62af..f32f08a64eaa 100644
> --- a/arch/m68k/include/asm/uaccess_no.h
> +++ b/arch/m68k/include/asm/uaccess_no.h
> @@ -42,7 +42,7 @@ static inline int _access_ok(unsigned long addr, unsigned long size)
>   	__put_user_asm(__pu_err, __pu_val, ptr, l);	\
>   	break;						\
>       case 8:						\
> -	memcpy(ptr, &__pu_val, sizeof (*(ptr))); \
> +	memcpy((void __force*)ptr, &__pu_val, sizeof (*(ptr))); \
                            ^^^
checkpatch wants a ' ' space in there.

Otherwise I think it looks good.

Regards
Greg

  
>   	break;						\
>       default:						\
>   	__pu_err = __put_user_bad();			\
> @@ -85,7 +85,7 @@ extern int __put_user_bad(void);
>   	    u64 l;						\
>   	    __typeof__(*(ptr)) t;				\
>   	} __gu_val;						\
> -	memcpy(&__gu_val.l, ptr, sizeof(__gu_val.l));		\
> +	memcpy(&__gu_val.l, (const void __force*)ptr, sizeof(__gu_val.l));		\
>   	(x) = __gu_val.t;					\
>   	break;							\
>       }								\
> 
