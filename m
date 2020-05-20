Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A338CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:10:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ED8E20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 01:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589937036;
	bh=DuIRGWpmRLK4Gvn27f6R1NXMTUEFp+oebvCIa14JEGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CiX1ZjX7nm4zn7YUSFkr3VdPHBPUR7jRkHxKAJuXN19P+AYTiX6QUMJgFvpe85Kak
	 1BngEzXNe/nc6PDQG0m7AmgyFhsXai3zvjIefs6O3VUHeNRzRdYJ9mY5gWy+id3oIX
	 dLK0ZFNhwviki14fc5CbkxvHpo8TNbMU+BFwJQi8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgETBKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 21:10:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:33208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgETBKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 21:10:35 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE51204EA;
        Wed, 20 May 2020 01:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589937034;
        bh=DuIRGWpmRLK4Gvn27f6R1NXMTUEFp+oebvCIa14JEGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JFAKfzMKamKtRyjemuWdUz1jRN4K4CWk5OVvuONLFLBrKQqQ8L7NQPAaC46daEogY
         pjO9U5Mv3J+3T++sJawlSQgLkuxEe3od1b4PFiwkCoRqhc8E+f9qgYgexCoV2oHmRH
         xmII0G8lLa6czATOOSeDIWx6tMZwfyR0YWxfUlOk=
Date:   Tue, 19 May 2020 18:10:34 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: include linux/time_types.h for sockios
Message-Id: <20200519181034.58c67eb5bea24aae24d33421@linux-foundation.org>
In-Reply-To: <20200519131327.1836482-1-arnd@arndb.de>
References: <20200519131327.1836482-1-arnd@arndb.de>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 15:13:13 +0200 Arnd Bergmann <arnd@arndb.de> wrote:

> Using the socket ioctls on arch/sh (and only there) causes build
> time problems when __kernel_old_timeval/__kernel_old_timespec are
> not already visible to the compiler.
> 
> Add an explict include line for the header that defines these
> structures.

I can grab this.

> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Fixes: 8c709f9a0693 ("y2038: sh: remove timeval/timespec usage from headers")
> Fixes: 0768e17073dc ("net: socket: implement 64-bit timestamps")

cc:stable?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/sh/include/uapi/asm/sockios.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sh/include/uapi/asm/sockios.h b/arch/sh/include/uapi/asm/sockios.h
> index 3da561453260..ef01ced9e169 100644
> --- a/arch/sh/include/uapi/asm/sockios.h
> +++ b/arch/sh/include/uapi/asm/sockios.h
> @@ -2,6 +2,8 @@
>  #ifndef __ASM_SH_SOCKIOS_H
>  #define __ASM_SH_SOCKIOS_H
>  
> +#include <linux/time_types.h>
> +
>  /* Socket-level I/O control calls. */
>  #define FIOGETOWN	_IOR('f', 123, int)
>  #define FIOSETOWN 	_IOW('f', 124, int)

