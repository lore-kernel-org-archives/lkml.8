Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E13C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4F12076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CV/gd6Gb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCRMN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:13:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42368 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCRMN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:13:28 -0400
Received: by mail-qk1-f195.google.com with SMTP id e11so38143381qkg.9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j5lq+ZeR1e5BLS61AhHY/9aQpgtc96UUH7xL5gfZlA4=;
        b=CV/gd6GbNBkHRzX6JGk52Gu52tpr+Ik38xHSjudsHMrtP3GG0SadQ/ERhtDU7kkGsE
         JgQEcYrOmU5agISimpX5xfwdM8s+z2RYoYxtH+/EZLht/quMchPcvOZnF+aJDxK1JKAB
         SFIbYlm7RqIlG6Ym6nJ4AM8uWuMtZ2VSK+DVdULVDkU/TE2VLsxbt4PLXTiL1wxEzmHU
         fMMLDzeinxdeV4YBUU38jrTyYx73QMmbDvX+wK6I+dusQ13+9ddEWjN0pwn+4s3UGI49
         oIdENEBzAzVDXSq+LsGLqAc6sdMxQzVD6XbuZdzmV/Vid71g52WOdJyziDHTFeDNFdUq
         rtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j5lq+ZeR1e5BLS61AhHY/9aQpgtc96UUH7xL5gfZlA4=;
        b=jYWnm5frdGrsaj0ecZnbabKXJGh4Tf8vPbaXMKdDS0u1o0m6IriZYYGKsrzN2ELqZA
         aIScpbiJpQK5jhR1cL+TxNB+Tovvjlg1sH9hygu3pqgTVI1gxu08Ywem8krtzdoxxcwa
         X3/W/B5gMHiiRHcMn/K234mmotCeKonw5Ur7j+qJoDioKCrpzJWohgQUlMz1kagn3hLz
         yjzRJuS4WkXphsDeaC6cUksy4lsIowk6doIZwchy0XgMm0sKu7fURghkLkFYqt/2k0j/
         fdQOfvnhkNbTfrySOZMyH24yJ68P/8DNqn+haHCglwHWo+SbaBa2nQopd3feOZ+1IerL
         4dBQ==
X-Gm-Message-State: ANhLgQ1jDBKH9Pxa+9/d+6RdW/b5oB5dQli8SGAjtY6xbJ16aBJDjbde
        r1tysleLY+OxkEXb3+FfLwtOgQ==
X-Google-Smtp-Source: ADFU+vs9zNKs2Xu1t6dEyeygPPbCwubyJJzXUvpJUoWsTNJzUZXqoXmlWPE4G/BL5uZuyOnIhMu0ug==
X-Received: by 2002:a37:aa54:: with SMTP id t81mr3827143qke.234.1584533607354;
        Wed, 18 Mar 2020 05:13:27 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id p25sm312216qkm.97.2020.03.18.05.13.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 05:13:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEXZe-0003a7-6B; Wed, 18 Mar 2020 09:13:26 -0300
Date:   Wed, 18 Mar 2020 09:13:26 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, paulmck@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifier: silence PROVE_RCU_LIST warnings
Message-ID: <20200318121326.GZ20941@ziepe.ca>
References: <20200317175640.2047-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317175640.2047-1-cai@lca.pw>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 01:56:40PM -0400, Qian Cai wrote:
> It is safe to traverse mm->notifier_subscriptions->list either under
> SRCU read lock or mm->notifier_subscriptions->lock using
> hlist_for_each_entry_rcu(). Silence the PROVE_RCU_LIST false positives,
> for example,
> 
>  WARNING: suspicious RCU usage
>  -----------------------------
>  mm/mmu_notifier.c:484 RCU-list traversed in non-reader section!!
> 
>  other info that might help us debug this:
> 
>  rcu_scheduler_active = 2, debug_locks = 1
>  3 locks held by libvirtd/802:
>   #0: ffff9321e3f58148 (&mm->mmap_sem#2){++++}, at: do_mprotect_pkey+0xe1/0x3e0
>   #1: ffffffff91ae6160 (mmu_notifier_invalidate_range_start){+.+.}, at: change_p4d_range+0x5fa/0x800
>   #2: ffffffff91ae6e08 (srcu){....}, at: __mmu_notifier_invalidate_range_start+0x178/0x460
> 
>  stack backtrace:
>  CPU: 7 PID: 802 Comm: libvirtd Tainted: G          I       5.6.0-rc6-next-20200317+ #2
>  Hardware name: HP ProLiant BL460c Gen8, BIOS I31 11/02/2014
>  Call Trace:
>   dump_stack+0xa4/0xfe
>   lockdep_rcu_suspicious+0xeb/0xf5
>   __mmu_notifier_invalidate_range_start+0x3ff/0x460
>   change_p4d_range+0x746/0x800
>   change_protection+0x1df/0x300
>   mprotect_fixup+0x245/0x3e0
>   do_mprotect_pkey+0x23b/0x3e0
>   __x64_sys_mprotect+0x51/0x70
>   do_syscall_64+0x91/0xae8
>   entry_SYSCALL_64_after_hwframe+0x49/0xb3
> 
> Signed-off-by: Qian Cai <cai@lca.pw>
> ---
>  mm/mmu_notifier.c | 27 ++++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)

Looks right to me

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

This was missed during testing because we don't run with
PROVE_RCU_LIST enabled

Jason
