Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742ACC3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CE84214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="X5H4VtDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbgCDHY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:24:29 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:42134 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgCDHY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:24:29 -0500
Received: by mail-io1-f66.google.com with SMTP id q128so1263532iof.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 23:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0StPfC8X5r/f0uwQzYAuENN0Fy4oQ3SfFfmaNBTQnc=;
        b=X5H4VtDyPvqJAdUJVPRhTnJNzg0cr0lXQnBxXOFBn70TvIaxwS7X1BhYAA6rW6iMx/
         2KL8fW6WmM9hvIfkxJ9HJLlSveCUGVutVFlbs/Dn3AB07u+7H4rIDUAkprO6clAYF+fk
         Yp/tkE8C0hW1UN84pzTDY8f0QLod+qUSCGqHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0StPfC8X5r/f0uwQzYAuENN0Fy4oQ3SfFfmaNBTQnc=;
        b=moKi/NMQ4rmrT9gQBkedRlHQ5M+2eq4UyifDj/N62cP/mDSCMYQD0eWiJ7e2UeLGPO
         ye1aWxNYtQdVmeZW4HsTVJGGJigXoAedlrN5mgGiq1Qb0avxysm5TECBm2GKMiir9+0B
         PuSzKDLkR2O4njeOBQ57/4abUMeMPixj0GyUxC25FVWcX62yobc5EC83QMqTq6ZArsq/
         Hg+yUrH/qhLjo/JvxxDkiQiY1UE2fYxHkE3scFZ2+P7GlrvkNwx4/CMp2FXNhUOLQ7nQ
         wqmeJLGiYjLGgf7BImkamb8RisOcov+V7INxDBX5fdCUI3oBw/cJuvDiEWxjhcDK37UP
         +PPA==
X-Gm-Message-State: ANhLgQ13ubg1ujes07ZyJbqgoc8m9AM2kjjNyGuqkzfUs68/I1HMgGl8
        urwnGTnmOfENYw8BVW8V+Xnptjqafy4VUcu92n34hg==
X-Google-Smtp-Source: ADFU+vtDP7J5I0uMr20ywNsGyuaqUtek9TyRHdnutO5YfvwGkuTKwFkRZeZRpw6nW1oXLNcQ+vXM+/g2FixK4+iaGBM=
X-Received: by 2002:a02:a1c9:: with SMTP id o9mr1543147jah.33.1583306668640;
 Tue, 03 Mar 2020 23:24:28 -0800 (PST)
MIME-Version: 1.0
References: <20200303005035.13814-1-luke.r.nels@gmail.com> <20200303005035.13814-3-luke.r.nels@gmail.com>
 <CAJ+HfNjgwVnxnyCTk5j+JCpxz+zmeEBYbj=_SueR750aAuoz=A@mail.gmail.com>
 <CADasFoBODSbgHHXU+iA-32=oKNs6n0Ff_UDU3063uiyGjx1xXg@mail.gmail.com> <CAJ+HfNhOp_Rbcqer0K=mZ8h+uswYSv4hSa3wCTdjjxH26HUTCw@mail.gmail.com>
In-Reply-To: <CAJ+HfNhOp_Rbcqer0K=mZ8h+uswYSv4hSa3wCTdjjxH26HUTCw@mail.gmail.com>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Tue, 3 Mar 2020 23:24:17 -0800
Message-ID: <CADasFoA3JN7PkvnVAmFZOFeDo2WgWzViankpwwRRWcjebSx+DQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] riscv, bpf: add RV32G eBPF JIT
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Luke Nelson <luke.r.nels@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Xi Wang <xi.wang@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I like that, but keep the first patch as a refactoring patch only, and
> then in a *new* patch 2 you add the rv32 specific code (sltu and
> pseudo instructions + the xlen preprocessor check + copyright-things
> ;-)).  Patch 3 will be the old patch 2. Wdyt?

Thanks! I'll make sure that patch 1 is for renaming bpf_jit_comp.c
and factoring code out. Do you think it's reasonable to add the
RV32-specific code to the header in the same patch that adds the
RV32 JIT implementation (patch 2)? It might make sense to commit
them together.

The full plan for v5 would be:

Patch 1

- Refactor existing code to bpf_jit.h and bpf_jit_core.c
  + Including the minor modifications to build_body() and
  bpf_int_jit_compile() (These are unrelated to RV32 and we could
  forego these tweaks).
  + Also making emit_insn and build_{prologue,epilogue} non-static
  and renaming them to be prefixed with "bpf_jit_".
- Rename bpf_jit_comp.c to bpf_jit_comp64.c

Patch 2

- Add the RV32 BPF JIT implementation to bpf_jit_comp32.c and
RV32-specific changes to bpf_jit.h.

Patch 3

- Update documentation.

Patch 4

- Update MAINTAINERS.

Thanks again,

Luke
