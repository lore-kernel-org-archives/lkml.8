Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7119AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 405C5206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFmvftu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgFJMcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgFJMcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:32:36 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B16C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 05:32:33 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id s18so1959861ioe.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 05:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEwAMEos9mJeyuBEtMGoJ7WeF5TrT6RnXqrCBNOkXKo=;
        b=mFmvftu8um4zSR74X94iYcbVafHOUT2/kfnxIJ6pJmXtt0NZ3RA0PpVJ8D/cwBTozI
         QcOGchsvt4jIO6zcGpXfP/UNpTM2ormEecd5+Qerse5Atz4s7WgwhLW8kEv+LqVyMtrC
         ibxnSuEP39roA3Apd+7h7YQQJPAi/+w34lpryuPYQDE9nqREIVU2xUVrBKWDL6MUtejy
         8WU1be9W4z/vfTj6xHrkXP/dVPap963HqP7gzUskmX/VB/n1JqLl51jdAzHhkj9AuCRw
         /hZw6aPdKa1j7o8C7nWTA1xzJEor+5oMmSxkaeC5c9rcmzrjZm+gsNJo+M2E+Zlvdzs/
         BYmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEwAMEos9mJeyuBEtMGoJ7WeF5TrT6RnXqrCBNOkXKo=;
        b=rXmrN8ubOIh8TiqXQa9iD1kICpxZ0k1lNnSuELTFYT1Axuj9/VR/wxS/zt5ISZ1obb
         PwSu0Nlwx3TmaUs3P6XI7oUs4aTQiVGhP1AO0EYb8RQKCvMxmcdhcYp2twtr3hBNq571
         gcQjaVQ+8WUdY8hrBZEYhClihyGm5xV1UYC0LDCza/agV3Zt8DU52G9/8/T+04VV3q69
         sc5UK3TZEPuU050SXvorRVxJ2K2nQX/UBuBm5fR8l/Aiixq+RyV4Wgr7M8uK1goJ0JtE
         Uu8oU1n7pYwvFtwzsxq5o6Sib9npolj82XZKX0CxDOTgaI4+YJReWaKtcBD2J8aXz4W/
         Zg4w==
X-Gm-Message-State: AOAM530Uy/9YCYyuVgTOKIG/e5OmoRfYgdyqB8wyA1wjoT1yDZ+MPECW
        ps8ymg/Az8OjKkwhhMi8R6v/set286pWUUTzhw==
X-Google-Smtp-Source: ABdhPJxFtXrRZYv/jPjKUVyCn4z98p60ZiiAk2PbzG5kx1qFSlHpBWc1HBjAWzumIC8NM4BJbXItyqdA1ttpUZOo2+k=
X-Received: by 2002:a05:6602:50:: with SMTP id z16mr3084684ioz.22.1591792353125;
 Wed, 10 Jun 2020 05:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200610114851.28549-1-jslaby@suse.cz>
In-Reply-To: <20200610114851.28549-1-jslaby@suse.cz>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Wed, 10 Jun 2020 08:32:22 -0400
Message-ID: <CAMzpN2imDt9GZ3rFAJHQXw_GZhCHGzpCckSPZ2-2ObpbxdePiQ@mail.gmail.com>
Subject: Re: [PATCH] syscalls: fix offset type of ksys_ftruncate
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 7:48 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> After the commit below, truncate on i586 uses ksys_ftruncate. But
> ksys_ftruncate truncates the offset to unsigned long. So switch the type
> of offset to loff_t which is what the lower do_sys_ftruncate expects.
>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> Fixes: 121b32a58a3a (x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments)
> Cc: Brian Gerst <brgerst@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> ---
>  include/linux/syscalls.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 63ffa6dc9da3..e97ca179d0dc 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1370,7 +1370,7 @@ static inline long ksys_lchown(const char __user *filename, uid_t user,
>
>  extern long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
>
> -static inline long ksys_ftruncate(unsigned int fd, unsigned long length)
> +static inline long ksys_ftruncate(unsigned int fd, loff_t length)
>  {
>         return do_sys_ftruncate(fd, length, 1);
>  }

Reviewed-by: Brian Gerst <brgerst@gmail.com>
