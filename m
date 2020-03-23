Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B5FC4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8E920788
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b80TLDee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgCWMSQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:18:16 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43624 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgCWMSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:18:16 -0400
Received: by mail-vs1-f67.google.com with SMTP id w185so1587481vsw.10
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZIjPVtwa8vukFKbNsjLTOoukuj9tIf+DVYy85zCK7n0=;
        b=b80TLDee+X1Jz9Tp2RA7UNcnmP+mTra0+kagwslurxtgPsyGd94Onk+mZZvvawQSC3
         zu/IIatBjYtMdSFMXa96DsniWwNjkrGelsSoQ6ugiDqd5nu2XmsBAOUsdJvGw5dC6ybq
         I9FlYXqO6wiuUzN6OufgJwGoJAZ9Ob6N0jsvebD48IuQ10jSQ7woSqzeBJk9HzxV2d1Z
         vM75Ccn4iVpeENNAG0uWYMR2EZtQ1Y4BOSl8kff9tRMShyVMQ76pOUlSetnR4ne/d+/E
         HkUueKAcNRjb48+85f9Um98PS97tBNFMyYURpH9m68qjw6pTyKoqZYpFgB14Ny+5GVwc
         XqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZIjPVtwa8vukFKbNsjLTOoukuj9tIf+DVYy85zCK7n0=;
        b=i9p3JOjNuGTdctypzIUkfVa/y79fUQEgThNK3woE7zAPNoulSHtyz+zF93wrfCHchB
         IXVWL78evhJMk/95OTqL8ayaBqdeiifc/d1d25eUlMyb+SUvlC3IZve2Zg+iAUnKr/+X
         f0L3vh00n9U5dHuSgBNxh9/cHEuMCmouu99LIuCGeFcX/u+j4LsUAm+ygob9QuXeVV2Q
         v9ZpqfwwQWBN8gK+bNlnv8S5tRu5z1xmxtLCEPntf/6OmepyhxWVoQEMddn0k0AdbhFB
         f6JUOzUCvGb2DPrqDs1iIGXLuXfUPdew51Mz6KNmv1vrQhxEK+2D1ZWgs5N8xKhrBD0V
         71pA==
X-Gm-Message-State: ANhLgQ0DRcdU3jkpU4iZowZzn8QyujXG7RVNcZaANKg72rF6ITg5u1bG
        UxLHdJjqUBNlgZJSPPKz1s34DYuFSnyyhJdPdus=
X-Google-Smtp-Source: ADFU+vsEp/gpr/Erhr2CBGjjsLk8QgypUY3rMqpasclJkcktIjSKg/GzkdhN3taas1XU3l2QE0R0Y/yFvOBBAYAY8x0=
X-Received: by 2002:a67:3201:: with SMTP id y1mr15672471vsy.54.1584965895124;
 Mon, 23 Mar 2020 05:18:15 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cbeaf705a15a9b30@google.com> <CADG63jAEOBvWZ2G-9tyvHbbuKnHxNTPpqqjfWmhP7YVvsHVioQ@mail.gmail.com>
 <20200323114225.GE26299@kadam>
In-Reply-To: <20200323114225.GE26299@kadam>
From:   Qiujun Huang <anenbupt@gmail.com>
Date:   Mon, 23 Mar 2020 20:18:03 +0800
Message-ID: <CADG63jAtF8RidQmeeSw7kC0Vzw2qSEeRYz+HEAKHhLFx7j=Zow@mail.gmail.com>
Subject: Re: KASAN: null-ptr-deref Write in get_block
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     syzbot <syzbot+4a88b2b9dc280f47baf4@syzkaller.appspotmail.com>,
        aeb@cwi.nl, danarag@gmail.com, kstewart@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, viro@zeniv.linux.org.uk,
        Qiujun Huang <hqjagain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 7:42 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Fix the subject to [PATCH] minix: Fix NULL dereference in alloc_branch()
>
> On Sun, Mar 22, 2020 at 08:06:48PM +0800, Qiujun Huang wrote:
> > Need to check the return value of sb_getblk.
> >
>
> Add a Reported-by tag.
>
> Reported-by: syzbot+4a88b2b9dc280f47baf4@syzkaller.appspotmail.com
>
> > Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> > ---
> >  fs/minix/itree_common.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/fs/minix/itree_common.c b/fs/minix/itree_common.c
> > index 043c3fd..eedd79f 100644
> > --- a/fs/minix/itree_common.c
> > +++ b/fs/minix/itree_common.c
> > @@ -85,6 +85,8 @@ static int alloc_branch(struct inode *inode,
> >   break;
> >   branch[n].key = cpu_to_block(nr);
> >   bh = sb_getblk(inode->i_sb, parent);
> > + if (!bh)
> > + break;
>
> The patch is white space damaged and we need to do a bit of error
> handling before the break as well.

I get it, thanks.

>
>         bh = sb_getblk(inode->i_sb, parent);
> +       if (!bh) {
> +               minix_free_block(inode, block_to_cpu(branch[n].key));
> +               break;
> +       }
>         lock_buffer(bh);
>
> Please fix those few things and resend.
>
> regards,
> dan carpenter
>
