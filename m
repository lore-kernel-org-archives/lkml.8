Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235CCC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB0C20722
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZnoNvW0J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgBROJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:09:36 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39619 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgBROJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:09:36 -0500
Received: by mail-ot1-f68.google.com with SMTP id 77so19593288oty.6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 06:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y9w13/tfZTffVdCMe2kCDHSUE9opbbsLGQSUEHoko5U=;
        b=ZnoNvW0JGNymhsudEZqj4eoZL6SliYBlFQN7OmbbDWtZ+DW/BAxE3hwh/GxzzOUq4I
         M14C03Y2T+WaaeCiZoUFUPZV9q4zgIZs8yBv8AnDW72hrDDM6y0NkeVo7zaJ40jqROow
         v8qPHUVDlCW+bds4jvDZv36VciX3KYf4LtCp5k4pcr8ly/3m77mKsJuXokfH7/UPJzfH
         nqTxQusEkwdKvIDkVZC81F8FbvGRU0IT2MTpGKQeUj5F2pk+dSN22zPstNJZzEVW1KAn
         JXjtLv6fd60NLxAXjxGyN9XhcueGuh4dWszfAnh55nBzaJl+pOp7AYmVDGNaANbVFIyL
         Aqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y9w13/tfZTffVdCMe2kCDHSUE9opbbsLGQSUEHoko5U=;
        b=sXMRqQLA2Y2iMKK30KoQ8JfeS3N0c6pJa9ZqEUe96HFqzat6bg0fyk+ZWAXsrm3/24
         ZrC0skcshefYEnpis+5FdEMeMnTOqfEJf1qfjf0BAXgM+R8m7k65ivw73ESIbbz2bWDi
         uM8SPM8o2frrjaUzWAvNcWZUyF9oyLVBCYMDErIuSN8uLS0+yBJsQBdbdOacebi7auVI
         ZYXcNl5CJvqgZKhW46Xsohb9Eidyx86r/Hrock1n+lQpX2TDliDvMfYB86q07aIxkK1J
         jrEGnlCSeSr2UYizWGxpP3nbqR3Szx54LWDV/rPxPOUvZk5Gc4HpGZgqSKbZQMFvgc3w
         VMJA==
X-Gm-Message-State: APjAAAULccsoJ9Tubkqck6dQ0+64U+d5tNOuRo90OvCi480CGbV7m6Yt
        TcJqPDOd0GCInCDA2nV00kDfPw3hntF2nyy9VR9qzP+twgw=
X-Google-Smtp-Source: APXvYqxYlKjO1s4KexGAjjp0ZYGelLIWTBxCcyZwR5o5/JwGl/0bZDE9Ceb/vNAMImYSSQ1HPgvU9yI7CPpyQS9x/EM=
X-Received: by 2002:a9d:66d1:: with SMTP id t17mr16550705otm.233.1582034975091;
 Tue, 18 Feb 2020 06:09:35 -0800 (PST)
MIME-Version: 1.0
References: <20200218103002.6rtjreyqjepo3yxe@box> <93E6B243-9A0F-410C-8EE4-9D57E28AF5AF@lca.pw>
In-Reply-To: <93E6B243-9A0F-410C-8EE4-9D57E28AF5AF@lca.pw>
From:   Marco Elver <elver@google.com>
Date:   Tue, 18 Feb 2020 15:09:22 +0100
Message-ID: <CANpmjNO320YvGvUfBkWJFnv+QwZy=B0GG=WAMKv7ZOJ2UYFkPg@mail.gmail.com>
Subject: Re: [PATCH -next] fork: annotate a data race in vm_area_dup()
To:     Qian Cai <cai@lca.pw>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzbot <syzbot+c034966b0b02f94f7f34@syzkaller.appspotmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 at 13:40, Qian Cai <cai@lca.pw> wrote:
>
>
>
> > On Feb 18, 2020, at 5:29 AM, Kirill A. Shutemov <kirill@shutemov.name> =
wrote:
> >
> > I think I've got this:
> >
> > vm_area_dup() blindly copies all fields of orignal VMA to the new one.
> > This includes coping vm_area_struct::shared.rb which is normally protec=
ted
> > by i_mmap_lock. But this is fine because the read value will be
> > overwritten on the following __vma_link_file() under proper protectecti=
on.
>
> Right, multiple processes could share the same file-based address space w=
here those vma have been linked into address_space::i_mmap via vm_area_stru=
ct::shared.rb. Thus, the reader could see its shared.rb linkage pointers go=
t updated by other processes.
>
> >
> > So the fix is correct, but justificaiton is lacking.
> >
> > Also, I would like to more fine-grained annotation: marking with
> > data_race() 200 bytes copy may hide other issues.
>
> That is the harder part where I don=E2=80=99t think we have anything for =
that today. Macro, any suggestions? ASSERT_IGNORE_FIELD()?

There is no nice interface I can think of. All options will just cause
more problems, inconsistencies, or annoyances.

Ideally, to not introduce more types of macros and keep it consistent,
ASSERT_EXCLUSIVE_FIELDS_EXCEPT(var, ...) maybe what you're after:
"Check no concurrent writers to struct, except ignore the provided
fields".

This option doesn't quite work, unless you just restrict it to 1 field
(we can't use ranges, because e.g. vm_area_struct has
__randomize_layout). The next time around, you'll want 2 fields, and
it won't work. Also, do we know that 'shared.rb' is the only thing we
want to ignore?

If you wanted something similar to ASSERT_EXCLUSIVE_BITS, it'd have to
be ASSERT_EXCLUSIVE_FIELDS(var, ...), however, this is quite annoying
for structs with many fields as you'd have to list all of them. It's
similar to what you can already do currently (but I also don't
recommend because it's unmaintainable):

ASSERT_EXCLUSIVE_WRITER(orig->vm_start);
ASSERT_EXCLUSIVE_WRITER(orig->vm_end);
ASSERT_EXCLUSIVE_WRITER(orig->vm_next);
ASSERT_EXCLUSIVE_WRITER(orig->vm_prev);
... and so on ...
*new =3D data_race(*orig);

Also note that vm_area_struct has __randomize_layout, which makes
using ranges impossible. All in all, I don't see a terribly nice
option.

If, however, you knew that there are 1 or 2 fields only that you want
to make sure are not modified concurrently, ASSERT_EXCLUSIVE_WRITER +
data_race() would probably work well (or even ASSERT_EXCLUSIVE_ACCESS
if you want to make sure there are no writers nor _readers_).

Thanks,
-- Marco
