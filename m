Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42018C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2880820756
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgEOR1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726168AbgEOR1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:27:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74607C061A0C;
        Fri, 15 May 2020 10:27:36 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1BB9A736;
        Fri, 15 May 2020 17:27:36 +0000 (UTC)
Date:   Fri, 15 May 2020 11:27:35 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: sysctl/kernel: document unaligned controls
Message-ID: <20200515112735.67ee1148@lwn.net>
In-Reply-To: <20200515160406.8649-1-steve@sk2.org>
References: <20200515160406.8649-1-steve@sk2.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 18:04:06 +0200
Stephen Kitt <steve@sk2.org> wrote:

> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 9599c0f3eea8..17c38d899572 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -143,6 +143,7 @@ Architecture-agnostic documentation
>     :maxdepth: 2
>  
>     asm-annotations
> +   unaligned-memory-access
>  
>  Architecture-specific documentation
>  -----------------------------------
> diff --git a/Documentation/unaligned-memory-access.txt b/Documentation/unaligned-memory-access.rst
> similarity index 100%
> rename from Documentation/unaligned-memory-access.txt
> rename to Documentation/unaligned-memory-access.rst

Adding this to the toctree is great, but I'd just as soon not leave it in
the top-level directory while we do that.  Since you're renaming it
anyway, can you move it into process/?  It's not a perfect fit, but that's
where that type of material has been going so far.

Thanks,

jon
