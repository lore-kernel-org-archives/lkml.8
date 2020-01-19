Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB325C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 09:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF962073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 09:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJ/WQJA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgASJMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 04:12:09 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58283 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726538AbgASJMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 04:12:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579425128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7/GLOX3neXRhFSwxzt6JYeaD8ZcLgraDA4/DOVM77Ms=;
        b=YJ/WQJA8U5N1UpFojAfN9U7VJ5uR4xhGnqQ+KxYvbcCmzrF/Hhxc9X4VohrO+Pru6G3ErJ
        2cSnpWPpvlPzHElpiShAlF2DHnp8OFCORDQ0fLb20MR+ZibBcwVEOGsEo6QAigvSyJ/1Xk
        JxsiWs2Ycba1CabZvboJ/AMkXK3A43E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-183-RXuIfLqkPAilIFFjk5zWIg-1; Sun, 19 Jan 2020 04:12:07 -0500
X-MC-Unique: RXuIfLqkPAilIFFjk5zWIg-1
Received: by mail-wr1-f70.google.com with SMTP id f15so12719092wrr.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 01:12:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7/GLOX3neXRhFSwxzt6JYeaD8ZcLgraDA4/DOVM77Ms=;
        b=TaZwcHEpCggNK/RGeRbgKJmwF/i1bUSB6fWaGA2o2FlL/1JmOIQWjKBHRmcGhEMjbw
         lSCZ5wTq54FoW83Wc/IWQPkt8ZzlBf7jPeNcz1d3it/dGdDF9dcIRA8HuGd7KAUaCTzt
         Iwf4Nn67+LOnPFhbQQDoWtm/QmHO34rOKuxp4LNPq7vw0q61ko16NqGnBxbcKYnNzgUu
         tUBpzxIDoKas5L4DhP6bqkb2SS4Tmmmp9r4wCpsSY+oz3QG+bDddE3f6AWGHkahCLeov
         Crz2ApMsx5272MImCHYl2EtzjGS4x/TUT/Lp2cb8hQJ9UKzziodn/NXiJM1Wh0Yuqusf
         cplw==
X-Gm-Message-State: APjAAAU9b6NQqjpdqdkUcGKS+rEdnQ3qifBbzJEslKQVD12Iq0fNuF1W
        MNL9/jyC0BswtlhZMmGgvzxqvD1utIZQX734HQqF9sNwWdWlBLv0MmyuRa6lFrsOjNpIuOmJwO7
        V4F3Oxim8AiCDND5BovUJkJDQ
X-Received: by 2002:a1c:5ac2:: with SMTP id o185mr13532817wmb.179.1579425126171;
        Sun, 19 Jan 2020 01:12:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqwDwkC7dDZDjZEuiAgMzY8U3Y7N4W29ndw4GTn8oT5UQWoJL5yEnU8cWXD25NJP2K9dsagQQA==
X-Received: by 2002:a1c:5ac2:: with SMTP id o185mr13532803wmb.179.1579425126002;
        Sun, 19 Jan 2020 01:12:06 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e0d6:d2cd:810b:30a9? ([2001:b07:6468:f312:e0d6:d2cd:810b:30a9])
        by smtp.gmail.com with ESMTPSA id i8sm43773037wro.47.2020.01.19.01.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2020 01:12:05 -0800 (PST)
Subject: Re: [PATCH] KVM: remove unused guest_enter
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        linux-kernel@vger.kernel.org
References: <1579145559-168038-1-git-send-email-alex.shi@linux.alibaba.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <19d27860-c2d1-455e-9690-9e381f255130@redhat.com>
Date:   Sun, 19 Jan 2020 10:12:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1579145559-168038-1-git-send-email-alex.shi@linux.alibaba.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/20 04:32, Alex Shi wrote:
> After commit 61bd0f66ff92 ("KVM: PPC: Book3S HV: Fix guest time accounting
> with VIRT_CPU_ACCOUNTING_GEN"), no one use this function anymore, So better
> to remove it.
> 
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  include/linux/context_tracking.h | 9 ---------
>  1 file changed, 9 deletions(-)
> 
> diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
> index 64ec82851aa3..8150f5ac176c 100644
> --- a/include/linux/context_tracking.h
> +++ b/include/linux/context_tracking.h
> @@ -154,15 +154,6 @@ static inline void guest_exit_irqoff(void)
>  }
>  #endif /* CONFIG_VIRT_CPU_ACCOUNTING_GEN */
>  
> -static inline void guest_enter(void)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	guest_enter_irqoff();
> -	local_irq_restore(flags);
> -}
> -
>  static inline void guest_exit(void)
>  {
>  	unsigned long flags;
> 

Queued, thanks.

Paolo

