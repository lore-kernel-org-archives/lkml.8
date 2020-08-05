Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC33C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B0F422B42
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xZgN77rc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729480AbgHETyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbgHEQsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:48:39 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D035C0A893D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RIIneg+7/mEtbE19meMAOfaXXJsMYVcX3DCzixtwFp4=; b=xZgN77rc7QTu2SUz2Txvp07BQa
        rEKwKgC5ctZBRSV40lDEvZPvCZt5LmfeV/pyQOmnZC6mdVXAcchmO14bFXVpo3vNwueBX+BKFPz14
        f3/FLmbDBzST8oOh2reniGLLG9o+E1Ce7vjg6GOkTdUF+fQZiWJ9F00Wkv+lyojL6bu8DUzqsLlUx
        eS124XSyfJ6v5oa2y7SUVKVHMHUjRsHW1rss0vou12PBoO3y4ruAdOXLDdQounpE76OtzNK7a5JeY
        JNab3EZGOKfbwCt7HaeJUJEm5q3n4ieRvin6IaqQqHS17pXADia68KF231yRUFKPInlpMI0WxtlyC
        GXTIOgJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3K9p-0000Mo-TQ; Wed, 05 Aug 2020 14:12:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B13C7301E02;
        Wed,  5 Aug 2020 16:12:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A584823D7A30F; Wed,  5 Aug 2020 16:12:37 +0200 (CEST)
Date:   Wed, 5 Aug 2020 16:12:37 +0200
From:   peterz@infradead.org
To:     Marco Elver <elver@google.com>
Cc:     bp@alien8.de, dave.hansen@linux.intel.com, fenghua.yu@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org, yu-cheng.yu@intel.com,
        jgross@suse.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev@googlegroups.com,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
Message-ID: <20200805141237.GS2674@hirez.programming.kicks-ass.net>
References: <0000000000007d3b2d05ac1c303e@google.com>
 <20200805132629.GA87338@elver.google.com>
 <20200805134232.GR2674@hirez.programming.kicks-ass.net>
 <20200805135940.GA156343@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805135940.GA156343@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 03:59:40PM +0200, Marco Elver wrote:
> On Wed, Aug 05, 2020 at 03:42PM +0200, peterz@infradead.org wrote:

> > Shouldn't we __always_inline those? They're going to be really small.
> 
> I can send a v2, and you can choose. For reference, though:
> 
> 	ffffffff86271ee0 <arch_local_save_flags>:
> 	ffffffff86271ee0:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> 	ffffffff86271ee5:       48 83 3d 43 87 e4 01    cmpq   $0x0,0x1e48743(%rip)        # ffffffff880ba630 <pv_ops+0x120>
> 	ffffffff86271eec:       00
> 	ffffffff86271eed:       74 0d                   je     ffffffff86271efc <arch_local_save_flags+0x1c>
> 	ffffffff86271eef:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> 	ffffffff86271ef4:       ff 14 25 30 a6 0b 88    callq  *0xffffffff880ba630
> 	ffffffff86271efb:       c3                      retq
> 	ffffffff86271efc:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> 	ffffffff86271f01:       0f 0b                   ud2

> 	ffffffff86271a90 <arch_local_irq_restore>:
> 	ffffffff86271a90:       53                      push   %rbx
> 	ffffffff86271a91:       48 89 fb                mov    %rdi,%rbx
> 	ffffffff86271a94:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> 	ffffffff86271a99:       48 83 3d 97 8b e4 01    cmpq   $0x0,0x1e48b97(%rip)        # ffffffff880ba638 <pv_ops+0x128>
> 	ffffffff86271aa0:       00
> 	ffffffff86271aa1:       74 11                   je     ffffffff86271ab4 <arch_local_irq_restore+0x24>
> 	ffffffff86271aa3:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> 	ffffffff86271aa8:       48 89 df                mov    %rbx,%rdi
> 	ffffffff86271aab:       ff 14 25 38 a6 0b 88    callq  *0xffffffff880ba638
> 	ffffffff86271ab2:       5b                      pop    %rbx
> 	ffffffff86271ab3:       c3                      retq
> 	ffffffff86271ab4:       0f 1f 44 00 00          nopl   0x0(%rax,%rax,1)
> 	ffffffff86271ab9:       0f 0b                   ud2


Blergh, that's abysmall. In part I suspect because you have
CONFIG_PARAVIRT_DEBUG, let me try and untangle that PV macro maze.
