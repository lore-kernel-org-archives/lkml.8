Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD2CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:44:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7438324676
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579700644;
	bh=X/t8LP8ySUhlmYfQunriutBdIsCajR+Pwll/gz5kHto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dupz8wLGXcbdPYKRdVpNBs9Jgs6kUcquPKTSoRlMXgXiCWUsOP/rEQetMPVj/5lus
	 tuUMeULcTuktlYejmoN5KKVJ8L82/mvmo2pIQveTkBl7bQjXKT0k8P2YSuXBeYXAIy
	 mMTikChDNgjDg/IpZgQO0B/FOyauer4EwEV4D8nQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAVNoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:44:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:35302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVNoD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:44:03 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8EF12073A;
        Wed, 22 Jan 2020 13:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579700642;
        bh=X/t8LP8ySUhlmYfQunriutBdIsCajR+Pwll/gz5kHto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=akmzMouxGD/x/ZhzTSvDFgYcA0tud+/4l1Ra4sgXYr4ZyDby0Zd3GlH1eycZ1opU2
         T5nny3Cyzsp8tenlwmryh6Vu1rdWxTeJLz6V7zehgBdt4lhDJH/m7FW3pcobntMAMH
         NqN6Yo3mfptjpQjX+0mnh8LQ798scTBEmFN7CADg=
Date:   Wed, 22 Jan 2020 14:43:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Brown <broonie@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 14/38] platform/x86: intel_scu_ipc: Introduce new SCU
 IPC API
Message-ID: <20200122134359.GE4963@kroah.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-15-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121160114.60007-15-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 07:00:50PM +0300, Mika Westerberg wrote:
> The current SCU IPC API has been operating on a single instance and
> there has been no way to pin the providing module in place when the SCU
> IPC is in use.
> 
> This implements a new API that takes the SCU IPC instance as first
> parameter (NULL means the single instance is being used). The SCU IPC
> instance can be retrieved by calling new function
> intel_scu_ipc_dev_get() that take care of pinning the providing module
> in place as long as intel_scu_ipc_dev_put() is not called.
> 
> The old API is left there to support existing users which cannot be
> converted easily but it is put to a separate header that is subject to
> be removed eventually. Subsequent patches will convert most of the users
> to the new API.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_scu_ipc.h        |  74 +++----
>  arch/x86/include/asm/intel_scu_ipc_legacy.h |  76 +++++++
>  drivers/platform/x86/intel_scu_ipc.c        | 219 ++++++++++++++++----
>  drivers/platform/x86/intel_scu_pcidrv.c     |   7 +-
>  4 files changed, 287 insertions(+), 89 deletions(-)
>  create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
> 
> diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
> index 252ea0046f16..ce2ad516f0f9 100644
> --- a/arch/x86/include/asm/intel_scu_ipc.h
> +++ b/arch/x86/include/asm/intel_scu_ipc.h
> @@ -1,9 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef _ASM_X86_INTEL_SCU_IPC_H_
> -#define  _ASM_X86_INTEL_SCU_IPC_H_
> +#define _ASM_X86_INTEL_SCU_IPC_H_

