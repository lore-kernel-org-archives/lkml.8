Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0067C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80945206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 18:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DDOUO4J9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730098AbgFIS4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 14:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728189AbgFIS4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 14:56:11 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0971C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 11:56:10 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j12so13142389lfh.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Sovn/OPrY+fqAY2G15cBAcZT8ZasF9m/hWZkDmlXa/w=;
        b=DDOUO4J98ldgz1F2z6akht9ULhd8V2pqiVRaCzAVHcW3ewJC5edGqnPJhzdSAO2PHv
         N9bhkpSh/+ZBmcWFiEN16uVmeXlnCIu0OLmverbJPae0eLyyv/zxGiy9DcEekvq3W9f7
         Nl5kEycxTF4HwDvF/Vq+QbftA7rxY1xlWacvAwi7rIe2o8EKZjxIk+fCx+Ekgg+TVr3P
         4K/OPl5J4FvHevK08Zaq/5xgS1Kx5tI6/xYTzvMZI0aqvdiJvTbwbKQAtzmUxd2aZrqn
         s7h8fQY3JREEmLRRnvo6IVNgfuoXH68L5zGT6OeqeGN47jXeIDQ4XW7A6/zjkcd8gJZK
         7J7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Sovn/OPrY+fqAY2G15cBAcZT8ZasF9m/hWZkDmlXa/w=;
        b=UIryPPnU/JlOBCegeBLqGGfeoD+t8pgiDGaKqai0M2v1OuSjuu2ohsB8VJ4ynyem6U
         gw0+xHWQkiZU+CoODWeS2GM/GyWC/CifOXX6A8Ksm39yvBemVqKg0jHU2cucUHp6oLDy
         +CbteW08i7fArXpOtcvYbuLK2xj6KqZUNrV3wM6a502ULpq3pGKps8WEPbj6uH93lE53
         Bs4JajR7XLsSI2hMdWLEcqDmhM3E0SVWmjbE0QiDdpRDb2opcCvJeB7VNDMTeQHEo3bH
         M1yzMkiVdysZG21lLehWVyMrnV1Gigf6NhhjdozNE+lQAjUKcm94Qrq5TMtRTL2iqoSm
         ZLow==
X-Gm-Message-State: AOAM530Y2CiIH30WiGyMaFMTELa88KiSv78UwW1dCmzXjqC+Eu7EXfR3
        w3lUP6+B/wEA8XmWJkIcJ6vSxF9oEY5TjIcKOHf+QA==
X-Google-Smtp-Source: ABdhPJzM4hKwVo4xpCuiu7aoervgZ66BqrZql9PlMaNddjuHkEQkkfr5EMCh0Hg2wdXVuljwNBbjzuGeZStqNBVKszY=
X-Received: by 2002:a19:c751:: with SMTP id x78mr16410549lff.82.1591728969076;
 Tue, 09 Jun 2020 11:56:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200609174048.576094775@linuxfoundation.org> <20200609174051.488794266@linuxfoundation.org>
In-Reply-To: <20200609174051.488794266@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Jun 2020 00:25:56 +0530
Message-ID: <CA+G9fYukN5V1z3g6Qwe9K5xnnXEuFafWdqGfDA1Wj2iVstoxfw@mail.gmail.com>
Subject: Re: [PATCH 4.19 24/25] uprobes: ensure that uprobe->offset and
 ->ref_ctr_offset are properly aligned
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jun 2020 at 23:35, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> From: Oleg Nesterov <oleg@redhat.com>
>
> commit 013b2deba9a6b80ca02f4fafd7dedf875e9b4450 upstream.
>
> uprobe_write_opcode() must not cross page boundary; prepare_uprobe()
> relies on arch_uprobe_analyze_insn() which should validate "vaddr" but
> some architectures (csky, s390, and sparc) don't do this.
>
> We can remove the BUG_ON() check in prepare_uprobe() and validate the
> offset early in __uprobe_register(). The new IS_ALIGNED() check matches
> the alignment check in arch_prepare_kprobe() on supported architectures,
> so I think that all insns must be aligned to UPROBE_SWBP_INSN_SIZE.
>
> Another problem is __update_ref_ctr() which was wrong from the very
> beginning, it can read/write outside of kmap'ed page unless "vaddr" is
> aligned to sizeof(short), __uprobe_register() should check this too.
>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Tested-by: Sven Schnelle <svens@linux.ibm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> ---
>  kernel/events/uprobes.c |   16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -612,10 +612,6 @@ static int prepare_uprobe(struct uprobe
>         if (ret)
>                 goto out;
>
> -       /* uprobe_write_opcode() assumes we don't cross page boundary */
> -       BUG_ON((uprobe->offset & ~PAGE_MASK) +
> -                       UPROBE_SWBP_INSN_SIZE > PAGE_SIZE);
> -
>         smp_wmb(); /* pairs with the smp_rmb() in handle_swbp() */
>         set_bit(UPROBE_COPY_INSN, &uprobe->flags);
>
> @@ -911,6 +907,15 @@ static int __uprobe_register(struct inod
>         if (offset > i_size_read(inode))
>                 return -EINVAL;
>
> +       /*
> +        * This ensures that copy_from_page(), copy_to_page() and
> +        * __update_ref_ctr() can't cross page boundary.
> +        */
> +       if (!IS_ALIGNED(offset, UPROBE_SWBP_INSN_SIZE))
> +               return -EINVAL;
> +       if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))

stable-rc 4.19 build failure for x86_64, i386 and arm.
make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Dx86 HOSTCC=3Dgcc
CC=3D"sccache gcc" O=3Dbuild

75 #
76 In file included from ../kernel/events/uprobes.c:25:
77 ../kernel/events/uprobes.c: In function =E2=80=98__uprobe_register=E2=80=
=99:
78 ../kernel/events/uprobes.c:916:18: error: =E2=80=98ref_ctr_offset=E2=80=
=99
undeclared (first use in this function); did you mean
=E2=80=98per_cpu_offset=E2=80=99?
79  916 | if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
80  | ^~~~~~~~~~~~~~
81 ../include/linux/kernel.h:62:30: note: in definition of macro =E2=80=98I=
S_ALIGNED=E2=80=99
82  62 | #define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
83  | ^
84 ../kernel/events/uprobes.c:916:18: note: each undeclared identifier
is reported only once for each function it appears in
85  916 | if (!IS_ALIGNED(ref_ctr_offset, sizeof(short)))
86  | ^~~~~~~~~~~~~~
87 ../include/linux/kernel.h:62:30: note: in definition of macro =E2=80=98I=
S_ALIGNED=E2=80=99
88  62 | #define IS_ALIGNED(x, a) (((x) & ((typeof(x))(a) - 1)) =3D=3D 0)
89  | ^
90 make[3]: *** [../scripts/Makefile.build:304: kernel/events/uprobes.o] Er=
ror 1

--
Linaro LKFT
https://lkft.linaro.org
