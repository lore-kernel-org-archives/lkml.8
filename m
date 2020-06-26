Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015B5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD0A220767
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 01:56:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgFZB4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 21:56:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:42138 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726070AbgFZB4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 21:56:20 -0400
IronPort-SDR: 3NsYYlvuHfu3eXiRTQYy9lFJVIyKKOx2QuP0lghLeLySYVfEhZ7vvstnjaGUzqcOOCY1ksxJdo
 Rl9y3+ZrlqRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="163225754"
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="163225754"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2020 18:56:19 -0700
IronPort-SDR: 1g5ZgjcKnSdJ2KrKrDb1vkhvRYx9+YR90mQ4Ri6TFYtzS5xToxjlKSKBT3MZjPgMaBoC/HxTB5
 pChCAg5nvjIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,281,1589266800"; 
   d="scan'208";a="385638735"
Received: from alison-desk.jf.intel.com ([10.54.74.53])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2020 18:56:19 -0700
Date:   Thu, 25 Jun 2020 18:55:41 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Ability to read the MKTME status from userspace (patch
 v2)
Message-ID: <20200626015541.GA23770@alison-desk.jf.intel.com>
References: <20200625211029.34733-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625211029.34733-1-daniel.gutson@eclypsium.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 06:10:29PM -0300, Daniel Gutson wrote:
> The intent of this patch is to provide visibility of the
> MKTME status to userspace. This is an important factor for
> firmware security related applilcations.
> 
> Changes since v1:
> * Documentation/ABI/stable/securityfs-mktme-status (new file)
> * include/uapi/misc/mktme_status.h (new file)
> * Fixed MAINTAINER title.
> * cpu.h: added values to the enumerands
> * Renamed the function from get_mktme_status to mktme_get_status
> * Improved Kconfig help
> * Removed unnecessary license-related lines since there is a SPDX line
> * Moved pr_fmt macro before the includes
> * Turned global variables (mktme_dir, mktme_file) as static
> * Removed BUFFER_SIZE macro
> * No longer returning -1 for error, but using the previously error.
> * No more pr_info for the normal behavior.
> * Renamed this from a kernel driver to a kernel module.
> 
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
> ---
>  .../ABI/stable/securityfs-mktme-status        | 12 ++++
>  MAINTAINERS                                   |  5 ++
>  arch/x86/include/asm/cpu.h                    |  8 +++
>  arch/x86/kernel/cpu/intel.c                   | 12 ++--
>  drivers/misc/Kconfig                          | 15 +++++
>  drivers/misc/Makefile                         |  1 +
>  drivers/misc/mktme_status.c                   | 67 +++++++++++++++++++
>  include/uapi/misc/mktme_status.h              | 12 ++++
>  8 files changed, 127 insertions(+), 5 deletions(-)
>  create mode 100644 Documentation/ABI/stable/securityfs-mktme-status
>  create mode 100644 drivers/misc/mktme_status.c
>  create mode 100644 include/uapi/misc/mktme_status.h
> 
> diff --git a/Documentation/ABI/stable/securityfs-mktme-status b/Documentation/ABI/stable/securityfs-mktme-status
> new file mode 100644
> index 000000000000..a791c6ef2c15
> --- /dev/null
> +++ b/Documentation/ABI/stable/securityfs-mktme-status
> @@ -0,0 +1,12 @@
> +What: 		/securityfs/mktme/status
> +Date:		24-Jun-2020
> +KernelVersion:	v5.7
> +Contact:	daniel.gutson@eclypsium.com
> +Description: 	The mktme securityfs interface exports the BIOS status
> +		of the MKTME.
> +Values:         For possible values see arch/x86/include/asm/cpu.h.
> +
> +		Currently these values are:
> +		0 Enabled by BIOS
> +		1 Disabled by BIOS
> +		2 Uninitialized
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7b5ffd646c6b..e034e8ab6fe1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11477,6 +11477,11 @@ W:	https://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	drivers/media/radio/radio-miropcm20*
>  
> +MKTME STATUS READING SUPPORT
> +M:	Daniel Gutson <daniel.gutson@eclypsium.com>
> +S:	Supported
> +F:	drivers/misc/mktme_status.c
> +
>  MMP SUPPORT
>  R:	Lubomir Rintel <lkundrak@v3.sk>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
> index dd17c2da1af5..80d2896a3f43 100644
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -26,6 +26,14 @@ struct x86_cpu {
>  	struct cpu cpu;
>  };
>  
> +enum mktme_status_type {
> +	MKTME_ENABLED = 0,
> +	MKTME_DISABLED = 1,
> +	MKTME_UNINITIALIZED = 2
> +};
> +
> +extern enum mktme_status_type mktme_get_status(void);
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  extern int arch_register_cpu(int num);
>  extern void arch_unregister_cpu(int);
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index c25a67a34bd3..134a88685bc3 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -495,11 +495,7 @@ static void srat_detect_node(struct cpuinfo_x86 *c)
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
> @@ -1114,6 +1110,12 @@ bool handle_user_split_lock(struct pt_regs *regs, long error_code)
>  	return true;
>  }
>  
> +enum mktme_status_type mktme_get_status(void)
> +{
> +	return mktme_status;
> +}
> +EXPORT_SYMBOL_GPL(mktme_get_status);
> +

Hi Daniel,

It's not clear this code is getting what it says its getting.
(putting aside for the moment the other feedback)

I think you said you want to know if TME is activated in BIOS. I get that.
You don't want the system to be up and the customer can't tell if they
actually turned on TME or not.

If you only look for MKTME enabled status, you may miss the TME enabled
status. We can have TME on and MKTME off. (Can't have opposite)

Here are the boot message I observe based on BIOS selections:

Select TME-off MKTME-off
[] x86/tme: not enabled by BIOS

Select TME-on MKTME-off
[] x86/tme: enabled by BIOS
[] x86/mktme: No known encryption algorithm is supported: 0x0
[] x86/mktme: disabled by BIOS

Select TME-on MKTME-on
[] x86/tme: enabled by BIOS
[] x86/mktme: enabled by BIOS
[] x86/mktme: 63 KeyIDs available

It's that second case above, (TME_on MKTME-off) that this code seems
to be miss. TME will be enabled, just not MKTME.

Alison








