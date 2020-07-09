Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E741C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 248E32074B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kp5z7mjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgGIKbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgGIKbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:31:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 383E3C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EOZVWDThDKqF4YYFkjeMog3dbaiyIMj81bHvidkFqbM=; b=Kp5z7mjCfrEn0TzLiityGZDAmg
        rnfM/0vw66/0HUAxCuR6ZXvmj+vyCCVzi39F8hieo4SYHYzhd/Z5b/SAAqo9alYzFEaajCd1P+5tP
        KqfP7vUydnwiDaZKABnoeqakHZVAmGnFyQyDV42vPZwBmmEAV+E1GqrTrv0JRv+Ttd+sIBYInvlmy
        EF6JHn6gApj84yC2p83QtY3nxO/JY32VD2D0xng+ooDI1vGgza6DqeCDQ8lht81PcSY27Iu7LRUjt
        Frpo/WqM1gNs19b76Hmxbx9F87XRlHh8lb28Lpf2bp+n6frw8jAwivE4WyNVR5wTEcLod6tcVhWCt
        pwtaXxFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtTpP-0007e6-S8; Thu, 09 Jul 2020 10:30:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A92CF30504E;
        Thu,  9 Jul 2020 12:30:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9B1F6285718DB; Thu,  9 Jul 2020 12:30:54 +0200 (CEST)
Date:   Thu, 9 Jul 2020 12:30:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v2 00/10] x86: Clean up percpu operations
Message-ID: <20200709103054.GP597537@hirez.programming.kicks-ass.net>
References: <20200530221127.459704-1-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200530221127.459704-1-brgerst@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 06:11:17PM -0400, Brian Gerst wrote:
> The core percpu operations already have a switch on the width of the
> data type, which resulted in an extra amount of dead code being
> generated with the x86 operations having another switch.  This patch set
> rewrites the x86 ops to remove the switch.  Additional cleanups are to
> use named assembly operands, and to cast variables to the width used in
> the assembly to make Clang happy.
> 
> Changes from v1:
> - Add separate patch for XADD constraint fix
> - Fixed sparse truncation warning
> - Add cleanup of percpu_stable_op()
> - Add patch to Remove PER_CPU()
> 
> Brian Gerst (10):
>   x86/percpu: Introduce size abstraction macros
>   x86/percpu: Clean up percpu_to_op()
>   x86/percpu: Clean up percpu_from_op()
>   x86/percpu: Clean up percpu_add_op()
>   x86/percpu: Remove "e" constraint from XADD
>   x86/percpu: Clean up percpu_add_return_op()
>   x86/percpu: Clean up percpu_xchg_op()
>   x86/percpu: Clean up percpu_cmpxchg_op()
>   x86/percpu: Clean up percpu_stable_op()
>   x86/percpu: Remove unused PER_CPU() macro
> 
>  arch/x86/include/asm/percpu.h | 510 ++++++++++++----------------------
>  1 file changed, 172 insertions(+), 338 deletions(-)

Nice!

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
