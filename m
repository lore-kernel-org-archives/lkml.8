Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0833EC2BA16
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 12:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6DD8206F5
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 12:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RgVJg0wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgDDMMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 08:12:35 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39393 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgDDMMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 08:12:35 -0400
Received: by mail-oi1-f194.google.com with SMTP id d63so8697532oig.6
        for <linux-kernel@vger.kernel.org>; Sat, 04 Apr 2020 05:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jKltLIjkeugNXvKZ/WNOjs3yWnJYwRe4Lc/bVmXm/3E=;
        b=RgVJg0wgr143G4gyzDbbfm84LsLH3MP4SN7MaIkYorAoVDOBWyb/mqeqd/llZlUALK
         pLOIJVHAXJ7+DwM8KcJEYnfUrevmL8hDEkZ/97Bp0ubUMgkETckeKob2oHdooiBOjPr3
         rriSFYQXyrtdLZ63XdkfzTqKQnT0ak5J596o7hBoouU6OSZJZHm9fjqZkFJTSTYEbQS7
         7jpm0dVmQsP6BVViUdq/XOgAkGrqCq705tOsDII+pSJ/6Xp2C22g2JIm5HujNedbTOk/
         u2M1MideUCCoOEGi150OaW2iKtBiCAQTEXiz4tcpxZLbeOK+BimEdjw0BjbuYQ9r/WUl
         XMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jKltLIjkeugNXvKZ/WNOjs3yWnJYwRe4Lc/bVmXm/3E=;
        b=nRr2MGSRY1uuIJzblkj0PxUFgh/5KhccqFHJzLR5NRS4J5+rvye/By3Hf9IZAzSQ/x
         3zJTGovs1NbW9+mpAsgowoAxnA5sG68f2jP1YCoXRDmMUAJMt9LqQ8kDtB+yV+CLJqO3
         ExeBj6Bo48H+G3oUiZoK2oUckxXaucxUFHzYpj7HqhWrmtQmjUrlFr7ApsS6BXh26EMW
         fn46lH3vFVjKp3zx5+FQ/Q+prsFz7HEzvg5aqU4/5pW/aTCc4LrIMTmuVeMAyYIV5m08
         y8IKznIEJpQOr2Yw3xdXT2m+vNeXdgDSmdKPsourNibUgCQohuvPl9hOlIuzmpbF7BI2
         KwnQ==
X-Gm-Message-State: AGi0PuZdkXdMEht6L6e5kw8kAkS2Vnyn3Zp3JcyxRQVGMf5nRSJPVsiK
        tmuY9muj1mF/W49T7SQHVs04F+Z+c2M6Ixmv+4v8EA==
X-Google-Smtp-Source: APiQypKoUIArlv+AU+qdaFbGmgtLIA43dBjeqmsMapEs9zbS0kBYGn63b7pHIli+RFC4il0+K87DaAx7Q7EETQmoj+c=
X-Received: by 2002:a05:6808:56:: with SMTP id v22mr6104012oic.116.1586002354371;
 Sat, 04 Apr 2020 05:12:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583772574.git.zong.li@sifive.com> <d27d9e68491e1df67dbee6c22df6a72ff95bab18.1583772574.git.zong.li@sifive.com>
 <20200401003233.17fe4b6f7075e5b8f0ed5114@kernel.org> <CANXhq0ra3o+mgenbYLq_q0eZY2KiXNpWmo2V0amD0cFDqCQkXw@mail.gmail.com>
 <20200402101733.1ef240faeaeada6e4d38ae80@kernel.org> <CANXhq0rMbkNxQ3_qqYEKe8DSbL-vfQku6V9a81Hy9cxW4LaW9g@mail.gmail.com>
 <20200404121428.596911ba5653f8b18a80eab2@kernel.org>
In-Reply-To: <20200404121428.596911ba5653f8b18a80eab2@kernel.org>
From:   Zong Li <zong.li@sifive.com>
Date:   Sat, 4 Apr 2020 20:12:24 +0800
Message-ID: <CANXhq0rc+6jor7CMaa-zqSn3vNBdJhj3gD5wGxPkXAtVVHDHdQ@mail.gmail.com>
Subject: Re: [PATCH v3 8/9] riscv: introduce interfaces to patch kernel code
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 4, 2020 at 11:14 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Zong,
>
> On Fri, 3 Apr 2020 17:04:51 +0800
> Zong Li <zong.li@sifive.com> wrote:
>
> > > > > > +{
> > > > > > +     void *waddr = addr;
> > > > > > +     bool across_pages = (((uintptr_t) addr & ~PAGE_MASK) + len) > PAGE_SIZE;
> > > > > > +     unsigned long flags = 0;
> > > > > > +     int ret;
> > > > > > +
> > > > > > +     raw_spin_lock_irqsave(&patch_lock, flags);
> > > > >
> > > > > This looks a bit odd since stop_machine() is protected by its own mutex,
> > > > > and also the irq is already disabled here.
> > > >
> > > > We need it because we don't always enter the riscv_patch_text_nosync()
> > > > through stop_machine mechanism. If we call the
> > > > riscv_patch_text_nosync() directly, we need a lock to protect the
> > > > page.
> > >
> > > Oh, OK, but it leads another question. Is that safe to patch the
> > > text without sync? Would you use it for UP system?
> > > I think it is better to clarify "in what case user can call _nosync()"
> > > and add a comment on it.
> >
> > The ftrace is one of the cases, as documentation of ftrace said, when
> > dynamic ftrace is initialized, it calls kstop_machine to make the
> > machine act like a uniprocessor so that it can freely modify code
> > without worrying about other processors executing that same code. So
> > the ftrace called the _nosync interface here directly.
>
> Hmm, even though, since it already running under kstop_machine(), no
> other thread will run.
> Could you consider to use text_mutex instead of that? The text_mutex
> is already widely used in x86 and kernel/kprobes.c etc.
>
> (Hmm, it seems except for x86, alternative code don't care about
>  racing...)
>

Yes, text_mutex seems to be great. I'll change to use text_mutex in
the next version if it works fine after testing. Thanks.

> Thank you,
> --
> Masami Hiramatsu <mhiramat@kernel.org>
