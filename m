Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEEEC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB177206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 06:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587450299;
	bh=QU5no/OrUnT96Vzl/CK3s7+DqKhw+qM37dWAFBcZEZY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=A4XLVE7QdXKWg7Mj8Wtpdu/Q3gYQ3k6orrm/hfXS8ho0VkrjtSsb5RmBRuYlH1VQC
	 oRVba/znucdn+YacAMnxe6ndbVv47ipZ9QIMbqJTa6ZzD7Pz7cLfV2bL+A4ZvGWVbq
	 O91ieheLMH365xQ/P85rD1wVhDmSG+LuDJCWADbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDUGY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:24:58 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:54360 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgDUGY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 02:24:58 -0400
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 03L6OeEZ002493
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 15:24:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 03L6OeEZ002493
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1587450281;
        bh=NCjFsF/5APZizCHMJFj1dJBHG+VhLjBwkmD0rofVo5I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GHEmP33kIdgySrnWfCjkW711ZitRWGkdKxAwqsaXlDWsRMqQWN3RlLJfQCA+Z123e
         1qm5tT8HZ5O53R+I9f/YRnFsTJAxbu3/ywBZ+Upvnl7J0jY7JmLwMvtJGnIY+ER9/p
         DQTe7LTo4lHSjVWBsHcZvN6q/QICPN19pKp2x5eiDGD5iGbASoxmofOZX+PNeUNokT
         Pd4PqE9d5H5QJlV+KcpicMYWvmI4/Jb1P1WoCDwKQvb40nZDOzInZwknlMwb/m1Kiv
         CC0WKKZVT+oim+NSjGoxPr0O+pKKnbqOhIezRhjfxkn3CgFa8RFyYjcQjcrK+Ock2G
         76RQZykjfDkWQ==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id u12so4641946uau.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 23:24:41 -0700 (PDT)
X-Gm-Message-State: AGi0PuZLv7g4/w57LO+hEF8s9YyQEQKPNmcK8C7a/w8vlmEShw7S8l3b
        tIJiRfAf3aYQT3hHbJCd1crTuaTM7nXSwhABoN0=
X-Google-Smtp-Source: APiQypJhC0BcRY70KQABBnZU/HLHDpZxKpCQyEvMAlCootR7nn+LkeTFDZSeJjV81gSW6nN4FFiuCHSsOwldfby85tA=
X-Received: by 2002:ab0:cd:: with SMTP id 71mr9086077uaj.109.1587450280224;
 Mon, 20 Apr 2020 23:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190723102106.11375-1-yamada.masahiro@socionext.com> <87r26bpp3r.wl-ysato@users.sourceforge.jp>
In-Reply-To: <87r26bpp3r.wl-ysato@users.sourceforge.jp>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 21 Apr 2020 15:24:04 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFBXBMrjuqWip9q0PyDZrvF4vTam+WACObZ8k4S-uvFQ@mail.gmail.com>
Message-ID: <CAK7LNATFBXBMrjuqWip9q0PyDZrvF4vTam+WACObZ8k4S-uvFQ@mail.gmail.com>
Subject: Re: [PATCH] h8300: move definition of __kernel_size_t etc. to posix_types.h
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        "moderated list:H8/300 ARCHITECTURE" 
        <uclinux-h8-devel@lists.sourceforge.jp>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sato-san,

Your h8300 repository is strange now.


See the following two commits in h8300-next.


commit de98871736825349b367275b0790e42ea4157350
Author:     Yoshinori Sato <ysato@users.sourceforge.jp>
AuthorDate: Thu Apr 16 13:43:01 2020 +0900
Commit:     Yoshinori Sato <ysato@users.sourceforge.jp>
CommitDate: Thu Apr 16 13:43:01 2020 +0900

    h8300: move definition of __kernel_size_t etc. to posix_types.h

    These types should be defined in posix_types.h, not in bitsperlong.h .

    With these defines moved, h8300-specific bitsperlong.h is no longer
    needed since Kbuild will automatically create a wrapper of
    include/uapi/asm-generic/bitsperlong.h

    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

