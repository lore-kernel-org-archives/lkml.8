Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA52C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6217207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgCEGWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:22:40 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59780 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCEGWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:22:40 -0500
Received: from 1.is.james.uk.vpn ([10.172.254.24] helo=malefic)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <james.troup@canonical.com>)
        id 1j9ju0-0005S7-TL; Thu, 05 Mar 2020 06:22:37 +0000
Received: from james by malefic with local (Exim 4.93 #3 (Debian))
        id 1j9jtw-003dRU-Ie; Thu, 05 Mar 2020 07:22:32 +0100
From:   James Troup <james.troup@canonical.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Add %p to the list
References: <202003041103.A5842AD@keescook>
Mail-Copies-To: never
Date:   Thu, 05 Mar 2020 07:22:31 +0100
In-Reply-To: <202003041103.A5842AD@keescook> (Kees Cook's message of "Wed, 4
        Mar 2020 11:13:28 -0800")
Message-ID: <87mu8vtj6g.fsf@canonical.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> index f9f196d3a69b..a4db119f4e09 100644
> --- a/Documentation/process/deprecated.rst
> +++ b/Documentation/process/deprecated.rst
> @@ -109,6 +109,23 @@ the given limit of bytes to copy. This is inefficient and can lead to
>  linear read overflows if a source string is not NUL-terminated. The
>  safe replacement is :c:func:`strscpy`.
>  
> +%p format specifier
> +-------------------
> +Using %p in format strings leads to a huge number of address exposures.

Perhaps this sentence should be in the past tense, since %p currently
prints a hashed value?

> +Instead of leaving these to be exploitable, "%p" should not be used in
> +the kernel.

On its face, this seems to contradict the guidance below?

> If used currently, it is a hashed value, rendering it

Perhaps: s/it is/it prints/ ?

> +unusable for addressing. Paraphrasing Linus's current `guideance
> <https://lore.kernel.org/lkml/CA+55aFwQEd_d40g4mUCSsVRZzrFPUJt74vc6PPpb675hYNXcKw@mail.gmail.com/>`_:

Typo: guidance

> +- Just use %p and get the hashed value.

-- 
James
