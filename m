Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838B0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E75620702
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 05:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ZU1MiFyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgGGFyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 01:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgGGFyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 01:54:13 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F867C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 22:54:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4B1BTG6KPlz9sRK;
        Tue,  7 Jul 2020 15:54:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1594101250;
        bh=dFrZ+0efWYOYHgXiMK1uk2eQYcabkTFSFgIIyIQw8Cg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZU1MiFywrRDiER1DUFYS1QBvdn0qEDg8F9y9yhYvzQ1JMApO3IHE9TrKlACTZyNs1
         HpH9gR6reQu4MnGI4ropbeJ+iEBNc+7nFqUbt8blrFOUdPjOPn/x8G1I1F1yd1yzkj
         /C8oCKyBYgZVNQWrpLJ+sVFYmvueyroa7RcaKZNplXHAFwjsrBGg5ogMKDR2SIrKWI
         O0DPiuM5sDflxRBtuA51Fat4hiFfNHPXShw4GKCIa98Av6FMtpeFO1uBxOpaa+zgWM
         HefE//3D0vqdohrB5Cbp+6M0AHmHRu8xcUFr7qfCSkHbNa70Qo+WaiRsPh8VsoSRqy
         FKLhc/snKUqyw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nayna Jain <nayna@linux.ibm.com>, linuxppc-dev@ozlabs.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Nayna Jain <nayna@linux.ibm.com>
Subject: Re: [PATCH] powerpc/pseries: detect secure and trusted boot state of the system.
In-Reply-To: <1593882535-21368-1-git-send-email-nayna@linux.ibm.com>
References: <1593882535-21368-1-git-send-email-nayna@linux.ibm.com>
Date:   Tue, 07 Jul 2020 15:56:23 +1000
Message-ID: <87imez50mw.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nayna Jain <nayna@linux.ibm.com> writes:
> The device-tree property to check secure and trusted boot state is
> different for guests(pseries) compared to baremetal(powernv).
>
> This patch updates the existing is_ppc_secureboot_enabled() and
> is_ppc_trustedboot_enabled() function to add support for pseries.
>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> ---
>  arch/powerpc/kernel/secure_boot.c | 31 +++++++++++++++++++++++++------
>  1 file changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/secure_boot.c b/arch/powerpc/kernel/secure_boot.c
> index 4b982324d368..43fc6607c7a5 100644
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
> @@ -23,11 +24,20 @@ bool is_ppc_secureboot_enabled(void)
>  {
>  	struct device_node *node;
>  	bool enabled = false;
> +	const u32 *secureboot;
>  
> -	node = get_ppc_fw_sb_node();
> -	enabled = of_property_read_bool(node, "os-secureboot-enforcing");
> +	if (machine_is(powernv)) {
> +		node = get_ppc_fw_sb_node();
> +		enabled =
> +		    of_property_read_bool(node, "os-secureboot-enforcing");
> +		of_node_put(node);
> +	}

We generally try to avoid adding new machine_is() checks if we can.

In a case like this I think you can just check for both properties
regardless of what platform you're on.
  
> -	of_node_put(node);
> +	if (machine_is(pseries)) {
> +		secureboot = of_get_property(of_root, "ibm,secure-boot", NULL);
> +		if (secureboot)
> +			enabled = (*secureboot > 1) ? true : false;
> +	}

Please don't use of_get_property() in new code. Use one of the properly
typed accessors that handles endian conversion for you.

cheers
