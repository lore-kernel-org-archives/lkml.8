Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C346C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:26:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FEBB2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbgCSR0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 13:26:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33708 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbgCSR0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 13:26:20 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jEyvW-0006QR-UH; Thu, 19 Mar 2020 18:25:51 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id E6E1F103088; Thu, 19 Mar 2020 18:25:49 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>, Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
In-Reply-To: <20200319112054.GD13073@zn.tnic>
References: <20200317111822.GA15609@zn.tnic> <20200319101657.GB13073@zn.tnic> <20200319102011.GA3617@lst.de> <20200319102834.GC13073@zn.tnic> <8d6d3b6c-7e4e-7d9e-3e19-38f7d4477c72@arm.com> <20200319112054.GD13073@zn.tnic>
Date:   Thu, 19 Mar 2020 18:25:49 +0100
Message-ID: <878sjw5k9u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Thu, Mar 19, 2020 at 11:06:15AM +0000, Robin Murphy wrote:
>> Let me add another vote from a native English speaker that "unencrypted" is
>> the appropriate term to imply the *absence* of encryption, whereas
>> "decrypted" implies the *reversal* of applied encryption.
>> 
>> Naming things is famously hard, for good reason - names are *important* for
>> understanding. Just because a decision was already made one way doesn't mean
>> that that decision was necessarily right. Churning one area to be
>> consistently inaccurate just because it's less work than churning another
>> area to be consistently accurate isn't really the best excuse.
>
> Well, the reason we chose "decrypted" vs something else is so to be as
> different from "encrypted" as possible. If we called it "unencrypted"
> you'd have stuff like:
>
>        if (force_dma_unencrypted(dev))
>                 set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);

TBH, I don't see how

	if (force_dma_decrypted(dev))
		set_memory_encrypted((unsigned long)cpu_addr, 1 << page_order);
       
makes more sense than the above. It's both non-sensical unless there is
a big fat comment explaining what this is about.

Thanks,

        tglx

