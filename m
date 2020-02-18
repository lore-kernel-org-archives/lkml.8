Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A931DC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DBA21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582036232;
	bh=BDNUG0PVI6qF0TJoOtiRb63h5GKA5Q3TmdlUA5662B4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=U7YSigjDUOXbE+GB5SdyR6H4Vqn1XmIgAtzVcV05y4/3CldOrswbStWCnSigy/9bk
	 s25Ox/r+lNflmZLrlrmjHq+12y5uqCg7o9ldFGeQjo0JO8sJrbB9MvOy7PZt/u5BBr
	 a3h1zUWK2ra5r1qDUac9R83Q91gB3XqqYcK082pM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgBROab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:30:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726422AbgBROab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 09:30:31 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21535208C4;
        Tue, 18 Feb 2020 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582036230;
        bh=BDNUG0PVI6qF0TJoOtiRb63h5GKA5Q3TmdlUA5662B4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r7bXkYPXBzTZqKsQReb59q5+8xqNQq1OHgSgCwjY+Y6AkDilWYWFWXX0XCv+6xLT+
         vN38uitXdbqmelmhaVVyjWGpKjY56DRe1fmcUqhrErYUaunbZOwQjCd4v6ulB7lvCx
         qkVfnfqP0a7l4xnC4MuQmCdmqbDe1qb9YA2AFrZg=
Date:   Tue, 18 Feb 2020 15:30:28 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Paul Burton <paulburton@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Borislav Petkov <bp@alien8.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 5/5] arm64: Remove TIF_NOHZ
Message-ID: <20200218143027.GA23864@lenoir>
References: <20200214152615.25447-1-frederic@kernel.org>
 <20200214152615.25447-6-frederic@kernel.org>
 <20200218085709.GB16828@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218085709.GB16828@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:57:09AM +0000, Will Deacon wrote:
> On Fri, Feb 14, 2020 at 04:26:15PM +0100, Frederic Weisbecker wrote:
> > The syscall slow path is spuriously invoked when context tracking is
> > activated while the entry code calls context tracking from fast path.
> > 
> > Remove that overhead and the unused flag itself while at it.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > Cc: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/Kconfig                   | 1 -
> >  arch/arm64/include/asm/thread_info.h | 4 +---
> >  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> Acked-by: Will Deacon <will@kernel.org>
> 
> Do you want this to go via the arm64 tree? It looks like it makes sense
> on its own to me, so I could pick it as a fix.

Thanks Will, unfortunately it depends on some patches on the series, so
the whole needs to go together.
