Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E365CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0748205CB
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 22:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Enkvx3eC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729920AbgHOWGc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbgHOVuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:50 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89947C03B3CE;
        Sat, 15 Aug 2020 01:41:07 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1c7a00329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ec:2f1c:7a00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id AC2801EC044B;
        Sat, 15 Aug 2020 10:41:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597480864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=CmqbmjtODYtlwRW7qWoQG1WqmoGu1ND+kuU+HHrBwFw=;
        b=Enkvx3eCIzsidlS3C+nqS52FIeO7ezEcI27HINGWHsC2a3OXUawSC8iEolmV1uC8UL1Q7Q
        nQchEb0VvZYIAzmKg9Hp5o/sU36IposP4sYm1Ay+AsgnzMWjzQ7W4vL2gG0MRSZmDNmpU8
        2pPkjh0eUEUPuBB9+hu24EIEq+1WtT0=
Date:   Sat, 15 Aug 2020 10:41:57 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Alison Wang <alison.wang@nxp.com>,
        James Morse <james.morse@arm.com>
Cc:     mchehab@kernel.org, tony.luck@intel.com, rrichter@marvell.com,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] edac: nxp: Add L1 and L2 error detection for A53 and A72
 cores
Message-ID: <20200815084157.GC25814@zn.tnic>
References: <20200709082215.12829-1-alison.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200709082215.12829-1-alison.wang@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 04:22:15PM +0800, Alison Wang wrote:
> Add error detection for A53 and A72 cores. Hardware error injection is
> supported on A53. Software error injection is supported on both.
> For hardware error injection on A53 to work, proper access to
> L2ACTLR_EL1, CPUACTLR_EL1 needs to be granted by EL3 firmware. This is
> done by making an SMC call in the driver. Failure to enable access
> disables hardware error injection. For error detection to work, another
> SMC call enables access to L2ECTLR_EL1.
> 
> It is for NXP's Layerscape family LS1043A, LS1046A, LS2088A and LX2160A.
> 
> Signed-off-by: York Sun <york.sun@nxp.com>
> Signed-off-by: Alison Wang <alison.wang@nxp.com>
> ---
>  .../bindings/edac/cortex-arm64-edac.txt       |  40 +
>  drivers/edac/Kconfig                          |   7 +
>  drivers/edac/Makefile                         |   1 +
>  drivers/edac/cortex_arm64_l1_l2.c             | 738 ++++++++++++++++++
>  drivers/edac/cortex_arm64_l1_l2.h             |  54 ++
>  5 files changed, 840 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/cortex-arm64-edac.txt
>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.c
>  create mode 100644 drivers/edac/cortex_arm64_l1_l2.h

This needs James to have a look at.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
