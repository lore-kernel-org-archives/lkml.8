Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBE8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 409CF2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r9zDN/x1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbgIHR5N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731573AbgIHQMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:12:48 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44A5C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 09:12:12 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id h9so4047128ooo.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 09:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f/2x/fmPr0smlalUj9WhY0K+GufBhz4BVPOjlENKkeE=;
        b=r9zDN/x1VgO7tRlqs8hVGaKVeOFIy0nhvuPHrKzZQZKJJT8b89ViSfMbkDKHjRYYIw
         hPIw6wEFqmkrxIoNKvcdfUUMdAgkQWVvBWxwzxEgAv656m7oEwL9DSHzlLSbaPjf3Ohx
         JEMLp0MUckl2NhlA8Fw6JVaHWFrEZxkgJO9Oue+W9dKe27M0hPicZUQhRDFSuV4gxrSw
         /CwzAjAaArQO+QCxjS+xmKOnWWPrihVvbeYVTgSh0m78/U1jxZgAQY7g9Enf69NfiCZo
         cMSlamAQ5/SsD6jWZBkvxhNanp/H8WSuXwz11c8B1owRdV+SpGQlwbAuCNNqcefUnujX
         gxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=f/2x/fmPr0smlalUj9WhY0K+GufBhz4BVPOjlENKkeE=;
        b=qhbKRnL4Vg8HWjSDBdgv3rcRvSlZD5eju2JbYrYQ127MUHNRyHjHw4beS40yIEl/US
         mfj4ugoPX9dfMbVPeMU1BNSEBCYwqK7Zu4C58j1f+ydewPuCXAdPsWYs1uSYO09il9zx
         2p2rDzGDeefiTh4cwB3+d1T7znDJfPuLv/5BKumxwe7MmvKqRTfbsSDk0n+iY+CQgDPX
         LaBZq0ihQAKPCgwPtnnIDVsLn5rna7VjpPBxzNnLGznu4uhAoVO3qwfI0y+9UAQ0/4X/
         mKuJaWH7HvJJ20cPtPhhakXf9MIDoxHjU63Gogf+4uqD8Fjy39Advaly5K6Wvdd0JtxC
         malA==
X-Gm-Message-State: AOAM532xOGI6O02wlvfSXgfF8bKCz73VAR1mhD5nJAyF5M2JWk+sjnTR
        9cY1yFM39b4UgUzoGyAmbZI=
X-Google-Smtp-Source: ABdhPJxzSmYe1beFIi9sv6U85nczxcVbjcNA6tiUtQUUxSp0dqUSuLx7NHwwOP04JlHABwgjp7oJfw==
X-Received: by 2002:a4a:b601:: with SMTP id z1mr6288105oon.83.1599581532142;
        Tue, 08 Sep 2020 09:12:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m1sm3298044oih.3.2020.09.08.09.12.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Sep 2020 09:12:11 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:12:10 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        davem@davemloft.net
Subject: Re: [PATCH] sparc64: Fix irqtrace warnings on Ultra-S
Message-ID: <20200908161210.GA167915@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 05:41:57PM +0200, peterz@infradead.org wrote:
> On Tue, Sep 08, 2020 at 07:40:23AM -0700, Guenter Roeck wrote:
> > qemu-system-sparc64 -M sun4u -cpu "TI UltraSparc IIi" -m 512 \
> >     -initrd rootfs.cpio \
> >     -kernel arch/sparc/boot/image -no-reboot \
> >     -append "panic=-1 slub_debug=FZPUA rdinit=/sbin/init console=ttyS0" \
> >     -nographic -monitor none
> 
> Thanks I got it. Also enabling DEBUG_LOCKDEP helps (-:
> 
> ---
> Subject: sparc64: Fix irqtrace warnings on Ultra-S
> 
> Recent changes in Lockdep's IRQTRACE broke Ultra-S.
> 
> In order avoid redundant IRQ state changes, local_irq_restore() lost the
> ability to trace a disable. Change the code to use local_irq_save() to
> disable IRQs and then use arch_local_irq_restore() to further disable
> NMIs.
> 
> This result in slightly suboptimal code, but given this code uses a
> global spinlock, performance cannot be its primary purpose.
> 
> Fixes: 044d0d6de9f5 ("lockdep: Only trace IRQ edges")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
> A possible alternative would be:
> 
> 	local_save_flags(flags);
> 	arch_local_irq_restore((unsigned long)PIL_NMI);
> 	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS))
> 		trace_hardirqs_off();
> 
> which generates optimal code, but is more verbose.
> 
>  arch/sparc/prom/p1275.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
> index 889aa602f8d8..e22233fcf741 100644
> --- a/arch/sparc/prom/p1275.c
> +++ b/arch/sparc/prom/p1275.c
> @@ -37,16 +37,15 @@ void p1275_cmd_direct(unsigned long *args)
>  {
>  	unsigned long flags;
>  
> -	local_save_flags(flags);
> -	local_irq_restore((unsigned long)PIL_NMI);
> +	local_irq_save(flags);
> +	arch_local_irq_restore((unsigned long)PIL_NMI);
>  	raw_spin_lock(&prom_entry_lock);
>  
>  	prom_world(1);
>  	prom_cif_direct(args);
>  	prom_world(0);
>  
> -	raw_spin_unlock(&prom_entry_lock);
> -	local_irq_restore(flags);
> +	raw_spin_unlock_irqrestore(&prom_entry_lock, flags);
>  }
>  
>  void prom_cif_init(void *cif_handler, void *cif_stack)
