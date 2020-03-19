Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00D2C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E5D2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbgCSWAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:00:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:41578 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbgCSWAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:00:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 59322ADAD;
        Thu, 19 Mar 2020 21:59:57 +0000 (UTC)
Date:   Thu, 19 Mar 2020 22:59:55 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        iommu@lists.linux-foundation.org, Ingo Molnar <mingo@redhat.com>,
        Paul Mackerras <paulus@samba.org>,
        Andy Lutomirski <luto@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
Message-ID: <20200319215955.GN25468@kitsune.suse.cz>
References: <20200317111822.GA15609@zn.tnic>
 <20200319101657.GB13073@zn.tnic>
 <20200319102011.GA3617@lst.de>
 <20200319102834.GC13073@zn.tnic>
 <8d6d3b6c-7e4e-7d9e-3e19-38f7d4477c72@arm.com>
 <20200319112054.GD13073@zn.tnic>
 <878sjw5k9u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878sjw5k9u.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 06:25:49PM +0100, Thomas Gleixner wrote:
> Borislav Petkov <bp@alien8.de> writes:
> 
> > On Thu, Mar 19, 2020 at 11:06:15AM +0000, Robin Murphy wrote:
> >> Let me add another vote from a native English speaker that "unencrypted" is
> >> the appropriate term to imply the *absence* of encryption, whereas
> >> "decrypted" implies the *reversal* of applied encryption.
Even as a non-native speaker I can clearly see the distinction.
> >> 
> >> Naming things is famously hard, for good reason - names are *important* for
> >> understanding. Just because a decision was already made one way doesn't mean
> >> that that decision was necessarily right. Churning one area to be
> >> consistently inaccurate just because it's less work than churning another
> >> area to be consistently accurate isn't really the best excuse.
> >
> > Well, the reason we chose "decrypted" vs something else is so to be as
> > different from "encrypted" as possible. If we called it "unencrypted"
> > you'd have stuff like:
> >
> >        if (force_dma_unencrypted(dev))
> >                 set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);

If you want something with high edit distance from 'encrypted' meaning
the opposite there is already 'cleartext' which was designed for this
exact purpose.

Thanks

Michal
