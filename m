Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C6E4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7826920734
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 11:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFQLTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 07:19:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:40411 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgFQLTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:19:38 -0400
IronPort-SDR: Wi+snSSEufq5td9Hr5ZCfhdRus2MWeDzAqIDUZ1B6+vZlAJqBOoIo0as/0aASXiwJdv8UYfRBX
 /rx5FvcTdPQg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2020 04:19:04 -0700
IronPort-SDR: 6H/Ig+zZ5rpAN2VVOGuvle3LT4zr6uyUyExC0md+cAZa3QTY6ct2294lEBNEbRlU2HBNN64Ndd
 I3dYDWJ4Xacw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,522,1583222400"; 
   d="gz'50?scan'50,208,50";a="308764950"
Received: from lkp-server02.sh.intel.com (HELO acd172f646ee) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Jun 2020 04:19:01 -0700
Received: from kbuild by acd172f646ee with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jlW5s-00002I-Sc; Wed, 17 Jun 2020 11:19:00 +0000
Date:   Wed, 17 Jun 2020 19:18:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yi Wang <wang.yi59@zte.com.cn>, cl@linux.com
Cc:     kbuild-all@lists.01.org, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        wang.liang82@zte.com.cn
Subject: Re: [PATCH] mm, slab: Use kmem_cache_zalloc() instead of
 kmem_cache_alloc() with flag GFP_ZERO.
Message-ID: <202006171950.OOdnEPis%lkp@intel.com>
References: <1592378156-7748-1-git-send-email-wang.yi59@zte.com.cn>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BXVAT5kNtrzKuDFl"
Content-Disposition: inline
In-Reply-To: <1592378156-7748-1-git-send-email-wang.yi59@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Yi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on mmotm/master]

url:    https://github.com/0day-ci/linux/commits/Yi-Wang/mm-slab-Use-kmem_cache_zalloc-instead-of-kmem_cache_alloc-with-flag-GFP_ZERO/20200617-151513
base:   git://git.cmpxchg.org/linux-mmotm.git master
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

In file included from include/linux/irq.h:21,
from include/asm-generic/hardirq.h:13,
from ./arch/nds32/include/generated/asm/hardirq.h:1,
from include/linux/hardirq.h:9,
from include/linux/highmem.h:10,
from include/linux/pagemap.h:11,
from fs//crypto/crypto.c:23:
include/linux/slab.h: In function 'kmem_cache_zalloc':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/slab.h: In function 'fscrypt_get_ctx':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/slab.h: In function 'fscrypt_initialize':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
In file included from include/linux/irq.h:21,
from include/asm-generic/hardirq.h:13,
from ./arch/nds32/include/generated/asm/hardirq.h:1,
from include/linux/hardirq.h:9,
from include/linux/highmem.h:10,
from include/linux/pagemap.h:11,
from fs//ext4/page-io.c:13:
include/linux/slab.h: In function 'kmem_cache_zalloc':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/slab.h: In function 'ext4_init_io_end':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
In file included from include/linux/genhd.h:16,
from include/linux/blkdev.h:11,
from include/linux/backing-dev.h:15,
from fs//fuse/fuse_i.h:23,
from fs//fuse/dev.c:9:
include/linux/slab.h: In function 'kmem_cache_zalloc':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/slab.h: In function '__fuse_request_alloc':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
In file included from include/linux/irq.h:21,
from include/asm-generic/hardirq.h:13,
from ./arch/nds32/include/generated/asm/hardirq.h:1,
from include/linux/hardirq.h:9,
from include/linux/highmem.h:10,
from include/linux/pagemap.h:11,
from include/linux/buffer_head.h:14,
from include/linux/jbd2.h:23,
from fs//jbd2/transaction.c:19:
include/linux/slab.h: In function 'kmem_cache_zalloc':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/slab.h: In function 'start_this_handle':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/slab.h: In function 'jbd2__journal_start':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
--
In file included from include/linux/irq.h:21,
from include/asm-generic/hardirq.h:13,
from ./arch/nds32/include/generated/asm/hardirq.h:1,
from include/linux/hardirq.h:9,
from include/linux/highmem.h:10,
from include/linux/pagemap.h:11,
from include/linux/buffer_head.h:14,
from include/linux/jbd2.h:23,
from fs//jbd2/journal.c:25:
include/linux/slab.h: In function 'kmem_cache_zalloc':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/slab.h: In function 'jbd2_journal_add_journal_head':
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/slab.h:678:21: error: inlining failed in call to always_inline 'kmem_cache_zalloc': recursive inlining
678 | static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
|                     ^~~~~~~~~~~~~~~~~
include/linux/slab.h:680:9: note: called from here
680 |  return kmem_cache_zalloc(k, flags);
|         ^~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/kmem_cache_zalloc +678 include/linux/slab.h

10cef602950291 Matt Mackall      2006-01-08  674  
81cda6626178cd Christoph Lameter 2007-07-17  675  /*
81cda6626178cd Christoph Lameter 2007-07-17  676   * Shortcuts
81cda6626178cd Christoph Lameter 2007-07-17  677   */
81cda6626178cd Christoph Lameter 2007-07-17 @678  static inline void *kmem_cache_zalloc(struct kmem_cache *k, gfp_t flags)
81cda6626178cd Christoph Lameter 2007-07-17  679  {
3b0c169b666d29 Liao Pingfang     2020-06-17  680  	return kmem_cache_zalloc(k, flags);
81cda6626178cd Christoph Lameter 2007-07-17  681  }
81cda6626178cd Christoph Lameter 2007-07-17  682  

:::::: The code at line 678 was first introduced by commit
:::::: 81cda6626178cd55297831296ba8ecedbfd8b52d Slab allocators: Cleanup zeroing allocations

:::::: TO: Christoph Lameter <clameter@sgi.com>
:::::: CC: Linus Torvalds <torvalds@woody.linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--BXVAT5kNtrzKuDFl
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--BXVAT5kNtrzKuDFl--
