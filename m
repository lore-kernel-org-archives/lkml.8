Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D73C2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE8B214D8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 13:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CezAMW14"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgDINAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 09:00:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46824 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgDINAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 09:00:32 -0400
Received: by mail-qk1-f196.google.com with SMTP id g74so3719422qke.13
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 06:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vnCZohwRHsmDtT2P5HcB+/NPRFz35HKFKOK1nLu0P0s=;
        b=CezAMW14TlE0+D8/bfCgQuMMzdla4tMTrjWEu6fghtWPYSzUiBcRIwfcAnMnqUkMam
         rFeLfKjk9NXXL4knaW1u0Y5cVIsQlTwekApdTj3hDfsyjfuh0jUG+tKqL6FxWlIoQy/s
         Q5V/fyVVqsJPCAwX6tvW7FEtkiSsTWe8BNVqRHkdow/awj4WmDt09mK4bHHpGewgOCc6
         ulIJslpf9/T4reX0gSpVjR3XdWaL1/aqgLZ8Sy68sLEU2tw+Tj1uqvgjxCi+UgVrphYt
         bH643HlPFmWaVkosyJEoMm9uNd7SczdPcyNd5d2lUuzw1uLDYp+yWcUUP30FrwxRyzhv
         T0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vnCZohwRHsmDtT2P5HcB+/NPRFz35HKFKOK1nLu0P0s=;
        b=TDNuMdHZnItDqeEYbRdLQoRVJvRihdvGB41TYOKJvuBkRZeCsu0ErmGK7CV1NsDVjz
         RuaQxYVS8RYW7yJgt/f6bNqI196TCViP3i2KQOgVYtBDFCPB9NKwilLnIGUythdOq9gh
         qevpOwJsoRqDE8UBF4STJ7IslI6hB5hRPAn5435HvVwyGNTpGO9o2yU+K3IZx8vTjcsR
         Iz0KJJEqwQAxcvwidgMhpHxtSvdymPGrREkuxlnXVkLmoOh2nynYOHMNflQ5CtK0ixvs
         RXzVzp6/cT6niZ/iuZE67tMyP6p0aBhYtSCsB3ykOiAXRFL6JKplAZO6m7Rp5ZpWTrJH
         fLWQ==
X-Gm-Message-State: AGi0PuYmreAyGqCDdBo7VgS+Iva4872tFY2Rsb/BeACkYC92HkRA8lTp
        C9Iu/Ja2fZWxnYVeqNKRcvhhc9X0nr1IIugdPhF9JA==
X-Google-Smtp-Source: APiQypJO7EzrDHF7D4zbkHdxOft7urOwT8fTJFGKxGTIPP2qJenCpoCClzj0s7F/4yq6bc/4hcBgpcxxpQtaBKEy9i4=
X-Received: by 2002:a05:620a:348:: with SMTP id t8mr11025765qkm.407.1586437231649;
 Thu, 09 Apr 2020 06:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200408014010.80428-1-peterx@redhat.com> <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
 <20200409114940.GT21484@bombadil.infradead.org>
In-Reply-To: <20200409114940.GT21484@bombadil.infradead.org>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Apr 2020 15:00:20 +0200
Message-ID: <CACT4Y+ZvQ9UvVAwTjjD8Zxo0X_nfxa3+6n6TqWk2g+hahBwdCw@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 9, 2020 at 1:49 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Apr 08, 2020 at 05:47:32PM -0700, Andrew Morton wrote:
> > On Tue,  7 Apr 2020 21:40:08 -0400 Peter Xu <peterx@redhat.com> wrote:
> >
> > > The two patches should fix below syzbot reports:
> > >
> > >   BUG: unable to handle kernel paging request in kernel_get_mempolicy
> > >   https://lore.kernel.org/lkml/0000000000002b25f105a2a3434d@google.com/
> > >
> > >   WARNING: bad unlock balance in __get_user_pages_remote
> > >   https://lore.kernel.org/lkml/00000000000005c65d05a2b90e70@google.com/
> >
> > (Is there an email address for the syzbot operators?)
>
> I'd suggest syzkaller-bugs@googlegroups.com (added to the Cc).

syzkaller@googlegroups.com is a better one.
syzkaller-bugs@googlegroups.com plays more of an LKML role.

> But there's a deeper problem in that we don't have anywhere to stash
> that kind of information in the kernel tree right now.  Perhaps a special
> entry in the MAINTAINERS file for bot operators?  Or one entry per bot?

I don't mind adding syzkaller. Some time ago I wanted to contact
KernelCI, CKI, LKFT, 0-day owners, finding relevant lists wasn't
impossible, but for some it was hard.

For syzkaller it would be:

https://github.com/google/syzkaller/issues for bugs/feature requests.
syzkaller@googlegroups.com for discussions.
