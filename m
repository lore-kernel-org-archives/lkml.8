Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD709C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7F7A20717
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRwqVOPU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgGSOfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 10:35:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSOfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 10:35:33 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB33C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 07:35:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 207so7787578pfu.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 07:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MSkvqxCGHgwiApo84aQWZNHUudChAzaosYHcOhPptH4=;
        b=GRwqVOPUpYjfZgAKaMMVgV5ROix3NayjZ5TFnwZbtxPv5J8rmy+2iJChiWKtYgiIBL
         +99jY7LV7BzSggJ3Ow9/xNUn6NUiaX2RUKdY2rqIg6IM50piKsicXHqweDjmMwnKbFzq
         v5jRYtzRGG7yfJZEqtXhh+6Ex04tLspkcxa/FMkUDS8BK88hmInrm3jre2uu6Si+df1D
         wqaw9S6wd0X3mxhJGSoZgB48+re+FprEbmdFXitdOC2HOEjRlZR0k8HsjJyFbJJCb6+V
         zmvNBhnMC2t6+lfc6fNBUHjzHuAf7fP5sTf7A8GSu2gWJIvVBkRIluen6/7ODB8EYwC9
         7NaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MSkvqxCGHgwiApo84aQWZNHUudChAzaosYHcOhPptH4=;
        b=nIYk3scIPSODbOJPlFOrNY2nmW9vICMRrCKhOvkgNJp6/N6rjbBH8fnfah8wZNNPem
         T1B+4XE7IsdOuBtncd3x/LOiWj0iu0hLzMSIfOeeLP+B/bVUZdjJS5qHkq66ymY6PwUm
         vJMXa+iMGSUmy2V50gz7y/pcq7sNPGg+J2VFmp11hS6Zv/ak6buOT6IV0+Sw77BdfEIv
         FbFwPNFBDE8y4ovHSF8kVHP7n/eAqvZyBCCzqpgI5kvEfScWw+sWiHApc6ySEF3PcFf5
         e6CF+vh4V6VaE3PYep0d7/H7nnMhj/36uQhdt7V0Ifw9i8s/C/+NEF8jKJnrNcOx91lC
         YV5w==
X-Gm-Message-State: AOAM5316p08hpDg9waP0cHKJR6lbNW1xT9qzWbAzbkc7OJmtWNKC3f3S
        yjVQxs/IGBzl0TXNcwryAsM=
X-Google-Smtp-Source: ABdhPJyaxbNWE08UVDkGdoZvdyzcho0Lm7meeHIBiK358Y573uNHLS9Fs5r7SFCdXfTzrGrViK8Dzw==
X-Received: by 2002:a63:1f45:: with SMTP id q5mr15417855pgm.240.1595169333407;
        Sun, 19 Jul 2020 07:35:33 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id a17sm12187302pgw.60.2020.07.19.07.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 07:35:31 -0700 (PDT)
Date:   Sun, 19 Jul 2020 23:35:27 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
Message-ID: <20200719143527.GA566@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717234818.8622-3-john.ogness@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/18 01:54), John Ogness wrote:
> ---
>  kernel/printk/printk.c | 114 ++++-------------------------------------
>  1 file changed, 11 insertions(+), 103 deletions(-)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index fec71229169e..c4274c867771 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -495,9 +495,14 @@ static void truncate_msg(u16 *text_len, u16 *trunc_msg_len)
>  		*trunc_msg_len = 0;
>  }
>  
> +static inline u32 printk_caller_id(void)
> +{
> +	return in_task() ? task_pid_nr(current) :
> +		0x80000000 + raw_smp_processor_id();
> +}

Can we merge lines that we don't want to merge?

   pr_cont()  ->  IRQ -> pr_cont() -> NMI -> pr_cont()

                  |__________________________________|
   different       same 0x80000000 + cpu_id caller id
   caller id

	-ss
