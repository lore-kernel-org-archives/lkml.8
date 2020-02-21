Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AECC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43A0420722
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 17:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dm+S/V9c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgBURHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 12:07:24 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55008 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBURHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 12:07:23 -0500
Received: by mail-wm1-f66.google.com with SMTP id n3so2521525wmk.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 09:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AqC2fWiWZxuVA5v3S/7DavUy6/LHSuW/SdnBa9FsreU=;
        b=Dm+S/V9cHvQIuxY32ywFd/CVVnU1HT7KaLT56X7KWzSAE8RHuLMUawyQ1sfFTrVuDg
         HgASOHEy9NMZP5zDvHpPokDCwwt0A0vczNG52ql5kiJ99tjb7xCwux3Rvj7WUILLEdbF
         LQ3LAouhLZfrkvMwRM70UW+RKmDXvJ1jKdT5vIOg8QS8y8MzvRkM1RSagbxFIrpDCuRr
         qcwI3WZh7h8Jbl5eQmASBh7WExK+uqOr8D6AeUP9RxKJBn5cHQVkjDMYNo10jHDq0yg0
         hw27ZfmT1AGvuyTLRBNWhT0Vd5y7Nc3cD9ucM3mrd8ZSNKZdkGVO9Q04J6d51EV8u41Y
         GvXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AqC2fWiWZxuVA5v3S/7DavUy6/LHSuW/SdnBa9FsreU=;
        b=h8XpL4lOVHcYPc0vnwiYzYXrvl3LaNxYPsh3aGcbDEHkX6EWngz+tdgY5fqttn9vwD
         1bJpzi9NfgnyarNn78/R5EVDjEX47Wc04N4DaZkFvqZ6vW31O7ordAgXVlxLQx0E8Sdo
         Xi/pmpcGSCZ8nD6NvRxW9nVUdfdvIyQKFG2cmotiwJ13fdCsFd0AcMWPNS1/7Onyf+xg
         Wi9FHdBUtf/OqgZ09IFaxM3B0bO67amF9DBMu6EMzUM8iC5ASPlmOon8339uZRh44z7b
         cx4aZPO7x7AbHQMeMRaJQCaejjWb8bEGfsu3NImyKh5G9PMyJMgOFiKXDOV1Zab0Ew05
         GSPQ==
X-Gm-Message-State: APjAAAX7YsxanfQa4hMobt7d/PweAtMQ3ys9GL+zr3y8Su/8IS3ADsy1
        X275VOqbkwga3wluLT+Ceuk6QiwWZPI=
X-Google-Smtp-Source: APXvYqzRCwaG2Ny1EOpRxBTYNEMY4FxGnxVFVGpKec47kvpAJV08JB3catC0hCh+B9JrFktrKFv6dQ==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr5087891wmi.118.1582304839975;
        Fri, 21 Feb 2020 09:07:19 -0800 (PST)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id q124sm10332724wme.2.2020.02.21.09.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 09:07:19 -0800 (PST)
Date:   Fri, 21 Feb 2020 18:07:13 +0100
From:   Marco Elver <elver@google.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] percpu_counter: fix a data race at vm_committed_as
Message-ID: <20200221170713.GA227918@google.com>
References: <1582302724-2804-1-git-send-email-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582302724-2804-1-git-send-email-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Feb 2020, Qian Cai wrote:

> "vm_committed_as.count" could be accessed concurrently as reported by
> KCSAN,
> 
>  BUG: KCSAN: data-race in __vm_enough_memory / percpu_counter_add_batch
> 
>  write to 0xffffffff9451c538 of 8 bytes by task 65879 on cpu 35:
>   percpu_counter_add_batch+0x83/0xd0
>   percpu_counter_add_batch at lib/percpu_counter.c:91
>   __vm_enough_memory+0xb9/0x260
>   dup_mm+0x3a4/0x8f0
>   copy_process+0x2458/0x3240
>   _do_fork+0xaa/0x9f0
>   __do_sys_clone+0x125/0x160
>   __x64_sys_clone+0x70/0x90
>   do_syscall_64+0x91/0xb05
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  read to 0xffffffff9451c538 of 8 bytes by task 66773 on cpu 19:
>   __vm_enough_memory+0x199/0x260
>   percpu_counter_read_positive at include/linux/percpu_counter.h:81
>   (inlined by) __vm_enough_memory at mm/util.c:839
>   mmap_region+0x1b2/0xa10
>   do_mmap+0x45c/0x700
>   vm_mmap_pgoff+0xc0/0x130
>   ksys_mmap_pgoff+0x6e/0x300
>   __x64_sys_mmap+0x33/0x40
>   do_syscall_64+0x91/0xb05
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The read is outside percpu_counter::lock critical section which results
> in a data race. Fix it by adding a READ_ONCE() in
> percpu_counter_read_positive() which could also service as the existing
> compiler memory barrier.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>

Acked-by: Marco Elver <elver@google.com>

FWIW in the function where this was inlined here, the generated code (on
x86 at least) is identical.

Thanks,
-- Marco

> ---
>  include/linux/percpu_counter.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
> index 4f052496cdfd..0a4f54dd4737 100644
> --- a/include/linux/percpu_counter.h
> +++ b/include/linux/percpu_counter.h
> @@ -78,9 +78,9 @@ static inline s64 percpu_counter_read(struct percpu_counter *fbc)
>   */
>  static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
>  {
> -	s64 ret = fbc->count;
> +	/* Prevent reloads of fbc->count */
> +	s64 ret = READ_ONCE(fbc->count);
>  
> -	barrier();		/* Prevent reloads of fbc->count */
>  	if (ret >= 0)
>  		return ret;
>  	return 0;
> -- 
> 1.8.3.1
> 
