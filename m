Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5CAC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2419320848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bL0rN4Kf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgCCXIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:08:31 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33473 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727274AbgCCXIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:08:31 -0500
Received: by mail-wr1-f65.google.com with SMTP id x7so83625wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 15:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=md2BYb9P2sgTueQnTV1sot78Pxk1E9kFXfWpP8gF5yo=;
        b=bL0rN4KffsmujAapE6Xq6kZfhV3VcTDZ1COtutwR9rNY5jr02zBrrfyq4rLaamlsrK
         anI/WpzSSigQW0om+ZuLWr/FOvNb24KY18jxSmC0/GUllziMVhVnKxK/hF/s9VFZgq41
         SBtIdJvZ3VscTtTGWXFp/gXuHhvCrHrX/wV6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=md2BYb9P2sgTueQnTV1sot78Pxk1E9kFXfWpP8gF5yo=;
        b=WEaQkw3+SjxLgzTs1zRYDeITnn1AVIFdo7b81stIc9q38cqh4uM9NeSCZsB//DVCH0
         zw8bphRsPCDJn4q5qIxIA44ZkGdqU0NpAjvzDQmm5o5bm0R8O2AJXjzh0I2pSZs2m7lu
         FaMInLFuh9qPi6gXthKGQMscb4bzY7kEuN+xWZUFR/j3pesuI1dA6IPrO7mPMmBByyQu
         KA7SQreUkDHQdruj9XL0uPlV0TsA6tkhn5dKC/FTBu14JA+CbZ2kpaiEEs9pcQVWMJNg
         iJ7dafwZszDcgHZlRityaVQilN+MybaEx+Q+U+YQ6AQviNFt82PeVt+SESjkBdrLaTwI
         ey4w==
X-Gm-Message-State: ANhLgQ2h6ZZLD9RctNX7tLLFTKLKIxP6zXbgCrD4+GYJko7/I01iKiN4
        uwymQe59zQcV/LjQMV5pmIzaWQ==
X-Google-Smtp-Source: ADFU+vtiy568ut/PM6Ax80mYv/H0qjTHKi5cOB3MttmOmryIFYjfkTs5GQl/7KauydEk7nFMdkjE8Q==
X-Received: by 2002:adf:f041:: with SMTP id t1mr309384wro.98.1583276909001;
        Tue, 03 Mar 2020 15:08:29 -0800 (PST)
Received: from chromium.org (77-56-209-237.dclient.hispeed.ch. [77.56.209.237])
        by smtp.gmail.com with ESMTPSA id t133sm994783wmf.31.2020.03.03.15.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 15:08:28 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 4 Mar 2020 00:08:26 +0100
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>
Subject: Re: [PATCH bpf-next 1/7] bpf: Refactor trampoline update code
Message-ID: <20200303230826.GA17103@chromium.org>
References: <20200303140950.6355-1-kpsingh@chromium.org>
 <20200303140950.6355-2-kpsingh@chromium.org>
 <CAEf4BzZj1+G7D2eZ9Enp_FtmmNPEkX7f6BDj2q=iZ1D8ZxxTMQ@mail.gmail.com>
 <20200303222433.GA3272@chromium.org>
 <CAEf4BzZey65RjDtAWojvtnakQgNiids4x8R-Hak6pZW1BqUfaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZey65RjDtAWojvtnakQgNiids4x8R-Hak6pZW1BqUfaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-Mär 15:03, Andrii Nakryiko wrote:
> On Tue, Mar 3, 2020 at 2:24 PM KP Singh <kpsingh@chromium.org> wrote:
> >
> > On 03-Mär 14:12, Andrii Nakryiko wrote:
> > > On Tue, Mar 3, 2020 at 6:13 AM KP Singh <kpsingh@chromium.org> wrote:
> > > >
> > > > From: KP Singh <kpsingh@google.com>
> > > >
> > > > As we need to introduce a third type of attachment for trampolines, the
> > > > flattened signature of arch_prepare_bpf_trampoline gets even more
> > > > complicated.
> > > >
> > > > Refactor the prog and count argument to arch_prepare_bpf_trampoline to
> > > > use bpf_tramp_progs to simplify the addition and accounting for new
> > > > attachment types.
> > > >
> > > > Signed-off-by: KP Singh <kpsingh@google.com>
> > > > ---
> > > >  arch/x86/net/bpf_jit_comp.c | 31 +++++++++---------
> > > >  include/linux/bpf.h         | 13 ++++++--
> > > >  kernel/bpf/bpf_struct_ops.c | 13 +++++++-
> > > >  kernel/bpf/trampoline.c     | 63 +++++++++++++++++++++----------------
> > > >  4 files changed, 75 insertions(+), 45 deletions(-)
> > > >
> > > > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > > > index 9ba08e9abc09..15c7d28bc05c 100644
> > > > --- a/arch/x86/net/bpf_jit_comp.c
> > > > +++ b/arch/x86/net/bpf_jit_comp.c
> > > > @@ -1362,12 +1362,12 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog, int nr_args,
> > > >  }
> > > >
> > > >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> > > > -                     struct bpf_prog **progs, int prog_cnt, int stack_size)
> > > > +                     struct bpf_tramp_progs *tp, int stack_size)
> > >
> > > nit: it's `tp` here, but `tprogs` in arch_prepare_bpf_trampoline. It's
> > > minor, but would be nice to stick to consistent naming.
> >
> > I did this to ~distinguish~ that rather than being an array of
> > tprogs it's a pointer to one of its members e.g.
> > &tprogs[BPF_TRAMP_FEXIT]).
> >
> > I change it if you feel this is not a valuable disntinction.
> 
> I think it's important distinction, but naming doesn't really help
> with it... Not sure how you can make it more clear, though.

I would prefer to keep the naming distinction. Hope that's okay with
you.

> >

[...]


> > >
> > count. Am I missing something :)
> 
> Ok, so it's setting entry 0 in bpf_tramp_progs->progs array, right?
> Wouldn't it be less mind-bending and confusing written this way:
> 
> tprogs[BPF_TRAMP_FENTRY].progs[0] = prog;

Definitely much cleaner/less mind bending :) Updated. Thanks!

- KP

> 
> ?
> 
> Syntax you used treats fixed-length progs array as a pointer, which is
> valid C, but not the best C either.
> 

[...]

> >
> > > [...]
