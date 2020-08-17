Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63034C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43414206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qnNWe2+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgHQJzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:55:40 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38766 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgHQJzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:55:39 -0400
Received: from zn.tnic (p200300ec2f26be0071e1cf3fa1f5ba15.dip0.t-ipconnect.de [IPv6:2003:ec:2f26:be00:71e1:cf3f:a1f5:ba15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 948751EC026E;
        Mon, 17 Aug 2020 11:55:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597658138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6Tf7YYM5n7xeCYKiahGC5yoyixvXsbkIQzXgCUnTbvE=;
        b=qnNWe2+JAHspKFI14qcip1FWrnCyPmEUGlBZmVgUM2uJrggwdS4T4WpaFfKXzqSI+haJoQ
        C6jfNP7Htugt7Yv06dWRXQIUragD1VcI/zFvxGUh5UQ4jJPFucZlwXgoEbP/I7gUlq4CUQ
        7i+CXzsXrc+1zXmEc50vz2mIzGPOxBI=
Date:   Mon, 17 Aug 2020 11:56:38 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        thor.thayer@linux.intel.com
Subject: Re: [PATCH] MAINTAINERS: edac: socfpga: transfer SoCFPGA EDAC
 maintainership
Message-ID: <20200817095638.GE549@zn.tnic>
References: <20200729174511.4256-1-dinguyen@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729174511.4256-1-dinguyen@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 12:45:11PM -0500, Dinh Nguyen wrote:
> Thor Thayer is leaving Intel and will no longer be able to maintain the
> EDAC for SoCFPGA, thus transfer maintainership to Dinh Nguyen.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f0569cf304ca..c53fc9febf12 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2466,7 +2466,7 @@ S:	Maintained
>  F:	drivers/clk/socfpga/
>  
>  ARM/SOCFPGA EDAC SUPPORT
> -M:	Thor Thayer <thor.thayer@linux.intel.com>
> +M:	Dinh Nguyen <dinguyen@kernel.org>
>  S:	Maintained
>  F:	drivers/edac/altera_edac.

Applied, thanks.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
