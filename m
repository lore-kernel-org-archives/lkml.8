Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02ABC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F86220825
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 15:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="bEyFs82H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgESPAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 11:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgESPAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 11:00:44 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4789C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:00:43 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id l5so5271175edn.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 08:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olWeaL9L3Th4SH3qpwoevbMzoFhixmGWtefArTEgTk4=;
        b=bEyFs82H4jPOzYgYPlYzidt1XghxF9RQPbBVSYNlHHo+64d1MNTn8faNwlkFFp8XOf
         gG93TwfVwkG1x1SYSw+sjMMWFJkF7MEU4WVXqVGtcdcINUqMvvJ0+cCULgJtCQLQs61K
         vXj6dXSp1aRiCwt0AazexjVnkE4ZNAkpCDQS9XxiM0RaP1T3r5NtDEln4DdTvI5ROC75
         IyyM7+pvwZ7/s+bKvbD/iAAfpgQHgYVyLMUKpVP+x5wk348rr8fMWFwaLt3cdSNfwjEe
         PHIFvD/DButvkbeAQN6sl0IFWPv3XAMn/cdJYslshqL4n0Fjc65uCPcTOXm8wnzgg8Ac
         dmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olWeaL9L3Th4SH3qpwoevbMzoFhixmGWtefArTEgTk4=;
        b=HNLK/4Uj6R7nFN25XmbiSHRKE9EK/CqwN5Ie1WARukVGYkiVdWcqeZvSDNtbaxGyQl
         w1FkqTSUAYXiWCzxjYk1OHX7EoTgTVsTzrMtZWMfX0WwDndq1xCxM85FoSBA8k0mECks
         RWm6q4JLUBbZJVMiRz++bY/AYLQtgqDUQAcyNsYLDJjeCo52aHWPSXbxmUTY6Mx8nZ29
         ScX8VQCy8P1aUyqs5k92epf9weLkZ/D2p4wVAgfRPvVI8quT8LI2GsEhhYubu1Lb2LQA
         mg6FAXlGiTyn9tiYumRo28S2PL8Ot+Rwkx1zuzQRP/1M4tFC/RF+JPsOsyQlzyV6r7ik
         /h9Q==
X-Gm-Message-State: AOAM5324QGfkV6yh86IhsvsOSVbIY5pKLMrC6snzzBRfYHFh1NvBfGQg
        YBKlbkrcCsoD+mhpMd4PxNc9QG4ABvxQWcQuy2TWgA==
X-Google-Smtp-Source: ABdhPJz+lhIpPKFIwyc4CnD865mj0YwvB2BjckQu7J/mXksfcTixa7jQ+FQ7BA5W++Bj57SzGGXmJbtqvWOZOvNVKQg=
X-Received: by 2002:a50:ee1a:: with SMTP id g26mr17925721eds.18.1589900442359;
 Tue, 19 May 2020 08:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAG=TAF6mfrwxF1-xEJJ9dL675uMUa7RZrOa_eL2mJizZJ-U7iQ@mail.gmail.com>
 <CAEf4BzazvGOoJbm+zNMqTjhTPJAnVLVv9V=rXkdXZELJ4FPtiA@mail.gmail.com>
 <CAG=TAF6aqo-sT2YE30riqp7f47KyXH_uhNJ=M9L12QU6EEEfqQ@mail.gmail.com> <CAEf4BzaBfnDL=WpRP-7rYFhocOsCQyFuZaLvM0+k9sv2t_=rVw@mail.gmail.com>
In-Reply-To: <CAEf4BzaBfnDL=WpRP-7rYFhocOsCQyFuZaLvM0+k9sv2t_=rVw@mail.gmail.com>
From:   Qian Cai <cai@lca.pw>
Date:   Tue, 19 May 2020 11:00:31 -0400
Message-ID: <CAG=TAF5rYmMXBcxno0pPxVZdcyz=ik-enh03E-V8wupjDS0K5g@mail.gmail.com>
Subject: Re: UBSAN: array-index-out-of-bounds in kernel/bpf/arraymap.c:177
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Linux Netdev List <netdev@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 8:25 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, May 18, 2020 at 5:09 PM Qian Cai <cai@lca.pw> wrote:
> >
> > On Mon, May 18, 2020 at 7:55 PM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > >
> > > On Sun, May 17, 2020 at 7:45 PM Qian Cai <cai@lca.pw> wrote:
> > > >
> > > > With Clang 9.0.1,
> > > >
> > > > return array->value + array->elem_size * (index & array->index_mask);
> > > >
> > > > but array->value is,
> > > >
> > > > char value[0] __aligned(8);
> > >
> > > This, and ptrs and pptrs, should be flexible arrays. But they are in a
> > > union, and unions don't support flexible arrays. Putting each of them
> > > into anonymous struct field also doesn't work:
> > >
> > > /data/users/andriin/linux/include/linux/bpf.h:820:18: error: flexible
> > > array member in a struct with no named members
> > >    struct { void *ptrs[] __aligned(8); };
> > >
> > > So it probably has to stay this way. Is there a way to silence UBSAN
> > > for this particular case?
> >
> > I am not aware of any way to disable a particular function in UBSAN
> > except for the whole file in kernel/bpf/Makefile,
> >
> > UBSAN_SANITIZE_arraymap.o := n
> >
> > If there is no better way to do it, I'll send a patch for it.
>
>
> That's probably going to be too drastic, we still would want to
> validate the rest of arraymap.c code, probably. Not sure, maybe
> someone else has better ideas.

This works although it might makes sense to create a pair of
ubsan_disable_current()/ubsan_enable_current() for it.

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 11584618e861..6415b089725e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -170,11 +170,16 @@ static void *array_map_lookup_elem(struct
bpf_map *map, void *key)
 {
        struct bpf_array *array = container_of(map, struct bpf_array, map);
        u32 index = *(u32 *)key;
+       void *elem;

        if (unlikely(index >= array->map.max_entries))
                return NULL;

-       return array->value + array->elem_size * (index & array->index_mask);
+       current->in_ubsan++;
+       elem = array->value + array->elem_size * (index & array->index_mask);
+       current->in_ubsan--;
+
+       return elem;
 }
