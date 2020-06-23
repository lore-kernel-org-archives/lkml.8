Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C4EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D1E22072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731611AbgFWH3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:29:42 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38313 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731547AbgFWH3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:29:40 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MqZE0-1j15Ck2VDU-00me7Z for <linux-kernel@vger.kernel.org>; Tue, 23 Jun
 2020 09:29:38 +0200
Received: by mail-qv1-f52.google.com with SMTP id d12so9232921qvn.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 00:29:38 -0700 (PDT)
X-Gm-Message-State: AOAM5324PO5P+HFq27Yt/Wji+KDMVt5mz2GhEKv31+Ru2qXnnv2E4mcy
        tWBPFJK6TP0PZ1pW2GrdpJBOEfza0jlofZYr+nM=
X-Google-Smtp-Source: ABdhPJzjlRBoHZR9GcNE5/qkGwbBsJCgbkV8+pXhkUlrRsDkq4pzT3YrjStQaZfeOqbW5DNjXIp6bHI22SV4czm23XY=
X-Received: by 2002:a0c:ba0e:: with SMTP id w14mr25299097qvf.222.1592897377432;
 Tue, 23 Jun 2020 00:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200623065744.18393-1-rppt@kernel.org>
In-Reply-To: <20200623065744.18393-1-rppt@kernel.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 23 Jun 2020 09:29:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1gsE8AbcYEu=MKYwYqc_AsPGcA_oBcePg_RS7UjdDh4g@mail.gmail.com>
Message-ID: <CAK8P3a1gsE8AbcYEu=MKYwYqc_AsPGcA_oBcePg_RS7UjdDh4g@mail.gmail.com>
Subject: Re: [PATCH 0/8] remove unicore32 support
To:     Mike Rapoport <rppt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Guan Xuetao <gxt@pku.edu.cn>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:q7okKZlL+/EvXtQVt7rDhgVgSOYy9epYHdaw3Ky9xoUcZBXVFq8
 kz4co4P2UXR5XCxgH4N8jX1tAajW3Kjy/nVrn+brd6ISElkJc5TqEoKnQiVT9t7zbfmVWzy
 zRmmrEVvXwh2IMIlD3JQhnOSK1W9HdNe/pkLLUPdYReJuuu3VeSwyHLgrkwneVrBR8EppRU
 yKvQSk9AAIxTXwQTmYWiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cr459Vo/5Ms=:S+kqGEjP38OBCdFK89cjE6
 zs3px56Gdw+D2FZ/ZmD1PrwYdR215tsksPLPsKRLelYtyXlHOdKts0RHxSMuRnZYE2r6xmRYV
 EQ23UrrZsqaifnPQJKl2y/kZz07FRFFb9a+/8pcAbQUq16so1TYPo3Y87CKt/nE0VC19Dq45j
 f2Vzma6Z8EmvWsoO5Dnuflvup1Qt18m8njk4oifdN5qQ+oiNtkI3qcq/24dRIO7kvmBvtSl/k
 O+fCSjqZD/WuMdM2bfhNUo8mP9F2AErETwOeJd8sq57OChMa2PjEj2AA6S6nTeMiiUHrYCMv5
 yo7m55JoYUpRnUUWNyeHc7phLfOiUz2zsT61YFYSlJntMYCQoYPGvU2nnKwSfqxV4a4IqyVR8
 wPprV/TQlTsa1XVordri9BsDQvX6DCjahxEl5Nal6b0EAJiq50nRrTi1hb6AHRdAv96tYifPS
 CVVMefF665hvG3MgiMOffxsVjlnYZcjEy/PBRvXgl4ajZDgnc5v8cYEL8IcgFCpir9fQ5WDwu
 ULnaE5wkVZgv+BYkxx8IdVk3ubO6iIG5gOwoLdfo1kaz5HOaZazx0GvYmkuqF5b2t3OKKmSY8
 +E1D6jctLXKZFE5fH4q1J+68Vgvux7XTFysI3Wf7sb0NAhoLuyNGmR3x2Q6oPyEvD8Hoh24he
 14KAZZ5ndkgAj8gq4OWTdOR9wjrIaI0oiOucRaYZdPhJp4uqdRhkDdUZt4quOiTN1nFJZ452m
 R2dmx7nSIE0FDMQhs5/DrC5Z9Ee60G57XkSsnwwNdpriKdmIGz5X3/nzsaT6RiH+KH5t/DSvS
 wjpbSmmsWu6iYfwiw+qDwrc/DJq87nAeAROV65aqdRAZtkVi9w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 8:57 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> The unicore32 port do not seem maintained for a long time now, there is no
> upstream toolchain that can create unicore32 binaries and all the links to
> prebuilt toolchains for unicore32 are dead. Even compilers that were
> available are not supported by the kernel anymore.

Peter Maydell also brought this up recently, since there is also a stale
qemu port.

I agree in principle that this port is about as dead as it gets and presumably
nobody has attempted running a kernel later than linux-4.9 nor will they
do that in the future. I see that the hardware support was never fully completed
either, with at least the "PKUnity-v3-UMAL" ethernet driver getting submitted
in 2011 but never merged and no public information on a driver for the
"PKUnity-v3-MMC" device that presumably holds the rootfs and the
"PKUnity-v3-UART" device.

However, it's worth pointing out two arguments against removal:

- Guan Xuetao is still listed as maintainer and asked for the port to be
   kept around the last time I suggested removing it two years ago.
   He promised that there would be compiler sources (llvm I think), but
   has not made those available since.

- https://github.com/gxt has patches to linux-4.9 and qemu-2.7, both
  released in 2016, with patches dated early 2019. These patches mainly
  restore a syscall ABI that was never part of mainline Linux but apparently
  used in production. qemu-2.8 removed support for that ABI and
  newer kernels (4.19+) as you say can no longer be built with the old
  toolchain, so I would guess there will not be any future updates to that
  git tree.

With that information added to the pull request and the maintainer
added to Cc:

Acked-by: Arnd Bergmann <arnd@arndb.de>
