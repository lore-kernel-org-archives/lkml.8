Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC081C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1242076C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 10:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GX36+Rur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCTK1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 06:27:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49808 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgCTK1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 06:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=5v+ejKx6Q1htExGyGsB45wG71rvNTqs2N1NFe0eofyA=; b=GX36+RurSbGrLgvXPdBMvxSQQ4
        x+0cpv9vHRMpOuKeDiJ+dRzCn/JnD/IZdPxkdJv/rDvqEUJHR7MQYbw+FZvXFfWs7y81iYWYwWD/C
        soZZb0K9E3kZ9EPvON841s4JFBeOdt2D5JN4WrT3CBtYqWLKq7UGh364/IxtzZrXMtI1/arQZGOUH
        VgZnCav6ZPv6GshmdGhtgpapA7LC65zqtQxO84CX9O++AgUjcMORmLG0LhDG4L+9dGduZ6g126567
        dp7qI0xPWsicqbpIR2hcKj/PVOmQIqWZuKP/UtXgQ3nGt1vWVtAR5eo3xH0EnCIMiymBuINtueBU9
        7LQwzEEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFErw-0007s3-0n; Fri, 20 Mar 2020 10:27:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DB756305C92;
        Fri, 20 Mar 2020 11:27:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A5797285E2762; Fri, 20 Mar 2020 11:27:09 +0100 (CET)
Date:   Fri, 20 Mar 2020 11:27:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     andrew.murray@arm.com, bristot@redhat.com,
        jakub.kicinski@netronome.com, Kees Cook <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>,
        Li Bin <huawei.libin@huawei.com>, bobo.shaobowang@huawei.com
Subject: Re: Why is text_mutex used in jump_label_transform for x86_64
Message-ID: <20200320102709.GC20696@hirez.programming.kicks-ass.net>
References: <f7f686f2-4f28-1763-dd19-43eff6a5a8f2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7f686f2-4f28-1763-dd19-43eff6a5a8f2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 09:49:04PM +0800, chengjian (D) wrote:
> Hi，everyone
> 
> I'm sorry to disturb you. I have a problem about jump_label, and a bit
> confused about the code
> 
> I noticed that text_mutex is used in this function under x86_64
> architecture,
> but other architectures do not.
> 
> in arch/x86/kernel/jump_label.c
>         static void __ref jump_label_transform(struct jump_entry *entry,
>              enum jump_label_type type,
>              int init)
>         {
>          mutex_lock(&text_mutex);
>          __jump_label_transform(entry, type, init);
>          mutex_unlock(&text_mutex);
> 
> in arch/arm64/kernel/jump_label.c
> 
>         void arch_jump_label_transform(struct jump_entry *entry,
>                                        enum jump_label_type type)
>         {
>                 void *addr = (void *)jump_entry_code(entry);
>                 u32 insn;
> 
>                 if (type == JUMP_LABEL_JMP) {
>                         insn =
> aarch64_insn_gen_branch_imm(jump_entry_code(entry),
> jump_entry_target(entry),
> AARCH64_INSN_BRANCH_NOLINK);
>                 } else {
>                         insn = aarch64_insn_gen_nop();
>                 }
> 
>                 aarch64_insn_patch_text_nosync(addr, insn);
>         }
> 
> 
> Is there anything wrong with x86
> 
> or
> 
> is this missing for other architectures?

It depends on the architecture details of how self-modifying code works.
In particular, x86 is a variable instruction length architecture and
needs extreme care -- it's implementation requires there only be a
single text modifier at any one time, hence the use of text_mutex.

ARM64 OTOH is, like most RISC based architectures, a fixed width
instruction architecture. And in particular it can re-write certain
(branch) instructions with impunity (see their
aarch64_insn_patch_text_nosync()). Which is why they don't need
additional serialization.
