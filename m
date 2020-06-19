Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A667C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 402F720885
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 06:49:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgFSGta (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 02:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgFSGta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 02:49:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155DCC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 23:49:30 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=vostro)
        by Galois.linutronix.de with esmtps (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1jmAq3-0001tw-6V; Fri, 19 Jun 2020 08:49:23 +0200
From:   John Ogness <john.ogness@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Petr Mladek <pmladek@suse.com>, kbuild-all@lists.01.org,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] printk: _printk_rb_static_dict can be static
References: <20200618144919.9806-4-john.ogness@linutronix.de>
        <20200618182323.GA72993@4e49555bcca1>
Date:   Fri, 19 Jun 2020 08:49:21 +0200
In-Reply-To: <20200618182323.GA72993@4e49555bcca1> (kernel test robot's
        message of "Fri, 19 Jun 2020 02:23:23 +0800")
Message-ID: <871rmbim8e.fsf@vostro.fn.ogness.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-18, kernel test robot <lkp@intel.com> wrote:
> Signed-off-by: kernel test robot <lkp@intel.com>
> ---
>  printk.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 7642ef634956f..d812ada06735f 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -434,7 +434,7 @@ static u32 log_buf_len = __LOG_BUF_LEN;
>   */
>  #define PRB_AVGBITS 5	/* 32 character average length */
>  
> -_DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
> +static _DECLARE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
>  		  PRB_AVGBITS, PRB_AVGBITS, &__log_buf[0]);

_DECLARE_PRINTKRB declares multiple variables, so this patch will not
work as intended. I would like to declare the variables static but am
not sure how best to go about it.

In the Linux source I see examples of macros just desclaring the
variables static. And I see examples of the macros providing a parameter
where the "static" keyword can be specified.

Since the ringbuffer was created exclusively to serve printk, I would
prefer to just have _DECLARE_PRINTKRB (and DECLARE_PRINTKRB) declare all
the variables as static.

John Ogness