commit ece7be2c964c2aa5015e74628ca33c03a5ff4e47
Author:     Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate: Tue Jul 23 19:21:06 2019 +0900
Commit:     Yoshinori Sato <ysato@users.sourceforge.jp>
CommitDate: Thu Apr 16 13:40:31 2020 +0900

    h8300: move definition of __kernel_size_t etc. to posix_types.h

    These types should be defined in posix_types.h, not in bitsperlong.h .

    With these defines moved, h8300-specific bitsperlong.h is no longer
    needed since Kbuild will automatically create a wrapper of
    include/uapi/asm-generic/bitsperlong.h

    Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
    Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>




Since you were silent for a long time,
I pushed the patch to Linus via my tree.
(c9ee4bf9e0f5e353ae1c81ee30a373b6653329d7)


Now, your recent rebase is wrong.
Please drop both commits above.


BTW, are you still maintaining h8300 (and sh) ?


Masahiro Yamada








On Sat, Jul 27, 2019 at 10:46 PM Yoshinori Sato
<ysato@users.sourceforge.jp> wrote:
>
> On Tue, 23 Jul 2019 19:21:06 +0900,
> Masahiro Yamada wrote:
> >
> > These types should be defined in posix_types.h, not in bitsperlong.h .
> >
> > With these defines moved, h8300-specific bitsperlong.h is no longer
> > needed since Kbuild will automatically create a wrapper of
> > include/uapi/asm-generic/bitsperlong.h
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/h8300/include/uapi/asm/bitsperlong.h | 15 ---------------
> >  arch/h8300/include/uapi/asm/posix_types.h | 13 +++++++++++++
> >  2 files changed, 13 insertions(+), 15 deletions(-)
> >  delete mode 100644 arch/h8300/include/uapi/asm/bitsperlong.h
> >  create mode 100644 arch/h8300/include/uapi/asm/posix_types.h
> >
> > diff --git a/arch/h8300/include/uapi/asm/bitsperlong.h b/arch/h8300/include/uapi/asm/bitsperlong.h
> > deleted file mode 100644
> > index a33e358f1c1b..000000000000
> > --- a/arch/h8300/include/uapi/asm/bitsperlong.h
> > +++ /dev/null
> > @@ -1,15 +0,0 @@
> > -/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > -#ifndef _UAPI__ASM_H8300_BITS_PER_LONG
> > -#define _UAPI__ASM_H8300_BITS_PER_LONG
> > -
> > -#include <asm-generic/bitsperlong.h>
> > -
> > -#if !defined(__ASSEMBLY__)
> > -/* h8300-unknown-linux required long */
> > -#define __kernel_size_t __kernel_size_t
> > -typedef unsigned long        __kernel_size_t;
> > -typedef long         __kernel_ssize_t;
> > -typedef long         __kernel_ptrdiff_t;
> > -#endif
> > -
> > -#endif /* _UAPI__ASM_H8300_BITS_PER_LONG */
> > diff --git a/arch/h8300/include/uapi/asm/posix_types.h b/arch/h8300/include/uapi/asm/posix_types.h
> > new file mode 100644
> > index 000000000000..3efc9dd59476
> > --- /dev/null
> > +++ b/arch/h8300/include/uapi/asm/posix_types.h
> > @@ -0,0 +1,13 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
> > +#ifndef _UAPI_ASM_POSIX_TYPES_H
> > +#define _UAPI_ASM_POSIX_TYPES_H
> > +
> > +/* h8300-unknown-linux required long */
> > +#define __kernel_size_t __kernel_size_t
> > +typedef unsigned long        __kernel_size_t;
> > +typedef long         __kernel_ssize_t;
> > +typedef long         __kernel_ptrdiff_t;
> > +
> > +#include <asm-generic/posix_types.h>
> > +
> > +#endif /* _UAPI_ASM_POSIX_TYPES_H */
> > --
> > 2.17.1
> >
>
> Applied h8300-next.
> Thanks.
>
> --
> Yosinori Sato



-- 
Best Regards
Masahiro Yamada
