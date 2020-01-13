Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CA7C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE78214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578932173;
	bh=kvKGZK7M3Vhmy3XHs10AlveyIukaIS1gBly4oyYvTJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SdaXqOYoUKJVj3WK+RQj3yRG0/W+LavaiicAuXC9zekNUkiKFNwqDKySVmNpFdJFS
	 ZN8j39xvvGd/RCYVQeKssjKO/sAgPAgGctk+YmwdU2dBK2pVgzahJVrLmUcjxQ/Ez7
	 9m2/D8cJxXzC+LHpgop8Qd1+El8sibvyqaQrpoCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgAMQQM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:16:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:51224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726943AbgAMQQM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:16:12 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B6BA2080D;
        Mon, 13 Jan 2020 16:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578932171;
        bh=kvKGZK7M3Vhmy3XHs10AlveyIukaIS1gBly4oyYvTJc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VuXIRQW6rm0kd+V12BGITjdewbdm+dADyuN8M7k6bEeVc4vE/p0OsW2X3GZnxEO0i
         L91yXkE6x3GSMyfNd8Sl6P72KoERH+GZfEgwp4C7MfpuAWuF9iAF2UsrsGOpbYaGGE
         i5enTkblyKNBoEzHIbCCH4CdWKbJ5quOiBxJCsEY=
Date:   Mon, 13 Jan 2020 16:16:06 +0000
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [RFC PATCH 5/8] READ_ONCE: Enforce atomicity for
 {READ,WRITE}_ONCE() memory accesses
Message-ID: <20200113161606.GD4458@willie-the-truck>
References: <20200110165636.28035-1-will@kernel.org>
 <20200110165636.28035-6-will@kernel.org>
 <CAK8P3a1pDW7cABLeotZBNTTxLxkQ299wO0OG3AWGyDqJWmQA+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1pDW7cABLeotZBNTTxLxkQ299wO0OG3AWGyDqJWmQA+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 08:24:00PM +0100, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 5:56 PM Will Deacon <will@kernel.org> wrote:
> 
> > +/*
> > + * Use __READ_ONCE() instead of READ_ONCE() if you do not require any
> > + * atomicity or dependency ordering guarantees. Note that this may result
> > + * in tears!
> > + */
> > +#define __READ_ONCE(x) (*(volatile typeof(x) *)&(x))
> > +
> 
> This probably allows writing
> 
>        extern int i;
>        __READ_ONCE(i) = 1;
> 
> and not get a warning for it. How about also casting to 'const'?

Well spotted! I'll fold that in.

Will
