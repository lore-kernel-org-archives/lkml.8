Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E63C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0023920BED
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 11:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QFUVyj8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbgH3Luj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 07:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728691AbgH3Lug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 07:50:36 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D6AC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 04:50:35 -0700 (PDT)
Received: from zn.tnic (p200300ec2f296000a06db95d0950e717.dip0.t-ipconnect.de [IPv6:2003:ec:2f29:6000:a06d:b95d:950:e717])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 96A441EC0281;
        Sun, 30 Aug 2020 13:50:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598788229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=H+3IIcxD1FEunqGmhWLq31uvRsaYsBBpUYC2R5ejKsY=;
        b=QFUVyj8dJLSoUh4GiV1jPe7aL+JEtsdBVRaGWzB7TZk+BG3D+w2TUmVYzRPEhlyyTO9CN0
        hKZoTsWLr89PKuxdhpV+wFnTMHpU0fz9FValfaVp3EbBrVliz9sTHtNxLiKW1Y1S1r2Poc
        DM6LRUtTdSOM9RW+Xow0AeCVGckcInA=
Date:   Sun, 30 Aug 2020 13:50:24 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Kyung Min Park <kyung.min.park@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        tony.luck@intel.com, dave.hansen@intel.com, ricardo.neri@intel.com,
        hpa@zytor.com, gregkh@linuxfoundation.org, ak@linux.intel.com,
        ravi.v.shankar@intel.com,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH v2] Documentation/x86: Add documentation for
 /proc/cpuinfo feature flags
Message-ID: <20200830115024.GA4297@zn.tnic>
References: <20200824180412.9440-1-kyung.min.park@intel.com>
 <20200828184209.GC19342@zn.tnic>
 <b171209faab7e141a9988ecf47fa55bf855cb664.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b171209faab7e141a9988ecf47fa55bf855cb664.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 03:30:32PM -0700, Kyung Min Park wrote:
> Should I mention the tool specifically although the tool is WIP?

Well, if you wanna look at it that way, the whole kernel is constantly
and forever WIP. :-)

Also, if there's some functionality missing, pointing to it might make
people send patches.

> As you commented previously, should I use
> tools/arch/x86/tools/cpuid/cpuid as the future tool and its location?

Yeah, let's just drop the second "tools", i.e.,

tools/arch/x86/kcpuid/

or so should be good enough.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
