Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75791C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2890224125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:51:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="g+zbBuyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgAULv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:51:29 -0500
Received: from the.earth.li ([46.43.34.31]:55934 "EHLO the.earth.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726052AbgAULv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
         s=the; h=In-Reply-To:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From
        :Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=AAEYZ5l+6EsdfFyEk6eyVbCSR6S07xGq0ivSUA0K/TA=; b=g+zbBuyTh3t9Dh6l786dXbpAaO
        +AW1o6Sg7h2W/6FgPSuptpOxL1Oiq1AuxCoEdwYdJkcKgIOb4Chobuakey4xeOFsJClDUdd2V9IjZ
        NpWxDViywfLHGshlRymHItIa3FnT8DUyVrtumzFtdNmbIn+4VuLF5fiyQShbyxvE6pFYVs2geZInq
        E1HX66cRP7HY9wNt4iir8hZdWi3BCsovkFyHNs/tUeSvjzIKghrNlbTZcZShxfpt4V53PmMYSBg1D
        IqgpDnMvUQIwmxj45iyfaER4dTYkJV8RqeonhnF1aiglnLMv89W+dzMpNV3XIbzmUNTL4CE5LBZvr
        RewyvvZw==;
Received: from noodles by the.earth.li with local (Exim 4.92)
        (envelope-from <noodles@earth.li>)
        id 1its45-0005YM-2e; Tue, 21 Jan 2020 11:51:25 +0000
Date:   Tue, 21 Jan 2020 11:51:25 +0000
From:   Jonathan McDowell <noodles@earth.li>
To:     andriy.shevchenko@linux.intel.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] x86/quirks: Convert DMI matching to use a table
Message-ID: <20200121115124.GA16758@earth.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120160801.53089-6-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20200120160801.53089-6-andriy.shevchenko@linux.intel.com> you wrote:
> In order to extend the DMI based quirks, convert them to a table.

> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/x86/kernel/quirks.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)

> diff --git a/arch/x86/kernel/quirks.c b/arch/x86/kernel/quirks.c
> index 6c122f35508a..78846a8dc88b 100644
> --- a/arch/x86/kernel/quirks.c
> +++ b/arch/x86/kernel/quirks.c
> @@ -658,8 +658,37 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x2083, quirk_intel_purley_xeon_ras
>  bool x86_apple_machine;
>  EXPORT_SYMBOL(x86_apple_machine);
>  
> +static const struct dmi_system_id x86_machine_table[] __initconst = {
> +	{
> +		.ident = "x86 Apple Macintosh",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Inc."),
> +		},
> +		.driver_data = &x86_apple_machine,
> +	},
> +	{
> +		.ident = "x86 Apple Macintosh",
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "Apple Computer, Inc."),
> +		},
> +		.driver_data = &x86_apple_machine,
> +	},
> +	{}
> +};
> +
> +static void __init early_platfrom_detect_quirk(void)

"platform"

> +{
> +	const struct dmi_system_id *id;
> +
> +	id = dmi_first_match(x86_machine_table);
> +	if (!id)
> +		return;
> +
> +	printk(KERN_DEBUG "Detected %s platform\n", id->ident);
> +	*((bool *)id->driver_data) = true;
> +}
> +
>  void __init early_platform_quirks(void)
>  {
> -	x86_apple_machine = dmi_match(DMI_SYS_VENDOR, "Apple Inc.") ||
> -			    dmi_match(DMI_SYS_VENDOR, "Apple Computer, Inc.");
> +	early_platfrom_detect_quirk();

As above.

>  }

J.

-- 
If I follow you home, will you keep me?
This .sig brought to you by the letter C and the number  9
Product of the Republic of HuggieTag
