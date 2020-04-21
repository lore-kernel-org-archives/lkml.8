Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD0FC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42EE0206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yh9NPA4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgDUTr7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDUTr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:47:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BD7C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xWfW0nwfxRCQ7wQd6L3Rz9ECsecJi1GV2Mml2YkU8Qc=; b=Yh9NPA4kNtR+QhBk1k4gTRqSyG
        hjf2ckD8gia+UmRKUvrCcePIe1SEh86WbR246xzBjVYVh8XbGbGhrxxLH0v6syUh+iq5fkTj31M+2
        W57lFG+DhOkRyy5wlpObUx0AEJPBAhrvSvGFnHsG49z07Zi8BrO/1JENN/Hep9M9OclkHa4+UpLYP
        E47DQFXmnoXDmOJHdOGHzOwK/wuS1k8KBPTgWwrlprxodHzFlbtNUWQgxOfRmw7DVYemf5R3Ap/Rs
        rzyyC0QYoXHkEcrmx0LOPqlCLJTf3/Q3OOJmSD7IgJaFKym8nNr63wHSdqepgLVKvbW535+1NtPr/
        x8NtRLzw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jQys4-0002kw-5F; Tue, 21 Apr 2020 19:47:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5F853300739;
        Tue, 21 Apr 2020 21:47:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2ED2E2BB16BBF; Tue, 21 Apr 2020 21:47:49 +0200 (CEST)
Date:   Tue, 21 Apr 2020 21:47:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] objtool: optimize insn_hash for split sections
Message-ID: <20200421194749.GX20730@hirez.programming.kicks-ass.net>
References: <20200421180724.245410-1-samitolvanen@google.com>
 <20200421180724.245410-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421180724.245410-3-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:07:23AM -0700, Sami Tolvanen wrote:
> When running objtool on vmlinux.o compiled with -ffunction-sections,
> we end up with a ton of collisions in the insn_hash table as each
> function is in its own section. This results in a runtime of minutes
> instead of seconds. Use both section index and offset as the key to
> avoid this, similarly to rela_hash.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I already have this queued:

  https://lkml.kernel.org/r/20200416115119.227240432@infradead.org

which looks very similar.
