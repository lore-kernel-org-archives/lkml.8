Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B2EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A075020784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 00:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="QV3uo2UA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbgCaA6X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 20:58:23 -0400
Received: from ozlabs.org ([203.11.71.1]:55645 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729019AbgCaA6X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 20:58:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48rrY83DPpz9sPF;
        Tue, 31 Mar 2020 11:58:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1585616301;
        bh=c8QxLZAVwZDP69eK2yRpjGsPj13bvRE+pFfd/mBq/58=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=QV3uo2UAfxzPxyIyOABda5NJBpGNlmDyTet2SWRKDOHs1a5Ce4nI1SL/YATBqmCgt
         jAMQcdXfKec6G97JX6DM9v+2aAcI1Y0rpdn/282c1agVOr1jQAf33/sW9WA4Js2bdc
         vMNjn/qamb82UjfKwNf5/H5RA9pEuOk6DpbH0k09WINvoLOB3TKuwiziOja3X8kqQ0
         fKUY9cHrfQqQXQN2a8i4kOVF47+5SsayMkk1HBd0oSTogF9XXQfFKcWaldfuhTxM68
         aKrqONAGWi3qqlcstgkCDge9jXJLoK0SBsFn85IaDNTw+qgA0/I8rdsSx6n+qozhao
         U5etm/SZ3tIUg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     YueHaibing <yuehaibing@huawei.com>, mporter@kernel.crashing.org,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     alistair@popple.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] powerpc/44x: Make AKEBONO depends on NET
In-Reply-To: <20200330143153.32800-1-yuehaibing@huawei.com>
References: <20200330143153.32800-1-yuehaibing@huawei.com>
Date:   Tue, 31 Mar 2020 11:58:28 +1100
Message-ID: <87pnctuyq3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:
> Fix Kconfig warnings:
>
> WARNING: unmet direct dependencies detected for NETDEVICES
>   Depends on [n]: NET [=n]
>   Selected by [y]:
>   - AKEBONO [=y] && PPC_47x [=y]
>
> WARNING: unmet direct dependencies detected for ETHERNET
>   Depends on [n]: NETDEVICES [=y] && NET [=n]
>   Selected by [y]:
>   - AKEBONO [=y] && PPC_47x [=y]
>
> AKEBONO select NETDEVICES and ETHERNET unconditionally,

It shouldn't do that, that's the job of a defconfig.

It might want to enable NET_VENDOR_IBM iff the config already has NET
and other dependencies enabled.

So the patch below might work?

cheers

diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index 25ebe634a661..32aac4f40f1b 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -207,9 +207,7 @@ config AKEBONO
 	select PPC4xx_HSTA_MSI
 	select I2C
 	select I2C_IBM_IIC
-	select NETDEVICES
-	select ETHERNET
-	select NET_VENDOR_IBM
+	imply NET_VENDOR_IBM
 	select IBM_EMAC_EMAC4 if IBM_EMAC
 	select USB if USB_SUPPORT
 	select USB_OHCI_HCD_PLATFORM if USB_OHCI_HCD



> If NET is not set, build fails. Add this dependcy to fix this.
>
> Fixes: 2a2c74b2efcb ("IBM Akebono: Add the Akebono platform")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  arch/powerpc/platforms/44x/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
> index 25ebe634a661..394f662d7df2 100644
> --- a/arch/powerpc/platforms/44x/Kconfig
> +++ b/arch/powerpc/platforms/44x/Kconfig
> @@ -199,6 +199,7 @@ config FSP2
>  config AKEBONO
>  	bool "IBM Akebono (476gtr) Support"
>  	depends on PPC_47x
> +	depends on NET
>  	select SWIOTLB
>  	select 476FPE
>  	select PPC4xx_PCI_EXPRESS
> -- 
> 2.17.1
