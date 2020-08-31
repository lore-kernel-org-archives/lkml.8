Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8821DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 649C1207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 22:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHaW2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 18:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728103AbgHaW2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 18:28:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5A1C061573;
        Mon, 31 Aug 2020 15:28:36 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id CAC957C0;
        Mon, 31 Aug 2020 22:28:35 +0000 (UTC)
Date:   Mon, 31 Aug 2020 16:28:34 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brooke Basile <brookebasile@gmail.com>,
        Felipe Balbi <balbi@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH 1/2] docs: process: Add cross-link to security-bugs
Message-ID: <20200831162834.294a7f39@lwn.net>
In-Reply-To: <20200827105319.9734-1-krzk@kernel.org>
References: <20200827105319.9734-1-krzk@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Aug 2020 12:53:18 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> The submitting patches mentions criteria for a fix to be called
> "security fix".  Add a link to document explaining the entire process
> of handling security bugs.
> 
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/process/submitting-patches.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index 5219bf3cddfc..d5b3c5a74d5d 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -299,7 +299,8 @@ sending him e-mail.
>  If you have a patch that fixes an exploitable security bug, send that patch
>  to security@kernel.org.  For severe bugs, a short embargo may be considered
>  to allow distributors to get the patch out to users; in such cases,
> -obviously, the patch should not be sent to any public lists.
> +obviously, the patch should not be sent to any public lists. See also
> +:ref:`Documentation/admin-guide/security-bugs.rst <security-bugs>`.

I've applied this (but not part 2).

Thanks,

jon
