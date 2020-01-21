Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0E7C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550E4206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 03:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgAUDaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 22:30:06 -0500
Received: from baldur.buserror.net ([165.227.176.147]:51656 "EHLO
        baldur.buserror.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726935AbgAUDaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 22:30:06 -0500
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
        by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <oss@buserror.net>)
        id 1itkAR-0005jP-1X; Mon, 20 Jan 2020 21:25:27 -0600
Message-ID: <bd0fa23b900fe967a8c3c11abd1ba9a47cec474f.camel@buserror.net>
From:   Scott Wood <oss@buserror.net>
To:     wangwenhu <wenhu.pku@gmail.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     trivial@kernel.org, wenhu.wang@vivo.com,
        Rai Harninder <harninder.rai@nxp.com>
Date:   Mon, 20 Jan 2020 21:25:25 -0600
In-Reply-To: <20200120144327.20800-1-wenhu.pku@gmail.com>
References: <20200120144327.20800-1-wenhu.pku@gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: wenhu.pku@gmail.com, galak@kernel.crashing.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, trivial@kernel.org, wenhu.wang@vivo.com, harninder.rai@nxp.com
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH] powerpc/Kconfig: Make FSL_85XX_CACHE_SRAM configurable
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-01-20 at 06:43 -0800, wangwenhu wrote:
> From: wangwenhu <wenhu.wang@vivo.com>
> 
> When generating .config file with menuconfig on Freescale BOOKE
> SOC, FSL_85XX_CACHE_SRAM is not configurable for the lack of
> description in the Kconfig field, which makes it impossible
> to support L2Cache-Sram driver. Add a description to make it
> configurable.
> 
> Signed-off-by: wangwenhu <wenhu.wang@vivo.com>

The intent was that drivers using the SRAM API would select the symbol.  What
is the use case for selecting it manually?

Since this code was added almost ten years ago and there are still no (in-
tree?) users of the API, we should just remove the sram code (unless this
prods someone to submit such a user very soon).

-Scott


