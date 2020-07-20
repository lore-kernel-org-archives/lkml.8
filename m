Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 121D8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E14AF2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595235335;
	bh=OTz0b1zn56xSY338F25IC4hm9bfR0uECcJXvYiLKvto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tyWsY991XjbNcZL0Fw0FzVnRO8vS731PAyjWkyPfvvm/tAzfCP58uPkGgNgbawLII
	 zRzHf0NzkeCiW43ysAUg0ACJ4tHEYGbVOINyTIkSOYfywc216R12C9lFrRFnNt/dnY
	 isZ3EOueSEhPzL0HNut23ixCGrBwFqfRydzcF4yk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgGTIze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:55:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:45228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726601AbgGTIzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:55:33 -0400
Received: from linux-8ccs (p57a236d4.dip0.t-ipconnect.de [87.162.54.212])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C2A520773;
        Mon, 20 Jul 2020 08:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595235332;
        bh=OTz0b1zn56xSY338F25IC4hm9bfR0uECcJXvYiLKvto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hJK+zoweDui39cr8zOV1cV8a5UQPn9Yp1Is4uhuV0B27Lu5Hf6uSKI/MCNJXqt7PL
         6BQU27VWwQHFTir8kPyk7svquXOJoBWNul6pUcHhlP6r0TyGNXMiSUU2pL1KY2bZh1
         NiQcdKmk4W8SiGfOxk0QcKRmBJnYWyATOeAJUJoA=
Date:   Mon, 20 Jul 2020 10:55:29 +0200
From:   Jessica Yu <jeyu@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modules: linux/moduleparam.h: drop duplicated word in a
 comment
Message-ID: <20200720085529.GA25857@linux-8ccs>
References: <e6006b9e-48dd-5b79-b676-eab2fc71c718@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <e6006b9e-48dd-5b79-b676-eab2fc71c718@infradead.org>
X-OS:   Linux linux-8ccs 5.5.0-lp150.12.61-default x86_64
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+++ Randy Dunlap [17/07/20 16:36 -0700]:
>From: Randy Dunlap <rdunlap@infradead.org>
>
>Drop the doubled word "the" in a comment.
>
>Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>Cc: Jessica Yu <jeyu@kernel.org>
>---
> include/linux/moduleparam.h |    2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>--- linux-next-20200714.orig/include/linux/moduleparam.h
>+++ linux-next-20200714/include/linux/moduleparam.h
>@@ -108,7 +108,7 @@ struct kparam_array
>  * ".") the kernel commandline parameter.  Note that - is changed to _, so
>  * the user can use "foo-bar=1" even for variable "foo_bar".
>  *
>- * @perm is 0 if the the variable is not to appear in sysfs, or 0444
>+ * @perm is 0 if the variable is not to appear in sysfs, or 0444
>  * for world-readable, 0644 for root-writable, etc.  Note that if it
>  * is writable, you may need to use kernel_param_lock() around
>  * accesses (esp. charp, which can be kfreed when it changes).

Applied, thanks!

Jessica
