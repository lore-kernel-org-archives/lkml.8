Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F3FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A025520838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 20:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726412AbgHJUGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 16:06:01 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:45652
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726304AbgHJUGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 16:06:01 -0400
X-IronPort-AV: E=Sophos;i="5.75,458,1589234400"; 
   d="scan'208";a="356302824"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 22:05:45 +0200
Date:   Mon, 10 Aug 2020 22:05:45 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Sumera Priyadarsini <sylphrenadin@gmail.com>
cc:     michal.lkml@markovi.net, linux-doc@vger.kernel.org, corbet@lwn.net,
        gregkh@linuxfoundation.org, Gilles.Muller@lip6.fr,
        nicolas.palix@imag.fr, linux-kernel@vger.kernel.org,
        Markus.Elfring@web.de, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v3] documentation: coccinelle: Improve command
 example for make C={1, 2}
In-Reply-To: <20200810175948.14090-1-sylphrenadin@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2008102205190.2466@hadrien>
References: <20200810175948.14090-1-sylphrenadin@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 Aug 2020, Sumera Priyadarsini wrote:

> Modify coccinelle documentation to further clarify
> the usage of the makefile C variable flag by coccicheck.
>
> Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>

Thanks.

Acked-by: Julia Lawall <julia.lawall@inria.fr>



>
> ---
> Changes in v3:
>         - Remove quotes as suggested by Markus Elfring
> 	- Change in wording, and punctuation, as suggested by Julia Lawall
> ---
>  Documentation/dev-tools/coccinelle.rst | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/dev-tools/coccinelle.rst b/Documentation/dev-tools/coccinelle.rst
> index 6c791af1c859..74c5e6aeeff5 100644
> --- a/Documentation/dev-tools/coccinelle.rst
> +++ b/Documentation/dev-tools/coccinelle.rst
> @@ -175,13 +175,20 @@ For example, to check drivers/net/wireless/ one may write::
>      make coccicheck M=drivers/net/wireless/
>
>  To apply Coccinelle on a file basis, instead of a directory basis, the
> -following command may be used::
> +C variable is used by the makefile to select which files to work with.
> +This variable can be used to run scripts for the entire kernel, a
> +specific directory, or for a single file.
>
> -    make C=1 CHECK="scripts/coccicheck"
> +For example, to check drivers/bluetooth/bfusb.c, the value 1 is
> +passed to the C variable to check files that make considers
> +need to be compiled.::
>
> -To check only newly edited code, use the value 2 for the C flag, i.e.::
> +    make C=1 CHECK=scripts/coccicheck drivers/bluetooth/bfusb.o
>
> -    make C=2 CHECK="scripts/coccicheck"
> +The value 2 is passed to the C variable to check files regardless of
> +whether they need to be compiled or not.::
> +
> +    make C=2 CHECK=scripts/coccicheck drivers/bluetooth/bfusb.o
>
>  In these modes, which work on a file basis, there is no information
>  about semantic patches displayed, and no commit message proposed.
> --
> 2.17.1
>
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
