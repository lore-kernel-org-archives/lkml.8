Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6774AC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484812074B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgGPINl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:13:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:60846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgGPINk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:13:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E1DE5B781;
        Thu, 16 Jul 2020 08:13:42 +0000 (UTC)
Date:   Thu, 16 Jul 2020 10:13:38 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Nayna Jain <nayna@linux.ibm.com>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v3] powerpc/pseries: detect secure and trusted boot state
 of the system.
Message-ID: <20200716081337.GB32107@kitsune.suse.cz>
References: <1594813921-12425-1-git-send-email-nayna@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594813921-12425-1-git-send-email-nayna@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:52:01AM -0400, Nayna Jain wrote:
> The device-tree property to check secure and trusted boot state is
> different for guests(pseries) compared to baremetal(powernv).
> 
> This patch updates the existing is_ppc_secureboot_enabled() and
> is_ppc_trustedboot_enabled() functions to add support for pseries.
> 
> The secureboot and trustedboot state are exposed via device-tree property:
> /proc/device-tree/ibm,secure-boot and /proc/device-tree/ibm,trusted-boot
> 
> The values of ibm,secure-boot under pseries are interpreted as:
                                      ^^^
> 
> 0 - Disabled
> 1 - Enabled in Log-only mode. This patch interprets this value as
> disabled, since audit mode is currently not supported for Linux.
> 2 - Enabled and enforced.
> 3-9 - Enabled and enforcing; requirements are at the discretion of the
> operating system.
> 
> The values of ibm,trusted-boot under pseries are interpreted as:
                                       ^^^
These two should be different I suppose?

Thanks

Michal
> 0 - Disabled
> 1 - Enabled
> 
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> ---
> v3:
> * fixed double check. Thanks Daniel for noticing it.
> * updated patch description.
> 
> v2:
> * included Michael Ellerman's feedback.
> * added Daniel Axtens's Reviewed-by.
> 
>  arch/powerpc/kernel/secure_boot.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
> index 4b982324d368..118bcb5f79c4 100644
> --- a/arch/powerpc/kernel/secure_boot.c
> +++ b/arch/powerpc/kernel/secure_boot.c
> @@ -6,6 +6,7 @@
>  #include <linux/types.h>
>  #include <linux/of.h>
>  #include <asm/secure_boot.h>
> +#include <asm/machdep.h>
>  
>  static struct device_node *get_ppc_fw_sb_node(void)
>  {
> @@ -23,12 +24,19 @@ bool is_ppc_secureboot_enabled(void)
>  {
>  	struct device_node *node;
>  	bool enabled = false;
> +	u32 secureboot;
>  
>  	node = get_ppc_fw_sb_node();
>  	enabled = of_property_read_bool(node, "os-secureboot-enforcing");
> -
>  	of_node_put(node);
>  
> +	if (enabled)
> +		goto out;
> +
> +	if (!of_property_read_u32(of_root, "ibm,secure-boot", &secureboot))
> +		enabled = (secureboot > 1);
> +
> +out:
>  	pr_info("Secure boot mode %s\n", enabled ? "enabled" : "disabled");
>  
>  	return enabled;
> @@ -38,12 +46,19 @@ bool is_ppc_trustedboot_enabled(void)
>  {
>  	struct device_node *node;
>  	bool enabled = false;
> +	u32 trustedboot;
>  
>  	node = get_ppc_fw_sb_node();
>  	enabled = of_property_read_bool(node, "trusted-enabled");
> -
>  	of_node_put(node);
>  
> +	if (enabled)
> +		goto out;
> +
> +	if (!of_property_read_u32(of_root, "ibm,trusted-boot", &trustedboot))
> +		enabled = (trustedboot > 0);
> +
> +out:
>  	pr_info("Trusted boot mode %s\n", enabled ? "enabled" : "disabled");
>  
>  	return enabled;
> -- 
> 2.26.2
> 
