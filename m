Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FB0C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 741DD20784
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 11:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vw9oy8mD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgDVLoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 07:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726426AbgDVLoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:44:08 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA70C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZDGlgFET5eq2bzJ0hxZIFrGXsu9vX9N5rM5mY+1mMY0=; b=Vw9oy8mDnKoXj7EmlZlLUyh4Le
        wwFvVWj0P7cHX7N2uENnCa4K8i51m6evPUk1Rx2Ur0rd8R+i96Qp0nPkTkArpSmLdYW3DTBdUqfnf
        DDYCZwSifat17sQOtMjWb4YX2hYBKdNZpQ+md7xEP12Ooyw8K9FrqhY3XGxEOkm5E3kFbTcW6C93t
        bo7qRpF/uzduGKtl9nsMw5wyqFdT39OeEbbDerMhtTV7rregTsOm7gGcR4MgzSDw7vuXNQZA2dSqz
        DZ0piQs3ghKM5VAGZ+5jlYWmJqhk897wILTfVeBQ004AA1WVPtD8vj9ULI2XYfJzr1fNe8X/hDA/U
        20Rn4MEg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDn6-00078f-2m; Wed, 22 Apr 2020 11:43:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D9594304CFD;
        Wed, 22 Apr 2020 13:43:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BDEEE203AA838; Wed, 22 Apr 2020 13:43:42 +0200 (CEST)
Date:   Wed, 22 Apr 2020 13:43:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/3] objtool: Rename elf_read() to elf_open_read()
Message-ID: <20200422114342.GD20730@hirez.programming.kicks-ass.net>
References: <20200422103205.61900-1-mingo@kernel.org>
 <20200422103205.61900-3-mingo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422103205.61900-3-mingo@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 12:32:04PM +0200, Ingo Molnar wrote:
> 'struct elf *' handling is an open/close paradigm, make sure the naming
> matches that:
> 
>    elf_open_read()
>    elf_write()
>    elf_close()


> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index f2a84271e807..12e2aea42bb2 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -2614,7 +2614,7 @@ int check(const char *_objname, bool orc)
>  
>  	objname = _objname;
>  
> -	file.elf = elf_read(objname, orc ? O_RDWR : O_RDONLY);
> +	file.elf = elf_open_read(objname, orc ? O_RDWR : O_RDONLY);

Note that I have a patch pending that makes that unconditionally O_RDWR,
which sort of seems to suggest elf_open() might be the better name.
