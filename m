Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA32C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80FFF22522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 08:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="qS8R044I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgAWIQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 03:16:29 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44248 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725785AbgAWIQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 03:16:29 -0500
Received: from zn.tnic (p200300EC2F095B0060FE665DEF90E16F.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5b00:60fe:665d:ef90:e16f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4EB9C1EC047D;
        Thu, 23 Jan 2020 09:16:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579767388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PPVaeXaXqO644uKt7eoWxEa5cUlx4kFXc+xXb3pXKAo=;
        b=qS8R044IuNPx4oq9bwbELyDinMpvs5kh2AipLwGxy2+TB4JfZL5wnmlUcGK9DL4B2wETKS
        X7xlodcsMotN7YpZHq9YKJhP1bheZSu727agE4+gK8dmNFaHNFhP4OEz26/H/PYtGs/5lD
        DqHeJg4cI3tQur99NC/gyt3FAKzh93M=
Date:   Thu, 23 Jan 2020 09:16:25 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Qian Cai <cai@lca.pw>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] x86/mm/pat: silence a data race in cpa_4k_install
Message-ID: <20200123081625.GA10328@zn.tnic>
References: <20200122084604.GP14914@hirez.programming.kicks-ass.net>
 <4F7E8467-98F0-483A-BF70-CD06AC78890D@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4F7E8467-98F0-483A-BF70-CD06AC78890D@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 09:15:07PM -0500, Qian Cai wrote:
> Okay, so which way should we move forward with this then? Borislav
> liked __no_kasan_or_inline and Peter liked data_race(). I personally
> like data_race() more because it has nothing to do with the GCC bug,
> but I realized my opinion has little weight here.

Do the data_race() thing, pls.

But do send after the merge window because latter should open next week
and we all will be busy and not review/apply new stuff.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
