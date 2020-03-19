Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06160C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:28:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C38D620739
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="dypae57F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgCSK23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:28:29 -0400
Received: from mail.skyhub.de ([5.9.137.197]:57538 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgCSK23 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:28:29 -0400
Received: from zn.tnic (p200300EC2F0A850035180F69CBC86220.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:8500:3518:f69:cbc8:6220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C77D31EC0CF9;
        Thu, 19 Mar 2020 11:28:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584613707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=iZUZhIBkCAhoEjiFaedPIp77BnKEXPzFG3udsiDWQxc=;
        b=dypae57FKE5rQct1uVw9z0eRqwwakJqg6wApvPGh+7jfpxaIYR9NvqV9dcyEoHaQhwxgS1
        SyvVx/9MAyVls4z0HFyj86rMEjzesgL6031uOQFgJUVuTia2O/DFwyOCcnYoUJCzSSUw5a
        7IXXW0Qn9kLr8AQU+YnSYTs99pl6VAE=
Date:   Thu, 19 Mar 2020 11:28:34 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200319102834.GC13073@zn.tnic>
References: <20200317111822.GA15609@zn.tnic>
 <20200319101657.GB13073@zn.tnic>
 <20200319102011.GA3617@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200319102011.GA3617@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 11:20:11AM +0100, Christoph Hellwig wrote:
> I thought we agreed that decrypted is absolutely the wrong term.

I don't think we did. At least I don't know where we did that.

> So NAK - if you want to change things it needs to go the other way.

We are already using "decrypted" everywhere in arch/x86/. Changing that
would be a *lot* more churn.

And it is just a term, for chrissakes, to denote memory which is not
encrypted. And it would make our lifes easier if we had only *two* terms
instead of three or more. Especially if the concept we denote with this
is a binary one: encrypted memory and *not* encrypted memory.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
