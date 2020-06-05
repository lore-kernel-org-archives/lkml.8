Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A09D1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA4E2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 18:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591382524;
	bh=d4myap8Ha8AYUx+Hd3NZUHePqnuTgf5hgvgT0tbjNO0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=FTZ75cR1dIg1hRT05UjHIITvppJ7hukMrrxtrezqz8wR5TA0mrrpOW1NUesN7ISPJ
	 8EcoIq8q8QLpum4oxiZ/hQ2kufVspA2c34aT48XXf96c+eB+syXehqbR4ddPkzLnaT
	 D/oW8Ysbm0GSTPd6NgEAZdNA7nrDOockj6EHZhuQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgFESmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:42:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:51246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbgFESmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 14:42:02 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E9D1206FA;
        Fri,  5 Jun 2020 18:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591382520;
        bh=d4myap8Ha8AYUx+Hd3NZUHePqnuTgf5hgvgT0tbjNO0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=zn3BDXeZV9DBpuNO3uRhkrsZ30phVgfz/FTM+u2GUHKYCQidWEz3bkhKQipWGCjnd
         sNhyc4DB9T3N2WQOM5GM9F6kNHYIpon30AQ3Kgauynkl/Zo/6zdl3hlfOR3OvqNm/3
         POFLDg9m/G1Fq848o7ndr9s2dDwC/FbD37ZOUpkw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D8D143522B47; Fri,  5 Jun 2020 11:41:59 -0700 (PDT)
Date:   Fri, 5 Jun 2020 11:41:59 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
Message-ID: <20200605184159.GA4062@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200604225445.GA32319@paulmck-ThinkPad-P72>
 <20200605131451.GE2750@hirez.programming.kicks-ass.net>
 <20200605141607.GB4455@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605141607.GB4455@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 07:16:07AM -0700, Paul E. McKenney wrote:
> On Fri, Jun 05, 2020 at 03:14:51PM +0200, Peter Zijlstra wrote:
> 
> No KCSAN.  GCC 8.2.1.  No cgroups unless the kernel creates some.
> No userspace other than a C-language binary named "init" that
> sleeps in an infinite loop.
> 
> .config attached.

And in case it is helpful, here is the output of "git bisect view",
which lists rather more commits than "git bisect run" claims, but there
are only a few scheduler commits below.  I don't see anything that
I can prove can cause this problem, but there are some that are at
least related to this code path.

Is there anything that is actually relevant?

						Thanx, Paul

------------------------------------------------------------------------
Semi-plausible to my admittedly untrained eye:
------------------------------------------------------------------------
a148866489fbe243c936fe43e4525d8dbfa0318f sched: Replace rq::wake_list
126c2092e5c8b28623cb890cd2930aa292410676 sched: Add rq::ttwu_pending
2ebb17717550607bcd85fb8cf7d24ac870e9d762 sched/core: Offload wakee task activation if it the wakee is descheduling
c6e7bd7afaeb3af55ffac122828035f1c01d1d7b sched/core: Optimize ttwu() spinning on p->on_cpu
7d148be69e3a0eaa9d029a3c51b545e322116a99 sched/fair: Optimize enqueue_task_fair()

