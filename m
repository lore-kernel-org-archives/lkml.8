Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53685C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20A1C20734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="EXCko644";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="npb9CuNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbgFCX03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:26:29 -0400
Received: from relay5.mymailcheap.com ([159.100.248.207]:54339 "EHLO
        relay5.mymailcheap.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgFCX02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:26:28 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jun 2020 19:26:26 EDT
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.199.117])
        by relay5.mymailcheap.com (Postfix) with ESMTPS id 77178262DD
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 23:18:33 +0000 (UTC)
Received: from filter2.mymailcheap.com (filter2.mymailcheap.com [91.134.140.82])
        by relay4.mymailcheap.com (Postfix) with ESMTPS id 660E73F162;
        Thu,  4 Jun 2020 01:18:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by filter2.mymailcheap.com (Postfix) with ESMTP id 2FAD62A8B5;
        Thu,  4 Jun 2020 01:18:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
        s=default; t=1591226311;
        bh=+ixwnyM2H11cEfxoxXHKn8sjfs+KqNAqyJ1XRCc/MjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EXCko644Nc4RLsLhDumIzhkrEuP+s7+5eQq+LH2zFDa+jchMaApJvQqPThEqinegX
         bFzbBVQqGj2LYE+zy3YVMQa/Dccy85tveMF2unE1cLMq7phngwsFZWzrzLiVpm2+xs
         5PA/yOJHZ8nlmNmTWcZNAlB+P8190P0DF9HVVJrc=
X-Virus-Scanned: Debian amavisd-new at filter2.mymailcheap.com
Received: from filter2.mymailcheap.com ([127.0.0.1])
        by localhost (filter2.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Vrsc7YEPSuJ8; Thu,  4 Jun 2020 01:18:28 +0200 (CEST)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by filter2.mymailcheap.com (Postfix) with ESMTPS;
        Thu,  4 Jun 2020 01:18:28 +0200 (CEST)
Received: from [148.251.23.173] (ml.mymailcheap.com [148.251.23.173])
        by mail20.mymailcheap.com (Postfix) with ESMTP id 91D02403ED;
        Wed,  3 Jun 2020 23:18:26 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com;
        dkim=pass (1024-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="npb9CuNO";
        dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from localhost (unknown [60.177.188.90])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail20.mymailcheap.com (Postfix) with ESMTPSA id CDB86403ED;
        Wed,  3 Jun 2020 23:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
        s=default; t=1591226302;
        bh=+ixwnyM2H11cEfxoxXHKn8sjfs+KqNAqyJ1XRCc/MjQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=npb9CuNOxJZa3AgV3pzxlpRSMztJHXb+ZjZRfhmNlf4whJ3oUmNeSdE3DhDyqhA6G
         rZaDpyKzAfzQfIxN1gjEM0n/HDukJNxQmdGWNHyX+h6tExixxG8xbqE5sV3UXGoQVu
         cvHHJWwXa5qxYOa5p/jfFSoxxUH/gP4dxGNpuTjA=
Date:   Thu, 4 Jun 2020 07:18:12 +0800
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqchip: Fix the description of the Loongson PCH MSI
 controller
Message-ID: <20200604071812.00003c74@flygoat.com>
In-Reply-To: <20200603154406.189594a5@lwn.net>
References: <20200603154406.189594a5@lwn.net>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 91D02403ED
X-Spamd-Result: default: False [-0.10 / 10.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         ARC_NA(0.00)[];
         R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
         RECEIVED_SPAMHAUS_PBL(0.00)[60.177.188.90:received];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_SPF_SOFTFAIL(0.00)[~all];
         RCPT_COUNT_FIVE(0.00)[5];
         ML_SERVERS(-3.10)[148.251.23.173];
         TO_DN_ALL(0.00)[];
         DKIM_TRACE(0.00)[flygoat.com:+];
         DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
         DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:24940, ipnet:148.251.0.0/16, country:DE];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         HFILTER_HELO_BAREIP(3.00)[148.251.23.173,1]
X-Rspamd-Server: mail20.mymailcheap.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 15:44:06 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> Commit 632dcc2c75ef ("irqchip: Add Loongson PCH MSI controller")
> appears to suffer from a lack of copy-and-paste fixup, with the
> result that the KConfig description describes the wrong device.
> Avoid potential user confusion by getting the right acronym where it
> was meant to be.

Hi£¬

Thanks for addressing.

There is already a commit[1] fixing that. It will appear in Linus tree
very soon.


[1]:
https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/commit/?h=irq/irqchip-next&id=5a7f796d4f2028bde4c2ac778dfe0456851871b2

- Jiaxun

> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> ---
>  drivers/irqchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 66b9a68f5e9f..d7c920afcfcb 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -550,7 +550,7 @@ config LOONGSON_PCH_PIC
>  	  Support for the Loongson PCH PIC Controller.
>  
>  config LOONGSON_PCH_MSI
> -	bool "Loongson PCH PIC Controller"
> +	bool "Loongson PCH MSI Controller"
>  	depends on MACH_LOONGSON64 || COMPILE_TEST
>  	depends on PCI
>  	default MACH_LOONGSON64
