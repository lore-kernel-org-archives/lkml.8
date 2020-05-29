Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5C8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9148207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590747977;
	bh=9g8EAMUcXzL5rm8FvjmpgV+PpYS3jeOMP9iJf7zni+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2kQ83qldlglK+EezO/krvwghEaV77j75R6m7kJ34jE504kyedTYOl2MTtkKYsacju
	 XwI7JkZCyTrc9eFnXtilwcNbOmNlSVh5VDi9YeF394FbfCGTbDc2ui8aO+EVMy1J9U
	 pkF5IwnJGMGKvk+MGDBBqFBOTY9icJ0I9AadQe5Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgE2K0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 06:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725681AbgE2K0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 06:26:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 48AE0206A4;
        Fri, 29 May 2020 10:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590747975;
        bh=9g8EAMUcXzL5rm8FvjmpgV+PpYS3jeOMP9iJf7zni+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=11+ybmNgpO0uk2pdsPLC0m92TOgTsM8Jn35KIS5Nvel9j7bjOSBDz0wl82lnXB4GQ
         XGF6zQed67uJvx7GaMJBzfQv6SReTk3vE9dsKx6q15eAIClUlvn/svlZSsQkWGHGi5
         WFeUz/0hO1/4WToAOSyETXwAuVoYlhxjB10RffsU=
Date:   Fri, 29 May 2020 12:26:13 +0200
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
Subject: Re: [PATCH 09/13] firmware_loader: simplify sysctl declaration with
 register_sysctl_subdir()
Message-ID: <20200529102613.GA1345939@kroah.com>
References: <20200529074108.16928-1-mcgrof@kernel.org>
 <20200529074108.16928-10-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529074108.16928-10-mcgrof@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 07:41:04AM +0000, Luis Chamberlain wrote:
> From: Xiaoming Ni <nixiaoming@huawei.com>
> 
> Move the firmware config sysctl table to fallback_table.c and use the
> new register_sysctl_subdir() helper. This removes the clutter from
> kernel/sysctl.c.
> 
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  drivers/base/firmware_loader/fallback.c       |  4 ++++
>  drivers/base/firmware_loader/fallback.h       | 11 ++++++++++
>  drivers/base/firmware_loader/fallback_table.c | 22 +++++++++++++++++--
>  include/linux/sysctl.h                        |  1 -
>  kernel/sysctl.c                               |  7 ------
>  5 files changed, 35 insertions(+), 10 deletions(-)

So it now takes more lines than the old stuff?  :(

> 
> diff --git a/drivers/base/firmware_loader/fallback.c b/drivers/base/firmware_loader/fallback.c
> index d9ac7296205e..8190653ae9a3 100644
> --- a/drivers/base/firmware_loader/fallback.c
> +++ b/drivers/base/firmware_loader/fallback.c
> @@ -200,12 +200,16 @@ static struct class firmware_class = {
>  
>  int register_sysfs_loader(void)
>  {
> +	int ret = register_firmware_config_sysctl();
> +	if (ret != 0)
> +		return ret;

checkpatch :(

>  	return class_register(&firmware_class);

And if that fails?

>  }
>  
>  void unregister_sysfs_loader(void)
>  {
>  	class_unregister(&firmware_class);
> +	unregister_firmware_config_sysctl();
>  }
>  
>  static ssize_t firmware_loading_show(struct device *dev,
> diff --git a/drivers/base/firmware_loader/fallback.h b/drivers/base/firmware_loader/fallback.h
> index 06f4577733a8..7d2cb5f6ceb8 100644
> --- a/drivers/base/firmware_loader/fallback.h
> +++ b/drivers/base/firmware_loader/fallback.h
> @@ -42,6 +42,17 @@ void fw_fallback_set_default_timeout(void);
>  
>  int register_sysfs_loader(void);
>  void unregister_sysfs_loader(void);
> +#ifdef CONFIG_SYSCTL
> +extern int register_firmware_config_sysctl(void);
> +extern void unregister_firmware_config_sysctl(void);
> +#else
> +static inline int register_firmware_config_sysctl(void)
> +{
> +	return 0;
> +}
> +static inline void unregister_firmware_config_sysctl(void) { }
> +#endif /* CONFIG_SYSCTL */
> +
>  #else /* CONFIG_FW_LOADER_USER_HELPER */
>  static inline int firmware_fallback_sysfs(struct firmware *fw, const char *name,
>  					  struct device *device,
> diff --git a/drivers/base/firmware_loader/fallback_table.c b/drivers/base/firmware_loader/fallback_table.c
> index 46a731dede6f..4234aa5ee5df 100644
> --- a/drivers/base/firmware_loader/fallback_table.c
> +++ b/drivers/base/firmware_loader/fallback_table.c
> @@ -24,7 +24,7 @@ struct firmware_fallback_config fw_fallback_config = {
>  EXPORT_SYMBOL_NS_GPL(fw_fallback_config, FIRMWARE_LOADER_PRIVATE);
>  
>  #ifdef CONFIG_SYSCTL
> -struct ctl_table firmware_config_table[] = {
> +static struct ctl_table firmware_config_table[] = {
>  	{
>  		.procname	= "force_sysfs_fallback",
>  		.data		= &fw_fallback_config.force_sysfs_fallback,
> @@ -45,4 +45,22 @@ struct ctl_table firmware_config_table[] = {
>  	},
>  	{ }
>  };
> -#endif
> +
> +static struct ctl_table_header *hdr;
> +int register_firmware_config_sysctl(void)
> +{
> +	if (hdr)
> +		return -EEXIST;

How can hdr be set?

> +	hdr = register_sysctl_subdir("kernel", "firmware_config",
> +				     firmware_config_table);
> +	if (!hdr)
> +		return -ENOMEM;
> +	return 0;
> +}
> +
> +void unregister_firmware_config_sysctl(void)
> +{
> +	if (hdr)
> +		unregister_sysctl_table(hdr);

Why can't unregister_sysctl_table() take a null pointer value?

And what sets 'hdr' (worst name for a static variable) to NULL so that
it knows not to be unregistered again as it looks like
register_firmware_config_sysctl() could be called multiple times.

thanks,

greg k-h
