Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482C4C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2478721927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 14:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="X+a/uoFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503248AbgDPOdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 10:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442413AbgDPOTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 10:19:08 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D33CC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 07:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=np/r4qmw0QP+lfZCIwmj89Ty0A5BEtMfhuVH8iBF1rQ=; b=X+a/uoFuacTRKSXmyYyt76ewgI
        X0RVeg+FHBRqUShdYm8ZS7gOQ7qLxNCBoXbdGvdw0Z0tKNAmZEjfjQNiY6/T6Eki1nUaEhPLbxRMF
        ry7FDCKJcSugklhOm6KMPIG53c/H22gkr2Ib1JLGXFHjFSIgBBxpsnTgM/vsmNHzmupU8Jaib/ekX
        ltpHTDT1Gjb+AyrsvyDIZPIXK8bI/NsMi7AVROjzBNu92vFqZPK28ZdSBx99EYMXrbZcL3wu6QBvL
        xKc//812mOYH82Lxfu9KADhmBJ+atHBp5WWApdtH1NNQd6HpcYKfMZQRNtjga9f9RHoKHAYvKcTn+
        j8IQdcUg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP5Lp-00020H-SF; Thu, 16 Apr 2020 14:18:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3EB4B3006E0;
        Thu, 16 Apr 2020 16:18:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2A45329E7027C; Thu, 16 Apr 2020 16:18:43 +0200 (CEST)
Date:   Thu, 16 Apr 2020 16:18:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, jpoimboe@redhat.com,
        jthierry@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH V3 6/9] objtool: Report inconsistent stack changes in
 alternative
Message-ID: <20200416141843.GP20730@hirez.programming.kicks-ass.net>
References: <20200414103618.12657-1-alexandre.chartre@oracle.com>
 <20200414103618.12657-7-alexandre.chartre@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414103618.12657-7-alexandre.chartre@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 12:36:15PM +0200, Alexandre Chartre wrote:
> To allow a valid stack unwinding, an alternative should have code
> where the same stack changes happens at the same places as in the
> original code. Add a check in objtool to validate that stack changes
> in alternative are effectively consitent with the original code.

This thing is completely buggered, it warns all over the place, even for
obviously correct alternatives like:

0000000000000310 <return_to_handler>:
 310:   48 83 ec 18             sub    $0x18,%rsp
 314:   48 89 04 24             mov    %rax,(%rsp)
 318:   48 89 54 24 08          mov    %rdx,0x8(%rsp)
 31d:   48 89 ef                mov    %rbp,%rdi
 320:   e8 00 00 00 00          callq  325 <return_to_handler+0x15>
                        321: R_X86_64_PLT32     ftrace_return_to_handler-0x4
 325:   48 89 c7                mov    %rax,%rdi
 328:   48 8b 54 24 08          mov    0x8(%rsp),%rdx
 32d:   48 8b 04 24             mov    (%rsp),%rax
 331:   48 83 c4 18             add    $0x18,%rsp
 335:   ff e7                   jmpq   *%rdi
 337:   90                      nop
 338:   90                      nop
 339:   90                      nop


Where 335 has two alternatives:

   0:   e9 00 00 00 00          jmpq   5 <.altinstr_replacement+0x5>
                        1: R_X86_64_PLT32       __x86_retpoline_rdi-0x4

and

   5:   0f ae e8                lfence
   8:   ff e7                   jmpq   *%rdi


And it then comes back with:

  defconfig-build/arch/x86/kernel/ftrace_64.o: warning: objtool: .entry.text+0x335: error in alternative
  defconfig-build/arch/x86/kernel/ftrace_64.o: warning: objtool: .altinstr_replacement+0x5: in alternative 2
  defconfig-build/arch/x86/kernel/ftrace_64.o: warning: objtool: .altinstr_replacement+0x8: misaligned alternative state change

which is just utter crap, JMP has no (CFI) state change.
