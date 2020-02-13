Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E97C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A0F206CC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgBMSzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:55:44 -0500
Received: from ms.lwn.net ([45.79.88.28]:47042 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbgBMSzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:55:44 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DB34A740;
        Thu, 13 Feb 2020 18:55:43 +0000 (UTC)
Date:   Thu, 13 Feb 2020 11:55:42 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] docs: merge debugging-modules.txt into
 sysctl/kernel.rst
Message-ID: <20200213115542.79a86048@lwn.net>
In-Reply-To: <20200213174701.3200366-3-steve@sk2.org>
References: <20200213174701.3200366-1-steve@sk2.org>
        <20200213174701.3200366-3-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Feb 2020 18:46:57 +0100
Stephen Kitt <steve@sk2.org> wrote:

> This fits nicely in sysctl/kernel.rst, merge it (and rephrase it)
> instead of linking to it.
> 
> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  Documentation/admin-guide/sysctl/kernel.rst | 16 ++++++++++++++-
>  Documentation/debugging-modules.txt         | 22 ---------------------
>  2 files changed, 15 insertions(+), 23 deletions(-)
>  delete mode 100644 Documentation/debugging-modules.txt

One quick comment here:

> diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
> index 1de8f0b199b1..1aacd7a24f5a 100644
> --- a/Documentation/admin-guide/sysctl/kernel.rst
> +++ b/Documentation/admin-guide/sysctl/kernel.rst
> @@ -388,7 +388,21 @@ This flag controls the L2 cache of G3 processor boards. If
>  modprobe
>  ========
>  
> -See Documentation/debugging-modules.txt.
> +This gives the full path of the modprobe command which the kernel will
> +use to load modules. This can be used to debug module loading
> +requests:
> +
> +::

This can be more readably written as just:

     requests::

No need for the separate "::" line.

Thanks,

jon

