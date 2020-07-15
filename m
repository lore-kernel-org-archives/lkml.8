Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDDAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E645A2064C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9kDPOp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730277AbgGOIhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbgGOIhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:37:01 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C55C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:37:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so2735100pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h9e1W5rBzUoEq05vuDlOKs3gf+nXF7OhrK8kaajg1ac=;
        b=Z9kDPOp1FOu00FcZtAxKCCrC//M9z2MauO785jr35+alWbwgh31TLfIbwBkJwkJIx1
         DNJBfgyJ9K4mIlkkNFDwNTqHraFDPl2s5lCYSlYhBKGlVdVka6e4rH1SgjV1ZnBTQ0YA
         azRGUWkc56EmpFXB7K20gR36aLtQk8xdI18iHAl+vJsN1luj/w+rCYRlAV2tchpx6hw6
         Pjzg03n+odx2Bu3ArbeliphQl4nUcsSCkfHMtsTratpMsr0Qe0dauFhJPRSOQUej8c4Y
         frIzwbZKglsrzysOE35FuFf7tnHMlW/GOv9BHscJ8X77S0Nr3p8V6TQL//jqoocHl/s2
         bBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h9e1W5rBzUoEq05vuDlOKs3gf+nXF7OhrK8kaajg1ac=;
        b=NAvES21p842NGIG1jgAiQhhixLwcsl0EdX1fkYbSVMUOyNetfyUP+6ijUUfeWEDwBo
         fpYRNwbzRm/aJ9pMHFVjjTWjy0GWAUG1QhIsA9kt9hc99b+ExRX4yi+WgFuEaWc5a2U8
         zR67q+9rBAZEb8WSYLpr71YeLa4xRxaFrspYNH12J9K6gJEC2W+waffdZyzGqsaeAbBV
         qXRHxfl53mxuZ1ZJ4C4cRLC903TXB1WURSaUxEr6Ytd7fRKp9IKlTqPcdkX1/HQwvs48
         oV2DOXK/4Hkl28eOFp6+LfeGyigdJFSuyAlnXouNHmTU69aOk5b9J+4wq37jhjZeEHBp
         lFIA==
X-Gm-Message-State: AOAM533NyDl4JTRlODd0krsW8PQIzZu1c/bKb3wrsupmOGNTmfdp1g7i
        c5XFAm3k5mqjObp+cIyMwUNqpmAWtCFdRtvFsOcvxg==
X-Google-Smtp-Source: ABdhPJw3SeXd2XR4IrKqxKl7AKVabBH4FlMuqTRltcDQ7ODNjGBPkrxjgzPvvgHQkNyLh820BQ+mH8+NEnTOCNHJVqs=
X-Received: by 2002:a17:90b:1296:: with SMTP id fw22mr9071513pjb.20.1594802220226;
 Wed, 15 Jul 2020 01:37:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200704085213.444645-1-ignat@cloudflare.com>
In-Reply-To: <20200704085213.444645-1-ignat@cloudflare.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 15 Jul 2020 01:36:49 -0700
Message-ID: <CAFd5g44QK2L+Zkri9=mTFoLXTqdjORn-QATPomiKXkgZfA+wqw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] um: allow static linking for non-glibc libc implementations
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 1:52 AM Ignat Korchagin <ignat@cloudflare.com> wrote:
>
> This is a continuation of [1]. Since I was able to produce a working UML binary
> with UML_NET_VECTOR linked with musl with the changes included in the patches
> here. I was compiling on Arch Linux, so hopefully all the latest versions of
> the compiler, libraries and binutils.
>
> I also tested allyesconfig with both musl and glibc. The compilation succeeds
> with both, however both binaries (glibc one being dynamically linked) segfault
> on start. This is probably of some incompatible config option/module being
> included and not related to musl/glibc.
>
> [1]: https://patchwork.ozlabs.org/project/linux-um/patch/20200624212319.403689-1-ignat@cloudflare.com/
>
> Ignat Korchagin (3):
>   um/kconfig: introduce CC_CAN_LINK_STATIC_NO_RUNTIME_DEPS
>   um: some fixes to build UML with musl
>   um: allow static linking for non-glibc implementations
>
>  arch/um/Kconfig               |  2 +-
>  arch/um/drivers/Kconfig       |  3 ---
>  arch/um/drivers/daemon_user.c |  1 +
>  arch/um/drivers/pcap_user.c   | 12 ++++++------
>  arch/um/drivers/slip_user.c   |  2 +-
>  arch/um/drivers/vector_user.c |  4 +---
>  arch/um/os-Linux/util.c       |  2 +-
>  arch/x86/um/user-offsets.c    |  2 +-
>  init/Kconfig                  |  6 ++++++
>  scripts/cc-can-link.sh        |  5 +++--
>  10 files changed, 21 insertions(+), 18 deletions(-)

Sorry for taking so long to get to this. I saw this last week or
whenever and then forgot, saw the comments yesterday and remembered.

Looks pretty good overall. I will put my reviewed-by on each
individual patch. Nevertheless, I tested them all together, so being
lazy:

Tested-by: Brendan Higgins <brendanhiggins@google.com>
