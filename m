Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3783C4BA04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3D2C21927
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 22:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582671375;
	bh=+h9xKlFLgYhEyczCaUyPJkZiCHIfoFvJ1ayPYu405TU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P2+QxIYKiCk/RgsVvrv7y+AeFn2z1o5oc6wULMkMBMM5CByzlNRl1TyB8Bk0S98NE
	 /k/dzpTiZyjl/UUckvsP7GyiHi7zGicjZW6+m5gf9bXQwrOaplhx8YazlVcoBwQj5n
	 2AsFK7EUII+zdJqdQIP7xbg9CQe4xF3jGIT7E2UE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbgBYW4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:33096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgBYW4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 17:56:14 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CE98222C2;
        Tue, 25 Feb 2020 22:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582671374;
        bh=+h9xKlFLgYhEyczCaUyPJkZiCHIfoFvJ1ayPYu405TU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FQ/lLUfPE3Y6iEMnJeFYI7O3bSpPJzYSqchqXbsWTptclbvzgEGni5KQIAtG/PLlV
         vpU7Ky6hZB6Ax9AP2F1g0JD8eyKcFm4h0KuGhEIFfDjJFvp782sb8WACyZP8D1iPnj
         wD+4rfre84YvKkNZ7h03gKiw8EQo3ha5dR+C+39s=
Received: by mail-lj1-f178.google.com with SMTP id q8so770086ljb.2;
        Tue, 25 Feb 2020 14:56:13 -0800 (PST)
X-Gm-Message-State: APjAAAVJnR+6+z+XnNcDWCIxrej0sWSLQRiUBmrY5ok5lvOfxagbhSTY
        pVI4paI00Nt52DrxdzT3ZJ6zrZPXYqFPC8B6bR0=
X-Google-Smtp-Source: ADFU+vsNg2JOfLZxB3JnW3N6Gl76jJs9brnWPKuHNnRE6Lk4pMu5bmfrIitEcDFMK4trkYMgSF9pO9E3s4LLjQ3uOxA=
X-Received: by 2002:a2e:b017:: with SMTP id y23mr759482ljk.229.1582671371753;
 Tue, 25 Feb 2020 14:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20200220041608.30289-1-lukenels@cs.washington.edu>
 <CAPhsuW6c9g9QRKZWVLXZN27SKOxMBM2tPV3F+QM5sb6mtvseow@mail.gmail.com> <CADasFoBoEs+UArgqwQSqesKJhmvZEJP5so9nN-u9s6a3rQEUdA@mail.gmail.com>
In-Reply-To: <CADasFoBoEs+UArgqwQSqesKJhmvZEJP5so9nN-u9s6a3rQEUdA@mail.gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 25 Feb 2020 14:56:00 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5mdL6CHSCqqwQnm3V4URONoaamPCGUD9zHSz84h3X2GA@mail.gmail.com>
Message-ID: <CAPhsuW5mdL6CHSCqqwQnm3V4URONoaamPCGUD9zHSz84h3X2GA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next] RV32G eBPF JIT
To:     Luke Nelson <lukenels@cs.washington.edu>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiong Wang <jiong.wang@netronome.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Networking <netdev@vger.kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Song Liu <songliubraving@fb.com>, Xi Wang <xi.wang@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:37 AM Luke Nelson <lukenels@cs.washington.edu> wrote:
>
>
> > I found a lot of common code between RV32G and RV64G. Can we move
> > these code into a header file?
>
> Certainly! I was planning on doing this in a separate patch to minimize the changes
> to the RV64 JIT. I can also do it in another revision of this patch if that seems like a better idea.

I would recommend expand this patch into two patches: one patch moves
common code
to a header, the other adds logic for RV32G.

Thanks,
Song
