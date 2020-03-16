Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF14C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8230520663
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="KyZp3UU4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732966AbgCPXv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:51:58 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:57705 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732873AbgCPXv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:51:58 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48hCl00YkRz9sNg;
        Tue, 17 Mar 2020 10:51:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1584402716;
        bh=VpGZJfIHRSmpY2D6/9MDE+epOSAM4GCBKy3wjs3vSQY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=KyZp3UU46svAFMhAbU9or0JQs3a7cvyqqXAhvu3oQALDSAmUTG90zdGlkD0Wp8Quw
         iHaED7uUOqwS9JISSSweGCtZP8EEnAF5XvupzScmakJX/Yn2W/31NAp0qT4f+Yo3zL
         V+wyBffLfS/TRxxkS2a0SlOLo9pib5gF931+1foZ/L7FWPYttasxj0OQpHsScZKNKN
         ogF9pHfcKEWI/a1mlWPhEBTrC9JUt5y4nLI6mfpObDEvrBNeI/0B3BCpIXycQZ+0DB
         Ojix1JIaU3FQdnEUeN+jWrJWSYAhqy4fJSNsKvV0oZrsbSbamiZu0zDmbRe8hACJ4h
         /Aw3ogY1hT2WQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] powerpc/32: Fix missing NULL pmd check in virt_to_kpte()
In-Reply-To: <CAKwvOdm6Z+ERUcGXPbuBKmnpBUNKfL8fPOdxK2g+a1gVRWqh-Q@mail.gmail.com>
References: <b1177cdfc6af74a3e277bba5d9e708c4b3315ebe.1583575707.git.christophe.leroy@c-s.fr> <20200313033517.GA37606@ubuntu-m2-xlarge-x86> <CAKwvOdm6Z+ERUcGXPbuBKmnpBUNKfL8fPOdxK2g+a1gVRWqh-Q@mail.gmail.com>
Date:   Tue, 17 Mar 2020 10:51:55 +1100
Message-ID: <87zhcfq2n8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Desaulniers <ndesaulniers@google.com> writes:
> Hello ppc friends, did this get picked up into -next yet?

Not yet.

It's in my next-test, but it got stuck there because some subsequent
patches caused some CI errors that I had to debug.

I'll push it to next today.

cheers

> On Thu, Mar 12, 2020 at 8:35 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
>>
>> On Sat, Mar 07, 2020 at 10:09:15AM +0000, Christophe Leroy wrote:
>> > Commit 2efc7c085f05 ("powerpc/32: drop get_pteptr()"),
>> > replaced get_pteptr() by virt_to_kpte(). But virt_to_kpte() lacks a
>> > NULL pmd check and returns an invalid non NULL pointer when there
>> > is no page table.
>> >
>> > Reported-by: Nick Desaulniers <ndesaulniers@google.com>
>> > Fixes: 2efc7c085f05 ("powerpc/32: drop get_pteptr()")
>> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> > ---
>> >  arch/powerpc/include/asm/pgtable.h | 4 +++-
>> >  1 file changed, 3 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
>> > index b80bfd41828d..b1f1d5339735 100644
>> > --- a/arch/powerpc/include/asm/pgtable.h
>> > +++ b/arch/powerpc/include/asm/pgtable.h
>> > @@ -54,7 +54,9 @@ static inline pmd_t *pmd_ptr_k(unsigned long va)
>> >
>> >  static inline pte_t *virt_to_kpte(unsigned long vaddr)
>> >  {
>> > -     return pte_offset_kernel(pmd_ptr_k(vaddr), vaddr);
>> > +     pmd_t *pmd = pmd_ptr_k(vaddr);
>> > +
>> > +     return pmd_none(*pmd) ? NULL : pte_offset_kernel(pmd, vaddr);
>> >  }
>> >  #endif
>> >
>> > --
>> > 2.25.0
>> >
>>
>> With QEMU 4.2.0, I can confirm this fixes the panic:
>>
>> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
>
>
>
> -- 
> Thanks,
> ~Nick Desaulniers
