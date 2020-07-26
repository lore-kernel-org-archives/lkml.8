Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C52C1C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1A152070B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 07:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595747215;
	bh=yqMeuAH11AK4xZQOGYBvoNfIg6YKAOUK5pcvK+ySOUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Yn55ObCbw5pvd35wNePs9JlHedvHshbVHTKwgmu1nIrKUPjuMWbwy6ljuEtlLwToI
	 9nEBaLNw2Uh8CAjnSwbCahi5u4UjkHPaEo667O248scXqO5VkFC3B0MRE1YgCMXtYV
	 dxJhiipVSZjUdI4uw3/HcevILDSlM4H12jBaJZg4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgGZHGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 03:06:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:59720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgGZHGy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:06:54 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1949920663;
        Sun, 26 Jul 2020 07:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595747213;
        bh=yqMeuAH11AK4xZQOGYBvoNfIg6YKAOUK5pcvK+ySOUU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZ+tc5Ko/nEIVET5iSFPN7/QrL0ET0/yd8TZYXCL8QhrqY+EaTu38psk8QFqM448K
         2e0fjfBjNKkXARz5YjTsziAyDw4DRKrnq7zqVxdpH43HWO4pIaLj70fUzmlZbcbFif
         Qk5Z9UTjuQWWmfuVK+QaLap5qPcxFoRd8HR+d5hY=
Date:   Sun, 26 Jul 2020 09:06:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Xin Xiong <xiongx18@fudan.edu.cn>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Xin Tan <tanxin.ctf@gmail.com>, yuanxzhang@fudan.edu.cn
Subject: Re: [PATCH] tty: fix pid refcount leak in tty_signal_session_leader
Message-ID: <20200726070650.GA440555@kroah.com>
References: <20200726052804.GA51199@xin-virtual-machine>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726052804.GA51199@xin-virtual-machine>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 01:28:04PM +0800, Xin Xiong wrote:
> In the loop, every time when p->signal->leader is true, the function
> tty_signal_session_leader() will invoke get_pid() and return a
> reference of tty->pgrp with increased refcount to the local variable
> tty_pgrp or return NULL if it fails. After finishing the loop, the
> function invokes put_pid() for only once, decreasing the refcount that
> tty_pgrp keeps.
> 
> Refcount leaks may occur when the scenario that p->signal->leader is
> true happens more than once. In this assumption, if the above scenario
> happens n times in the loop, the function forgets to decrease the
> refcount for n-1 times, which causes refcount leaks.
> 
> Fix the issue by decreasing the current refcount of the local variable
> tty_pgrp before assigning new objects to it.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> Signed-off-by: Xin Xiong <xiongx18@fudan.edu.cn>
> ---
>  drivers/tty/tty_jobctrl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
> index f8ed50a16848..9e6bf693ade1 100644
> --- a/drivers/tty/tty_jobctrl.c
> +++ b/drivers/tty/tty_jobctrl.c
> @@ -212,6 +212,8 @@ int tty_signal_session_leader(struct tty_struct *tty, int exit_session)
>  			__group_send_sig_info(SIGCONT, SEND_SIG_PRIV, p);
>  			put_pid(p->signal->tty_old_pgrp);  /* A noop */
>  			spin_lock(&tty->ctrl_lock);
> +			if (tty_pgrp)
> +				put_pid(tty_pgrp);

No need to check this before calling it.

But, the real question is why is this needed now?  Nothing has changed
in this area of the kernel for a very long time, so how did things get
broken here?

How are you triggering this and what is the result when we have that
additional reference?

thanks,

greg k-h
