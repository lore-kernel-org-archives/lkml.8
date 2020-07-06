Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BFDC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE0020760
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 18:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594060520;
	bh=L1CbjDcZbuTi+ztU4KBMPGZHPbJI+hhe3kCcYygI0o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=u5JWnjcOJpFzV59TV60X3rfJjBqFBOnNsSJExFpMMDswEgX+KyFTalc0YPVb8Eaku
	 FI9M98ufSkNPHyXeo9oM7ENXeIHKF/2BPaHykSMQiB6tmU2HeDF4ZfdjjwKVmOjXJy
	 bvvOEU5jcYKM4mWEIZM2AJaEZoH4E/4kAMlm1KDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729797AbgGFSfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 14:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:37852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729550AbgGFSfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 14:35:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2248206DF;
        Mon,  6 Jul 2020 18:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594060518;
        bh=L1CbjDcZbuTi+ztU4KBMPGZHPbJI+hhe3kCcYygI0o0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pihAVQPmOe+iFKvXzWEZmccOMAFXbtPUIoeXKLuLZyeXrYbyOJ6cXySu9bEogjbdh
         cLDn9jzGmTenZvCFTagNnHqffzlsPGhOGmvjuOt5phD9ZUcu+P3pwzmspR82n/YyNp
         ck5o8VKYVnNWweouqlXuNVXDuMhuL9ES7pvNRgzU=
Date:   Mon, 6 Jul 2020 19:35:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Sami Tolvanen <samitolvanen@google.com>,
        Matt Turner <mattst88@gmail.com>, kernel-team@android.com,
        Marco Elver <elver@google.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-arm-kernel@lists.infradead.org,
        Richard Henderson <rth@twiddle.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-alpha@vger.kernel.org
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200706183510.GA23766@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <20200706160820.GC10992@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706160820.GC10992@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 05:08:20PM +0100, Dave Martin wrote:
> On Tue, Jun 30, 2020 at 06:37:34PM +0100, Will Deacon wrote:
> > diff --git a/arch/arm64/include/asm/rwonce.h b/arch/arm64/include/asm/rwonce.h
> > new file mode 100644
> > index 000000000000..515e360b01a1
> > --- /dev/null
> > +++ b/arch/arm64/include/asm/rwonce.h
> > @@ -0,0 +1,63 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Copyright (C) 2020 Google LLC.
> > + */
> > +#ifndef __ASM_RWONCE_H
> > +#define __ASM_RWONCE_H
> > +
> > +#ifdef CONFIG_CLANG_LTO
> > +
> > +#include <linux/compiler_types.h>
> > +#include <asm/alternative-macros.h>
> > +
> > +#ifndef BUILD_VDSO
> > +
> > +#ifdef CONFIG_AS_HAS_LDAPR
> > +#define __LOAD_RCPC(sfx, regs...)					\
> > +	ALTERNATIVE(							\
> > +		"ldar"	#sfx "\t" #regs,				\
> 
> ^ Should this be here?  It seems that READ_ONCE() will actually read
> twice... even if that doesn't actually conflict with the required
> semantics of READ_ONCE(), it looks odd.

It's patched at runtime, so it's either LDAR or LDAPR.

> Making a direct link between LTO and the memory model also seems highly
> spurious (as discussed in the other subthread) so can we have a comment
> explaining the reasoning?

Sure, although like I say, this is more about helping to progress that
conversation.

Will
