Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105CFC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E760C20752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 14:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgCROzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:55:44 -0400
Received: from ms.lwn.net ([45.79.88.28]:40986 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgCROzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 10:55:44 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ED5ECA78;
        Wed, 18 Mar 2020 14:55:43 +0000 (UTC)
Date:   Wed, 18 Mar 2020 08:55:42 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: locking: Add 'need' to hardirq section
Message-ID: <20200318085542.081ca750@lwn.net>
In-Reply-To: <20200318054425.111928-1-swboyd@chromium.org>
References: <20200318054425.111928-1-swboyd@chromium.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 22:44:25 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Add the missing word to make this sentence read properly.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  Documentation/kernel-hacking/locking.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
> index a8518ac0d31d..9850c1e52607 100644
> --- a/Documentation/kernel-hacking/locking.rst
> +++ b/Documentation/kernel-hacking/locking.rst
> @@ -263,7 +263,7 @@ by a hardware interrupt on another CPU. This is where
>  interrupts on that cpu, then grab the lock.
>  :c:func:`spin_unlock_irq()` does the reverse.
>  
> -The irq handler does not to use :c:func:`spin_lock_irq()`, because
> +The irq handler does not need to use :c:func:`spin_lock_irq()`, because

Please take out the :c:func: stuff while you're at it, we don't need that
anymore.  Just spin_lock_irq() will do the right thing.

Thanks,

jon
