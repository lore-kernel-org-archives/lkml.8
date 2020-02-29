Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C977FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A143824672
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgB2XJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:09:30 -0500
Received: from baldur.buserror.net ([165.227.176.147]:54288 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbgB2XJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:09:30 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1j8BEZ-0002KT-PB; Sat, 29 Feb 2020 17:09:24 -0600
Message-ID: <498ce16efb7784d95569d000bfab33ae25b823bd.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Cc:     "christophe.leroy@c-s.fr" <christophe.leroy@c-s.fr>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Date:   Sat, 29 Feb 2020 17:09:22 -0600
In-Reply-To: <20200123111914.2565-1-laurentiu.tudor@nxp.com>
References: <20200123111914.2565-1-laurentiu.tudor@nxp.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: laurentiu.tudor@nxp.com, linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au, christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org, diana.craciun@nxp.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] powerpc/fsl_booke: avoid creating duplicate tlb1 entry
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-01-23 at 11:19 +0000, Laurentiu Tudor wrote:
> In the current implementation, the call to loadcam_multi() is wrapped
> between switch_to_as1() and restore_to_as0() calls so, when it tries
> to create its own temporary AS=1 TLB1 entry, it ends up duplicating the
> existing one created by switch_to_as1(). Add a check to skip creating
> the temporary entry if already running in AS=1.
> 
> Fixes: d9e1831a4202 ("powerpc/85xx: Load all early TLB entries at once")
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: stable@vger.kernel.org
> ---
>  arch/powerpc/mm/nohash/tlb_low.S | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Assuming you've tested this on all combinations of 32/64 relocatable and not:

Acked-by: Scott Wood <oss@buserror.net>

-Scott


