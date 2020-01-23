Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79128C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45EA924125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="kL3OvILS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727235AbgAWIX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:23:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45466 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726232AbgAWIX0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 03:23:26 -0500
Received: from zn.tnic (p200300EC2F095B0060FE665DEF90E16F.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5b00:60fe:665d:ef90:e16f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5D8831EC047D;
        Thu, 23 Jan 2020 09:23:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579767805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=WIJL5XHyKt5KPKlO9I4JS71YWtGovioHHFMiIIQUA4M=;
        b=kL3OvILS/zc0IEoZqMt3xfaJMrGvbZ3Bsz+Z35zr15SqFdwyAaZZXkpnGmaT1ZJUZsBH28
        r3RnAaE+xZT/6FCp3SdHdZeV7RrhAfodbplmpbM9vPNjJximr9OYLjvpaEreAKrE5Gi6CT
        NEZrzDbQh+F9o9/Jp5EWDNwvUWAlwJc=
Date:   Thu, 23 Jan 2020 09:23:22 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Shiping Ji <shiping.linux@gmail.com>
Cc:     James Morse <james.morse@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-edac <linux-edac@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>, hangl@microsoft.com,
        Lei Wang <lewan@microsoft.com>, ruizhao@microsoft.com,
        shji@microsoft.com, Scott Branden <scott.branden@broadcom.com>,
        Yuqing Shen <yuqing.shen@broadcom.com>
Subject: Re: [PATCH v10 1/2] dt-bindings: edac: dmc-520.yaml
Message-ID: <20200123082322.GB10328@zn.tnic>
References: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <09a2fe69-842f-01cf-1cfa-d5fc639b158a@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 04:31:07PM -0800, Shiping Ji wrote:
> This is the device tree bindings for new EDAC driver dmc520_edac.c.
> 
> From: Lei Wang <leiwang_git@outlook.com>
> 
> Signed-off-by: Lei Wang <leiwang_git@outlook.com>
> Signed-off-by: Shiping Ji <shiping.linux@gmail.com>
> Reviewed-by: James Morse <james.morse@arm.com>
> 
> ---
>      Changes in v10:
>          - Convert to the YAML format for binding description

So you've changed this patch considerably. If you do so, you cannot keep
Reviewed-by tags.

Also, AFAICT, you've written a completely *new* patch which would mean
that this time you're the author. Correct?

If so, you don't need to keep Lei's From.

In any case, please take some time to read this:

https://www.kernel.org/doc/html/latest/process/index.html

It is a lot so do concentrate on the whole process, i.e., this:

https://www.kernel.org/doc/html/latest/process/development-process.html

so that you have a basic idea.

If you have questions, I'm sure Sasha would be willing to answer them
even if he's away now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
