Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C15C35DF9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAEF2469B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbgB0RzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:55:13 -0500
Received: from ale.deltatee.com ([207.54.116.67]:57282 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbgB0RzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:55:12 -0500
Received: from s0106ac1f6bb1ecac.cg.shawcable.net ([70.73.163.230] helo=[192.168.11.155])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1j7NMx-0004I6-PN; Thu, 27 Feb 2020 10:54:45 -0700
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org,
        Dan Williams <dan.j.williams@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Eric Badger <ebadger@gigaio.com>
References: <20200221182503.28317-1-logang@deltatee.com>
 <20200227171704.GK31668@ziepe.ca>
 <e8781f85-3fc7-b9ce-c751-606803cbdc77@deltatee.com>
 <20200227174311.GL31668@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7e573498-81c1-7f00-c1ff-ed16e12a5b96@deltatee.com>
Date:   Thu, 27 Feb 2020 10:54:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200227174311.GL31668@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.73.163.230
X-SA-Exim-Rcpt-To: ebadger@gigaio.com, peterz@infradead.org, luto@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, benh@kernel.crashing.org, will@kernel.org, catalin.marinas@arm.com, hch@lst.de, akpm@linux-foundation.org, david@redhat.com, mhocko@kernel.org, dan.j.williams@intel.com, linux-mm@kvack.org, platform-driver-x86@vger.kernel.org, linux-sh@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-ia64@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v3 0/7] Allow setting caching mode in arch_add_memory()
 for P2PDMA
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-02-27 10:43 a.m., Jason Gunthorpe wrote:
> Hm, AFAIK WC memory is not compatible with the spinlocks/mutexs/etc in
> Linux, so while it is true the memory has no side effects, there would
> be surprising concurrency risks if anything in the kernel tried to
> write to it.
> 
> Not compatible means the locks don't contain stores to WC memory the
> way you would expect. AFAIK on many CPUs extra barriers are required
> to keep WC stores ordered, the same way ARM already has extra barriers
> to keep UC stores ordered with locking..
> 
> The spinlocks are defined to contain UC stores though.
> 
> If there is no actual need today for WC I would suggest using UC as
> the default.

Ok, that sounds sensible. I'll do that in the next revision.

Thanks,

Logan
