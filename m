Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A15C11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0795B2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KqIfyeCv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727382AbgBXKwB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:52:01 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:50813 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726673AbgBXKwB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:52:01 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48QzQl4qKTz9sPk;
        Mon, 24 Feb 2020 21:51:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1582541519;
        bh=jc2MOo4RJ+14VTJRINC5R+uCJeUGpDuWdaViTSLxAg8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KqIfyeCv06Ng6IOFtBDJhgtKs/rQ0w+PVXFoe1SU4w047OD4BN3Mt570rHTfyP98U
         Lm9GqEpNTCUdr4ZPwIcy2vVw1vN35bBLGv5O6kgC1MKGv3QliImvPz6OsR0vnQBvDF
         WkCTd7Rcz5Xh4rsMiS4y76e8sPSUGFbmJNkyjHYF6oBKdFSHXnt01cjROXwoFTNCh4
         uJXLjwatNBiKj5V7Uk2PHCuHmstaMnkNVQneJ6/9yl8kQwlfrRjDJoRW06Q6g4qBzR
         U0nbuhunDdiF8w/1E/xLkOLN52i4jTzCI4k0n0G4WaWQJLqO0b+f4p5RGnXVhwBWFb
         BLcecUyA2GJ5w==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, mikey@neuling.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 04/12] powerpc/ptrace: split out VSX related functions.
In-Reply-To: <920fe735d5f3dd882331b36a895bb756bd415fe7.1561735587.git.christophe.leroy@c-s.fr>
References: <cover.1561735587.git.christophe.leroy@c-s.fr> <920fe735d5f3dd882331b36a895bb756bd415fe7.1561735587.git.christophe.leroy@c-s.fr>
Date:   Mon, 24 Feb 2020 21:51:59 +1100
Message-ID: <875zfw1cmo.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:
> diff --git a/arch/powerpc/kernel/ptrace/ptrace-novsx.c b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
> new file mode 100644
> index 000000000000..55fbbb4aa9d7
> --- /dev/null
> +++ b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
> @@ -0,0 +1,83 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +
> +#include <linux/kernel.h>
> +#include <linux/sched.h>
> +#include <linux/mm.h>
> +#include <linux/smp.h>
> +#include <linux/errno.h>
> +#include <linux/ptrace.h>
> +#include <linux/regset.h>
> +#include <linux/tracehook.h>
> +#include <linux/elf.h>
> +#include <linux/user.h>
> +#include <linux/security.h>
> +#include <linux/signal.h>
> +#include <linux/seccomp.h>
> +#include <linux/audit.h>
> +#include <trace/syscall.h>
> +#include <linux/hw_breakpoint.h>
> +#include <linux/perf_event.h>
> +#include <linux/context_tracking.h>
> +#include <linux/nospec.h>
> +
> +#include <linux/uaccess.h>
> +#include <linux/pkeys.h>
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/switch_to.h>
> +#include <asm/tm.h>
> +#include <asm/asm-prototypes.h>
> +#include <asm/debug.h>
> +#include <asm/hw_breakpoint.h>

I suspect we probably don't need all those headers anymore. But I guess
we'll clean them up in future, as it's very tedious work to trim the list.

> +
> +#include <kernel/ptrace/ptrace-decl.h>

It's preferable to use:

#include "ptrace-decl.h"

cheers
