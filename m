Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B91C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0B2207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgFOPbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:31:17 -0400
Received: from baldur.buserror.net ([165.227.176.147]:51010 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730439AbgFOPbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:31:15 -0400
X-Greylist: delayed 1949 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Jun 2020 11:31:14 EDT
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1jkqUp-0004Ge-Sr; Mon, 15 Jun 2020 09:54:05 -0500
Message-ID: <b1aea45c882859def80d77229f36598c5fb3cd0a.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     Arseny Solokha <asolokha@kb.kras.ru>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jason Yan <yanaijie@huawei.com>, linuxppc-dev@lists.ozlabs.org
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date:   Mon, 15 Jun 2020 09:53:58 -0500
In-Reply-To: <20200613162801.1946619-1-asolokha@kb.kras.ru>
References: <20200613162801.1946619-1-asolokha@kb.kras.ru>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: asolokha@kb.kras.ru, mpe@ellerman.id.au, yanaijie@huawei.com, linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr, linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] powerpc/fsl_booke/32: fix build with
 CONFIG_RANDOMIZE_BASE
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-06-13 at 23:28 +0700, Arseny Solokha wrote:
> Building the current 5.8 kernel for a e500 machine with
> CONFIG_RANDOMIZE_BASE set yields the following failure:
> 
>   arch/powerpc/mm/nohash/kaslr_booke.c: In function 'kaslr_early_init':
>   arch/powerpc/mm/nohash/kaslr_booke.c:387:2: error: implicit declaration
> of function 'flush_icache_range'; did you mean 'flush_tlb_range'?
> [-Werror=implicit-function-declaration]
> 
> Indeed, including asm/cacheflush.h into kaslr_booke.c fixes the build.
> 
> The issue dates back to the introduction of that file and probably went
> unnoticed because there's no in-tree defconfig with CONFIG_RANDOMIZE_BASE
> set.
> 
> Fixes: 2b0e86cc5de6 ("powerpc/fsl_booke/32: implement KASLR infrastructure")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>
> ---
>  arch/powerpc/mm/nohash/kaslr_booke.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Scott Wood <oss@buserror.net>

-Scott


