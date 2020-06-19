Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6D8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF03D20890
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592555058;
	bh=Xq8Ij+6u/8JcNOjy40zqn86PaaYBeksc+X+qt6XzZ20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=12kATwtkPeHQrMZwNDPs0r7QmT1YqoQ75c+tjqet3yugFApEbE0j2qDg/IgpniRKo
	 uMyN33uibXuMCaC1sn+QJ2MeT78M5Yi7Fxo1Dp2KwnUGaPPbe7J9trGUcDgRJz8qRc
	 CT9LNi6Dr7Zl+/g3hWoK6y1iwMZyqDJC7Eiop2N4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbgFSIYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:24:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731409AbgFSIXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:23:47 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1073420885;
        Fri, 19 Jun 2020 08:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592555027;
        bh=Xq8Ij+6u/8JcNOjy40zqn86PaaYBeksc+X+qt6XzZ20=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AfgV0lJ2fHFvPVxGGuZ+7j/177k2Mky+486OBxfmyr1AAGJ/PMXA5REDOX6ZK99HU
         tKOmH3YvDyaHBCs08GCikPVixPptsSMtpYJDH1iUffNGKunsN0fi+9aACn4agfMGrG
         c5HUWQGzE6tc0RGt5v1tNIETy5rEKIQEAcCf/lJE=
Date:   Fri, 19 Jun 2020 09:23:43 +0100
From:   Will Deacon <will@kernel.org>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Marco Elver <elver@google.com>,
        Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH] sparse: use the _Generic() version of
 __unqual_scalar_typeof()
Message-ID: <20200619082342.GB6500@willie-the-truck>
References: <20200618222620.5069-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618222620.5069-1-luc.vanoostenryck@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:26:20AM +0200, Luc Van Oostenryck wrote:
> If the file is being checked with sparse, use the version of
> __unqual_scalar_typeof() using _Generic(), leaving the unoptimized
> version only for the oldest versions of GCC.
> 
> This reverts commit
>   b398ace5d2ea ("compiler_types.h: Use unoptimized __unqual_scalar_typeof for sparse")
> 
> Note: a recent version of sparse will be needed (minimum v0.6.2-rc2
>        or later than 2020-05-28).
> 
> Cc: Marco Elver <elver@google.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Link: https://marc.info/?l=linux-sparse&m=159233481816454
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  include/linux/compiler_types.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index e368384445b6..e34a1080f36b 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -254,7 +254,7 @@ struct ftrace_likely_data {
>   * __unqual_scalar_typeof(x) - Declare an unqualified scalar type, leaving
>   *			       non-scalar types unchanged.
>   */
> -#if (defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900) || defined(__CHECKER__)
> +#if defined(CONFIG_CC_IS_GCC) && CONFIG_GCC_VERSION < 40900
>  /*
>   * We build this out of a couple of helper macros in a vain attempt to
>   * help you keep your lunch down while reading it.

If you don't mind forcing people to update sparse, then:

Acked-by: Will Deacon <will@kernel.org>

Will
