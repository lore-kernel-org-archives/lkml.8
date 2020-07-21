Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 986CCC433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3282068F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595343037;
	bh=aNdmG5FsTOEdRO5wwbpPC+77Y5ZHj9o0TCBNjVxmUPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YIPS3W6XNBKOkHCa6naNgyuiD5Kz5WlGuyRAG0a3j1gCU8AMZWHl4bzXnC5TzBlwm
	 kwJR3eaqCRB9gvvRT6/hE6RQlXdSt6cUhk2touhPo/f21+puFpd+eqJO05wpj+y7kt
	 eX6zPAif8NnALDG7rEAkh+HKkmP0BWqyf1xvpQiw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgGUOug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:50:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:39806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728454AbgGUOub (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:50:31 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A26DF20717;
        Tue, 21 Jul 2020 14:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595343031;
        bh=aNdmG5FsTOEdRO5wwbpPC+77Y5ZHj9o0TCBNjVxmUPw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yR5hvNnshGR+m2ClD1DJ95m2CrjuK7W0TRv/SjhMfSMw0tyr/PrezegeeO/iRG97y
         1NfwxzJqji3t3IJryAgNzFrpb4ZauAcgINuz8I49y0q87kK9j3BaFGDLKFVAgmb/OM
         geWxEVkNEcIUYrfVuEqqve4OMa8JnvKDVG25w/gc=
Date:   Tue, 21 Jul 2020 16:50:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     tglx@linutronix.de, linux-spdx@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] LICENSES: Replace HTTP links with HTTPS ones
Message-ID: <20200721145038.GA1991774@kroah.com>
References: <20200713084231.32496-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713084231.32496-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 10:42:31AM +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely or at least not just HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  LICENSES/dual/Apache-2.0 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/LICENSES/dual/Apache-2.0 b/LICENSES/dual/Apache-2.0
> index 6e89ddeab187..fd71308fd2c3 100644
> --- a/LICENSES/dual/Apache-2.0
> +++ b/LICENSES/dual/Apache-2.0
> @@ -15,7 +15,7 @@ Apache License
>  
>  Version 2.0, January 2004
>  
> -http://www.apache.org/licenses/
> +https://www.apache.org/licenses/
>  
>  TERMS AND CONDITIONS FOR USE, REPRODUCTION, AND DISTRIBUTION
>  
> -- 
> 2.27.0
> 

You can't change the text of a license that comes from elsewhere.  This
file is fine as-is.

thanks,

greg k-h
