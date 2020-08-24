Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFCEC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CA08205CB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 14:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="XmZMWR3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHXOfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 10:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgHXOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 10:35:15 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF2FC061573;
        Mon, 24 Aug 2020 07:35:15 -0700 (PDT)
Received: from zn.tnic (p200300ec2f07f000b1b49965430c1c10.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:f000:b1b4:9965:430c:1c10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8B2601EC01A8;
        Mon, 24 Aug 2020 16:35:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1598279712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=nH6JxYKkLy9Kr2gBQqL9SmNvqMEUYVecW8js1CIex3c=;
        b=XmZMWR3oYsrKFToD1jenecjVxz8XYJT81N2Wh2h+aBHJ8K2rkYSg5ql5BZxjynuEovDUIe
        jJI0uVDIXtw7qWdBvQJ8745fCDF8TeICr6GyPkc8Yf9nPKz5vA7t7A5ojIchS3C8fmcG5T
        C54weZYwKS+cxu3L0vT+bmVSpFsyRjQ=
Date:   Mon, 24 Aug 2020 16:35:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Robert Richter <rric@kernel.org>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS, edac: Calxeda Highbank, handover
 maintenance to Andre Przywara
Message-ID: <20200824143514.GC4732@zn.tnic>
References: <20200824124931.2933-1-rric@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200824124931.2933-1-rric@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 02:49:31PM +0200, Robert Richter wrote:
> I do not have hardware anymore, nor there is ongoing development. So
> handover maintenance to Andre who already maintains the last
> remainings of Calxeda.
> 
> Cc: Andre Przywara <andre.przywara@arm.com>
> Signed-off-by: Robert Richter <rric@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1b7b0c1a24c8..6ed56e1a7d28 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6148,7 +6148,7 @@ S:	Supported
>  F:	drivers/edac/bluefield_edac.c
>  
>  EDAC-CALXEDA
> -M:	Robert Richter <rric@kernel.org>
> +M:	Andre Przywara <andre.przywara@arm.com>
>  L:	linux-edac@vger.kernel.org
>  S:	Maintained
>  F:	drivers/edac/highbank*
> -- 

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
