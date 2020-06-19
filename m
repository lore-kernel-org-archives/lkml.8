Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B40DDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82862214DB
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592555462;
	bh=nUWAQt6wgk6P7nZCV8zYSDW4pTP25h4u2rDxVqGr44g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dgAEX96mlf9zoUhr98KU7v3HQx9ZNSgpT4hrcpTyo3T9/OocPXRF1Qx6uZtvoF0yv
	 fTwosm2zMbQk6/03aXnks29fPNkbAgMR/mDtnAzk2D3O2vmmEwfwi9p7OhG/3OvSu/
	 Vj3/drzAbanPn1yc50QuEPyuV+5HPRoUf06Kht44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbgFSIbA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:31:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:52374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730651AbgFSIa5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:30:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2F7A20776;
        Fri, 19 Jun 2020 08:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592555456;
        bh=nUWAQt6wgk6P7nZCV8zYSDW4pTP25h4u2rDxVqGr44g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mQHwp9NwoFnBYbFuD04qnsjpygLzur/y6KSIe990VNSpsOg/24Yrw5q0X6IL8DZPZ
         qNviLHdVj3he4xABz7LoMzeBphSIExNVe8eeBRmuUJl5SzQNA3ah5bSyI3fsbNznjM
         pKPFOfDI/EEkLgqCyBtpE6qn1nf7sPRwAX25aCDA=
Date:   Fri, 19 Jun 2020 09:20:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, Daniel Gutson <daniel@eclypsium.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
Message-ID: <20200619072041.GA2795@kroah.com>
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 06:02:15PM -0300, Daniel Gutson wrote:
> From: Daniel Gutson <daniel@eclypsium.com>
> 
> The intent of this patch is to provide visibility of the
> MKTME status to userspace. This is an important factor for
> firmware security related applilcations.
> 
> Signed-off-by: Daniel Gutson <daniel@eclypsium.com>

Code review that is agnostic as to the need for this at all, I figured
might as well as this needs work even if everyone agrees that the
function/feature is needed:

> ---
>  MAINTAINERS                 |  5 +++
>  arch/x86/include/asm/cpu.h  |  8 ++++
>  arch/x86/kernel/cpu/intel.c | 12 +++---
>  drivers/misc/Kconfig        | 11 +++++
>  drivers/misc/Makefile       |  1 +
>  drivers/misc/mktme_status.c | 81 +++++++++++++++++++++++++++++++++++++
>  6 files changed, 113 insertions(+), 5 deletions(-)
>  create mode 100644 drivers/misc/mktme_status.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 50659d76976b..dc3b3c0e4701 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11335,6 +11335,11 @@ W:	https://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/radio/radio-miropcm20*
>  
> +MKTME_STATUS MKTME STATUS READING SUPPORT

You list the same thing twice on one line?

> +M:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +S:	Supported
> +F:	drivers/misc/mktme_status.c
> +
>  MMP SUPPORT
>  R:	Lubomir Rintel <lkundrak@v3.sk>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index dd17c2da1af5..8929c1240135 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -26,6 +26,14 @@ struct x86_cpu {
>  	struct cpu cpu;
>  };
>  
> +enum mktme_status_type {
> +	MKTME_ENABLED,
> +	MKTME_DISABLED,
> +	MKTME_UNINITIALIZED
> +};

You are exporting these values to userspace, so you need to specify
exactly what these enums resolve to, AND put them in a userspace visable
.h file so that they can be checked/read/understood.

> +
> +extern enum mktme_status_type get_mktme_status(void);
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  extern int arch_register_cpu(int num);
>  extern void arch_unregister_cpu(int);
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index a19a680542ce..1f6054523226 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -489,11 +489,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
>  #define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	/* Bits 63:48 */
>  #define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
>  
> -/* Values for mktme_status (SW only construct) */
> -#define MKTME_ENABLED			0
> -#define MKTME_DISABLED			1
> -#define MKTME_UNINITIALIZED		2
> -static int mktme_status = MKTME_UNINITIALIZED;
> +static enum mktme_status_type mktme_status = MKTME_UNINITIALIZED;
>  
>  static void detect_tme(struct cpuinfo_x86 *c)
>  {
> @@ -1107,6 +1103,12 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>  	return true;
>  }
>  
> +enum mktme_status_type get_mktme_status(void)
> +{
> +	return mktme_status;
> +}
> +EXPORT_SYMBOL_GPL(get_mktme_status);

prefix of the subsystem first please:
	mktme_get_status

Or, better yet, why not just export the variable directly?  Why is this
a function at all?

