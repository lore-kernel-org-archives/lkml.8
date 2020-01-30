Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27955C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1DEF2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580414549;
	bh=T5hCZojYtWMFH95Uk6W7V35evSlM/w1WxGxIlyY1mHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l0moqxeJE5pMnB8w3seRhiSvTfh4iUxg+o5rIR1MtaR10g3YNlngh4x/L0BcHASk7
	 RDiLb/iadlgKDb9qcUWE62UeFLXganZk6WdYI27/JfzFsu91U1tfHs5FaGlNl0r5So
	 RgZzZ/Mhz+mMp8FWXQWGS1j0AyDZPjCQjW/jrhoM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgA3UC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:02:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45162 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3UC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:02:27 -0500
Received: by mail-qt1-f194.google.com with SMTP id d9so3480660qte.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:02:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EnO9ApUhravM+tL102IQlojS3LeUikkMXEduxs5VnRY=;
        b=buUCSUGjOSvW39r5wIg+tKdu30Kq25W821E2E7UAPF9lUKcKSvLUjYWNfxihI/c3Ek
         GHrXIfAzH0B6agYXgc92IvUSdMfQ8Ams3sRb0vOpGpOyP8yL5gFo4TtDBofUZET4hoqW
         jHFoHEgkNjIRrmsZ8kVI/UE9rqpAY/SNg9TTVd3Etdxh7W+Qhz6VA3GPdYDF9FhMIB4q
         bH5h4lG2QPOwMp5EV9GZ2hPVhLSouke9V3VaLWhPBkzU29ozKJeTkLgau+slDIxbFV5S
         GtLYIEcqw0ci18FXwA1rzU/oJbumlq1YDujYxWx4Pspb2KseQCQZfTxeUVOx4lAp/Sn+
         aEXA==
X-Gm-Message-State: APjAAAXG5AmFyw/iPu79+ZB3jxeOneyRxQQV08JrXWrm6IlBfryJTWcM
        a/NuPG47bzj0XSNfb3UYUsE=
X-Google-Smtp-Source: APXvYqzTd0jiVB0C/NGRDY2nITRBPLL+esJyO9jJ6SAdUEND2P7U5Z3tpNG7u1P+TegikMJjbZH6YA==
X-Received: by 2002:ac8:6910:: with SMTP id e16mr6828095qtr.273.1580414545491;
        Thu, 30 Jan 2020 12:02:25 -0800 (PST)
Received: from dennisz-mbp ([2620:10d:c091:480::308e])
        by smtp.gmail.com with ESMTPSA id f4sm3311771qka.89.2020.01.30.12.02.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:02:24 -0800 (PST)
Date:   Thu, 30 Jan 2020 20:01:50 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, dennis@kernel.org, tj@kernel.org,
        cl@linux.com, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/util: annotate an intentional data race
Message-ID: <20200130200150.GA99121@dennisz-mbp>
References: <20200130145649.1240-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130145649.1240-1-cai@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 09:56:49AM -0500, Qian Cai wrote:
> "vm_committed_as.count" could be accessed concurrently as reported by
> KCSAN,
> 
>  read to 0xffffffff923164f8 of 8 bytes by task 1268 on cpu 38:
>   __vm_enough_memory+0x43/0x280 mm/util.c:801
>   mmap_region+0x1b2/0xb90 mm/mmap.c:1726
>   do_mmap+0x45c/0x700
>   vm_mmap_pgoff+0xc0/0x130
>   vm_mmap+0x71/0x90
>   elf_map+0xa1/0x1b0
>   load_elf_binary+0x9de/0x2180
>   search_binary_handler+0xd8/0x2b0
>   __do_execve_file+0xb61/0x1080
>   __x64_sys_execve+0x5f/0x70
>   do_syscall_64+0x91/0xb47
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
>  write to 0xffffffff923164f8 of 8 bytes by task 1265 on cpu 41:
>   percpu_counter_add_batch+0x83/0xd0 lib/percpu_counter.c:91
>   exit_mmap+0x178/0x220 include/linux/mman.h:68
>   mmput+0x10e/0x270
>   flush_old_exec+0x572/0xfe0
>   load_elf_binary+0x467/0x2180
>   search_binary_handler+0xd8/0x2b0
>   __do_execve_file+0xb61/0x1080
>   __x64_sys_execve+0x5f/0x70
>   do_syscall_64+0x91/0xb47
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> The warning is almost impossible to trigger according to the commit
> 82f71ae4a2b8 ("mm: catch memory commitment underflow") but leave it for
> now to catch any possible unbalanced vm_unacct_memory() in the future.
> Since only the read is operating as lockless, mark it as an intentional
> data race using the data_race() macro.
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/util.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/util.c b/mm/util.c
> index 988d11e6c17c..528d2c710771 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -798,8 +798,8 @@ int __vm_enough_memory(struct mm_struct *mm, long pages, int cap_sys_admin)
>  {
>  	long allowed;
>  
> -	VM_WARN_ONCE(percpu_counter_read(&vm_committed_as) <
> -			-(s64)vm_committed_as_batch * num_online_cpus(),
> +	VM_WARN_ONCE(data_race(percpu_counter_read(&vm_committed_as) <
> +			-(s64)vm_committed_as_batch * num_online_cpus()),
>  			"memory commitment underflow");
>  
>  	vm_acct_memory(pages);
> -- 
> 2.21.0 (Apple Git-122.2)
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
