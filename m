Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79670C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 459FD20784
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="EnDlkKcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgC3IEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:04:12 -0400
Received: from ozlabs.org ([203.11.71.1]:32815 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729588AbgC3IEK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:04:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48rQ2v5hYmz9sPk;
        Mon, 30 Mar 2020 19:04:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1585555448;
        bh=UEqraPxWZNMFx5fHfH7tIq3y+zDn+e9FvroX/7SOtOY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EnDlkKcLlbAbJLDWOjVc5qVM7tXpkLgrsGq89J8CccIFT2Nap0ukO8RWbj+Jp1YTq
         EWHcNOMOJ2dpbS1RyRL5Y1/y9xc+giTT/849l4uOpSZbYHGDSkAcR8+xYnIC8u04xI
         rYt8FQSHJkBhIJ7Z2Ml+i1EogXySuzoaEddN6WWk2nxzQCb1U/e0miceaKWsuOSqc+
         Mx6Lk4/zhhWSEckEdFgsXLKq+Z/fETWToLrsbjS8MtOSIRJ7H6RWFgFzVH7GNBmw3+
         lPqb6vvS4hLRrnCCQnmDsLLmB6H2btMDiZMaZMriLmP/+KPzZsAxEkQsXbxPOh2OR5
         jBZVYwGyz5UtQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Borislav Petkov <bp@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the tip tree
In-Reply-To: <20200330074823.GA14624@zn.tnic>
References: <20200330143529.4dafeb34@canb.auug.org.au> <CAMe9rOqnRCEdHhSHOT=Ut11D3O2WhjiFYhvPnaU5dANZNPE-=A@mail.gmail.com> <20200330150819.7f0199a2@canb.auug.org.au> <20200330074823.GA14624@zn.tnic>
Date:   Mon, 30 Mar 2020 19:04:16 +1100
Message-ID: <87wo72uv3z.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@suse.de> writes:
> On Mon, Mar 30, 2020 at 03:08:19PM +1100, Stephen Rothwell wrote:
>> What you really need is an Ack from the PowerPC people for the fix you
>> suggested and then tha fix should go in the same series that is now
>> causing the failure (preferably before the problematic (for PowerPC)
>> patch.
>
> I'll zap this commit from the tip lineup. There's always another merge
> window.

Or just squash the hunk Stephen posted into the commit, which is what I
thought would happen to begin with.

You can have my ack for it:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
