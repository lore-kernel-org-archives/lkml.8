Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001ABC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AB52065F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgFZRXv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgFZRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:23:51 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B7BC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:23:51 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C70327DB;
        Fri, 26 Jun 2020 17:23:50 +0000 (UTC)
Date:   Fri, 26 Jun 2020 11:23:49 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: update URL for sparse's tarballs
Message-ID: <20200626112349.1292a654@lwn.net>
In-Reply-To: <20200621153330.54480-1-luc.vanoostenryck@gmail.com>
References: <20200621153330.54480-1-luc.vanoostenryck@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jun 2020 17:33:30 +0200
Luc Van Oostenryck <luc.vanoostenryck@gmail.com> wrote:

> The URL given to get sparse's tarballs is sparse.wiki.kernel.org
> but the wiki will is deprecated in favor of sparse.docs.kernel.org.
> 
> So, update this URL to the one where the tarballs can directly
> be found.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  Documentation/dev-tools/sparse.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/dev-tools/sparse.rst b/Documentation/dev-tools/sparse.rst
> index 6f4870528226..8a7055593c31 100644
> --- a/Documentation/dev-tools/sparse.rst
> +++ b/Documentation/dev-tools/sparse.rst
> @@ -73,8 +73,8 @@ sparse would otherwise report a context imbalance.
>  Getting sparse
>  --------------
>  
> -You can get latest released versions from the Sparse homepage at
> -https://sparse.wiki.kernel.org/index.php/Main_Page
> +You can get tarballs of the latest released versions from:
> +https://www.kernel.org/pub/software/devel/sparse/dist/

I've applied this, but it also seems like we're losing some information by
going from a wiki straight to a directory listing.  It seems maybe we need
a link to the new documentation site in here as well?

Thanks,

jon
