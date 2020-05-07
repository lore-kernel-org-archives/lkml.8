Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CCCC54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D69D208D6
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588884783;
	bh=TyVMubmSwnb6HspI26I671gs2+xz/BioghUujIiqGH8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bt4/BpUno+kFKp24SlpafZnDHiOvvB+fI74kykl9BTRibVIGdlOpzfWUUY3AwyrRF
	 JMdlSASX42FfH9xLEzVNP1F+F4UdBSis//4Sac9IGis0ALfYbJZx7O2sfuRoE/rDPz
	 rY6zsA5p34ubmqygC1Exl1yldnXkVgz15EaUCF8Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgEGUxC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:53:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:34952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbgEGUxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:53:02 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2E7920735;
        Thu,  7 May 2020 20:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588884780;
        bh=TyVMubmSwnb6HspI26I671gs2+xz/BioghUujIiqGH8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pLECSGx/bjY/e6dPZHg/pogKtFknD7CQxEbYnTijPvo31G65TH5qkje/0482SYoYN
         DUxu9XSArBxL1RHMChRsQBx2Ke74CL6dm6TMRGPJJfX7xkDXTBpZl44fWyvfgMqhU0
         epsvy3zKnV8VlRwcWKCyI4E8L4mB8LcbloZDf/RA=
Date:   Thu, 7 May 2020 13:52:58 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     ira.weiny@intel.com
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, dri-devel@lists.freedesktop.org,
        Christian Koenig <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 13/15] parisc/kmap: Remove duplicate kmap code
Message-Id: <20200507135258.f430182578c0d63b7488916e@linux-foundation.org>
In-Reply-To: <20200507150004.1423069-14-ira.weiny@intel.com>
References: <20200507150004.1423069-1-ira.weiny@intel.com>
        <20200507150004.1423069-14-ira.weiny@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 May 2020 08:00:01 -0700 ira.weiny@intel.com wrote:

> parisc reimplements the kmap calls except to flush it's dcache.  This is
> arguably an abuse of kmap but regardless it is messy and confusing.
> 
> Remove the duplicate code and have parisc define
> ARCH_HAS_FLUSH_ON_KUNMAP for a kunmap_flush_on_unmap() architecture
> specific call to flush the cache.

checkpatch says:

ERROR: #define of 'ARCH_HAS_FLUSH_ON_KUNMAP' is wrong - use Kconfig variables or standard guards instead
#69: FILE: arch/parisc/include/asm/cacheflush.h:103:
+#define ARCH_HAS_FLUSH_ON_KUNMAP

which is fair enough, I guess.  More conventional would be

arch/parisc/include/asm/cacheflush.h:

static inline void kunmap_flush_on_unmap(void *addr)
{
	...
}
#define kunmap_flush_on_unmap kunmap_flush_on_unmap


include/linux/highmem.h:

#ifndef kunmap_flush_on_unmap
static inline void kunmap_flush_on_unmap(void *addr)
{
}
#define kunmap_flush_on_unmap kunmap_flush_on_unmap
#endif


static inline void kunmap_atomic_high(void *addr)
{
	/* Mostly nothing to do in the CONFIG_HIGHMEM=n case as kunmap_atomic()
	 * handles re-enabling faults + preemption */
	kunmap_flush_on_unmap(addr);
}


but I don't really think it's worth bothering changing it.	

(Ditto patch 3/15)