> +
>  /*
>   * This function is called only when switching between tasks with
>   * different split-lock detection modes. It sets the MSR for the
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 99e151475d8f..0dc978efbbd5 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -465,6 +465,17 @@ config PVPANIC
>  	  a paravirtualized device provided by QEMU; it lets a virtual machine
>  	  (guest) communicate panic events to the host.
>  
> +config MKTME_STATUS
> +	tristate "MKTME status reading support"
> +	depends on X86_64 && SECURITYFS
> +	help
> +	  This driver provides support for reading the MKTME status. The status
> +	  can be read from the mktme virtual file in the securityfs filesystem,
> +	  under the mktme directory.
> +
> +	  The MKTME (Multi-Key Total Memory Encryption) status can be
> +	  0 (enabled), 1 (disabled), or 3 (uninitialized).

name of the module, should you enable this, etc...

> +
>  source "drivers/misc/c2port/Kconfig"
>  source "drivers/misc/eeprom/Kconfig"
>  source "drivers/misc/cb710/Kconfig"
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index 9abf2923d831..f2f02efe34fd 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -58,3 +58,4 @@ obj-$(CONFIG_PVPANIC)   	+= pvpanic.o
>  obj-$(CONFIG_HABANA_AI)		+= habanalabs/
>  obj-$(CONFIG_UACCE)		+= uacce/
>  obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
> +obj-$(CONFIG_MKTME_STATUS)	+= mktme_status.o
> diff --git a/drivers/misc/mktme_status.c b/drivers/misc/mktme_status.c
> new file mode 100644
> index 000000000000..795993181e77
> --- /dev/null
> +++ b/drivers/misc/mktme_status.c
> @@ -0,0 +1,81 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * MKTME Status driver
> + *
> + * Copyright 2020 (c) Daniel Gutson (daniel.gutson@eclypsium.com)
> + *
> + * This file is licensed under  the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.

these sentances are not needed if you have the SPDX line above, so
please drop them.

> + */
> +
> +#include <linux/module.h>
> +#include <linux/security.h>
> +#include <asm/cpu.h>
> +
> +#ifdef pr_fmt
> +#undef pr_fmt
> +#endif
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt

No need to check, just define the thing, BEFORE the #include lines.

> +
> +struct dentry *mktme_dir;
> +struct dentry *mktme_file;

static?

> +
> +/* Buffer to return: always 3 because of the following chars:
> + *     value \n \0
> + */
> +#define BUFFER_SIZE 3

Why a define?

> +
> +static ssize_t mktme_status_read(struct file *filp, char __user *buf,
> +				 size_t count, loff_t *ppos)
> +{
> +	char tmp[BUFFER_SIZE];
> +
> +	if (*ppos == BUFFER_SIZE)
> +		return 0; // nothing else to read

Why check this if you are using simple_read_from_buffer()?  Shouldn't
that handle this type of check for you correctly?  As it is, I don't
think you are doing this right anyway.

> +
> +	sprintf(tmp, "%d\n", (int)get_mktme_status() & 1);
> +	return simple_read_from_buffer(buf, count, ppos, tmp, sizeof(tmp));
> +}
> +
> +static const struct file_operations mktme_status_ops = {
> +	.read = mktme_status_read,
> +};
> +
> +static int __init mod_init(void)
> +{
> +	mktme_dir = securityfs_create_dir("mktme", NULL);
> +	if (IS_ERR(mktme_dir)) {
> +		pr_err("Couldn't create mktme sysfs dir\n");
> +		return -1;

Don't make up random error numbers, use the EWHATEVER defines please.

> +	}
> +
> +	pr_info("mktme securityfs dir creation successful\n");

If code works properly, it should be quiet, do not do this.  Would you
want to see your kernel log full of this for every individual virtual
file that was created?


> +
> +	mktme_file = securityfs_create_file("status", 0600, mktme_dir, NULL,
> +					    &mktme_status_ops);
> +	if (IS_ERR(mktme_file)) {
> +		pr_err("Error creating sysfs file bioswe\n");

"bioswe", what is that?

And this isn't sysfs.

Did anyone actually review this?


> +		goto out_file;
> +	}
> +
> +	return 0;
> +
> +out_file:
> +	securityfs_remove(mktme_file);
> +	securityfs_remove(mktme_dir);
> +	return -1;

Again, random return values, please do not.

> +}
> +
> +static void __exit mod_exit(void)
> +{
> +	securityfs_remove(mktme_file);
> +	securityfs_remove(mktme_dir);
> +}
> +
> +module_init(mod_init);
> +module_exit(mod_exit);
> +
> +MODULE_DESCRIPTION("MKTME Status driver");

Is this really a driver?

Also no Documentation/ABI/ update for your new userspace api that you
just created?

thanks,

greg k-h
