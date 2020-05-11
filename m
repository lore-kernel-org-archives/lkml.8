Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E17CC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3129820661
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731800AbgEKUjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:39:01 -0400
Received: from smtprelay0130.hostedemail.com ([216.40.44.130]:38690 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729801AbgEKUjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:39:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0A199100E7B43;
        Mon, 11 May 2020 20:39:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: duck20_4e5e081df3660
X-Filterd-Recvd-Size: 2939
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 May 2020 20:38:58 +0000 (UTC)
Message-ID: <02b965de57774f393bb16d669164e0cef2497f2f.camel@perches.com>
Subject: Re: [PATCH -next] s390: Remove two unused inline functions
From:   Joe Perches <joe@perches.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, mingo@redhat.com,
        heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 11 May 2020 13:38:57 -0700
In-Reply-To: <cf344230-27b1-7302-36bb-55c25c6b5de4@de.ibm.com>
References: <20200508140724.11324-1-yuehaibing@huawei.com>
         <20200511060750.GA93884@tuxmaker.boeblingen.de.ibm.com>
         <20200511161756.7586afe6@gandalf.local.home>
         <cf344230-27b1-7302-36bb-55c25c6b5de4@de.ibm.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 22:27 +0200, Christian Borntraeger wrote:
> On 11.05.20 22:17, Steven Rostedt wrote:
> > On Mon, 11 May 2020 08:07:51 +0200
> > Sven Schnelle <svens@linux.ibm.com> wrote:
> > 
> > > Thanks for noticing, looks like i missed them.
> > > 
> > > Acked-by: Sven Schnelle <svens@linux.ibm.com>
> > 
> > As this is s390 specific, will it be going through the s390 repo?
> 
> Yes. 
> I will pick this up. Vasily will then take care of it.

Awhile back, I posted a list of apparently unused static inline
functions in .h files treewide found by a script:

https://lore.kernel.org/lkml/4603e761a5f39f4d97375e1e08d20d720c526341.camel@perches.com/

Here are the s390 entries:

arch/s390/include/asm/atomic_ops.h:138:static inline long __atomic64_cmpxchg_bool(long *ptr, long old, long new)
arch/s390/include/asm/bitops.h:278:static inline void __set_bit_inv(unsigned long nr, volatile unsigned long *ptr)
arch/s390/include/asm/bitops.h:283:static inline void __clear_bit_inv(unsigned long nr, volatile unsigned long *ptr)
arch/s390/include/asm/cpu_mcf.h:106:static inline int kernel_cpumcf_begin(void)
arch/s390/include/asm/cpu_mcf.h:114:static inline void kernel_cpumcf_end(void)
arch/s390/include/asm/ftrace.h:64:static inline int is_ftrace_nop(struct ftrace_insn *insn)
arch/s390/include/asm/kvm_para.h:146:static inline long kvm_hypercall5(unsigned long nr, unsigned long p1,
arch/s390/include/asm/kvm_para.h:175:static inline long kvm_hypercall6(unsigned long nr, unsigned long p1,
arch/s390/include/asm/pci_dma.h:134:static inline void invalidate_table_entry(unsigned long *entry)
arch/s390/include/asm/pci_dma.h:176:static inline int entry_isprotected(unsigned long entry)
arch/s390/include/asm/timex.h:52:static inline void store_clock_comparator(__u64 *time)


