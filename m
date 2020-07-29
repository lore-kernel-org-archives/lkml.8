Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E048C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE6D2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 09:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iT11XOfi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgG2JD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 05:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG2JD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:03:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BFEC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 02:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p8xM3KLUYVzo1b9pVgABw20nOWvB/g3PfvGdgdfnwY8=; b=iT11XOfih4eckS10psH1Uerktp
        td89OM7E7oj/M/Gtiatb7O12JLz9UAkpVhqE8FwCAyeUescHPsKF+a3I5e3FrakWEWWZyCexrZC4t
        dEzlNerj3KkD8957V516sBGj/SkZxNopTkW1kSer7dJf3y5OlZKa17N8iiQ/VoT0wTzQefmxmrv9Q
        aKzI6lu/+l1QrmLLDHARVWZnQPxrq3p8M85wIR6d739rparoRiN4sD5FE4O/de4aDFnyOO0lgI2b1
        tubnRdlypdkmeKY3RMOihBmUY+3Dxh/GGS63G7s4aVCUh4kFo8eFLaY7F8UNOgteez8ICiGWprKli
        dciA1uFg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0hzd-0002zv-Ht; Wed, 29 Jul 2020 09:03:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3547C300238;
        Wed, 29 Jul 2020 11:03:19 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 12E322B804950; Wed, 29 Jul 2020 11:03:19 +0200 (CEST)
Date:   Wed, 29 Jul 2020 11:03:19 +0200
From:   peterz@infradead.org
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com,
        tony.luck@intel.com
Subject: Re: [PATCH 1/6] arch: x86: Don't use TIF flags for mm context
Message-ID: <20200729090319.GA119549@hirez.programming.kicks-ass.net>
References: <20200728202229.1195682-1-krisman@collabora.com>
 <20200728202229.1195682-2-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728202229.1195682-2-krisman@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 04:22:24PM -0400, Gabriel Krisman Bertazi wrote:

> diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
> index 267701ae3d86..934aa15b20f2 100644
> --- a/arch/x86/include/asm/thread_info.h
> +++ b/arch/x86/include/asm/thread_info.h
> @@ -53,6 +53,12 @@ struct task_struct;
>  #include <asm/cpufeature.h>
>  #include <linux/atomic.h>
>  
> +enum {
> +	PSABI_IA64 = 0,

That's the Itanic, and it has sailed. I think you want PSABI_X86_64 or
something.

> +	PSABI_IA32 = 1,
> +	PSABI_X32  = 2
> +};
