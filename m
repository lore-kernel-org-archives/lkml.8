Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA8BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9B024655
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579700786;
	bh=UGhdvXx5rv6nQ3UgCGNGUEYiobkQTE/Vnl5IbYSBMMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=O8HZLdsWIRol4BFxabUr8E5C05S7DyQqg6I16jH5Db23U8St3V3gz6sAl3xCPFmIx
	 rUZE57enac3BYLdjtX+j07PpoJ2nEk1ktXtnrgoLayJ9iByeUmlR+izMASrGo0otDY
	 xhBrW7zTUo+y2PsXBcYjeUx/0hLGSij83WaduTnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgAVNqZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:46:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:36620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725802AbgAVNqZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:46:25 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8267A21569;
        Wed, 22 Jan 2020 13:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579700784;
        bh=UGhdvXx5rv6nQ3UgCGNGUEYiobkQTE/Vnl5IbYSBMMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KO1ENSpl/zTiCQmBHAHEPe1F6t6oeoFICjpm2MJDvVBXhqyKj9lX48fRG226c1SE3
         PaM8ZIdJMjz6Jb1Jf9gkjvIEEm512pYnW7Ml8myd2XctpGqGL6RCp6ufdIU26doNkB
         kh6uIkuz0aS5tYP6KutR3xKFHLzrlTK54hOEckd8=
Date:   Wed, 22 Jan 2020 14:46:21 +0100
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
Subject: Re: [PATCH v4 27/38] mfd: intel_soc_pmic_bxtwc: Convert to use new
 SCU IPC API
Message-ID: <20200122134621.GF4963@kroah.com>
References: <20200121160114.60007-1-mika.westerberg@linux.intel.com>
 <20200121160114.60007-28-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121160114.60007-28-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 07:01:03PM +0300, Mika Westerberg wrote:
> Convert the Intel Broxton Whiskey Cover PMIC driver to use the new SCU
> IPC API. This allows us to get rid of the PMC IPC implementation which
> is now covered in SCU IPC driver.
> 
> Also move PMIC specific IPC message constants to the PMIC driver from
> the intel_pmc_ipc.h header.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/include/asm/intel_pmc_ipc.h |  3 ---
>  drivers/mfd/intel_soc_pmic_bxtwc.c   | 22 +++++++++++++++-------
>  2 files changed, 15 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/arch/x86/include/asm/intel_pmc_ipc.h
> index e6da1ce26256..b438a488f613 100644
> --- a/arch/x86/include/asm/intel_pmc_ipc.h
> +++ b/arch/x86/include/asm/intel_pmc_ipc.h
> @@ -3,9 +3,6 @@
>  #define  _ASM_X86_INTEL_PMC_IPC_H_
>  
>  /* Commands */
> -#define PMC_IPC_PMIC_ACCESS		0xFF
> -#define		PMC_IPC_PMIC_ACCESS_READ	0x0
> -#define		PMC_IPC_PMIC_ACCESS_WRITE	0x1
>  #define PMC_IPC_USB_PWR_CTRL		0xF0
>  #define PMC_IPC_PMIC_BLACKLIST_SEL	0xEF
>  #define PMC_IPC_PHY_CONFIG		0xEE
> diff --git a/drivers/mfd/intel_soc_pmic_bxtwc.c b/drivers/mfd/intel_soc_pmic_bxtwc.c
> index 739cfb5b69fe..60aba2a1561c 100644
> --- a/drivers/mfd/intel_soc_pmic_bxtwc.c
> +++ b/drivers/mfd/intel_soc_pmic_bxtwc.c
> @@ -15,7 +15,7 @@
>  #include <linux/mfd/intel_soc_pmic_bxtwc.h>
>  #include <linux/module.h>
>  
> -#include <asm/intel_pmc_ipc.h>
> +#include <asm/intel_scu_ipc.h>
>  
>  /* PMIC device registers */
>  #define REG_ADDR_MASK		0xFF00
> @@ -58,6 +58,10 @@
>  /* Whiskey Cove PMIC share same ACPI ID between different platforms */
>  #define BROXTON_PMIC_WC_HRV	4
>  
> +#define PMC_PMIC_ACCESS		0xFF
> +#define PMC_PMIC_READ		0x0
> +#define PMC_PMIC_WRITE		0x1
> +
>  enum bxtwc_irqs {
>  	BXTWC_PWRBTN_LVL1_IRQ = 0,
>  	BXTWC_TMU_LVL1_IRQ,
> @@ -288,9 +292,9 @@ static int regmap_ipc_byte_reg_read(void *context, unsigned int reg,
>  
>  	ipc_in[0] = reg;
>  	ipc_in[1] = i2c_addr;
> -	ret = intel_pmc_ipc_command(PMC_IPC_PMIC_ACCESS,
> -			PMC_IPC_PMIC_ACCESS_READ,
> -			ipc_in, sizeof(ipc_in), (u32 *)ipc_out, 1);
> +	ret = intel_scu_ipc_dev_command(pmic->scu, PMC_PMIC_ACCESS,
> +					PMC_PMIC_READ, ipc_in, sizeof(ipc_in),
> +					ipc_out, sizeof(ipc_out));
>  	if (ret) {
>  		dev_err(pmic->dev, "Failed to read from PMIC\n");

Meta-comment, the call should be the thing making that error message,
do not force all callers to log it again, or in some other way.  That
just makes for a larger mess.

thanks,

greg k-h
