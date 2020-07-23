Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0F63C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6D2C206E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726904AbgGWU0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWU0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:26:46 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F42C0619DC;
        Thu, 23 Jul 2020 13:26:46 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6EE382BA;
        Thu, 23 Jul 2020 20:26:45 +0000 (UTC)
Date:   Thu, 23 Jul 2020 14:26:44 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, gregkh@linuxfoundation.org,
        tyhicks@canonical.com, jpoimboe@redhat.com, jkosina@suse.cz,
        tglx@linutronix.de, keescook@chromium.org, steve@sk2.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] docs: process/index.rst: Fix reference to nonexistent
 document
Message-ID: <20200723142644.5dd89bd4@lwn.net>
In-Reply-To: <20200718165107.625847-5-dwlsalmeida@gmail.com>
References: <20200718165107.625847-1-dwlsalmeida@gmail.com>
        <20200718165107.625847-5-dwlsalmeida@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jul 2020 13:50:59 -0300
"Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:

> From: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> 
> Fix the following warning:
> 
> WARNING: toctree contains reference to nonexistent document
> 'process/unaligned-memory-access'
> 
> The path to the document was wrong.
> 
> Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> ---
>  Documentation/process/index.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> index f07c9250c3acb..dd231ffc8422d 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -32,7 +32,7 @@ Below are the essential guides that every developer should read.
>     kernel-enforcement-statement
>     kernel-driver-statement
>  
> -Other guides to the community that are of interest to most developers are: 
> +Other guides to the community that are of interest to most developers are:
>  
>  .. toctree::
>     :maxdepth: 1
> @@ -61,7 +61,7 @@ lack of a better place.
>     botching-up-ioctls
>     clang-format
>     ../riscv/patch-acceptance
> -   unaligned-memory-access
> +   ../core-api/unaligned-memory-access

Applied, but the right solution is probably just to list it in the
core-api book rather than here.

Thanks,

jon
