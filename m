Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64785C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DB7D20731
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgD3TrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:47:07 -0400
Received: from ms.lwn.net ([45.79.88.28]:57848 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgD3TrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:47:06 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B33096E3;
        Thu, 30 Apr 2020 19:47:05 +0000 (UTC)
Date:   Thu, 30 Apr 2020 13:47:04 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     linux-doc@vger.kernel.org, hubcap@omnibond.com,
        martin@omnibond.com, devel@lists.orangefs.org,
        linux-kernel@vger.kernel.org, brendanhiggins@google.com,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] docs: filesystems: fix `make htmldocs` warning
Message-ID: <20200430134704.236c612b@lwn.net>
In-Reply-To: <20200430190737.80950-1-vitor@massaru.org>
References: <20200430190737.80950-1-vitor@massaru.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020 16:07:37 -0300
Vitor Massaru Iha <vitor@massaru.org> wrote:

> make htmldocs
> Documentation/filesystems/orangefs.rst:124: WARNING: Literal block expected; none found.
> 
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
> ---
>  Documentation/filesystems/orangefs.rst | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/Documentation/filesystems/orangefs.rst b/Documentation/filesystems/orangefs.rst
> index e41369709c5b..628dc220567e 100644
> --- a/Documentation/filesystems/orangefs.rst
> +++ b/Documentation/filesystems/orangefs.rst
> @@ -119,9 +119,7 @@ it comes to that question::
>  
>      /opt/ofs/bin/pvfs2-genconfig /etc/pvfs2.conf
>  
> -Create an /etc/pvfs2tab file::
> -
> -Localhost is fine for your pvfs2tab file:
> +Create an /etc/pvfs2tab file. Localhost is fine for your pvfs2tab file::
>  
>      echo tcp://localhost:3334/orangefs /pvfsmnt pvfs2 defaults,noauto 0 0 > \
>  	/etc/pvfs2tab

Thanks, but this has already been fixed in docs-next.

jon
