Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5F1C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2B9206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 18:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727358AbgC1SaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 14:30:18 -0400
Received: from mx.sdf.org ([205.166.94.20]:65465 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727306AbgC1SaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 14:30:18 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02SISIHc011475
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sat, 28 Mar 2020 18:28:18 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02SISHQd007793;
        Sat, 28 Mar 2020 18:28:17 GMT
Date:   Sat, 28 Mar 2020 18:28:17 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, lkml@sdf.org
Subject: [RFC PATCH v1 00/52] Audit kernel random number use
Message-ID: <20200328182817.GE5859@SDF.ORG>
References: <202003281643.02SGhPmY017434@sdf.org>
 <CAPcyv4iagZy5m3FpMrQqyOi=_uCzqh5MjbW+J_xiHU1Z1BmF=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iagZy5m3FpMrQqyOi=_uCzqh5MjbW+J_xiHU1Z1BmF=g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the long Cc list, but this is a treewide cleanup and
I wanted to send this cover letter to everyone.  Individual patches
are Cc: the relevant maintainers, and the whole series can be found
on linux-kernel@vger.

The original itch I wanted to scratch was fixing the numerous
instances of "get_random_u32() % range" and "prandom_u32() % range"
in the kernel.  % is fast to type but slow to execute: even in the
optimized special case that the range is a compile-time constant,
the modulo requires two multiplies to evaluate.

prandom_u32_max() works better; it used reciprocal_scale(), which
ends up doing (u64)prandom_u32() * range >> 32".

This is not only faster and less code, the random numbers are
more uniform.  When the range is not a power of 2, some outputs are
generated more often than others.  With the modulo technique, those
are all the outputs less than 0x100000000 % range.  When multiplying,
the overrepresented outputs are at least spread uniformly across the
possible outputs.

The multiplicative technique can also be easily extended to
generate perfectly uniform random numbers (by detecting an
overrepresented case and looping if it happens) if desired.


But as I started in on the project, I kept finding more things
that needed fixing.  This patch series is what I have ready at the moment.

I could use feedback on individual patches, but also the series as
a whole.  How should it be broken up?  How should it be submitted?

Perhaps, with this series as motivation, merge the random.[ch]
changes, and then do the rest piecemeal?

The series (currently based on v5.5.10) consists of:

01..07: These are various bugs I came across while looking for code to
    replace.  They are independent of the rest of the series, but related.
08: (EXT4) This is a bit of code I'm not sure about.  Sometimes a
    random number is used, and sometimes a hash is used as input to the
    range reduction.  Does the modulo have to be preserved for backward
    compatibility?
09: If the range is a compile-time constant power of 2, then gcc optimizes
    the modulo better than the multiply in prandom_u32_max().  This patch
    fixes that, so that you don't have to worry about the numerical
    value of the range; prandom_u32_max() is always as good or better.
10: This is a very optional patch, for disucssion.  When the range is
    a compile-time constant, making the output of prandom_u32_max()
    perfectly uniform is quite cheap.  This adds the extra test
    and retry loop to that common special case.  Worth bothering?
11: This is the big one (which probably needs to be broken up by
    subsystem), doing a treewide replacement of prandom_u32() % range,
    when the range is not obviously a power of 2.
12: The same, for prandom_u32_state()
13..19: These are patches that were pulled out of the previous two
    because they're involve some more complex code changes.
20..23: Changes to the prandom_u32() generator itself.  Including
    switching to a stronger & faster PRNG.
24..35: Places where crypto-strength get_random_* was used, but only
    pseudorandom numbers are justified.  Examples are:
    - self-test code
    - Seeding other PRNGs
    - random backoffs and timeouts
36..38: Improvements to the batched entropy pool in random.c.
39: (ARM64) Avoid the need for a temporary buffer (and subsequent wiping)
    when transferring random seed material across kexec.
40..44: Replace get_random_bytes() with get_random_{u32,u64,long},
    where the slightly weaker security guarantees of the latter
    suffice.
45: Add a get_random_max() function, using batched crypto-quality
    entropy.  This is more complex than prandom_u32_max()
    because it has to support 64-bit results and is perfectly
    uniform in all cases.
46..49: Use get_random_max in various applications
50: Is the first part of the next phase.  This adds a function to
    fill a byte buffer from the batched entropy buffer, a drop-in
    replacement for get_random_bytes().  I'm particularly seeking
    comment on what this function, with its different security
    guarantees, should be called.  One option I'm considering is
    to name it get_random_bytes, and move the (relatively few)
    call sites that really need unbacktrackable random numbers
    to another name like get_secret_bytes().

George Spelvin (50):
  IB/qib: Delete struct qib_ivdev.qp_rnd
  lib/fault-inject.c: Fix off-by-one error in probability
  fault-inject: Shrink struct fault_attr
  batman-adv: fix batadv_nc_random_weight_tq
  net/rds/bind.c: Use prandom_u32_max()
  ubi/debug: Optimize computation of odds
  mm/slab: Use simpler Fisher-Yates shuffle
  fs/ext4/ialloc.c: Replace % with reciprocal_scale() TO BE VERIFIED
  <linux/random.h> prandom_u32_max() for power-of-2 ranges
  <linux/random.h> Make prandom_u32_max() exact for constant ranges
  Treewide: Extirpate "prandom_u32() % range"
  Treewide: Extirpate prandom_u32_state(rnd) % range
  Avoid some useless msecs/jiffies conversions
  crypto/testmgr.c: use prandom_u32_max() & prandom_bytes()
  drivers/block/drbd/drbd_main: fix _drbd_fault_random()
  include/net/red.h: Simplify red_random() TO BE VERIFIED
  net/802/{garp,mrp}.c: Use prandom_u32_max instead of manual equivalent
  net/ipv6/addrconf.c: Use prandom_u32_max for rfc3315 backoff time computation
  net/sched/sch_netem: Simplify get_crandom
  lib/random32: Move prandom_warmup() inside prandom_seed_early()
  lib/random32.c: Change to SFC32 PRNG
  lib/random32: Use random_ready_callback for seeding.
  prandom_seed_state(): Change to 32-bit seed type.
  crypto4xx_core: Use more appropriate seed for PRNG
  HID: hid-lg: We only need pseudorandom bytes for the address
  drivers/nfc/nfcsim: use prandom_32() for time delay
  drivers/s390/scsi/zcsp_fc.c: Use prandom_u32_max() for backoff
  drivers/target/iscsi: Replace O(n^2) randomization
  fs/ocfs2/journal: Use prandom_u32() and not /dev/random for timeout
  kernel/locking/test-ww_mutex.c: Use cheaper prandom_u32_max()
  lib/nodemask.c: Use cheaper prandom_u32_max() in node_random()
  lib/test*.c: Use prandom_u32_max()
  lib/test_vmalloc.c: Use pseudorandom numbers
  mm/slub.c: Use cheaper prandom source in shuffle_freelist
  USB: serial: iuu_phoenix: Use pseudorandom for xmas mode
  random: Merge batched entropy buffers
  random: Simplify locking of batched entropy
  random: use chacha_permute() directly
  arm: kexec_file: Avoid temp buffer for RNG seed
  arch/*/include/asm/stackprotector.h: Use get_random_canary() consistently
  drivers/block/drbd/drbd_nl.c: Use get_random_u64()
  drivers/ininiband: Use get_random_u32()
  drivers/isdn: Use get_random_u32()
  arm64: ptr auth: Use get_random_u64 instead of _bytes
  random: add get_random_max() function
  mm/shuffle.c: use get_random_max()
  kernel/bpf/core.c: Use get_random_max32()
  arch/arm/kernel/process.c: Use get_random_max32() for sigpage_addr()
  arch/x86/entry/vdso/vma.c: Use get_random_max32() for vdso_addr
  random: add get_random_nonce()

 arch/arm/include/asm/stackprotector.h         |   9 +-
 arch/arm/kernel/process.c                     |   2 +-
 arch/arm64/include/asm/pointer_auth.h         |  20 +-
 arch/arm64/include/asm/stackprotector.h       |   8 +-
 arch/arm64/kernel/machine_kexec_file.c        |   8 +-
 arch/arm64/kernel/pointer_auth.c              |  62 +-
 arch/mips/include/asm/stackprotector.h        |   7 +-
 arch/powerpc/include/asm/stackprotector.h     |   6 +-
 arch/sh/include/asm/stackprotector.h          |   8 +-
 arch/x86/entry/vdso/vma.c                     |   2 +-
 arch/x86/include/asm/stackprotector.h         |   4 +-
 arch/x86/mm/pageattr-test.c                   |   4 +-
 arch/xtensa/include/asm/stackprotector.h      |   7 +-
 crypto/testmgr.c                              |  21 +-
 drivers/block/drbd/drbd_main.c                |  37 +-
 drivers/block/drbd/drbd_nl.c                  |   4 +-
 drivers/char/random.c                         | 581 +++++++++++++-----
 drivers/crypto/amcc/crypto4xx_core.c          |   7 +-
 drivers/crypto/chelsio/chtls/chtls_io.c       |   4 +-
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c |   2 +-
 drivers/gpu/drm/i915/selftests/scatterlist.c  |   4 +-
 drivers/hid/hid-lg.c                          |   2 +-
 drivers/infiniband/core/cm.c                  |   2 +-
 drivers/infiniband/core/cma.c                 |   5 +-
 drivers/infiniband/core/sa_query.c            |   2 +-
 drivers/infiniband/hw/cxgb4/id_table.c        |   4 +-
 drivers/infiniband/hw/i40iw/i40iw_verbs.c     |   2 +-
 drivers/infiniband/hw/qib/qib_verbs.c         |   2 -
 drivers/infiniband/hw/qib/qib_verbs.h         |   1 -
 drivers/infiniband/sw/siw/siw_mem.c           |   9 +-
 drivers/infiniband/sw/siw/siw_verbs.c         |   2 +-
 drivers/infiniband/ulp/srp/ib_srp.c           |   3 +-
 drivers/isdn/mISDN/tei.c                      |   5 +-
 drivers/mmc/core/core.c                       |   4 +-
 drivers/mtd/nand/raw/nandsim.c                |   4 +-
 drivers/mtd/tests/mtd_nandecctest.c           |  10 +-
 drivers/mtd/tests/stresstest.c                |  15 +-
 drivers/mtd/ubi/debug.c                       |   2 +-
 drivers/mtd/ubi/debug.h                       |   6 +-
 drivers/net/ethernet/broadcom/cnic.c          |   3 +-
 .../broadcom/brcm80211/brcmfmac/p2p.c         |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   2 +-
 drivers/nfc/nfcsim.c                          |   3 +-
 drivers/s390/scsi/zfcp_fc.c                   |   2 +-
 drivers/scsi/fcoe/fcoe_ctlr.c                 |  10 +-
 drivers/scsi/qedi/qedi_main.c                 |   2 +-
 .../target/iscsi/iscsi_target_seq_pdu_list.c  |  72 +--
 drivers/usb/serial/iuu_phoenix.c              |   7 +-
 fs/ceph/inode.c                               |   2 +-
 fs/ceph/mdsmap.c                              |   2 +-
 fs/ext2/ialloc.c                              |   3 +-
 fs/ext4/ialloc.c                              |   5 +-
 fs/ext4/super.c                               |   8 +-
 fs/ocfs2/journal.c                            |   7 +-
 fs/ubifs/debug.c                              |  11 +-
 fs/ubifs/lpt_commit.c                         |  12 +-
 fs/xfs/xfs_error.c                            |   2 +-
 include/crypto/chacha.h                       |   1 +
 include/linux/fault-inject.h                  |   4 +-
 include/linux/random.h                        | 279 ++++++++-
 include/net/red.h                             |  22 +-
 kernel/bpf/core.c                             |   4 +-
 kernel/locking/test-ww_mutex.c                |  23 +-
 lib/crypto/chacha.c                           |   2 +-
 lib/fault-inject.c                            |  12 +-
 lib/find_bit_benchmark.c                      |   4 +-
 lib/interval_tree_test.c                      |   9 +-
 lib/nodemask.c                                |   2 +-
 lib/random32.c                                | 558 +++++++++--------
 lib/rbtree_test.c                             |   2 +-
 lib/reed_solomon/test_rslib.c                 |   4 +-
 lib/sbitmap.c                                 |   7 +-
 lib/test-string_helpers.c                     |   2 +-
 lib/test_bpf.c                                |   2 +-
 lib/test_hexdump.c                            |  10 +-
 lib/test_list_sort.c                          |   2 +-
 lib/test_parman.c                             |   2 +-
 lib/test_vmalloc.c                            |  58 +-
 mm/shuffle.c                                  |   2 +-
 mm/slab.c                                     |  25 +-
 mm/slab_common.c                              |  15 +-
 mm/slub.c                                     |   2 +-
 mm/swapfile.c                                 |   2 +-
 net/802/garp.c                                |   2 +-
 net/802/mrp.c                                 |   2 +-
 net/batman-adv/bat_iv_ogm.c                   |   4 +-
 net/batman-adv/bat_v_elp.c                    |   2 +-
 net/batman-adv/bat_v_ogm.c                    |  10 +-
 net/batman-adv/network-coding.c               |   9 +-
 net/bluetooth/hci_request.c                   |   2 +-
 net/ceph/mon_client.c                         |   2 +-
 net/core/neighbour.c                          |   6 +-
 net/core/pktgen.c                             |  20 +-
 net/core/stream.c                             |   2 +-
 net/ipv4/igmp.c                               |   6 +-
 net/ipv4/inet_connection_sock.c               |   2 +-
 net/ipv6/addrconf.c                           |  17 +-
 net/ipv6/mcast.c                              |  10 +-
 net/packet/af_packet.c                        |   2 +-
 net/rds/bind.c                                |   2 +-
 net/sched/act_gact.c                          |   2 +-
 net/sched/act_sample.c                        |   2 +-
 net/sched/sch_netem.c                         |  23 +-
 net/sctp/socket.c                             |   2 +-
 net/sunrpc/xprtsock.c                         |   2 +-
 net/tipc/socket.c                             |   5 +-
 net/wireless/scan.c                           |   2 +-
 net/xfrm/xfrm_state.c                         |   2 +-
 sound/core/pcm_lib.c                          |   2 +-
 sound/core/pcm_native.c                       |   2 +-
 110 files changed, 1324 insertions(+), 917 deletions(-)

-- 
2.26.0
