Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E0AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A26C2070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K58RlRZD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgHCJSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCJSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:18:35 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F59C06174A;
        Mon,  3 Aug 2020 02:18:35 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i6so1063668edy.5;
        Mon, 03 Aug 2020 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=46M9GTuupRoqORbP6h7ufZ9lnCPLcka6ykEe3C8miaE=;
        b=K58RlRZDzEJdyNlkLyQ5zWl16F8RtVjEGm6rvkJV5sjSQY/5XkkadLKujpSWVvKrO/
         ckzqiGQTKNGQD4pFRPoRcB9WOO4KBIsO1bXCo0chKtZCYa65Q/ogBqccdco5DaW5ZMwk
         7NM1VMr/SDRjK+UrQe4uMJ2Y4DeyLxoZyCYygG050QWFXIPzwCNFGhZuY1osORHmhIGl
         VZPMs26Pnmz8jhJUgWvSpOLGLPDMRPUPemXzpeYbBpevNcvrmEWSt2hKM3DpRct9jyzd
         yPlRFLQKwk5egQf25jaqiu0AEFGQG4JQYkIrZvAQb+GB91O6poCUejzt8NvZlS2H0eJi
         Qniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=46M9GTuupRoqORbP6h7ufZ9lnCPLcka6ykEe3C8miaE=;
        b=Cey5jNOtyq//Finpao2jfi3G2JJQw66jROvABqjYoOpj3YczNWC2sXSHlt1xJB5KNf
         kFWkom/J537C+9WeqK+25r0vGZNxeliK5rHgf1MCQlQ1yeKAi+v3Ygqrcf11/huA9sBm
         xwtg/UIovUHG5zff0uYskFTRxU0DU/LFdAtKdlXwqJvgqRqBEa2Z/nP0I1SDSlzDlU4J
         Vh+YHAhCqcKaY96hyFj6gyn0ofqn14HCPujh3eKDI99zmQ8z7dfCcnirfkWDyilR3juH
         ha06sxR+FghQxyEbOBjRt3te1J+RExbcI3gdGPTPSMKREIMRoitXN//+isJdnWaZgWxi
         jg6A==
X-Gm-Message-State: AOAM5300v1tdM1bjWi9bKs6qlmYBD9nfUFPFUiecyCcmvloLTfz+OrwP
        V3TD10PW50yb7OgZIuT12IWK29XRBUpj5ETSNQkW5XYG
X-Google-Smtp-Source: ABdhPJyyHfbD61tN/3AhYPMubo/h0lYN4jLerOOjrTGcwVq91nJgb/vCJdEHEsn+B+d3ZW/9ZCz+P3Rz+GNPWQd8ZtY=
X-Received: by 2002:aa7:d1cc:: with SMTP id g12mr15296352edp.385.1596446313888;
 Mon, 03 Aug 2020 02:18:33 -0700 (PDT)
MIME-Version: 1.0
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Mon, 3 Aug 2020 12:18:23 +0300
Message-ID: <CADxRZqzyxzN9yC79kjhtdpL9QT6ybgTsSCb3G1U8zJHZy-W_9w@mail.gmail.com>
Subject: [sparc64] unable to build v5.8 / master on sparc64 , bisect attached
To:     Sparc kernel list <sparclinux@vger.kernel.org>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I'm unable to build kernel (master git) with the following messages:

linux-2.6$ make
...
  CC      crypto/drbg.o
In file included from ./arch/sparc/include/asm/percpu_64.h:11,
                 from ./arch/sparc/include/asm/percpu.h:5,
                 from ./include/linux/random.h:14,
                 from ./include/crypto/drbg.h:43,
                 from crypto/drbg.c:100:
./arch/sparc/include/asm/trap_block.h:54:39: error: =E2=80=98NR_CPUS=E2=80=
=99
undeclared here (not in a function)
   54 | extern struct trap_per_cpu trap_block[NR_CPUS];
      |                                       ^~~~~~~
make[1]: *** [scripts/Makefile.build:281: crypto/drbg.o] Error 1
make: *** [Makefile:1756: crypto] Error 2

can someone help me please? Thanks.

git bisect log:

git bisect start
# bad: [bcf876870b95592b52519ed4aafcf9d95999bc9c] Linux 5.8
git bisect bad bcf876870b95592b52519ed4aafcf9d95999bc9c
# good: [92ed301919932f777713b9172e525674157e983d] Linux 5.8-rc7
git bisect good 92ed301919932f777713b9172e525674157e983d
# bad: [0ae3495b6502cf93634cbd027cb2f6f9f83a406f] Merge tag
'for-linus-2020-08-01' of
git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
git bisect bad 0ae3495b6502cf93634cbd027cb2f6f9f83a406f
# bad: [aa54ea903abb02303bf55855fb51e3fcee135d70] ARM: percpu.h: fix build =
error
git bisect bad aa54ea903abb02303bf55855fb51e3fcee135d70
# good: [c2f3850df7f95537e79c561f7be49df2e4ad8060] Merge tag
'drm-fixes-2020-07-29' of git://anongit.freedesktop.org/drm/drm into
master
git bisect good c2f3850df7f95537e79c561f7be49df2e4ad8060
# bad: [0513b9d75c07cbcdfda3778b636d3d131d679eb1] Merge tag
'io_uring-5.8-2020-07-30' of git://git.kernel.dk/linux-block
git bisect bad 0513b9d75c07cbcdfda3778b636d3d131d679eb1
# good: [d3590ebf6f91350192737dd1d1b219c05277f067] Merge tag
'audit-pr-20200729' of
git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit
git bisect good d3590ebf6f91350192737dd1d1b219c05277f067
# good: [4ae6dbd683860b9edc254ea8acf5e04b5ae242e5] io_uring: fix
lockup in io_fail_links()
git bisect good 4ae6dbd683860b9edc254ea8acf5e04b5ae242e5
# bad: [1c9df907da83812e4f33b59d3d142c864d9da57f] random: fix circular
include dependency on arm64 after addition of percpu.h
git bisect bad 1c9df907da83812e4f33b59d3d142c864d9da57f
