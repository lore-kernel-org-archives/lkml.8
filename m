Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE7BC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:45:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10BE214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbgCBRpE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:45:04 -0500
Received: from ms.lwn.net ([45.79.88.28]:57784 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727196AbgCBRpD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:45:03 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E5E922E4;
        Mon,  2 Mar 2020 17:45:02 +0000 (UTC)
Date:   Mon, 2 Mar 2020 10:45:01 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Pragat Pandya <pragat.pandya@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH 1/2] Documentation: Add a new .rst file under
 Documentation
Message-ID: <20200302104501.0f9987bb@lwn.net>
In-Reply-To: <20200302173920.24626-2-pragat.pandya@gmail.com>
References: <20200302173920.24626-1-pragat.pandya@gmail.com>
        <20200302173920.24626-2-pragat.pandya@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  2 Mar 2020 23:09:19 +0530
Pragat Pandya <pragat.pandya@gmail.com> wrote:

Thanks for working to make the documentation better.  A few comments,
though...  To begin with, please give a more descriptive subject line; any
time you have multiple patches with the same subject line you should be
seeing an indicator that you're not giving enough information there.

> Add io_mapping.rst under Documentation and reference it in TOCTree of
> index.rst to include it in html documentation.

You're not adding a file, you're renaming an existing file; say that.
> 
> Signed-off-by: Pragat Pandya <pragat.pandya@gmail.com>
> ---
>  Documentation/index.rst                       |   1 +
>  .../{io-mapping.txt => io_mapping.rst}        |   0
>  doc_make.log                                  | 372 ++++++++++++++++++

This doc_make.log file certainly doesn't belong here; please look
carefully at your patches before sending them.

>  3 files changed, 373 insertions(+)
>  rename Documentation/{io-mapping.txt => io_mapping.rst} (100%)
>  create mode 100644 doc_make.log
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index e99d0bd2589d..14670f2eaa33 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -141,6 +141,7 @@ Architecture-agnostic documentation
>     :maxdepth: 2
>  
>     asm-annotations
> +   io_mapping

Is there a reason you changed the name (io-mapping to io_mapping)?  If so,
you should explain it.

Finally, this document really doesn't belong in the top level.  Please
move it into the driver-api manual.

Thanks,

jon
