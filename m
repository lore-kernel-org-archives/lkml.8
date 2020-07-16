Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED33C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1378C20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594888257;
	bh=j2zfoYVTc58A9JeoCfrkQ7rAq8KE5rHDqXF799MrGI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nShkHbYW/gVFleOo/0vIBUZ3lHK+uqi5pdPTqSvY/JdMXcoSKJ43wZfP019iYPfYm
	 p0apTTOVs4tN1uneq5Tn3j2AD/WDr17SkrIBW4yPXhBgrzUS5mDDGgQYxg5QPSKwEG
	 8e5+ZaJvSlpl6BVnRwX9uz6W7UnTV/Zx+oZLLB70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgGPIa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:30:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:55718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726547AbgGPIaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:30:55 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87E4F2064C;
        Thu, 16 Jul 2020 08:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594888254;
        bh=j2zfoYVTc58A9JeoCfrkQ7rAq8KE5rHDqXF799MrGI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=srmlhbOzMGAuRa/PYoyRR7ZVP7g9qozdMB8DP7Z3MNJCxMGKk7g/R6YVeo3NnMgns
         oPeuqeim7BR13M4JyjF7ilK4BcmpBujuB5ozsZlcIgfT+4xEKFDX5PWG4mqzVx8am8
         N5YIRwmz7Fm86KFQTdviMgglL+qBFn8L4BayhyJE=
Date:   Thu, 16 Jul 2020 09:30:49 +0100
From:   Will Deacon <will@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH RESEND] lockdep: Move list.h inclusion into lockdep.h
Message-ID: <20200716083049.GA6771@willie-the-truck>
References: <20200716063649.GA23065@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716063649.GA23065@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 04:36:50PM +1000, Herbert Xu wrote:
> Currently lockdep_types.h includes list.h without actually using any
> of its macros or functions.  All it needs are the type definitions
> which were moved into types.h long ago.  This potentially causes
> inclusion loops because both are included by many core header
> files.
> 
> This patch moves the list.h inclusion into lockdep.h.  Note that
> we could probably remove it completely but that could potentially
> result in compile failures should any end users not include list.h
> directly and also be unlucky enough to not get list.h via some other
> header file.
> 
> Reported-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Acked-by: Will Deacon <will@kernel.org>

Will
