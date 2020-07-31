Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE19EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E642074B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733150AbgGaRJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:09:34 -0400
Received: from ms.lwn.net ([45.79.88.28]:55948 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729269AbgGaRJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:09:34 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2DFFE6D9;
        Fri, 31 Jul 2020 17:09:34 +0000 (UTC)
Date:   Fri, 31 Jul 2020 11:09:33 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Tony Luck <tony.luck@intel.com>, kernel-janitors@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ia64: correct typo
Message-ID: <20200731110933.4edfc99c@lwn.net>
In-Reply-To: <1596104250-32673-1-git-send-email-Julia.Lawall@inria.fr>
References: <1596104250-32673-1-git-send-email-Julia.Lawall@inria.fr>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 12:17:30 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> Replace RTC_WKLAM_RD with RTC_WKALM_RD.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  Documentation/ia64/efirtc.rst |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/ia64/efirtc.rst b/Documentation/ia64/efirtc.rst
> index 2f7ff50..fd83284 100644
> --- a/Documentation/ia64/efirtc.rst
> +++ b/Documentation/ia64/efirtc.rst
> @@ -113,7 +113,7 @@ We have added 2 new ioctl()s that are specific to the EFI driver:
>  
>  	Read the current state of the alarm::
>  
> -		ioctl(d, RTC_WKLAM_RD, &wkt)
> +		ioctl(d, RTC_WKALM_RD, &wkt)

Applied to the docs tree, thanks.

jon
