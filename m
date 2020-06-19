Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF783C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97D621531
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388137AbgFST0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388086AbgFST0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:26:44 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85A5C06174E;
        Fri, 19 Jun 2020 12:26:44 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2F7562CD;
        Fri, 19 Jun 2020 19:26:44 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:26:43 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     akpm@linux-foundation.org, jack@suse.cz,
        kirill.shutemov@linux.intel.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH] docs: mm/gup: Minor documentation update
Message-ID: <20200619132643.1e9290fc@lwn.net>
In-Reply-To: <1592422023-7401-1-git-send-email-jrdr.linux@gmail.com>
References: <1592422023-7401-1-git-send-email-jrdr.linux@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jun 2020 00:57:03 +0530
Souptick Joarder <jrdr.linux@gmail.com> wrote:

> Now there are 5 cases. Updated the same.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> ---
>  Documentation/core-api/pin_user_pages.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/pin_user_pages.rst b/Documentation/core-api/pin_user_pages.rst
> index 6068266..7ca8c7b 100644
> --- a/Documentation/core-api/pin_user_pages.rst
> +++ b/Documentation/core-api/pin_user_pages.rst
> @@ -33,7 +33,7 @@ all combinations of get*(), pin*(), FOLL_LONGTERM, and more. Also, the
>  pin_user_pages*() APIs are clearly distinct from the get_user_pages*() APIs, so
>  that's a natural dividing line, and a good point to make separate wrapper calls.
>  In other words, use pin_user_pages*() for DMA-pinned pages, and
> -get_user_pages*() for other cases. There are four cases described later on in
> +get_user_pages*() for other cases. There are five cases described later on in
>  this document, to further clarify that concept.

Applied, thanks.

jon
