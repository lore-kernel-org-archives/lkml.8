Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673B0C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39354206A2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 11:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ezJOnc/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730454AbgDQLsv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 07:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730267AbgDQLsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 07:48:50 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2550C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 04:48:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 493Z9s1CRmz9sR4;
        Fri, 17 Apr 2020 21:48:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1587124129;
        bh=u64JoNPznSk/s1wlkLsaK0ZwwAoV7umGq+/7aZC3G2M=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ezJOnc/a+90kryN6h6AM6TUNXUbbAPB0090CGjSNgXlVDKaVnrwEU4ms7K3FQnEv2
         xBCXhBhgbKC5ZttvDuEXsfnDXVQMj4hJYWzqGzwXi8IfvQUQZ8SRu2qSVe3pZpm/U8
         DY2XUD/dTpuY2OPFuDfIddGRnrmpsoz84XN9RlX9BOuH2vh+/0yw3ZqZh97lO/dQ7Z
         M23e9CVphFDqBnlx3eZxPdYR86H67rk/BLT9vovU1EKWioQ3NegzDCMgJRA/sl0A0p
         qLmLNOTwqRvUN77YxPk3DDqa02YgTZ8h/TuklFX1Y+QKmnWF4Kf2uPMBWV6O9+/nbf
         WtEd9hppX7Zsg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Qian Cai <cai@lca.pw>, Russell Currey <ruscur@russell.cc>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: POWER9 crash due to STRICT_KERNEL_RWX (WAS: Re: Linux-next POWER9 NULL pointer NIP...)
In-Reply-To: <1587106774.1oa2whm69m.naveen@linux.ibm.com>
References: <15AC5B0E-A221-4B8C-9039-FA96B8EF7C88@lca.pw> <87eeszlb6u.fsf@mpe.ellerman.id.au> <0675B22E-8F32-432C-9378-FDE159DD1729@lca.pw> <20200407093054.3eb23e45@gandalf.local.home> <EA9F9A54-87BC-477A-BE8A-7D53F80C5223@lca.pw> <20200409101413.35d9c72d@gandalf.local.home> <06A2EA93-B730-4DB1-819F-D27E7032F0B3@lca.pw> <161662E3-5D9C-4C15-919C-CFEFE4CC35CB@lca.pw> <69F0448F-CA5B-497D-B8AF-2848175B9477@lca.pw> <1587106774.1oa2whm69m.naveen@linux.ibm.com>
Date:   Fri, 17 Apr 2020 21:49:02 +1000
Message-ID: <87blnqib81.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Naveen N. Rao" <naveen.n.rao@linux.ibm.com> writes:
> Hi Qian,
>
> Qian Cai wrote:
>> OK, reverted the commit,
>>=20
>> c55d7b5e6426 (=E2=80=9Cpowerpc: Remove STRICT_KERNEL_RWX incompatibility=
 with RELOCATABLE=E2=80=9D)
>>=20
>> or set STRICT_KERNEL_RWX=3Dn fixed the crash below and also mentioned in=
 this thread,
>>=20
>> https://lore.kernel.org/lkml/15AC5B0E-A221-4B8C-9039-FA96B8EF7C88@lca.pw/
>
> Do you see any errors logged in dmesg when you see the crash?=20=20
> STRICT_KERNEL_RWX changes how patch_instruction() works, so it would be=20
> interesting to see if there are any ftrace-related errors thrown before=20
> the crash.

I've been able to reproduce with STRICT_KERNEL_RWX=3Dy and concurrently
running:

# while true; do echo function > /sys/kernel/debug/tracing/current_tracer ;=
 echo nop > /sys/kernel/debug/tracing/current_tracer ; done

and:

# while true; do find /lib/modules/$(uname -r) -name '*.ko' -printf "%f\n" =
| sed -e "s/\.ko//" | xargs -i modprobe -va {}; lsmod | awk '{print $1}' | =
xargs -i modprobe -vr {}; done

ie. stressing module loading/unloading and ftrace at the same time.


It's not 100% but it usually reproduces within 10-20 minutes.

It looks like sometimes our __patch_instruction() fails, and then that
somehow leads to things getting further messed up. Presumably we have
some bad error handling somewhere.

cheers
