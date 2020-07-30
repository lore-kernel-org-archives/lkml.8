Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F32C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE3A20809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 18:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cs.washington.edu header.i=@cs.washington.edu header.b="aNmEAluR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgG3SxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 14:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbgG3SxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 14:53:17 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD3CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:53:17 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c16so11547996ils.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.washington.edu; s=goo201206;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=42l4ctj1Gypy+YF97+QpYMW91oh26x5wOMqUsgssC6s=;
        b=aNmEAluRstld+RIo7hQUz4NM8ImkejUWF/fEJtMXvDNc1ZLsHGVAj1sX3XZx8SHsBT
         DQnU61itpM1kTzbT6mU+RlB4m8Oj08Z/4BRq1prQZadsUGnlY7giifhAe0vxUFe3EFyZ
         bFf7SgKzakHLoGV7Jfie/FBaf3nE9fJVIOMJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=42l4ctj1Gypy+YF97+QpYMW91oh26x5wOMqUsgssC6s=;
        b=PdRjgHA91WNeMjIEtGmerbMogMGPtAyaJ/gBG65jDCfl2N1TQdKtlKM3MEHg3so+Bw
         R+MQXJCN4x+mvaNsT5GBFPBggErhjVTuFb71zgE9Em3BUPd+cyhiS4zbU2ZfZ/gqvk/C
         xtnQ4qaSzGF+QIlJh3l0o5LpCCswu0N8lXnTzfZbR4zjYWjRYGnjK+qNYZ0UuC28N/hC
         fecPGVtnm4YJ0nkwbBdDxNVRyMrdlHQ6DyaCx2I57GPjiPtW5amrhJ+O1GWNq64uTYcB
         OW8V1arYRGglNzkhW21XmiJbH/bnTWkcjUJuC7B50Sa+RVvWIu3XFykmUc5zd24Zqdr+
         cWLQ==
X-Gm-Message-State: AOAM531VEHD08GlKoZPmM4ClIeYMhvXBmgcpBrnZwTT64sFCf28rzeD8
        N5T9PLxNSxV7jXduz+loprA1jlZMUYEhXEzzvu7M8A==
X-Google-Smtp-Source: ABdhPJxSedzy/Q7HXRU/z9wJWqDWTBmt62c9ADo7O1Zj105UNNtxV6tpIvvZ5SGx50X91HnHl5zU5uT1AtbgwHDVVFY=
X-Received: by 2002:a92:918b:: with SMTP id e11mr29802679ill.201.1596135196772;
 Thu, 30 Jul 2020 11:53:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200722152422.72532-1-kernel@esmil.dk> <20200722152422.72532-2-kernel@esmil.dk>
In-Reply-To: <20200722152422.72532-2-kernel@esmil.dk>
From:   Luke Nelson <lukenels@cs.washington.edu>
Date:   Thu, 30 Jul 2020 11:53:06 -0700
Message-ID: <CADasFoDfRwcfFHM_Sa-HzwSDyXEr2PNu3Wfe5riwZJM9XsELBQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] riscv: Clean up module relocations
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Zong Li <zong@andestech.com>, Andreas Schwab <schwab@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Xi Wang <xi.wang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the patch!

> Also RISC-V has a number of instruction pairs to
> generate 32bit immediates or jump/call offsets. Eg.:
>
> lui   rd, hi20
> addi  rd, rd, lo12

On RV64, both hi20 from lui and lo12 from addi are sign-extended to 64 bits=
.
This means that there are some 32-bit signed offsets (in the range
[2^31-2^11, 2^31-1])
that are not encodable using (lui+addi), (auipc+jalr), etc. (see
discussion at [1]).

The following note is from the ISA manual:
>>> Note that the set of address offsets that can be formed by pairing LUI =
with LD,
>>> AUIPC with JALR, etc. in RV64I is [=E2=88=922^31=E2=88=922^11, 2^31=E2=
=88=922^11=E2=88=921].

The existing code and the new code both seem buggy if the offset happens to
be a 32-bit int but falls outside of the encodable range.

> +       if (offset !=3D (s32)offset) {
> [...]
> +       if (offset !=3D (s32)offset) {
> [...]

These checks should probably be replaced with something similar to
what's used in the RV64 BPF JIT here: [2],
except that this code should check if using RV32 or RV64, since the
encodable range differs for each.

> My hope is that we can eventually factor out the code to generate
> immediates and instructions so it can be reused both here, in the
> jump-label code and in the bpf-jit code, but let's take it
> one step at a time.

This sounds great! Having fewer copies of RISC-V encoding logic around will
hopefully decrease the likelihood of bugs :) Some other archs already
have shared
infrastructure for doing instruction encoding (e.g., in
arch/arm64/kernel/insn.c);
we should consider doing something similar for RISC-V.

- Luke Nelson

[1]: https://groups.google.com/a/groups.riscv.org/forum/#!topic/isa-dev/bwW=
FhBnnZFQ
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=
=3D489553dd13a88d8a882db10622ba8b9b58582ce4
