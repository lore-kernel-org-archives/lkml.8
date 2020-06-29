Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD712C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F652053B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgF2TBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:01:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:48442 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729397AbgF2TBY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:01:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id F1A96ACF1;
        Mon, 29 Jun 2020 14:50:20 +0000 (UTC)
Date:   Mon, 29 Jun 2020 16:50:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Cengiz Can <cengiz@kernel.wtf>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] kdb: prevent possible null deref in kdb_msg_write
Message-ID: <20200629145020.GL6156@alley>
References: <20200629135923.14912-1-cengiz@kernel.wtf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629135923.14912-1-cengiz@kernel.wtf>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-06-29 16:59:24, Cengiz Can wrote:
> `kdb_msg_write` operates on a global `struct kgdb_io *` called
> `dbg_io_ops`.
> 
> Although it is initialized in `debug_core.c`, there's a null check in
> `kdb_msg_write` which implies that it can be null whenever we dereference
> it in this function call.
> 
> Coverity scanner caught this as CID 1465042.
> 
> I have modified the function to bail out if `dbg_io_ops` is not properly
> initialized.
> 
> Signed-off-by: Cengiz Can <cengiz@kernel.wtf>
> ---
>  kernel/debug/kdb/kdb_io.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index 683a799618ad..85e579812458 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -549,14 +549,15 @@ static void kdb_msg_write(const char *msg, int msg_len)
>  	if (msg_len == 0)
>  		return;
>  
> -	if (dbg_io_ops) {
> -		const char *cp = msg;
> -		int len = msg_len;
> +	if (!dbg_io_ops)
> +		return;

This looks wrong. The message should be printed to the consoles
even when dbg_io_ops is NULL. I mean that the for_each_console(c)
cycle should always get called.

Well, the code really looks racy. dbg_io_ops is set under
kgdb_registration_lock. IMHO, it should also get accessed under this lock.

It seems that the race is possible. kdb_msg_write() is called from
vkdb_printf(). This function is serialized on more CPUs using
kdb_printf_cpu lock. But it is not serialized with
kgdb_register_io_module() and kgdb_unregister_io_module() calls.

But I might miss something. dbg_io_ops is dereferenced on many other
locations without any check.


>  
> -		while (len--) {
> -			dbg_io_ops->write_char(*cp);
> -			cp++;
> -		}
> +	const char *cp = msg;
> +	int len = msg_len;
> +
> +	while (len--) {
> +		dbg_io_ops->write_char(*cp);
> +		cp++;
>  	}
>  
>  	for_each_console(c) {

You probably got confused by this new code:

		if (c == dbg_io_ops->cons)
			continue;

It dereferences dbg_io_ops without NULL check. It should probably
get replaced by:

		if (dbg_io_ops && c == dbg_io_ops->cons)
			continue;

Daniel, Sumit, could you please put some light on this?

Best Regards,
Petr
