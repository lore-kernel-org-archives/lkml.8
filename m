Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A6C9C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 228032072C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 14:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgBQOLQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 09:11:16 -0500
Received: from mga03.intel.com ([134.134.136.65]:12540 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbgBQOLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 09:11:16 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Feb 2020 06:11:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,452,1574150400"; 
   d="scan'208";a="348504253"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga001.fm.intel.com with ESMTP; 17 Feb 2020 06:11:09 -0800
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1j3h79-002p1K-3f; Mon, 17 Feb 2020 16:11:11 +0200
Date:   Mon, 17 Feb 2020 16:11:11 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Lee Jones <lee.jones@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 03/19] platform/x86: intel_scu_ipc: Move legacy SCU
 IPC API to a separate header
Message-ID: <20200217141111.GD10400@smile.fi.intel.com>
References: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
 <20200217131446.32818-4-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217131446.32818-4-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 04:14:30PM +0300, Mika Westerberg wrote:
> In preparation for introducing a new API for SCU IPC, move the legacy
> API and constants to a separate header that is is subject to be removed
> eventually.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_scu_ipc.h        | 56 +------------------
>  arch/x86/include/asm/intel_scu_ipc_legacy.h | 62 +++++++++++++++++++++
>  2 files changed, 63 insertions(+), 55 deletions(-)
>  create mode 100644 arch/x86/include/asm/intel_scu_ipc_legacy.h
> 
> diff --git a/arch/x86/include/asm/intel_scu_ipc.h b/arch/x86/include/asm/intel_scu_ipc.h
> index 78f939782a67..a2f4694a253c 100644
> --- a/arch/x86/include/asm/intel_scu_ipc.h
> +++ b/arch/x86/include/asm/intel_scu_ipc.h
> @@ -3,22 +3,6 @@
>  #define  _ASM_X86_INTEL_SCU_IPC_H_
>  
>  #include <linux/ioport.h>
> -#include <linux/notifier.h>
> -
> -#define IPCMSG_INDIRECT_READ	0x02
> -#define IPCMSG_INDIRECT_WRITE	0x05
> -
> -#define IPCMSG_COLD_OFF		0x80	/* Only for Tangier */
> -
> -#define IPCMSG_WARM_RESET	0xF0
> -#define IPCMSG_COLD_RESET	0xF1
> -#define IPCMSG_SOFT_RESET	0xF2
> -#define IPCMSG_COLD_BOOT	0xF3
> -
> -#define IPCMSG_VRTC		0xFA	 /* Set vRTC device */
> -	/* Command id associated with message IPCMSG_VRTC */
> -	#define IPC_CMD_VRTC_SETTIME      1 /* Set time */
> -	#define IPC_CMD_VRTC_SETALARM     2 /* Set alarm */
>  
>  struct device;
>  struct intel_scu_ipc_dev;
> @@ -37,44 +21,6 @@ struct intel_scu_ipc_dev *
>  intel_scu_ipc_register(struct device *parent,
>  		       const struct intel_scu_ipc_pdata *pdata);
>  
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
> -{
> -	return blocking_notifier_call_chain(&intel_scu_notifier, v, p);
> -}
> -
> -#define		SCU_AVAILABLE		1
> -#define		SCU_DOWN		2
> +#include <asm/intel_scu_ipc_legacy.h>
>  
>  #endif
> diff --git a/arch/x86/include/asm/intel_scu_ipc_legacy.h b/arch/x86/include/asm/intel_scu_ipc_legacy.h
> new file mode 100644
> index 000000000000..d3a02bc07edd
> --- /dev/null
> +++ b/arch/x86/include/asm/intel_scu_ipc_legacy.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
> +#define _ASM_X86_INTEL_SCU_IPC_LEGACY_H_
> +
> +#include <linux/notifier.h>
> +
> +#define IPCMSG_INDIRECT_READ	0x02
> +#define IPCMSG_INDIRECT_WRITE	0x05
> +
> +#define IPCMSG_COLD_OFF		0x80	/* Only for Tangier */
> +
> +#define IPCMSG_WARM_RESET	0xF0
> +#define IPCMSG_COLD_RESET	0xF1
> +#define IPCMSG_SOFT_RESET	0xF2
> +#define IPCMSG_COLD_BOOT	0xF3
> +
> +#define IPCMSG_VRTC		0xFA	/* Set vRTC device */
> +/* Command id associated with message IPCMSG_VRTC */
> +#define IPC_CMD_VRTC_SETTIME      1	/* Set time */
> +#define IPC_CMD_VRTC_SETALARM     2	/* Set alarm */
> +
> +/* Read single register */
> +int intel_scu_ipc_ioread8(u16 addr, u8 *data);
> +
> +/* Read a vector */
> +int intel_scu_ipc_readv(u16 *addr, u8 *data, int len);
> +
> +/* Write single register */
> +int intel_scu_ipc_iowrite8(u16 addr, u8 data);
> +
> +/* Write a vector */
> +int intel_scu_ipc_writev(u16 *addr, u8 *data, int len);
> +
> +/* Update single register based on the mask */
> +int intel_scu_ipc_update_register(u16 addr, u8 data, u8 mask);
> +
> +/* Issue commands to the SCU with or without data */
> +int intel_scu_ipc_simple_command(int cmd, int sub);
> +int intel_scu_ipc_command(int cmd, int sub, u32 *in, int inlen,
> +			  u32 *out, int outlen);
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
> -- 
> 2.25.0
> 

-- 
With Best Regards,
Andy Shevchenko