gratuitous change :(

>  #include <linux/ioport.h>
> -#include <linux/notifier.h>
>  
>  #define IPCMSG_INDIRECT_READ	0x02
>  #define IPCMSG_INDIRECT_WRITE	0x05
> @@ -21,6 +20,7 @@
>  	#define IPC_CMD_VRTC_SETALARM     2 /* Set alarm */
>  
>  struct device;
> +struct intel_scu_ipc_dev;
>  
>  /**
>   * struct intel_scu_ipc_pdata - Platform data for SCU IPC
> @@ -32,47 +32,39 @@ struct intel_scu_ipc_pdata {
>  	int irq;
>  };
>  
> -int intel_scu_ipc_register(struct device *dev,
> -			   const struct intel_scu_ipc_pdata *pdata);
> -
> -/* Read single register */
> -int intel_scu_ipc_ioread8(u16 addr, u8 *data);
> -
> -/* Read a vector */
> -int intel_scu_ipc_readv(u16 *addr, u8 *data, int len);
> -
> -/* Write single register */
> -int intel_scu_ipc_iowrite8(u16 addr, u8 data);
> -
> -/* Write a vector */
> -int intel_scu_ipc_writev(u16 *addr, u8 *data, int len);
> -
> -/* Update single register based on the mask */
> -int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask);
> -
> -/* Issue commands to the SCU with or without data */
> -int intel_scu_ipc_simple_command(int cmd, int sub);
> -int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
> -			  u32 *out, int outlen);
> -
> -extern struct blocking_notifier_head intel_scu_notifier;
> -
> -static inline void intel_scu_notifier_add(struct notifier_block *nb)
> -{
> -	blocking_notifier_chain_register(&intel_scu_notifier, nb);
> -}
> -
> -static inline void intel_scu_notifier_remove(struct notifier_block *nb)
> -{
> -	blocking_notifier_chain_unregister(&intel_scu_notifier, nb);
> -}
> -
> -static inline int intel_scu_notifier_post(unsigned long v, void *p)
> +struct intel_scu_ipc_dev *
> +intel_scu_ipc_register(struct device *dev, const struct intel_scu_ipc_pdata *pdata);
> +
> +struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void);
> +void intel_scu_ipc_dev_put(struct intel_scu_ipc_dev *scu);
> +struct intel_scu_ipc_dev *devm_intel_scu_ipc_dev_get(struct device *dev);
> +
> +int intel_scu_ipc_dev_ioread8(struct intel_scu_ipc_dev *scu, u16 addr,
> +			      u8 *data);
> +int intel_scu_ipc_dev_iowrite8(struct intel_scu_ipc_dev *scu, u16 addr,
> +			       u8 data);
> +int intel_scu_ipc_dev_readv(struct intel_scu_ipc_dev *scu, u16 *addr,
> +			    u8 *data, size_t len);
> +int intel_scu_ipc_dev_writev(struct intel_scu_ipc_dev *scu, u16 *addr,
> +			     u8 *data, size_t len);
> +
> +int intel_scu_ipc_dev_update(struct intel_scu_ipc_dev *scu, u16 addr,
> +			     u8 data, u8 mask);
> +
> +int intel_scu_ipc_dev_simple_command(struct intel_scu_ipc_dev *scu, int cmd,
> +				     int sub);
> +int intel_scu_ipc_dev_command_with_size(struct intel_scu_ipc_dev *scu, int cmd,
> +					int sub, const void *in, size_t inlen,
> +					size_t size, void *out, size_t outlen);
> +
> +static inline int intel_scu_ipc_dev_command(struct intel_scu_ipc_dev *scu, int cmd,
> +					    int sub, const void *in, size_t inlen,
> +					    void *out, size_t outlen)
>  {
> -	return blocking_notifier_call_chain(&intel_scu_notifier, v, p);
> +	return intel_scu_ipc_dev_command_with_size(scu, cmd, sub, in, inlen,
> +						   inlen, out, outlen);
>  }
>  
> -#define		SCU_AVAILABLE		1
> -#define		SCU_DOWN		2
> +#include <asm/intel_scu_ipc_legacy.h>
>  
>  #endif
> diff --git a/arch/x86/include/asm/intel_scu_ipc_legacy.h b/arch/x86/include/asm/intel_scu_ipc_legacy.h
> new file mode 100644
> index 000000000000..3399ea8eea48
> --- /dev/null
> +++ b/arch/x86/include/asm/intel_scu_ipc_legacy.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
> +#define _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
> +
> +#include <linux/notifier.h>
> +
> +/* Don't call these in new code - they will be removed eventually */
> +
> +/* Read single register */
> +static inline int intel_scu_ipc_ioread8(u16 addr, u8 *data)
> +{
> +	return intel_scu_ipc_dev_ioread8(NULL, addr, data);
> +}
> +
> +/* Read a vector */
> +static inline int intel_scu_ipc_readv(u16 *addr, u8 *data, int len)
> +{
> +	return intel_scu_ipc_dev_readv(NULL, addr, data, len);
> +}
> +
> +/* Write single register */
> +static inline int intel_scu_ipc_iowrite8(u16 addr, u8 data)
> +{
> +	return intel_scu_ipc_dev_iowrite8(NULL, addr, data);
> +}
> +
> +/* Write a vector */
> +static inline int intel_scu_ipc_writev(u16 *addr, u8 *data, int len)
> +{
> +	return intel_scu_ipc_dev_writev(NULL, addr, data, len);
> +}
> +
> +/* Update single register based on the mask */
> +static inline int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask)
> +{
> +	return intel_scu_ipc_dev_update(NULL, addr, data, mask);
> +}
> +
> +/* Issue commands to the SCU with or without data */
> +static inline int intel_scu_ipc_simple_command(int cmd, int sub)
> +{
> +	return intel_scu_ipc_dev_simple_command(NULL, cmd, sub);
> +}
> +
> +static inline int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
> +					u32 *out, int outlen)
> +{
> +	/* New API takes both inlen and outlen as bytes so convert here */
> +	size_t inbytes = inlen * sizeof(u32);
> +	size_t outbytes = outlen * sizeof(u32);
> +
> +	return intel_scu_ipc_dev_command_with_size(NULL, cmd, sub, in, inbytes,
> +						   inlen, out, outbytes);
> +}
> +
> +extern struct blocking_notifier_head intel_scu_notifier;
> +
> +static inline void intel_scu_notifier_add(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_register(&intel_scu_notifier, nb);
> +}
> +
> +static inline void intel_scu_notifier_remove(struct notifier_block *nb)
> +{
> +	blocking_notifier_chain_unregister(&intel_scu_notifier, nb);
> +}
> +
> +static inline int intel_scu_notifier_post(unsigned long v, void *p)
> +{
> +	return blocking_notifier_call_chain(&intel_scu_notifier, v, p);
> +}
> +
> +#define		SCU_AVAILABLE		1
> +#define		SCU_DOWN		2
> +
> +#endif
> diff --git a/drivers/platform/x86/intel_scu_ipc.c b/drivers/platform/x86/intel_scu_ipc.c
> index 518b044d8ecb..391b65a4789e 100644
> --- a/drivers/platform/x86/intel_scu_ipc.c
> +++ b/drivers/platform/x86/intel_scu_ipc.c
> @@ -19,6 +19,7 @@
>  #include <linux/init.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/module.h>
>  
>  #include <asm/intel_scu_ipc.h>
>  
> @@ -78,6 +79,99 @@ static struct intel_scu_ipc_dev  ipcdev; /* Only one for now */
>  
>  static DEFINE_MUTEX(ipclock); /* lock used to prevent multiple call to SCU */
>  
> +/**
> + * intel_scu_ipc_dev_get() - Get SCU IPC instance
> + *
> + * The recommended new API takes SCU IPC instance as parameter and this
> + * function can be called by driver to get the instance. This also makes
> + * sure the driver providing the IPC functionality cannot be unloaded
> + * while the caller has the intance.
> + *
> + * Call intel_scu_ipc_dev_put() to release the instance.
> + *
> + * Returns %NULL if SCU IPC is not currently available.
> + */
> +struct intel_scu_ipc_dev *intel_scu_ipc_dev_get(void)
> +{
> +	struct intel_scu_ipc_dev *scu = &ipcdev;
> +
> +	mutex_lock(&ipclock);
> +	if (!scu->dev)
> +		goto err_unlock;
> +	if (!try_module_get(scu->dev->driver->owner))
> +		goto err_unlock;
> +	mutex_unlock(&ipclock);
> +	return scu;

NO REFERENCE COUNT INCREMENT???

You owe me 5 recitations of the "Data Structures" of
Documentation/process/coding-style.rst

And some whisky to get me through the next round of code reviews of this
mess...

greg k-h
