Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B750C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791B620810
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590748008;
	bh=8bEWlZvRJTJSN5EFbE7fd2XRTFiSJ+Enlo+N8agFquw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZU4Q//u2+HbxxELoWMbzbJSC87yzs0AYFGK4EY88vg1fXwvjWevmkPZK8hEuqGKdv
	 M7cZuf0IgTHeirJVgySWilPb17mYesgR0e2tSAywwV0t52P5lGtyqHNhZwUIbafdv+
	 t01+XMzALELfBE6yom01OWpJzI25M3j2SmMJQLWM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgE2K0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 06:26:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgE2K0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:26:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C26F9206A4;
        Fri, 29 May 2020 10:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590748006;
        bh=8bEWlZvRJTJSN5EFbE7fd2XRTFiSJ+Enlo+N8agFquw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faxcz92sMN7eOu8oBUxaAuviQDXXeCuF2ty48gOQVoG5HKyRtgx+1j3jYaEufgT4v
         ps9TDuc6AUOCKrsn9WS7bIWuM8CHQAcMiGCY1kLVP1M2yVXU9+iLCJ5JPtqGZK78wI
         pz+6O4DU0xL3evrZoQJnm3ddwYf+9VKFG7x8HgYY=
Date:   Fri, 29 May 2020 12:26:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     keescook@chromium.org, yzaikin@google.com, nixiaoming@huawei.com,
        ebiederm@xmission.com, axboe@kernel.dk, clemens@ladisch.de,
        arnd@arndb.de, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch, benh@kernel.crashing.org,
        rdna@fb.com, viro@zeniv.linux.org.uk, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com, vbabka@suse.cz,
        sfr@canb.auug.org.au, jack@suse.cz, amir73il@gmail.com,
        rafael@kernel.org, tytso@mit.edu, julia.lawall@lip6.fr,
        akpm@linux-foundation.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linuxppc-dev@lists.ozlabs.org,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] random: simplify sysctl declaration with
 register_sysctl_subdir()
Message-ID: <20200529102644.GB1345939@kroah.com>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-12-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529074108.16928-12-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 07:41:06AM +0000, Luis Chamberlain wrote:
> From: Xiaoming Ni <nixiaoming@huawei.com>
> 
> Move random_table sysctl from kernel/sysctl.c to drivers/char/random.c
> and use register_sysctl_subdir() to help remove the clutter out of
> kernel/sysctl.c.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/char/random.c  | 14 ++++++++++++--
>  include/linux/sysctl.h |  1 -
>  kernel/sysctl.c        |  5 -----
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index a7cf6aa65908..73fd4b6e9c18 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -2101,8 +2101,7 @@ static int proc_do_entropy(struct ctl_table *table, int write,
>  }
>  
>  static int sysctl_poolsize = INPUT_POOL_WORDS * 32;
> -extern struct ctl_table random_table[];
> -struct ctl_table random_table[] = {
> +static struct ctl_table random_table[] = {
>  	{
>  		.procname	= "poolsize",
>  		.data		= &sysctl_poolsize,
> @@ -2164,6 +2163,17 @@ struct ctl_table random_table[] = {
>  #endif
>  	{ }
>  };
> +
> +/*
> + * rand_initialize() is called before sysctl_init(),
> + * so we cannot call register_sysctl_init() in rand_initialize()
> + */
> +static int __init random_sysctls_init(void)
> +{
> +	register_sysctl_subdir("kernel", "random", random_table);

No error checking?

:(

