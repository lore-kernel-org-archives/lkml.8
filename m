Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	TVD_SUBJ_WIPE_DEBT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25594C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E88AB20853
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:29:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgFIF3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgFIF3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:29:34 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D88BC03E969
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 22:29:34 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzFf057Gz9sTl; Tue,  9 Jun 2020 15:29:22 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        kbuild test robot <lkp@intel.com>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200518181043.3363953-1-natechancellor@gmail.com>
References: <87a7254bxd.fsf@mpe.ellerman.id.au> <20200518181043.3363953-1-natechancellor@gmail.com>
Subject: Re: [PATCH] input: i8042: Remove special PowerPC handling
Message-Id: <159168032784.1381411.6982899186952383628.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:29:22 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 11:10:43 -0700, Nathan Chancellor wrote:
> This causes a build error with CONFIG_WALNUT because kb_cs and kb_data
> were removed in commit 917f0af9e5a9 ("powerpc: Remove arch/ppc and
> include/asm-ppc").
> 
> ld.lld: error: undefined symbol: kb_cs
> > referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> > input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> > referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> > input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> > referenced by i8042-ppcio.h:28 (drivers/input/serio/i8042-ppcio.h:28)
> > input/serio/i8042.o:(__i8042_command) in archive drivers/built-in.a
> 
> [...]

Applied to powerpc/next.

[1/1] input: i8042 - Remove special PowerPC handling
      https://git.kernel.org/powerpc/c/e4f4ffa8a98c24a4ab482669b1e2b4cfce3f52f4

cheers
