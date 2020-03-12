Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945F8C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C72C20674
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 21:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f+l+gXIK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbgCLVG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:06:59 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34837 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgCLVG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 17:06:59 -0400
Received: by mail-ot1-f65.google.com with SMTP id k26so7890315otr.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 14:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjIF8laC9ymQN6dGPb1ZYido+iVLQSJ80e27qnd6uTA=;
        b=f+l+gXIKYD8ZqIsbSKM4dLqAUjD21JGnao8P6oy+6Zmm9Rb8AXN6l/tS4s9RT9ecgP
         8OTh+Gt18uKCXrL2agzWwd/jaz4kTY1PcHwRp8AM/PzPPozlKad5X4ZfeHipH/tIBjxa
         99BbLEDknWH+7czLa5Ds6pxh1qQr+8L/YyNq5vH159Q93v9ftJQBMYn9MTLI0ylozz0g
         SxF6JBvVR6aRYy+G/pWJCbP5kvTgAoAwODj4DnUgeTdzCZUniI5BUzeE45A4/CVcJor4
         PJTNqoA2uuZZ4WpMILVN15YTIvUc7nqvO81ayj7Ez+wssmSZmgvM6o862uS0AIZwCaSh
         XIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjIF8laC9ymQN6dGPb1ZYido+iVLQSJ80e27qnd6uTA=;
        b=tvNhx8JKOVv0S0dkB9KkNYHGp2hjeTeheu4tCJ4UIEAqNCvVB/ITDTyJYT1YzlWZhx
         sVgOY0Iy30vjo6crAT39dd9ywTa6PdFZz2ajW4WYVBDYRgfoQU50yF8UO9aaBxY7Q/hU
         NwQWS89hMpPTJpVDLHaecMy3FzU9vMLmx2/zQylpb1LOgcuKmtmmLbS8WB0iqQSFZ/T1
         wHUSOu2IYu0IiS5cPkFjHXyPrNB5Hjed7W9IeCJDlCZNLoU7E3trqldqC/vg3axwPutb
         IFsKRQ1MFcZchh2uYeD6ZjZNyIIS7Q8v9kXcurloPpL/h2IYEyavHtIJ54XmysVuQ8lI
         tJaw==
X-Gm-Message-State: ANhLgQ0EIT8iqIOUj+XWNnhhzmGfg1Nb/t+aXCd/0C7+6P70Dn65U1UB
        aUs5e3bv3JfiChbb++4XvCzwNlBI5hskNH2FAufCAA==
X-Google-Smtp-Source: ADFU+vuorKp4Am1Eft4fdcP1G8Nf7OvlWyXXPJjJAuw2HysSDIhCcZVTlSzqZ6RrA6JxKhMxZ3B+h9vZHTYAu4IJG2I=
X-Received: by 2002:a9d:c24:: with SMTP id 33mr8191344otr.355.1584047218074;
 Thu, 12 Mar 2020 14:06:58 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000041c6c205a08225dc@google.com> <20200312182826.GG79873@mtj.duckdns.org>
In-Reply-To: <20200312182826.GG79873@mtj.duckdns.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Thu, 12 Mar 2020 14:06:47 -0700
Message-ID: <CAHS8izPySSO07dHi3OZ_1uXjmMCGnNMWey+o-qwFM7GnD7oSHw@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in cgroup_file_notify
To:     Tejun Heo <tj@kernel.org>
Cc:     syzbot <syzbot+cac0c4e204952cf449b1@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, andriin@fb.com,
        ast@kernel.org, bpf@vger.kernel.org, cgroups@vger.kernel.org,
        christian@brauner.io, daniel@iogearbox.net,
        Johannes Weiner <hannes@cmpxchg.org>, kafai@fb.com,
        open list <linux-kernel@vger.kernel.org>,
        Li Zefan <lizefan@huawei.com>, netdev@vger.kernel.org,
        sfr@canb.auug.org.au, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 11:28 AM Tejun Heo <tj@kernel.org> wrote:
>
> On Tue, Mar 10, 2020 at 08:55:14AM -0700, syzbot wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    c99b17ac Add linux-next specific files for 20200225
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1610d70de00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=6b7ebe4bd0931c45
> > dashboard link: https://syzkaller.appspot.com/bug?extid=cac0c4e204952cf449b1
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1242e1fde00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1110d70de00000
> >
> > The bug was bisected to:
> >
> > commit 6863de00e5400b534cd4e3869ffbc8f94da41dfc
> > Author: Mina Almasry <almasrymina@google.com>
> > Date:   Thu Feb 20 03:55:30 2020 +0000
> >
> >     hugetlb_cgroup: add accounting for shared mappings
>
> Mina, can you please take a look at this?
>

Gah, I missed the original syzbot email but I just saw this. I'll take a look.

> Thanks.

>
> --
> tejun
