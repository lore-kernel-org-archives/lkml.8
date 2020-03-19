Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA3FC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DFBF20740
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgCSLGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 07:06:33 -0400
Received: from foss.arm.com ([217.140.110.172]:33408 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgCSLGc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:06:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4BB731B;
        Thu, 19 Mar 2020 04:06:31 -0700 (PDT)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F2A993F305;
        Thu, 19 Mar 2020 04:06:25 -0700 (PDT)
Subject: Re: [PATCH -v2] treewide: Rename "unencrypted" to "decrypted"
To:     Borislav Petkov <bp@alien8.de>, Christoph Hellwig <hch@lst.de>
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
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200317111822.GA15609@zn.tnic> <20200319101657.GB13073@zn.tnic>
 <20200319102011.GA3617@lst.de> <20200319102834.GC13073@zn.tnic>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8d6d3b6c-7e4e-7d9e-3e19-38f7d4477c72@arm.com>
Date:   Thu, 19 Mar 2020 11:06:15 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319102834.GC13073@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[since this is in my inbox...]

On 2020-03-19 10:28 am, Borislav Petkov wrote:
> On Thu, Mar 19, 2020 at 11:20:11AM +0100, Christoph Hellwig wrote:
>> I thought we agreed that decrypted is absolutely the wrong term.
> 
> I don't think we did. At least I don't know where we did that.
> 
>> So NAK - if you want to change things it needs to go the other way.
> 
> We are already using "decrypted" everywhere in arch/x86/. Changing that
> would be a *lot* more churn.
> 
> And it is just a term, for chrissakes, to denote memory which is not
> encrypted. And it would make our lifes easier if we had only *two* terms
> instead of three or more. Especially if the concept we denote with this
> is a binary one: encrypted memory and *not* encrypted memory.

Let me add another vote from a native English speaker that "unencrypted" 
is the appropriate term to imply the *absence* of encryption, whereas 
"decrypted" implies the *reversal* of applied encryption.

Naming things is famously hard, for good reason - names are *important* 
for understanding. Just because a decision was already made one way 
doesn't mean that that decision was necessarily right. Churning one area 
to be consistently inaccurate just because it's less work than churning 
another area to be consistently accurate isn't really the best excuse.

Robin.
