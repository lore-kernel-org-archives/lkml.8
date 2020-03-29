Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA7DC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE8C20714
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 21:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUI+WBkK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgC2Vln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 17:41:43 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52097 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbgC2Vln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 17:41:43 -0400
Received: by mail-wm1-f65.google.com with SMTP id c187so17756574wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 14:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5Am6MQZe72IkQbz+igLTEEyX0AXnZ3Ned/hNiOH0Ey8=;
        b=TUI+WBkKyQvyWlClI3qStG1njdKrwTh2FS9WZhvHo0Eu84kPXivXhrGnAmQHqa/nbn
         vk2ee2ycWjvb5W34gx3L27+rUzEIsYM3C2U9Cjw7EZoWoH3byyADEB52utqvO1Z3rUn+
         x8JhkjvbSHd3BfILlGU5uirJxICDj+ZbcrIVK6liv7xfx29hRoROMzgGvYs7wb8Mi23T
         Lf9Xy2hgpSDiAMp1Fn/b5mvxfG0utcWaYouPodpv2F75sJ2/AMVXzFKTjgsjaR7DmPhz
         3IAmae77o4WI/c5xybHsDIMw1LMVVp6+W08SkemKT2ZkqvO4ps1mtED/Mzx9gf2JGFM6
         EwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5Am6MQZe72IkQbz+igLTEEyX0AXnZ3Ned/hNiOH0Ey8=;
        b=CpJDldxzt2C8B1zOamiKqpIszCRz0NBmumaLyAcwzINyslU3IIgkdLfnCoOPtLmLO7
         Awe1Auo1Ui1eyEzlScJhQSjwiOceh+/IWKKV9bReNlyamOOAH5Qx6aeSUzgAMXHOe8cb
         VycgbMjOz/GxvyavEIUkzf2AsZ7cKh8tFctb7AoQFqXEIThbbqu3t1rqUN6M+R6ikiUV
         pDz/csIFYYI3jsN7hjIvY3RQ90uI2ZIVI0w69gq0nc2MEDnGzgih3Nhw/boCTagno4GI
         Re97AjqYWkYtg+xmDtU0tFzIsLg04+rwgUL4bSH/EM++tfD6XMfRdx2+1YgVCNYryp5v
         lHig==
X-Gm-Message-State: ANhLgQ3Tig+Up8uH4vgXLwi7qdiom16HkQ55r/BOUn6Ia/JIvFSLU10/
        pl29OWDKBKge/N3YwIlYpCgr9yCRfuqS+4XkVK4=
X-Google-Smtp-Source: ADFU+vtrwRQ6BfChwf6D0caegIXYg+eHMkn7lJ+tQiDBelWCutxy+Nkel0RLYiLIZ6TOt3P3fhr9IC6aD+3Xu7dklPA=
X-Received: by 2002:a1c:2e10:: with SMTP id u16mr9437124wmu.143.1585518099817;
 Sun, 29 Mar 2020 14:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <1584466534-13248-1-git-send-email-alan.maguire@oracle.com> <2295c218-74a6-d785-f4b1-2046ee91503a@cambridgegreys.com>
In-Reply-To: <2295c218-74a6-d785-f4b1-2046ee91503a@cambridgegreys.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 29 Mar 2020 23:41:28 +0200
Message-ID: <CAFLxGvypQCHnnuRi8RC15wL3yJ7yBJiUQGMHG8MRoPeNA6pAPA@mail.gmail.com>
Subject: Re: [PATCH] arch/um: falloc.h needs to be directly included for older libc
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>, alex.dewar@gmx.co.uk,
        erelx.geron@intel.com, "Berg, Johannes" <johannes.berg@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-um <linux-um@lists.infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 4:58 PM Anton Ivanov
<anton.ivanov@cambridgegreys.com> wrote:
>
>
>
> On 17/03/2020 17:35, Alan Maguire wrote:
> > When building UML with glibc 2.17 installed, compilation
> > of arch/um/os-Linux/file.c fails due to failure to find
> > FALLOC_FL_PUNCH_HOLE and FALLOC_FL_KEEP_SIZE definitions.
> >
> > It appears that /usr/include/bits/fcntl-linux.h (indirectly
> > included by /usr/include/fcntl.h) does not include falloc.h
> > with an older glibc, whereas a more up-to-date version
> > does.
> >
> > Adding the direct include to file.c resolves the issue
> > and does not cause problems for more recent glibc.
> >
> > Fixes: 50109b5a03b4 ("um: Add support for DISCARD in the UBD Driver")
> > Cc: Brendan Higgins <brendanhiggins@google.com>
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
> >   arch/um/os-Linux/file.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
> > index fbda105..5c819f8 100644
> > --- a/arch/um/os-Linux/file.c
> > +++ b/arch/um/os-Linux/file.c
> > @@ -8,6 +8,7 @@
> >   #include <errno.h>
> >   #include <fcntl.h>
> >   #include <signal.h>
> > +#include <linux/falloc.h>
> >   #include <sys/ioctl.h>
> >   #include <sys/mount.h>
> >   #include <sys/socket.h>
> >
>
> Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Applied, thanks!

BTW: Anton & Brendan, thanks a lot for reviewing all these patches!

-- 
Thanks,
//richard
