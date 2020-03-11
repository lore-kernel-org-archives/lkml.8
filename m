Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119FEC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:30:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107B720736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731202AbgCKTa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:30:29 -0400
Received: from ms.lwn.net ([45.79.88.28]:52692 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731187AbgCKTa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:30:29 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 57C1F2E4;
        Wed, 11 Mar 2020 19:30:28 +0000 (UTC)
Date:   Wed, 11 Mar 2020 13:30:27 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     peter@bikeshed.quignogs.org.uk
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/1] Added double colons and blank lines within
 kerneldoc to format code snippets as ReST literal blocks.
Message-ID: <20200311133027.2c77f348@lwn.net>
In-Reply-To: <20200311192256.15911-2-peter@bikeshed.quignogs.org.uk>
References: <20200311192256.15911-1-peter@bikeshed.quignogs.org.uk>
        <20200311192256.15911-2-peter@bikeshed.quignogs.org.uk>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 19:22:56 +0000
peter@bikeshed.quignogs.org.uk wrote:

> From: Peter Lister <peter@bikeshed.quignogs.org.uk>
> 
> This removes the following warnings from the kernel doc build...
> ./drivers/base/platform.c:134: WARNING: Unexpected indentation.
> ./drivers/base/platform.c:213: WARNING: Unexpected indentation.
> 
> Signed-off-by: Peter Lister <peter@bikeshed.quignogs.org.uk>
> ---
>  drivers/base/platform.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 7fa654f1288b..7fb5cf847253 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -128,7 +128,8 @@ EXPORT_SYMBOL_GPL(devm_platform_ioremap_resource_byname);
>   * request_irq() APIs. This is the same as platform_get_irq(), except that it
>   * does not print an error message if an IRQ can not be obtained.
>   *
> - * Example:
> + * Example: ::
> + *

The change seems good, but you can make it just:

 * Example::

...and keep it a bit more readable.

Thanks,

jon
