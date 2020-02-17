Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A59C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE1C20801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 20:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="p79DEuOY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgBQUsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 15:48:04 -0500
Received: from mail.skyhub.de ([5.9.137.197]:53420 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbgBQUsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 15:48:03 -0500
Received: from zn.tnic (p200300EC2F060D00F45FBD97DBAEED4C.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:d00:f45f:bd97:dbae:ed4c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F7821EC0CEA;
        Mon, 17 Feb 2020 21:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581972481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pXUQLBnvAvbm1QU0WL1QhfsZjIvoahth1MX0a41TYHU=;
        b=p79DEuOYwU2cg7nsTkWIjVzUeYMUfOM2oJq7zUC9iIhDrlrs2VJLaEpxGkKlibROq7Q6Vr
        rDOiKgrWgXC6Db3j50vCdvkQRKYDmqaX4X0SGFe7iqcIiONCJ/ZcrdfOOK0iZXvRL3XxD0
        o7TkM9NZsmS2iVIQrG7jthIqMRtNa4o=
Date:   Mon, 17 Feb 2020 21:47:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/mce: /dev/mcelog: Dynamically allocate space for
 machine check records
Message-ID: <20200217204756.GE14426@zn.tnic>
References: <20200208000551.11364-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200208000551.11364-1-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 04:05:51PM -0800, Tony Luck wrote:
> We have had a hard coded limit of 32 machine check records since the
> dawn of time.  But as numbers of cores increase, it is possible for
> more than 32 errors to be reported before a user process reads from
> /dev/mcelog. In this case the additional errors are lost.
> 
> Keep 32 as the minimum. But tune the maximum value up based on the
> number of processors.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/include/asm/mce.h           |  6 ++--
>  arch/x86/kernel/cpu/mce/dev-mcelog.c | 46 ++++++++++++++++------------
>  2 files changed, 29 insertions(+), 23 deletions(-)

...

> @@ -214,21 +210,21 @@ static ssize_t mce_chrdev_read(struct file *filp, char __user *ubuf,
>  
>  	/* Only supports full reads right now */
>  	err = -EINVAL;
> -	if (*off != 0 || usize < MCE_LOG_LEN*sizeof(struct mce))
> +	if (*off != 0 || usize < mcelog->len*sizeof(struct mce))

Add spaces around that *

>  		goto out;
>  
> -	next = mcelog.next;
> +	next = mcelog->next;
>  	err = 0;
>  
>  	for (i = 0; i < next; i++) {
> -		struct mce *m = &mcelog.entry[i];
> +		struct mce *m = &mcelog->entry[i];
>  
>  		err |= copy_to_user(buf, m, sizeof(*m));
>  		buf += sizeof(*m);
>  	}
>  
> -	memset(mcelog.entry, 0, next * sizeof(struct mce));
> -	mcelog.next = 0;
> +	memset(mcelog->entry, 0, next * sizeof(struct mce));
> +	mcelog->next = 0;
>  
>  	if (err)
>  		err = -EFAULT;

...

> @@ -340,6 +336,15 @@ static struct miscdevice mce_chrdev_device = {
>  static __init int dev_mcelog_init_device(void)
>  {
>  	int err;
> +	int mce_log_len;

Please sort function local variables declaration in a reverse christmas
tree order:

	<type A> longest_variable_name;
	<type B> shorter_var_name;
	<type C> even_shorter;
	<type D> i;

> +
> +	mce_log_len = max(MCE_LOG_MIN_LEN, num_online_cpus());

arch/x86/kernel/cpu/mce/dev-mcelog.c: In function ‘dev_mcelog_init_device’:
./include/linux/kernel.h:835:29: warning: comparison of distinct pointer types lacks a cast
  835 |   (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
      |                             ^~
./include/linux/kernel.h:849:4: note: in expansion of macro ‘__typecheck’
  849 |   (__typecheck(x, y) && __no_side_effects(x, y))
      |    ^~~~~~~~~~~
./include/linux/kernel.h:859:24: note: in expansion of macro ‘__safe_cmp’
  859 |  __builtin_choose_expr(__safe_cmp(x, y), \
      |                        ^~~~~~~~~~
./include/linux/kernel.h:875:19: note: in expansion of macro ‘__careful_cmp’
  875 | #define max(x, y) __careful_cmp(x, y, >)
      |                   ^~~~~~~~~~~~~
arch/x86/kernel/cpu/mce/dev-mcelog.c:341:16: note: in expansion of macro ‘max’
  341 |  mce_log_len = max(MCE_LOG_MIN_LEN, num_online_cpus());
      |                ^~~

That MCE_LOG_MIN_LEN wants to be 32U.

> +	mcelog = kzalloc(sizeof(*mcelog) + mce_log_len * sizeof(struct mce), GFP_KERNEL);
> +	if (!mcelog)
> +		return -ENOMEM;

<---- newline here.

> +	strncpy(mcelog->signature, MCE_LOG_SIGNATURE, sizeof(mcelog->signature));
> +	mcelog->len = mce_log_len;
> +	mcelog->recordlen = sizeof(struct mce);
>  
>  	/* register character device /dev/mcelog */
>  	err = misc_register(&mce_chrdev_device);

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