------------------------------------------------------------------------
Full list, which includes quite a few additional sched-related commits:
------------------------------------------------------------------------
e8f4abf8fd1a2beb94983cb95ed713df75b3d135 Merge branch 'uaccess.csum' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
174e1ea8a2f6140078b6c61068b478cf3c4aa74f fix a braino in ia64 uaccess csum changes
e7c93cbfe9cb4b0a47633099e78c455b1f79bbac Merge tag 'threads-v5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
d479c5a1919b4e569dcd3ae9c84ed74a675d0b94 Merge tag 'sched-core-2020-06-02' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
f6aee505c71bbb035dde146caf5a6abbf3ccbe47 Merge tag 'x86-timers-2020-06-03' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
dabc4df27c628866ede130a09121f255ca894d8c Merge tag 'timers-core-2020-06-02' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
f6606d0c0010953e4c28c8662623662b5108b4ce Merge tag 'irq-core-2020-06-02' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
d6f9469a03d832dcd17041ed67774ffb5f3e73b3 Merge tag 'erofs-for-5.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs
cadf32234b6f6dd96a0892bf915e3ee8c438cf07 Merge tag 'jfs-5.8' of git://github.com/kleikamp/linux-shaggy
f3cdc8ae116e27d84e1f33c7a2995960cebb73ac Merge tag 'for-5.8-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
8eeae5bae1239c030ba0b34cac97ebd5e7ec1886 Merge tag 'vfs-5.8-merge-2' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
96ed320d527eb071389f69cbd6772440805af7d7 Merge tag 'vfs-5.8-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
16d91548d1057691979de4686693f0ff92f46000 Merge tag 'xfs-5.8-merge-8' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux
25de110d148666752dc0e0da7a0b69de31cd7098 irq_work: Define irq_work_single() on !CONFIG_IRQ_WORK too
d77aeb5d403d379ff458e04fc07b5b86700270f2 irqchip: Fix "Loongson HyperTransport Vector support" driver build on all non-MIPS platforms
76fe06c1e68b8f8dfb63d5b268623830dcb16ed0 Merge tag 'irqchip-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core
34f853b849eb6a509eb8f40f2f5946ebb1f62739 erofs: suppress false positive last_block warning
f57a3fe44995a3820192e0cf7c3ebdecedd9586e erofs: convert to use the new mount fs_context api
da10a4b626657387845f32d37141fc7d48ebbdb3 dt-bindings: interrupt-controller: Add Loongson PCH MSI
632dcc2c75ef6de3272aa4ddd8f19da1f1ace323 irqchip: Add Loongson PCH MSI controller
b6e4bc125fc517969f97d901b1845ebf47bbea26 dt-bindings: interrupt-controller: Add Loongson PCH PIC
ef8c01eb64ca6719da449dab0aa9424e13c58bd0 irqchip: Add Loongson PCH PIC controller
6c2832c3c6edc38ab58bad29731b4951c0a90cf8 dt-bindings: interrupt-controller: Add Loongson HTVEC
818e915fbac518e8c78e1877a0048d92d4965e5a irqchip: Add Loongson HyperTransport Vector support
1d0326f352bb094771df17f045bdbadff89a43e6 genirq: Check irq_data_get_irq_chip() return value before use
2166e5edce9ac1edf3b113d6091ef72fcac2d6c4 btrfs: fix space_info bytes_may_use underflow during space cache writeout
467dc47ea99c56e966e99d09dae54869850abeeb btrfs: fix space_info bytes_may_use underflow after nocow buffered write
e2c8e92d1140754073ad3799eb6620c76bab2078 btrfs: fix wrong file range cleanup after an error filling dealloc range
213ff4b72a9c7509dd85979db64c66774f4f26c1 btrfs: remove redundant local variable in read_block_for_search
995e9a166b6909c9bb4af8f51b9502f8b8c18291 btrfs: open code key_search
d8f3e73587ce574f7a9bc165e0db69b0b148f6f8 btrfs: split btrfs_direct_IO to read and write part
5f008163a559d566a0ee1190a0a24f3eec6f1ea7 btrfs: remove BTRFS_INODE_READDIO_NEED_LOCK
b75b7ca7c27dfd61dba368f390b7d4dc20b3a8cb fs: remove dio_end_io()
a43a67a2d715540c1368b9501a22b0373b5874c0 btrfs: switch to iomap_dio_rw() for dio
1f8db4150536431b031585ecc2a6793f69245de2 sched/headers: Split out open-coded prototypes into kernel/sched/smp.h
a148866489fbe243c936fe43e4525d8dbfa0318f sched: Replace rq::wake_list
126c2092e5c8b28623cb890cd2930aa292410676 sched: Add rq::ttwu_pending
4b44a21dd640b692d4e9b12d3e37c24825f90baa irq_work, smp: Allow irq_work on call_single_queue
b2a02fc43a1f40ef4eb2fb2b06357382608d4d84 smp: Optimize send_call_function_single_ipi()
afaa653c564da38c0b34c4baba31e88c46a8764c smp: Move irq_work_run() out of flush_smp_call_function_queue()
52103be07d8b08311955f8c30e535c2dda290cf4 smp: Optimize flush_smp_call_function_queue()
19a1f5ec699954d21be10f74ff71c2a7079e99ad sched: Fix smp_call_function_single_async() usage for ILB
58ef57b16d9e91cce1c640a6fe8a21d53a85181d Merge branch 'core/rcu' into sched/core, to pick up dependency
498bdcdb949e879d4a45f415468aef802a3dff4a Merge branch 'sched/urgent' into sched/core, to pick up fix
6dcde60efd946e38fac8d276a6ca47492103e856 xfs: more lockdep whackamole with kmem_alloc*
a5949d3faedf492fa7863b914da408047ab46eb0 xfs: force writes to delalloc regions to unwritten
590b16516ef38e2e88674fe0a0cea39927a8ee2e xfs: refactor xfs_iomap_prealloc_size
f0322c7cc05eb23ef034775f9b39254cbd4f3678 xfs: measure all contiguous previous extents for prealloc size
1edd2c055dff9710b1e29d4df01902abb0a55f1f xfs: don't fail unwritten extent conversion on writeback due to edquot
964176bd32da9847112b505f57ee6e602ee5c84d xfs: rearrange xfs_inode_walk_ag parameters
042f65f4a79c819d74309c2607959fccacc4094a xfs: straighten out all the naming around incore inode tree walks
5662d38ccdbd9e5c816f5c0b7f490a29729217b0 xfs: move xfs_inode_ag_iterator to be closer to the perag walking code
7e88d31423e2874be03f8ebc6274c917f674743a xfs: use bool for done in xfs_inode_ag_walk
39b1cfd75b278f5cb1e58517f6ec1ac9ef16d9f4 xfs: fix inode ag walk predicate function return values
a91bf9928e1e16dd175ff363efa54ebc9e38d53d xfs: refactor eofb matching into a single helper
8921a0fda54adf0a45ef15a9507594829e4ec6f5 xfs: remove __xfs_icache_free_eofblocks
390600f811f1adfb9158e9b670b81219a9d94d72 xfs: remove flags argument from xfs_inode_ag_walk
9be0590453cdae1b7aa2eb08515cc140ecc850c3 xfs: remove xfs_inode_ag_iterator_flags
43d24bcf19d139b904752b5727def241920cff37 xfs: remove unused xfs_inode_ag_iterator function
fc96be95e6c612eb77c0c0306cef2da1b8a243f9 xfs: replace open-coded XFS_ICI_NO_TAG
3737bb2c67770afea6362aeaf4f48a969d119777 xfs: move eofblocks conversion function to xfs_ioctl.c
df42ce64dc3eb7f01f8b601abd3881c6dddfbbaa xfs: allow individual quota grace period extension
e850301f0981741c47f5ee423380a2a963fce563 xfs: per-type quota timers and warn limits
ce6e7e79ced35a8ba4576d70bb999e8835f95769 xfs: switch xfs_get_defquota to take explicit type
3dbb9aa310089702ac1023296d26672f36ea4096 xfs: pass xfs_dquot to xfs_qm_adjust_dqtimers
8d077f5bfc273a85ea4c665d4f15b7fd06b97c20 xfs: fix up some whitespace in quota code
dcf1ccc99e6db06a3a3cc9f72161f7d084a38d40 xfs: always return -ENOSPC on project quota reservation failure
c8d329f311c4d3d8f8e6dc5897ec235e37f48ae8 xfs: group quota should return EDQUOT when prj quota enabled
b41b46c20c0bd32cd0a3795fcd2b892213cb6f5e xfs: remove the m_active_trans counter
b0dff466c00975a3e3ec97e6b0266bfd3e4805d6 xfs: separate read-only variables in struct xfs_mount
f18c9a9030972d892a244968c653aceb98e27c70 xfs: reduce free inode accounting overhead
dc3ffbb14060c943469d5e12900db3a60bc3fa64 xfs: gut error handling in xfs_trans_unreserve_and_mod_sb()
e7cda1ee94f464e02e356319aec7d83ccba8cab4 erofs: code cleanup by removing ifdef macro surrounding
3ad99bec6e82e32fa9faf2f84e74b134586b46f7 iomap: remove lockdep_assert_held()
8cecd0ba854799cda72d03a470e7de9eed3ed6c4 iomap: add a filesystem hook for direct I/O bio submission
d85dc2e116fdce776280224ed2bee4c78e5e5af2 fs: export generic_file_buffered_read()
0e375f51017bcc86c23979118b10445c424ef5ad irqchip/sifive-plic: Improve boot prints for multiple PLIC instances
2234ae846ccb9ebdf4c391824cb79e73674dceda irqchip/sifive-plic: Setup cpuhp once after boot CPU handler is present
2458ed31e9b9ab40d78a452ab2650a0857556e85 irqchip/sifive-plic: Set default irq affinity in plic_irqdomain_map()
cc86432aa8cc5a81f99d79eea2a29099da694df3 irqchip/gic-v2, v3: Drop extra IRQ_NOAUTOEN setting for (E)PPIs
bbcd1f4d52587d4f6a90692d896cf06a37b6554a btrfs: turn space cache writeout failure messages into debug messages
2e69a7a60d8d93b19f520bf4179614188a6cfdf5 btrfs: include error on messages about failure to write space/inode caches
918cdf442326e5eaa808258e403c6a6e2dc23113 btrfs: remove useless 'fail_unlock' label from btrfs_csum_file_blocks()
7e4a3f7ed5d54926ec671bbb13e171cfe179cc50 btrfs: do not ignore error from btrfs_next_leaf() when inserting checksums
cc14600c1516f6c679cab1c503a34841d58050a6 btrfs: make checksum item extension more efficient
e289f03ea79bbc6574b78ac25682555423a91cbb btrfs: fix corrupt log due to concurrent fsync of inodes with shared extents
adbab6420c973f37079b1ce9b7e8a12f54810250 btrfs: unexport btrfs_compress_set_level()
0202e83fdab05b3bf641804afea57a2bfcbcbd70 btrfs: simplify iget helpers
a820feb546842a4ab5678279a62d4450320e6696 btrfs: open code read_fs_root
56e9357a1e8167134388d4c70654795353765c7b btrfs: simplify root lookup by id
1dae7e0e58b484eaa43d530f211098fdeeb0f404 btrfs: reloc: clear DEAD_RELOC_TREE bit for orphan roots to prevent runaway balance
51415b6c1b117e223bc083e30af675cb5c5498f3 btrfs: reloc: fix reloc root leak and NULL pointer dereference
c11fbb6ed0ddc11b992f9c668b79505d31956368 btrfs: reduce lock contention when creating snapshot
aeb935a455812e0ec15e15801f7a42d887e6c22f btrfs: don't set SHAREABLE flag for data reloc tree
82028e0a2a9b7a3db6ef1f1885c580a37ab9eebb btrfs: inode: cleanup the log-tree exceptions in btrfs_truncate_inode_items()
92a7cc4252231d1641b36c38cf845cfc50308ab0 btrfs: rename BTRFS_ROOT_REF_COWS to BTRFS_ROOT_SHAREABLE
ae3e715f85fff878b317369b898cf4b89785c80a btrfs: drop stale reference to volume_mutex
583e4a2384db843fa8ae9a67aff8ea0eed140e61 btrfs: update documentation of set/get helpers
f472d3c28385397b1a2891c4ec264b90cd6d2187 btrfs: optimize split page write in btrfs_set_token_##bits
f4ca8c51d12631f1297d093f767c3a5ce5b95aff btrfs: optimize split page write in btrfs_set_##bits
ba8a9a0537770df69d9dc38c11312c9b0f840cf2 btrfs: optimize split page read in btrfs_get_token_##bits
84da071f3df5a9c0df0352d1c52b0c36ddb1c53f btrfs: optimize split page read in btrfs_get_##bits
c60ac0ffd682fc04f564dd6f4cc1a77c0f94608b btrfs: drop unnecessary offset_in_page in extent buffer helpers
2b48966a4da4bcb35f0883bc23dcaf63fcb8557f btrfs: constify extent_buffer in the API functions
db3756c879773c4c7986fce3dac8355f210df807 btrfs: remove unused map_private_extent_buffer
5cd17f343bd1c47dc673260fa2973abc14ecc549 btrfs: speed up and simplify generic_bin_search
ce7afe8782a5293edbf4bc2165ac4a866ed430db btrfs: speed up btrfs_set_token_##bits helpers
029e4a42a2b22f3c82e5b325820219963aa3f13b btrfs: speed up btrfs_set_##bits helpers
8f9da810ee1fac6b587e3b871ee73696906bcba3 btrfs: speed up btrfs_get_token_##bits helpers
1441ed9b7a0f53f47afd0b5ccdcb447e50559165 btrfs: speed up btrfs_get_##bits helpers
5e3946890c184a17b4d74baec89c96dce518f002 btrfs: add separate bounds checker for set/get helpers
870b388db02cac33eebe40a1cbeb056cf13e9f40 btrfs: preset set/get token with first page and drop condition
a31356b9e263b723d4991383efc87b71c6e87991 btrfs: don't use set/get token in leaf_space_used
60d48e2e4575dd848a43ceeda6cbc38a87427330 btrfs: don't use set/get token for single assignment in overwrite_item
cc4c13d55cba8a0b81bc18243eabc57be1aa44d2 btrfs: drop eb parameter from set/get token helpers
4dae666a6286ce5d9f4890f8b88af646473686f0 btrfs: use the token::eb for all set/get helpers
f2998ebd32e25e432e3d0058552e4777c5aba75a btrfs: remove duplicated include in block-group.c
3be4d8efe3cf218350cf2c3f39136a636698c572 btrfs: block-group: rename write_one_cache_group()
97f4728af88822ddd13941c3ac84a4ce3a9ff823 btrfs: block-group: refactor how we insert a block group item
7357623a7f4beb4ac76005f8fac9fc0230f9a67e btrfs: block-group: refactor how we delete one block group item
9afc66498a0b5f76928f9823b58c55c5dfb06ae5 btrfs: block-group: refactor how we read one block group item
83fe9e12b0558eae519351cff00da1e06bc054d2 btrfs: block-group: don't set the wrong READA flag for btrfs_read_block_groups()
89efda52e6b6930f80f5adda9c3c9edfb1397191 btrfs: send: emit file capabilities after chown
89490303a4294238b84c83541c140e540faa17ba btrfs: scrub, only lookup for csums if we are dealing with a data extent
684b752b0933ac287fdd1f4cdc53c4a937e90e46 btrfs: move the block group freeze/unfreeze helpers into block-group.c
6b7304af62d02d77d740defd4cfddf2ef3188067 btrfs: rename member 'trimming' of block group to a more generic name
2473d24f2b77da0ffabcbb916793e58e7f57440b btrfs: fix a race between scrub and block group removal/allocation
31344b2fcead3239c5b801016d9bae82506b92c2 btrfs: remove more obsolete v0 extent ref declarations
943aeb0dae9903ec70157129daed246086e8e111 btrfs: remove unused function btrfs_dev_extent_chunk_tree_uuid
cbab8ade585a18c4334b085564d9d046e01a3f70 btrfs: qgroup: mark qgroup inconsistent if we're inherting snapshot to a new qgroup
a619b3c7abdd585cdd003effa1773e627aa8a44e btrfs: speedup dead root detection during orphan cleanup
eec5b6e097cbcaf8d42209b6ef059cee8aa00790 btrfs: remove unused function heads_to_leaves
fb8521caa8f21f3153c5dc9feb055b6cd3e45c89 btrfs: add more codes to decoder table
d54f814434c5f87356d35bc377f43ef8d0556f15 btrfs: sort error decoder entries
7f551d969037cc128eca60688d9c5a300d84e665 btrfs: free alien device after device add
998a0671961f66e9fad4990ed75f80ba3088c2f1 btrfs: include non-missing as a qualifier for the latest_bdev
fd08001f17c7f0a5b19bf4026bbaace19d8fbdb6 btrfs: use crypto_shash_digest() instead of open coding
1ed802c972c6c676412e34d168e313a17c3d931e btrfs: drop useless goto in open_fs_devices
0bc2d3c08e2b970117cc2b7c529291123978cae6 btrfs: remove useless check for copy_items() return value
77d5d6893106ea7b19709bed2491f93ff10a86d7 btrfs: unify buffered and direct I/O read repair
5c047a699aa9433ad92136343a9306d985134c24 btrfs: get rid of endio_repair_workers
fd9d6670edba68cedd87b3db04cbdcdfc492cc0a btrfs: simplify direct I/O read repair
769b4f2497bdb31cd2c7b53d171bc7c13ef4e793 btrfs: get rid of one layer of bios in direct I/O
85879573fc8b06e8f70698686e3bc17c9e6225ba btrfs: put direct I/O checksums in btrfs_dio_private instead of bio
e3b318d14df7d6d04f37ce10f9a2f33ca3d550be btrfs: convert btrfs_dio_private->pending_bios to refcount_t
2390a6daf92d241b23bc02687bfb9fabdf93f117 btrfs: remove unused btrfs_dio_private::private
ce06d3ec2b5aed70b95ee080a7a3d55ef08ce7f3 btrfs: make btrfs_check_repairable() static
47df7765a803a3333dda7f1452581e1641f984b0 btrfs: rename __readpage_endio_check to check_data_csum
fb30f4707d421add0f4bf9a08bb228daac273b9f btrfs: clarify btrfs_lookup_bio_sums documentation
f337bd7478178f4c5e2b825fdb8dfaa266c344a2 btrfs: don't do repair validation for checksum errors
c7333972b9b571a03bf9aecd1aeecfab81243e8d btrfs: look at full bi_io_vec for repair decision
c36cac28cb94e58f7e21ff43bdc6064346dab32c btrfs: fix double __endio_write_update_ordered in direct I/O
6d3113a193e3385c72240096fe397618ecab6e43 btrfs: fix error handling when submitting direct I/O bio
1072c12d7d58b5512b6c05c2268f57d32f1ab76c block: add bio_for_each_bvec_all()
534cf531ccf6331b6e63a054f2ceb8e1ccff1ec9 btrfs: simplify error handling of clean_pinned_extents()
e3b8336117e515a260da32fa10bb3354ba12c429 btrfs: remove the redundant parameter level in btrfs_bin_search()
b335eab890ed4c5b8e45e4b3d12f303686298850 btrfs: make btrfs_read_disk_super return struct btrfs_disk_super
a7571232b2aa8a43a137f827d77941634c309144 btrfs: use list_for_each_entry_safe in free_reloc_roots
7c09c03091ac562ddca2b393e5d65c1d37da79f1 btrfs: don't force read-only after error in drop snapshot
2d9faa5a8aaaf4a0559be46cccdbed7dbb10bad0 btrfs: remove pointless assertion on reclaim_size counter
72f4f078de3fa81b089522fb8090b08e3ffdd148 btrfs: tree-checker: remove duplicate definition of 'inode_item_err'
9c343784c4328781129bcf9e671645f69fe4b38a btrfs: force chunk allocation if our global rsv is larger than metadata
42a72cb75374634ef714514b4742a8844391fd9e btrfs: run btrfs_try_granting_tickets if a priority ticket fails
666daa9f977d46010e2597a3b4f6524ba4d28129 btrfs: only check priority tickets for priority flushing
bb4f58a747f0421b10645fbf75a6acc88da0de50 btrfs: account for trans_block_rsv in may_commit_transaction
e6549c2aabb9875cf7827bb2283905aaab5b0523 btrfs: allow to use up to 90% of the global block rsv for unlink
7f9fe614407692f670601a634621138233ac00d7 btrfs: improve global reserve stealing logic
876de781b0da240fcf8d29514c34607e147e5a94 btrfs: backref: distinguish reloc and non-reloc use of indirect resolution
1b23ea180b6b4186ff79db767dcbec612477968f btrfs: reloc: move error handling of build_backref_tree() to backref.c
fc997ed05a9f9d2185b8804fb2d0273e6d9e921a btrfs: backref: rename and move finish_upper_links()
1b60d2ec982a35c2953d81d035e1d7fc7c89f42a btrfs: backref: rename and move handle_one_tree_block()
d36e7f0e8fedd0675789b4fc5869d8d48d33e18a btrfs: reloc: open code read_fs_root() for handle_indirect_tree_backref()
55465730bcea75606c2c281ca55701c7fc20a000 btrfs: backref: rename and move should_ignore_root()
982c92cbd51cf6ab1319e1e94dfd4902d3678d9a btrfs: backref: rename and move backref_tree_panic()
13fe1bdb22f8302afa5e588e89a7a94606ef35fb btrfs: backref: rename and move backref_cache_cleanup()
023acb07bc996636b39c70e07966f70e70c0a008 btrfs: backref: rename and move remove_backref_node()
b0fe7078d62c23bc94d0203887d9ad7b128f684b btrfs: backref: rename and move drop_backref_node()
741188d3a549af328cc7946ce9650dd33a25087b btrfs: backref: rename and move free_backref_(node|edge)
f39911e5527e8be7ab56cadde306237092bcc78f btrfs: backref: rename and move link_backref_edge()
47254d07f37590fddc1516006e3e79453e755424 btrfs: backref: rename and move alloc_backref_edge()
b1818dab9bda1da8f3ea5a13230b5d91ae964f00 btrfs: backref: rename and move alloc_backref_node()
584fb12187f087f4909f74fa91dbb61856107684 btrfs: backref: rename and move backref_cache_init()
e9a28dc52af31d8af1883afe08e724a303b3c4eb btrfs: rename tree_entry to rb_simple_node and export it
7053544146ac7eb71de6cee1ffda678714f905d8 btrfs: backref: move btrfs_backref_(node|edge|cache) structures to backref.h
a26195a5230d61e4c214b17cc611e3ac7cc64c33 btrfs: reloc: add btrfs_ prefix for backref_node/edge/cache
29db137b6bb2f79851d86fa267ad8d6e6540a855 btrfs: reloc: refactor useless nodes handling into its own function
1f872924663f9a15924cc7169932608c1d697ee1 btrfs: reloc: refactor finishing part of upper linkage into finish_upper_links()
e7d571c7b004dc20f385d53d0c89e99d078e0415 btrfs: reloc: remove the open-coded goto loop for breadth-first search
0304f2d8cce7fc23baf9e005c095beff7a29847d btrfs: reloc: pass essential members for alloc_backref_node()
2a979612d594c16953ca512f2de7f0bb385ffb65 btrfs: reloc: use wrapper to replace open-coded edge linking
4d81ea8bb4fc40903f4950b082955c709d785467 btrfs: reloc: refactor indirect tree backref processing into its own function
4007ea87d900e20a7986cdcdcfdc866e8f8bd473 btrfs: reloc: refactor direct tree backref processing into its own function
2433bea592d26daf6bd15492ce4262b598a7f804 btrfs: reloc: make reloc root search-specific for relocation backref cache
33a0f1f716973ae87d94e03e597d0c46fd032541 btrfs: reloc: add backref_cache::fs_info member
84780289335fe614057e5ddf796050ce15751f4a btrfs: reloc: add backref_cache::pending_edge and backref_cache::useless_node
9569cc203d23ddaed7f7f2ca986a7cda7f1c33c0 btrfs: reloc: rename mark_block_processed and __mark_block_processed
71f572a9e82fb7ed6f8c625e2682160f3a498db3 btrfs: reloc: use btrfs_backref_iter infrastructure
c39c2ddc67024979915c4df4e30da96a3e7619b0 btrfs: backref: implement btrfs_backref_iter_next()
a37f232b7b65789cadc9834d389f6390de11b583 btrfs: backref: introduce the skeleton of btrfs_backref_iter
78d933c79cb649906577715af15400c7724ca633 btrfs: add missing annotation for btrfs_tree_lock()
c142c6a449c7765b0d3b6ecce0be8d783a19abcb btrfs: add missing annotation for btrfs_lock_cluster()
2ebb17717550607bcd85fb8cf7d24ac870e9d762 sched/core: Offload wakee task activation if it the wakee is descheduling
c6e7bd7afaeb3af55ffac122828035f1c01d1d7b sched/core: Optimize ttwu() spinning on p->on_cpu
809eb4e9bf9d84eb5b703358afd0d564d514f6d2 dt-bindings: timer: Add renesas,em-sti bindings
7a3768c206a006525afc090f92d4d618d8356b92 clocksource/drivers/timer-versatile: Clear OF_POPULATED flag
7d7de1a65349811b24971c5e8e040e6aac192dd4 clocksource: mips-gic-timer: Mark GIC timer as unstable if ref clock changes
48016e78d328998b1f00bcfb639adeabca51abe5 clocksource: mips-gic-timer: Register as sched_clock
6d2e16a3181bafb77b535095c39ad1c8b9558c8c clocksource: dw_apb_timer_of: Fix missing clockevent timers
65e0f876405ef4f0ff25eb1c5ff3e9b536d68805 clocksource: dw_apb_timer: Affiliate of-based timer with any CPU
cee43dbf2ee3f430434e2b66994eff8a1aeda889 clocksource: dw_apb_timer: Make CPU-affiliation being optional
e69bc8999662a3fa6d856820dd09717afff1cbb0 dt-bindings: timer: Move snps,dw-apb-timer DT schema from rtc
b33aaf5cd68d0fa0f0d6aa15831a1e82e2ef98e1 dt-bindings: rtc: Convert snps,dw-apb-timer to DT schema
264418e20d1fedbed8ad79683b63caa3d72c3b2e clocksource/drivers/timer-ti-dm: Do one override clock parent in prepare()
b4d86d1994725b468772975f6294d37515e66dcc Merge branch 'omap-for-v5.8/dt-timer' of git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap into timers/drivers/next
ac593e62b0cfcbc53502be8b6c7e40fed8baff8c clocksource/drivers/timer-ti-dm: Fix spelling mistake "detectt" -> "detect"
1f422417945d08731e2915e0addb976f11b3a85a Merge branch 'timers/drivers/timer-ti' into timers/drivers/next
c177e2975430cec296aa52a0d413e447417d6cf9 clocksource/drivers/timer-ti-dm: Fix warning for set but not used
52762fbd1c4778ac9b173624ca0faacd22ef4724 clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support
46b30515f97ece3da661b251e4a0ad9ac7a338d3 clocksource/drivers/timer-ti-32k: Add support for initializing directly
d1b5e55208fd8e1c73876ab6ad1ce93485e3f5a2 drivers/clocksource/arm_arch_timer: Remove duplicate error message
311fb70aa55174ddebb5c6022b23e58b85e9f116 clocksource/drivers/arc_timer: Remove duplicate error message
83cba9536905e4f82b726a98fe404400f0c9eb76 clocksource/drivers/rda: drop redundant Kconfig dependency
bd35c77e32e4359580207891c0f7a438ad4b42df x86/tsc: Add tsc_early_khz command line parameter
9ed78b05f998050784ae863bd5ba4aea2e2141ed irqdomain: Allow software nodes for IRQ domain creation
87526603c89256e18ad2c23821fdaf376b072fc8 irqdomain: Get rid of special treatment for ACPI in __irq_domain_add()
181e9d4efaf6aa8d1e7d510aeb7114c0f276fad7 irqdomain: Make __irq_domain_add() less OF-dependent
128516e49de67d10d52fba62ef8d482b220ac4b0 iio: dummy_evgen: Fix use after free on error in iio_dummy_evgen_create()
c5d6082d35e0bcc20a26a067ffcfddcb5257e580 irqchip/gic-v3-its: Balance initial LPI affinity across CPUs
d505b8af58912ae1e1a211fabc9995b19bd40828 sched: Defend cfs and rt bandwidth quota against overflow
dbe9337109c2705f08e6a00392f991eb2d2570a5 sched/cpuacct: Fix charge cpuacct.usage_sys
04f5c362ec6d3ff0e14f1c05230b550da7f528a4 sched/fair: Replace zero-length array with flexible-array
95d685935a2edf209fc68f52494ede4a382a6c2b sched/pelt: Sync util/runnable_sum with PELT window when propagating
12aa2587388de6697fd2e585ae6a90f70249540b sched/cpuacct: Use __this_cpu_add() instead of this_cpu_ptr()
7d148be69e3a0eaa9d029a3c51b545e322116a99 sched/fair: Optimize enqueue_task_fair()
9013196a467e770e1470cccee6c0fe435ef37c66 Merge branch 'sched/urgent'
ef8385128d4b31a382d496b1c433697993bd0bfb xfs: cleanup xfs_idestroy_fork
f7e67b20ecbbcb9180c888a5c4fde267935e075f xfs: move the fork format fields into struct xfs_ifork
daf83964a3681cf1f1f255ad6095c0b60cba7dca xfs: move the per-fork nextents fields into struct xfs_ifork
b2c20045b67bf37aa63be9bd9463708dfb38cbcc xfs: remove xfs_ifree_local_data
09c38edd54c16657093a73a3169342f9f9080bb3 xfs: remove the XFS_DFORK_Q macro
5fd68bdb5a87c929fff5f7bbd947034368f36f4f xfs: clean up xchk_bmap_check_rmaps usage of XFS_IFORK_Q
4b516ff4e772993a99fc9bf36503d23ce5bd5ba9 xfs: remove the NULL fork handling in xfs_bmapi_read
1a1c57b2826f8b408feb733d3321490591a6e4c9 xfs: remove the special COW fork handling in xfs_bmapi_read
0f45a1b20cd8f9cfc985a1f91a1e7a86e5e14dd6 xfs: improve local fork verification
7c7ba2186305d6bee5eb5b8fb95a61d8de14de4f xfs: refactor xfs_inode_verify_forks
1934c8bd81bee4c239478b03a59addf5fe8e2785 xfs: remove xfs_ifork_ops
bb8a66af4fff1cecb7631c68af761ea8e1a41ac2 xfs: remove xfs_iread
7f0290123506e2b248fe06fa7cdc17c1b5b603b5 xfs: don't reset i_delayed_blks in xfs_iread
2d6051d4965308c3367bf5a2468dff969872a96e xfs: call xfs_dinode_verify from xfs_inode_from_disk
0bce8173fdcf203c92a4d57dc7d3bb642ed478a1 xfs: handle unallocated inodes in xfs_inode_from_disk
9229d18e801bdbdf79d963d8c944980fc77b5d6b xfs: split xfs_iformat_fork
cb7d58594412fff106cde550dd9e0a7999cc2a0c xfs: call xfs_iformat_fork from xfs_inode_from_disk
b90c2a9c8b4422bb9398b50fe3d6163e46dcddec xfs: xfs_bmapi_read doesn't take a fork id as the last argument
14506f7a91d8f4d13fc07126ac8d14c6519f00e3 xfs: fix the warning message in xfs_validate_sb_common()
765d3c393c222c3bb281885ea211c8ebc08250b4 xfs: don't allow SWAPEXT if we'd screw up quota accounting
78bba5c812cc651cee51b64b786be926ab7fe2a9 xfs: use ordered buffers to initialize dquot buffers during quotacheck
6d15120b282e49811a47f2f6d6b749d178be7e99 clocksource/drivers/timer-ti-dm: Fix warning for set but not used
f28cef9e4daca11337cb9f144cdebedaab69d78c xfs: don't fail verifier on empty attr3 leaf block
aba1ad05da088944a62eb87fb0cd8391152e8985 clocksource/drivers/timer-ti-dm: Add clockevent and clocksource support
d15483bb49bae0f9cbb67c54becec252545752d3 clocksource/drivers/timer-ti-32k: Add support for initializing directly
2f13ff1d1d5c0257c97ea76b86a2d9c99c44a4b9 irqchip/gic-v3-its: Track LPI distribution on a per CPU basis
337cbeb2c13eb4cab84f576fd402d7ae4ed31ae1 genirq/irq_sim: Simplify the API
5c8f77a278737a6af44a892f0700d9aadb2b0de0 irqdomain: Make irq_domain_reset_irq_data() available to  non-hierarchical users
82f2202ddc97490994fad0dbfec04a014fa5163d irqchip/sifive-plic: Remove incorrect requirement about number of irq contexts
8a94c1ab34d53476617f83610521cfb6674db8d4 irqchip/gic-v3: Fix missing "__init" for gic_smp_init()
ae0bb9fda405c881848f7f6e94d912b35f6e31d2 platform-msi: Fix typos in comment
508578f2f5601816ea29bec5cda00ea7d95a856d xfs: Use the correct style for SPDX License Identifier
ee4064e56cd81cd3126805159122f53cf4f12ae6 xfs: Replace zero-length array with flexible-array
237aac4624aac5d46b903539e91c8d4567a2bab5 xfs: ensure f_bfree returned by statfs() is non-negative
2c567af418e3f9380c2051aada58b4e5a4b5c2ad fs: Introduce DCACHE_DONTCACHE
dae2f8ed7992e88c8d62c54e8295ffc8475b4a80 fs: Lift XFS_IDONTCACHE to the VFS layer
2b40c5db73e239531ea54991087f4edc07fbb08e selftests/pidfd: add pidfd setns tests
303cc571d107b3641d6487061b748e70ffe15ce4 nsproxy: attach to namespaces via pidfds
2a0a24ebb499c9d499eea948d3fc108f936e36d4 sched: Make scheduler_ipi inline
90b5363acd4739769c3f38c1aff16171bd133e8c sched: Clean up scheduler_ipi()
f2a8d52e0a4db968c346c4332630a71cba377567 nsproxy: add struct nsset
3d60548b216b5486a541a06c167df3dfb6df9c2e xfs: remove duplicate headers
43dc0aa84ef74e3acd908b6d5eaa8ae15d7ecc8a xfs: fix unused variable warning in buffer completion on !DEBUG
6ea670ade207232d7863933bc6a834defe8b0269 xfs: remove unnecessary includes from xfs_log_recover.c
17d29bf271ea48b253c93969a590a11a51c19c1f xfs: move log recovery buffer cancellation code to xfs_buf_item_recover.c
cc560a5a9540be2d907c0c170e29ebde98d13d63 xfs: hoist setting of XFS_LI_RECOVERED to caller
96b60f826713767f222254418c995fb6fd7596b3 xfs: refactor intent item iop_recover calls
889eb55dd68f97729adccb8c06834b35e8bd9590 xfs: refactor intent item RECOVERED flag into the log item
86a37174138621a44c38621b69595e2cd67e5956 xfs: refactor adding recovered intent items to the log
154c733a33d9cdaabec42ae76ca1189044d0447e xfs: refactor releasing finished intents during log recovery
bba7b1644a25809c299684a325e766263ad15c62 xfs: refactor xlog_item_is_intent now that we're done converting
9329ba89cbb1f261decfedfd83e67d89d9d6c591 xfs: refactor recovered BUI log item playback
c57ed2f5a2ffa2e2009ffa638efd06c6e86e7ebd xfs: refactor recovered CUI log item playback
cba0ccac28a766968243cda597566983843f5be2 xfs: refactor recovered RUI log item playback
10d0c6e06fc87fe9e99d7c8df493f973b354fd9c xfs: refactor recovered EFI log item playback
2565a11b224b68a222838d09623c6a398c4d5f6c xfs: remove log recovery quotaoff item dispatch for pass2 commit functions
3c6ba3cf90c7233359a190c5230a553d19fbc8ef xfs: refactor log recovery BUI item dispatch for pass2 commit functions
9b4467e9834058df5be27a7a903be84921977170 xfs: refactor log recovery CUI item dispatch for pass2 commit functions
07590a9d38b8587076c175550743daca9e067f09 xfs: refactor log recovery RUI item dispatch for pass2 commit functions
9817aa80dcdc0358226f41322e1ff35339d0d24b xfs: refactor log recovery EFI item dispatch for pass2 commit functions
3ec6efa703cf65887e681d1f97d38a63261d907e xfs: refactor log recovery icreate item dispatch for pass2 commit functions
fcbdf91e0c9ff099ca5b6ea4c69cb5223874cec7 xfs: refactor log recovery dquot item dispatch for pass2 commit functions
658fa68b6f34f73c7e4023489accd34c1db91cb1 xfs: refactor log recovery inode item dispatch for pass2 commit functions
1094d3f12363474b2a3d1a6c06124bec25dd1555 xfs: refactor log recovery buffer item dispatch for pass2 commit functions
3304a4fabd099820df99de1acac345dd6fe16d1d xfs: refactor log recovery item dispatch for pass1 commit functions
8ea5682d07115b422e923bb4f55fe081964f484a xfs: refactor log recovery item dispatch for pass2 readhead functions
86ffa471d9ce6ac3fda66f704c3143c3d55181f5 xfs: refactor log recovery item sorting into a generic dispatch structure
35f4521fd3a001fb290a1780f8beeffb06d99a04 xfs: convert xfs_log_recover_item_t to struct xfs_log_recover_item
c199507993ede3f63d0deae7e2cbc2f5462c6452 xfs: remove unused iget_flags param from xfs_imap_to_bp()
28d84620797e04e983bcd515ac0a6146396b0e31 xfs: remove unused shutdown types
7376d74547344598008d00419eae0caa5f50f4f0 xfs: random buffer write failure errortag
88fc187984c968c02b3b41b27049e52a70b2d941 xfs: remove unused iflush stale parameter
2b3cf09356d54711b6afdc7694b382c379ea42c4 xfs: combine xfs_trans_ail_[remove|delete]()
6af0479d8b6b162b7f006581553705521af9984b xfs: drop unused shutdown parameter from xfs_trans_ail_remove()
655879290c28bc5678a30a7b41c9b61f4f7f90c2 xfs: use delete helper for items expected to be in AIL
849274c103aeb149f23a81ba4a6bab42a5d77a78 xfs: acquire ->ail_lock from xfs_trans_ail_delete()
b707fffda6a3e1d0a46fceaa4c3f6c06b90f448a xfs: abort consistently on dquot flush failure
629dcb38dc351947ed6a26a997d4b587f3bd5c7e xfs: fix duplicate verification from xfs_qm_dqflush()
61948b6fb276ad95ad63f82863e607719a31a628 xfs: ratelimit unmount time per-buffer I/O error alert
f9bccfcc3b59b9aba64791ab3a2bfefe681ab75b xfs: refactor ratelimited buffer error messages into helper
b6983e80b03bd4fd42de71993b3ac7403edac758 xfs: reset buffer write failure state on successful completion
15fab3b9be2255be70ba1c598a11622fa03c9d5e xfs: remove unnecessary shutdown check from xfs_iflush()
f20192991d791293ccb7f6a073bb28de572f799a xfs: simplify inode flush error handling
54b3b1f619efbc838870735db2ddde9450f93a8f xfs: factor out buffer I/O failure code
cb6ad0993eb8973533235de8a35aa4b9c872d733 xfs: refactor failed buffer resubmission into xfsaild
cec5f268cd02d25d2d74807843d8ae0292fe0fb7 x86/delay: Introduce TPAUSE delay
46f90c7aad62be1af76588108c730d826308a801 x86/delay: Refactor delay_mwaitx() for TPAUSE support
e8824890249355656968d8846908a313fe231f11 x86/delay: Preparatory code cleanup
8bc3b5e4b70d28f8edcafc3c9e4de515998eea9e xfs: clean up the error handling in xfs_swap_extents
ac819eda7cc96656df50897848ffe5dfe9a3cb7c ARM: dts: Add 32KHz clock as default clock source
840d493dff1abb0cb0d73417148a3eeecd5f30d9 fs/xfs: Combine xfs_diflags_to_linux() and xfs_diflags_to_iflags()
32dbc5655f1ccb3bffa5785523146f60fa4bf905 fs/xfs: Create function xfs_inode_should_enable_dax()
8d6c3446ec23ecd97bc089ed224342baf9426c30 fs/xfs: Make DAX mount option a tri-state
606723d982939ab138a05a8070b1ec48ed532234 fs/xfs: Change XFS_MOUNT_DAX to XFS_MOUNT_DAX_ALWAYS
d45344d6c49cf9863e1d526fc1d8cb27ab147148 fs/xfs: Remove unnecessary initialization of i_rwsem
2f88f1efd02ddf76cb5973abc42474c4dac2b03a xfs: spell out the parameter name for ->cancel_item
3ec1b26c04d4910f37cdaad26d14b403c0240e30 xfs: use a xfs_btree_cur for the ->finish_cleanup state
f09d167c20332ad1298ff82a6f538b4c7ea3fe1b xfs: turn dfp_done into a xfs_log_item
bb47d79750f1a68a75d4c7defc2da934ba31de14 xfs: refactor xfs_defer_finish_noroll
13a8333339072b8654c1d2c75550ee9f41ee15de xfs: turn dfp_intent into a xfs_log_item
d367a868e46b025a8ced8e00ef2b3a3c2f3bf732 xfs: merge the ->diff_items defer op into ->create_intent
c1f09188e8de0ae65433cb9c8ace4feb66359bcc xfs: merge the ->log_item defer op into ->create_intent
e046e949486ec92d83b2ccdf0e7e9144f74ef028 xfs: factor out a xfs_defer_create_intent helper
fd9cbe51215198ccffa64169c98eae35b0916088 xfs: remove the xfs_inode_log_item_t typedef
c84e819090f39e96e4d432c9047a50d2424f99e0 xfs: remove the xfs_efd_log_item_t typedef
82ff450b2d936d778361a1de43eb078cc043c7fe xfs: remove the xfs_efi_log_item_t typedef
98b69b1285be048b9c811f093ba1fa86e4d8fe87 xfs: refactor xlog_recover_buffer_pass1
f15ab3f60ef3f25c6139262939388dc5617e2e6f xfs: simplify xlog_recover_inode_ra_pass2
7d4894b4ce070398952de25e893873edc67d3105 xfs: factor out a xlog_buf_readahead helper
5ce70b770d163b0c7697dd23420cbaee070b1cd0 xfs: rename inode_list xlog_recover_reorder_trans
e968350aadf34c86eedd9cb43f6324263845586b xfs: refactor the buffer cancellation table helpers
ec43f6da31f100696b56e4781b62fb5367a40d71 xfs: define printk_once variants for xfs messages
166405f6b53b7d7eecb7939aa4a79bc7c1e0ed68 xfs: stop CONFIG_XFS_DEBUG from changing compiler flags
57fd2d8f61a2bc4d7b465588ca1a2217cd94076c xfs: remove unnecessary check of the variable resblks in xfs_symlink
cd59455980f94ea4e9a5f84a7c326d42a4d84a78 xfs: simplify the flags setting in xfs_qm_scall_quotaon
7994aae8516aa35ca26dba64cf8d6938e93c2265 xfs: remove unnecessary assertion from xfs_qm_vop_create_dqattach
ea1c90403d5d38bd26c4c5a72627a8f0f87295ff xfs: remove unnecessary variable udqp from xfs_ioctl_setattr
fb353ff19d34e9b0ee8ba2b25d78aeab0436f479 xfs: reserve quota inode transaction space only when needed
d51bafe0d227e9fef1b0ab4cc1a424d8e2b59218 xfs: combine two if statements with same condition
c140735bbb65daa89275a6b87f120c5feca99d6a xfs: trace quota allocations for all quota types
0d2d35a33ea77f34d534106e0b18a5797d3bbcf7 xfs: report unrecognized log item type codes during recovery
83d9088659e8f113741bb197324bd9554d159657 Documentation/dax: Update Usage section
712b2698e4c024b561694cbcc1abba13eb0fd9ce fs/stat: Define DAX statx attribute
efbe3c2493d2f7a1e1a753780fe727b34709ebd2 fs: Remove unneeded IS_DAX() check in io_is_direct()
b1d1779e5ef7a60b192b61fd97201f322e1e9303 sched/core: Simplify sched_init()
12ac6782a40ad7636b6ef45680741825b64ab221 sched/swait: Reword some of the main description
17c891ab349138e8d8a59ca2700f42ce8af96f4e sched/fair: Use __this_cpu_read() in wake_wide()
bf2c59fce4074e55d622089b34be3a6bc95484fb sched/core: Fix illegal RCU from offline CPUs
f38f12d1e0811c0ee59260b2bdadedf99e16c4af sched/fair: Mark sched_init_granularity __init
5a6d6a6ccb5f48ca8cf7c6d64ff83fd9c7999390 sched/fair: Refill bandwidth before scaling
457d1f465778ccb5f14f7d7a62245e41d12a3804 sched: Extract the task putting code from pick_next_task()
d91cecc156620ec75d94c55369509c807c3d07e6 sched: Make newidle_balance() static again
36c5bdc4387056af3840adb4478c752faeb9d15e sched/topology: Kill SD_LOAD_BALANCE
e669ac8ab952df2f07dee1e1efbf40647d6de332 sched: Remove checks against SD_LOAD_BALANCE
9818427c6270a9ce8c52c8621026fe9cebae0f92 sched/debug: Make sd->flags sysctl read-only
45da27732b0b9b7a04696653065d5e6037bc5ac0 sched/fair: find_idlest_group(): Remove unused sd_flag parameter
586b58cac8b4683eb58a1446fbc399de18974e40 exit: Move preemption fixup up, move blocking operations down
64297f2b03cc7a6d0184a435f1b296beca1bedd1 sched/fair: Simplify the code of should_we_balance()
ab93a4bc955b3980c699430bc0b633f0d8b607be sched/fair: Remove distribute_running from CFS bandwidth
e98fa02c4f2ea4991dae422ac7e34d102d2f0599 sched/fair: Eliminate bandwidth race between throttling and distribution
f080d93e1d419099a99d7473ed532289ca8dc717 sched/debug: Fix trival print_task() format
bfed0eded1ce00bda5cc2d2939b017f88e6b1fd0 clocksource/drivers/versatile: Allow CONFIG_CLKSRC_VERSATILE to be disabled
25259f7a5de2de9d67793dc584b15c83a3134c93 clocksource/drivers/timer-microchip-pit64b: Select CONFIG_TIMER_OF
8c42c0f72d7c4f295646d3eba73f62e5579b1732 clocksource/drivers/atmel-st: Remove useless 'status'
ac161f57b66dcf14b3339b1c5857c08a9ad4d833 clocksource/drivers/imx-tpm: Add support for ARM64
4855f2bd91b6e3461af7d795bfe9a40420122131 clocksource: davinci: axe a pointless __GFP_NOFAIL
bdf8783c0dae9d3d8fc1c4078fe849ab8aa8b583 clocksource/drivers/davinci: Avoid trailing '\n' hidden in pr_fmt()
7aba5dcc234635b44b2781dbc268048cfba388ad jfs: Replace zero-length array with flexible-array member
