Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43EDC2D0EE
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB8320786
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 01:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728963AbgC3BLM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 21:11:12 -0400
Received: from mga11.intel.com ([192.55.52.93]:7816 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbgC3BLL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 21:11:11 -0400
IronPort-SDR: 5n+Ld7Z3rL/vecF+yoy5byyQ7STUmqxj6qtzF09eXbMrDfw650Oul6t63zX06HQfjfaVBV6wP7
 RQXebHx9MWNQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2020 18:11:10 -0700
IronPort-SDR: 94ZtHd5vqXMv1OJvnLOQCLMq5tegO5pQMKrqTQKwPRRV++/my5NqSIStnFsQY1E7VHwjvAw6tR
 1uhKMEcCHNFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,322,1580803200"; 
   d="scan'208";a="448086109"
Received: from feng-iot.sh.intel.com (HELO localhost) ([10.239.13.114])
  by fmsmga005.fm.intel.com with ESMTP; 29 Mar 2020 18:11:09 -0700
Date:   Mon, 30 Mar 2020 09:12:54 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Chen, Rong A" <rong.a.chen@intel.com>,
        Jann Horn <jannh@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Subject: Re: [LKP] Re: [mm] fd4d9c7d0c: stress-ng.switch.ops_per_sec -30.5%
 regression
Message-ID: <20200330011254.GA14393@feng-iot>
References: <20200326055723.GL11705@shao2-debian>
 <CAHk-=wi2c3UcK4fjUR2nM-7iUOAyQijq9ETfQHaN0WwFh2Bm9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wi2c3UcK4fjUR2nM-7iUOAyQijq9ETfQHaN0WwFh2Bm9A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Fri, Mar 27, 2020 at 12:57:45AM +0800, Linus Torvalds wrote:
> On Wed, Mar 25, 2020 at 10:57 PM kernel test robot
> <rong.a.chen@intel.com> wrote:
> >
> > FYI, we noticed a -30.5% regression of stress-ng.switch.ops_per_sec due to commit:
> >
> > commit: fd4d9c7d0c71866ec0c2825189ebd2ce35bd95b8 ("mm: slub: add missing TID bump in kmem_cache_alloc_bulk()")
> 
> This looks odd.
> 
> I would not expect the update of c->tid to have that noticeable an
> impact, even on a big machine that might be close to some scaling
> limit.
 
The test machin is a Cascade Lake platform, 2 sockets, 48C/96T.

> It doesn't add any expensive atomic ops, and while it _could_ make a
> percpu cacheline dirty, I think that cacheline should already be dirty
> anyway under any load where this is noticeable. Plus this should be a
> relatively cold path anyway.
> 
> So mind humoring me, and double-check that regression?
> 
> Of course, it might be another "just magic cache placement" detail
> where code moved enough to make a difference.
> 
> Or maybe it really ends up causing new tid mismatches and we end up
> failing the fast path in slub as a result. But looking at the stats
> that changed in your message doesn't make me go "yeah, that looks like
> a slub difference".

Per our check, the code movement does exist.

From the system map:

old map:
	ffffffff812a1880 T kmem_cache_alloc_bulk
	ffffffff812a1a80 t kmalloc_large_node
	ffffffff812a1b10 t calculate_sizes
	ffffffff812a1eb0 t store_user_store
	ffffffff812a1f20 t poison_store
	ffffffff812a1f90 t red_zone_store
	ffffffff812a2000 t order_store

new map:
	ffffffff812a1880 T kmem_cache_alloc_bulk
	ffffffff812a1a90 t kmalloc_large_node
	ffffffff812a1b20 T __kmalloc_node	---> relocated
	ffffffff812a1e40 t calculate_sizes
	ffffffff812a21e0 t store_user_store
	ffffffff812a2250 t poison_store
	ffffffff812a22c0 t red_zone_store
	ffffffff812a2330 t order_store

In old map the 'kmem_cache_alloc_bulk' is cache aligned, and occupies
0x200 bytes, and the next function 'kmalloc_large_node' starts at
an alinged address. In new map 'kmem_cache_alloc_bulk' occupies
0x210 bytes, and offset of the alignment of many functions following
it. (please let us know if you need the full system map for the
2 vmlinuxs)

From the objdump, the direct chagne of "c->tid = next_tid(c->tid);" 
is one line added "49 83 40 08 01	addq   $0x1,0x8(%r8)"

We did experiments to make the kernel functions 32 bytes aligned,
----------------------------------------------------------------
diff --git a/Makefile b/Makefile
index 171f2b004c8a..63f28aaf78c9 100644
--- a/Makefile
+++ b/Makefile
 
 KBUILD_AFLAGS   := -D__ASSEMBLY__ -fno-PIE
-KBUILD_CFLAGS   := -Wall -Wundef -Werror=strict-prototypes -Wno-trigraphs \
+KBUILD_CFLAGS   := -Wall -Wundef -falign-functions=32 -Werror=strict-prototypes -Wno-trigraphs \
----------------------------------------------------------------
 
the regression is reduced to about 3%:

2060457 ±  4%      -3.2%    1993685 ±  2%  stress-ng.switch.ops_per_sec

which is pretty small for a micro-benchmark

Thanks,
Feng
