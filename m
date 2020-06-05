Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED13C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0E4207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgFEF6k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:58:40 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:6671 "EHLO
        mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725280AbgFEF6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 01:58:40 -0400
X-IronPort-AV: E=Sophos;i="5.73,475,1583190000"; 
   d="scan'208";a="350650169"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2020 07:58:37 +0200
Date:   Fri, 5 Jun 2020 07:58:37 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
cc:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>, cocci@systeme.lip6.fr,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] docs: dev-tools: coccinelle: underlines
In-Reply-To: <20200605030405.6479-1-xypron.glpk@gmx.de>
Message-ID: <alpine.DEB.2.21.2006050758150.2567@hadrien>
References: <20200605030405.6479-1-xypron.glpk@gmx.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 5 Jun 2020, Heinrich Schuchardt wrote:

> Underline lengths should match the lengths of headings to avoid build
> warnings with Sphinx.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


Acked-by: Julia Lawall <julia.lawall@inria.fr>

Thanks for your help.

> ---
>  Documentation/dev-tools/coccinelle.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index 00a3409b0c28..70274c3f5f5a 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -14,7 +14,7 @@ many uses in kernel development, including the application of complex,
>  tree-wide patches and detection of problematic programming patterns.
>
>  Getting Coccinelle
> --------------------
> +------------------
>
>  The semantic patches included in the kernel use features and options
>  which are provided by Coccinelle version 1.0.0-rc11 and above.
> @@ -56,7 +56,7 @@ found at:
>  https://github.com/coccinelle/coccinelle/blob/master/install.txt
>
>  Supplemental documentation
> ----------------------------
> +--------------------------
>
>  For supplemental documentation refer to the wiki:
>
> @@ -128,7 +128,7 @@ To enable verbose messages set the V= variable, for example::
>     make coccicheck MODE=report V=1
>
>  Coccinelle parallelization
> ----------------------------
> +--------------------------
>
>  By default, coccicheck tries to run as parallel as possible. To change
>  the parallelism, set the J= variable. For example, to run across 4 CPUs::
> @@ -333,7 +333,7 @@ as an example if requiring at least Coccinelle >= 1.0.5::
>  	// Requires: 1.0.5
>
>  Proposing new semantic patches
> --------------------------------
> +------------------------------
>
>  New semantic patches can be proposed and submitted by kernel
>  developers. For sake of clarity, they should be organized in the
> --
> 2.26.2
>
>
