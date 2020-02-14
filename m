Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F57C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:27:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908282187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:27:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="AAmMMOsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgBNG1T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:27:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:38772 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727212AbgBNG1T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:27:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48Jk1w3jrRzB09ZX;
        Fri, 14 Feb 2020 07:27:16 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=AAmMMOsg; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id MifSIpyiCvsp; Fri, 14 Feb 2020 07:27:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48Jk1w2bs2zB09ZV;
        Fri, 14 Feb 2020 07:27:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581661636; bh=diH9kuS50d2uOBYZwIHDWqEbnrON/+GYep/snUnx6ss=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=AAmMMOsg1zQUiu90YFOJnJXVCiwkKKf46COAFAFT2oBcpkcsX6a1+JETih/DDRhDv
         7f+P0RbXWzQKCoWm69xxfzxLDv3BJOG6pBMfqkD4+ds5h2xEdboXuwZlF80tpowinq
         PD6Hbe66L0s2pObHeFK9c5oQ8qxhPCb9XVNOacGo=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 31E2F8B878;
        Fri, 14 Feb 2020 07:27:17 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id MCz8mh-5upQa; Fri, 14 Feb 2020 07:27:17 +0100 (CET)
Received: from [172.25.230.102] (po15451.idsi0.si.c-s.fr [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0E0828B874;
        Fri, 14 Feb 2020 07:27:17 +0100 (CET)
Subject: Re: [PATCH v2] powerpc/32s: Fix DSI and ISI exceptions for
 CONFIG_VMAP_STACK
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     "Erhard F." <erhard_f@mailbox.org>, linux-kernel@vger.kernel.org
References: <6981d1be4504fc25b893f7127611e74c224887eb.1581588239.git.christophe.leroy@c-s.fr>
Message-ID: <6ce4945a-a053-d1fd-a540-b42be7c459ba@c-s.fr>
Date:   Fri, 14 Feb 2020 07:27:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <6981d1be4504fc25b893f7127611e74c224887eb.1581588239.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/02/2020 à 11:04, Christophe Leroy a écrit :
> hash_page() needs to read page tables from kernel memory. When entire
> kernel memory is mapped by BATs, which is normally the case when
> CONFIG_STRICT_KERNEL_RWX is not set, it works even if the page hosting
> the page table is not referenced in the MMU hash table.
> 
> However, if the page where the page table resides is not covered by
> a BAT, a DSI fault can be encountered from hash_page(), and it loops
> forever. This can happen when CONFIG_STRICT_KERNEL_RWX is selected
> and the alignment of the different regions is too small to allow
> covering the entire memory with BATs. This also happens when
> CONFIG_DEBUG_PAGEALLOC is selected or when booting with 'nobats'
> flag.
> 
> Also, if the page containing the kernel stack is not present in the
> MMU hash table, registers cannot be saved and a recursive DSI fault
> is encountered.
> 
> To allow hash_page() to properly do its job at all time and load the
> MMU hash table whenever needed, it must run with data MMU disabled.
> This means it must be called before re-enabling data MMU. To allow
> this, registers clobbered by hash_page() and create_hpte() have to
> be saved in the thread struct together with SRR0, SSR1, DAR and DSISR.
> It is also necessary to ensure that DSI prolog doesn't overwrite
> regs saved by prolog of the current running exception. That means:
> - DSI can only use SPRN_SPRG_SCRATCH0
> - Exceptions must free SPRN_SPRG_SCRATCH0 before writing to the stack.
> 
> This also fixes the Oops reported by Erhard when create_hpte() is
> called by add_hash_page().
> 
> Fixes: cd08f109e262 ("powerpc/32s: Enable CONFIG_VMAP_STACK")
> Reported-by: Erhard F. <erhard_f@mailbox.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206501
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Tested-by: Erhard F. <erhard_f@mailbox.org>

