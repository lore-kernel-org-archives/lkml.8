Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CECBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 665DA2078D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 05:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgFSFfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 01:35:47 -0400
Received: from mga17.intel.com ([192.55.52.151]:33206 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728156AbgFSFfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 01:35:46 -0400
IronPort-SDR: w5KZFdzXBQ7DpKZHufZndbprMlZeWkAw6f1x4OnTByd4yP6JG3KGmpQb67CrpHfc0OJuwoIGzS
 05nEnnA37uCw==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="123089645"
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="gz'50?scan'50,208,50";a="123089645"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2020 21:55:43 -0700
IronPort-SDR: LuE2drLsCjqSHjZcqdEqRymdbbebXRooDR1vJ7GI/rSdln/wLBft7ffqoh4iIRimW/FCfvcgZg
 ek1I8TfGIxbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,253,1589266800"; 
   d="gz'50?scan'50,208,50";a="477502119"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jun 2020 21:55:41 -0700
Date:   Fri, 19 Jun 2020 12:55:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Subject: include/linux/blk-mq.h:300:29: error: 'MQ_RQ_IN_FLIGHT' undeclared
Message-ID: <20200619045519.GA29997@intel.com>
Reply-To: kernel test robot <lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5e857ce6eae7ca21b2055cca4885545e29228fe2
commit: 0fc09f920983f61be625658c62cc40ac25a7b3a5 blk-mq: export setting request completion state
config: powerpc64-randconfig-m031-20200618 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/scsi/scsi_cmnd.h:11,
                    from drivers/ata/libata-core.c:65:
   include/scsi/scsi_device.h:433:4: error: unknown type name 'req_flags_t'; did you mean 'vm_flags_t'?
     433 |    req_flags_t rq_flags, int *resid);
         |    ^~~~~~~~~~~
         |    vm_flags_t
   include/scsi/scsi_device.h: In function 'scsi_execute_req':
   include/scsi/scsi_device.h:439:9: error: implicit declaration of function 'scsi_execute'; did you mean 'scsi_execute_req'? [-Werror=implicit-function-declaration]
     439 |  return scsi_execute(sdev, cmd, data_direction, buffer,
         |         ^~~~~~~~~~~~
         |         scsi_execute_req
   In file included from include/scsi/scsi_request.h:5,
                    from include/scsi/scsi_cmnd.h:12,
                    from drivers/ata/libata-core.c:65:
   include/linux/blk-mq.h: At top level:
   include/linux/blk-mq.h:142:2: error: unknown type name 'softirq_done_fn'
     142 |  softirq_done_fn  *complete;
         |  ^~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:5,
                    from include/linux/debug_locks.h:6,
                    from include/linux/lockdep.h:28,
                    from include/linux/spinlock_types.h:18,
                    from include/linux/spinlock.h:82,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from drivers/ata/libata-core.c:44:
   include/linux/blk-mq.h: In function 'blk_mq_mark_complete':
   include/linux/blk-mq.h:300:20: error: dereferencing pointer to incomplete type 'struct request'
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                    ^~
   arch/powerpc/include/asm/cmpxchg.h:483:19: note: in definition of macro 'cmpxchg'
     483 |      __typeof__(*(ptr)) _o_ = (o);      \
         |                   ^~~
>> include/linux/blk-mq.h:300:29: error: 'MQ_RQ_IN_FLIGHT' undeclared (first use in this function)
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                             ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:483:32: note: in definition of macro 'cmpxchg'
     483 |      __typeof__(*(ptr)) _o_ = (o);      \
         |                                ^
   include/linux/blk-mq.h:300:29: note: each undeclared identifier is reported only once for each function it appears in
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                             ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:483:32: note: in definition of macro 'cmpxchg'
     483 |      __typeof__(*(ptr)) _o_ = (o);      \
         |                                ^
>> include/linux/blk-mq.h:300:46: error: 'MQ_RQ_COMPLETE' undeclared (first use in this function); did you mean 'COMMAND_COMPLETE'?
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                                              ^~~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:484:32: note: in definition of macro 'cmpxchg'
     484 |      __typeof__(*(ptr)) _n_ = (n);      \
         |                                ^
   In file included from include/scsi/scsi_request.h:5,
                    from include/scsi/scsi_cmnd.h:12,
                    from drivers/ata/libata-core.c:65:
   include/linux/blk-mq.h: In function 'blk_mq_rq_from_pdu':
   include/linux/blk-mq.h:310:22: error: invalid application of 'sizeof' to incomplete type 'struct request'
     310 |  return pdu - sizeof(struct request);
         |                      ^~~~~~
   include/linux/blk-mq.h: In function 'blk_mq_rq_to_pdu':
   include/linux/blk-mq.h:314:12: error: invalid use of undefined type 'struct request'
     314 |  return rq + 1;
         |            ^
   In file included from drivers/ata/libata-core.c:65:
   include/scsi/scsi_cmnd.h: In function 'scsi_bidi_cmnd':
   include/scsi/scsi_cmnd.h:215:9: error: implicit declaration of function 'blk_bidi_rq' [-Werror=implicit-function-declaration]
     215 |  return blk_bidi_rq(cmd->request) &&
         |         ^~~~~~~~~~~
   include/scsi/scsi_cmnd.h: In function 'scsi_get_lba':
   include/scsi/scsi_cmnd.h:308:9: error: implicit declaration of function 'blk_rq_pos' [-Werror=implicit-function-declaration]
     308 |  return blk_rq_pos(scmd->request);
         |         ^~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/scsi/scsi_host.h:11,
                    from drivers/ata/libata-scsi.c:42:
   include/linux/blk-mq.h:98:9: error: type defaults to 'int' in declaration of 'blk_status_t' [-Werror=implicit-int]
      98 | typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
         |         ^~~~~~~~~~~~
   include/linux/blk-mq.h:98:9: error: 'blk_status_t' declared as function returning a function
   include/linux/blk-mq.h:99:16: warning: parameter names (without types) in function declaration
      99 |   const struct blk_mq_queue_data *);
         |                ^~~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:121:2: error: unknown type name 'queue_rq_fn'
     121 |  queue_rq_fn  *queue_rq;
         |  ^~~~~~~~~~~
   include/linux/blk-mq.h:142:2: error: unknown type name 'softirq_done_fn'
     142 |  softirq_done_fn  *complete;
         |  ^~~~~~~~~~~~~~~
   include/linux/blk-mq.h:217:31: error: 'blk_mq_req_flags_t' undeclared here (not in a function); did you mean 'blk_mq_free_tag_set'?
     217 |  BLK_MQ_REQ_NOWAIT = (__force blk_mq_req_flags_t)(1 << 0),
         |                               ^~~~~~~~~~~~~~~~~~
         |                               blk_mq_free_tag_set
   include/linux/blk-mq.h:227:3: error: expected declaration specifiers or '...' before 'blk_mq_req_flags_t'
     227 |   blk_mq_req_flags_t flags);
         |   ^~~~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:229:20: error: expected declaration specifiers or '...' before 'blk_mq_req_flags_t'
     229 |   unsigned int op, blk_mq_req_flags_t flags,
         |                    ^~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:5,
                    from include/linux/debug_locks.h:6,
                    from include/linux/lockdep.h:28,
                    from include/linux/spinlock_types.h:18,
                    from include/linux/spinlock.h:82,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from drivers/ata/libata-scsi.c:36:
   include/linux/blk-mq.h: In function 'blk_mq_mark_complete':
   include/linux/blk-mq.h:300:20: error: dereferencing pointer to incomplete type 'struct request'
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                    ^~
   arch/powerpc/include/asm/cmpxchg.h:483:19: note: in definition of macro 'cmpxchg'
     483 |      __typeof__(*(ptr)) _o_ = (o);      \
         |                   ^~~
>> include/linux/blk-mq.h:300:29: error: 'MQ_RQ_IN_FLIGHT' undeclared (first use in this function)
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                             ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:483:32: note: in definition of macro 'cmpxchg'
     483 |      __typeof__(*(ptr)) _o_ = (o);      \
         |                                ^
   include/linux/blk-mq.h:300:29: note: each undeclared identifier is reported only once for each function it appears in
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                             ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:483:32: note: in definition of macro 'cmpxchg'
     483 |      __typeof__(*(ptr)) _o_ = (o);      \
         |                                ^
>> include/linux/blk-mq.h:300:46: error: 'MQ_RQ_COMPLETE' undeclared (first use in this function); did you mean 'COMMAND_COMPLETE'?
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                                              ^~~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:484:32: note: in definition of macro 'cmpxchg'
     484 |      __typeof__(*(ptr)) _n_ = (n);      \
         |                                ^
   In file included from include/scsi/scsi_host.h:11,
                    from drivers/ata/libata-scsi.c:42:
   include/linux/blk-mq.h: In function 'blk_mq_rq_from_pdu':
   include/linux/blk-mq.h:310:22: error: invalid application of 'sizeof' to incomplete type 'struct request'
     310 |  return pdu - sizeof(struct request);
         |                      ^~~~~~
   include/linux/blk-mq.h: In function 'blk_mq_rq_to_pdu':
   include/linux/blk-mq.h:314:12: error: invalid use of undefined type 'struct request'
     314 |  return rq + 1;
         |            ^
   In file included from include/scsi/scsi_cmnd.h:11,
                    from drivers/ata/libata-scsi.c:43:
   include/scsi/scsi_device.h: At top level:
   include/scsi/scsi_device.h:433:4: error: unknown type name 'req_flags_t'; did you mean 'vm_flags_t'?
     433 |    req_flags_t rq_flags, int *resid);
         |    ^~~~~~~~~~~
         |    vm_flags_t
   include/scsi/scsi_device.h: In function 'scsi_execute_req':
   include/scsi/scsi_device.h:439:9: error: implicit declaration of function 'scsi_execute'; did you mean 'scsi_execute_req'? [-Werror=implicit-function-declaration]
     439 |  return scsi_execute(sdev, cmd, data_direction, buffer,
         |         ^~~~~~~~~~~~
         |         scsi_execute_req
   In file included from drivers/ata/libata-scsi.c:43:
   include/scsi/scsi_cmnd.h: In function 'scsi_bidi_cmnd':
   include/scsi/scsi_cmnd.h:215:9: error: implicit declaration of function 'blk_bidi_rq' [-Werror=implicit-function-declaration]
     215 |  return blk_bidi_rq(cmd->request) &&
         |         ^~~~~~~~~~~
   include/scsi/scsi_cmnd.h: In function 'scsi_get_lba':
   include/scsi/scsi_cmnd.h:308:9: error: implicit declaration of function 'blk_rq_pos' [-Werror=implicit-function-declaration]
     308 |  return blk_rq_pos(scmd->request);
         |         ^~~~~~~~~~
   In file included from include/linux/writeback.h:13,
                    from include/linux/memcontrol.h:31,
                    from include/linux/swap.h:9,
                    from include/linux/suspend.h:5,
                    from drivers/ata/libata-scsi.c:51:
   include/linux/blk_types.h: At top level:
   include/linux/blk_types.h:29:22: error: conflicting types for 'blk_status_t'
      29 | typedef u8 __bitwise blk_status_t;
         |                      ^~~~~~~~~~~~
   In file included from include/scsi/scsi_host.h:11,
                    from drivers/ata/libata-scsi.c:42:
   include/linux/blk-mq.h:98:9: note: previous declaration of 'blk_status_t' was here
      98 | typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
         |         ^~~~~~~~~~~~
   drivers/ata/libata-scsi.c: In function 'ata_scsi_qc_new':
   drivers/ata/libata-scsi.c:876:32: error: 'RQF_QUIET' undeclared (first use in this function); did you mean 'BIO_QUIET'?
     876 |   if (cmd->request->rq_flags & RQF_QUIET)
         |                                ^~~~~~~~~
         |                                BIO_QUIET
   In file included from include/asm-generic/bug.h:5,
                    from arch/powerpc/include/asm/bug.h:128,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from drivers/ata/libata-scsi.c:36:
   drivers/ata/libata-scsi.c: In function 'atapi_drain_needed':
   drivers/ata/libata-scsi.c:1260:14: error: implicit declaration of function 'blk_rq_is_passthrough' [-Werror=implicit-function-declaration]
    1260 |  if (likely(!blk_rq_is_passthrough(rq)))
         |              ^~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:33:34: note: in definition of macro '__branch_check__'
      33 |    ______r = __builtin_expect(!!(x), expect); \
         |                                  ^
   drivers/ata/libata-scsi.c:1260:6: note: in expansion of macro 'likely'
    1260 |  if (likely(!blk_rq_is_passthrough(rq)))
         |      ^~~~~~
   drivers/ata/libata-scsi.c:1263:7: error: implicit declaration of function 'blk_rq_bytes' [-Werror=implicit-function-declaration]
    1263 |  if (!blk_rq_bytes(rq) || op_is_write(req_op(rq)))
         |       ^~~~~~~~~~~~
   drivers/ata/libata-scsi.c: In function 'ata_scsi_dev_config':
   drivers/ata/libata-scsi.c:1278:2: error: implicit declaration of function 'blk_queue_max_hw_sectors' [-Werror=implicit-function-declaration]
    1278 |  blk_queue_max_hw_sectors(q, dev->max_sectors);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/libata-scsi.c:1286:3: error: implicit declaration of function 'blk_queue_update_dma_pad' [-Werror=implicit-function-declaration]
    1286 |   blk_queue_update_dma_pad(q, ATA_DMA_PAD_SZ - 1);
         |   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/libata-scsi.c:1289:35: error: dereferencing pointer to incomplete type 'struct request_queue'
    1289 |   buf = kmalloc(ATAPI_MAX_DRAIN, q->bounce_gfp | GFP_KERNEL);
         |                                   ^~
   drivers/ata/libata-scsi.c:1295:3: error: implicit declaration of function 'blk_queue_dma_drain' [-Werror=implicit-function-declaration]
    1295 |   blk_queue_dma_drain(q, atapi_drain_needed, buf, ATAPI_MAX_DRAIN);
         |   ^~~~~~~~~~~~~~~~~~~
   drivers/ata/libata-scsi.c:1313:2: error: implicit declaration of function 'blk_queue_update_dma_alignment' [-Werror=implicit-function-declaration]
    1313 |  blk_queue_update_dma_alignment(q, sdev->sector_size - 1);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/ata/libata-scsi.c:1326:2: error: implicit declaration of function 'blk_queue_flush_queueable' [-Werror=implicit-function-declaration]
    1326 |  blk_queue_flush_queueable(q, false);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/fs.h:39,
                    from include/linux/huge_mm.h:7,
                    from include/linux/mm.h:479,
                    from include/linux/scatterlist.h:8,
                    from include/scsi/scsi.h:10,
                    from drivers/ata/libata-scsi.c:41:
--
   In file included from include/scsi/scsi_host.h:11,
                    from drivers/ata/libata-eh.c:40:
   include/linux/blk-mq.h:98:9: error: type defaults to 'int' in declaration of 'blk_status_t' [-Werror=implicit-int]
      98 | typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
         |         ^~~~~~~~~~~~
   include/linux/blk-mq.h:98:9: error: 'blk_status_t' declared as function returning a function
   include/linux/blk-mq.h:99:16: warning: parameter names (without types) in function declaration
      99 |   const struct blk_mq_queue_data *);
         |                ^~~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:121:2: error: unknown type name 'queue_rq_fn'
     121 |  queue_rq_fn  *queue_rq;
         |  ^~~~~~~~~~~
   include/linux/blk-mq.h:142:2: error: unknown type name 'softirq_done_fn'
     142 |  softirq_done_fn  *complete;
         |  ^~~~~~~~~~~~~~~
   include/linux/blk-mq.h:217:31: error: 'blk_mq_req_flags_t' undeclared here (not in a function); did you mean 'blk_mq_free_tag_set'?
     217 |  BLK_MQ_REQ_NOWAIT = (__force blk_mq_req_flags_t)(1 << 0),
         |                               ^~~~~~~~~~~~~~~~~~
         |                               blk_mq_free_tag_set
   include/linux/blk-mq.h:227:3: error: expected declaration specifiers or '...' before 'blk_mq_req_flags_t'
     227 |   blk_mq_req_flags_t flags);
         |   ^~~~~~~~~~~~~~~~~~
   include/linux/blk-mq.h:229:20: error: expected declaration specifiers or '...' before 'blk_mq_req_flags_t'
     229 |   unsigned int op, blk_mq_req_flags_t flags,
         |                    ^~~~~~~~~~~~~~~~~~
   In file included from arch/powerpc/include/asm/atomic.h:11,
                    from include/linux/atomic.h:5,
                    from include/linux/rcupdate.h:38,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/blkdev.h:5,
                    from drivers/ata/libata-eh.c:36:
   include/linux/blk-mq.h: In function 'blk_mq_mark_complete':
   include/linux/blk-mq.h:300:20: error: dereferencing pointer to incomplete type 'struct request'
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                    ^~
   arch/powerpc/include/asm/cmpxchg.h:483:19: note: in definition of macro 'cmpxchg'
     483 |      __typeof__(*(ptr)) _o_ = (o);      \
         |                   ^~~
>> include/linux/blk-mq.h:300:29: error: 'MQ_RQ_IN_FLIGHT' undeclared (first use in this function)
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                             ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:483:32: note: in definition of macro 'cmpxchg'
     483 |      __typeof__(*(ptr)) _o_ = (o);      \
         |                                ^
   include/linux/blk-mq.h:300:29: note: each undeclared identifier is reported only once for each function it appears in
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                             ^~~~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:483:32: note: in definition of macro 'cmpxchg'
     483 |      __typeof__(*(ptr)) _o_ = (o);      \
         |                                ^
>> include/linux/blk-mq.h:300:46: error: 'MQ_RQ_COMPLETE' undeclared (first use in this function); did you mean 'COMMAND_COMPLETE'?
     300 |  return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
         |                                              ^~~~~~~~~~~~~~
   arch/powerpc/include/asm/cmpxchg.h:484:32: note: in definition of macro 'cmpxchg'
     484 |      __typeof__(*(ptr)) _n_ = (n);      \
         |                                ^
   In file included from include/scsi/scsi_host.h:11,
                    from drivers/ata/libata-eh.c:40:
   include/linux/blk-mq.h: In function 'blk_mq_rq_from_pdu':
   include/linux/blk-mq.h:310:22: error: invalid application of 'sizeof' to incomplete type 'struct request'
     310 |  return pdu - sizeof(struct request);
         |                      ^~~~~~
   include/linux/blk-mq.h: In function 'blk_mq_rq_to_pdu':
   include/linux/blk-mq.h:314:12: error: invalid use of undefined type 'struct request'
     314 |  return rq + 1;
         |            ^
   In file included from include/scsi/scsi_cmnd.h:11,
                    from include/scsi/scsi_eh.h:7,
                    from drivers/ata/libata-eh.c:41:
   include/scsi/scsi_device.h: At top level:
   include/scsi/scsi_device.h:433:4: error: unknown type name 'req_flags_t'; did you mean 'vm_flags_t'?
     433 |    req_flags_t rq_flags, int *resid);
         |    ^~~~~~~~~~~
         |    vm_flags_t
   include/scsi/scsi_device.h: In function 'scsi_execute_req':
   include/scsi/scsi_device.h:439:9: error: implicit declaration of function 'scsi_execute'; did you mean 'scsi_execute_req'? [-Werror=implicit-function-declaration]
     439 |  return scsi_execute(sdev, cmd, data_direction, buffer,
         |         ^~~~~~~~~~~~
         |         scsi_execute_req
   In file included from include/scsi/scsi_eh.h:7,
                    from drivers/ata/libata-eh.c:41:
   include/scsi/scsi_cmnd.h: In function 'scsi_bidi_cmnd':
   include/scsi/scsi_cmnd.h:215:9: error: implicit declaration of function 'blk_bidi_rq' [-Werror=implicit-function-declaration]
     215 |  return blk_bidi_rq(cmd->request) &&
         |         ^~~~~~~~~~~
   include/scsi/scsi_cmnd.h: In function 'scsi_get_lba':
   include/scsi/scsi_cmnd.h:308:9: error: implicit declaration of function 'blk_rq_pos' [-Werror=implicit-function-declaration]
     308 |  return blk_rq_pos(scmd->request);
         |         ^~~~~~~~~~
   In file included from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/ktime.h:24,
                    from include/linux/rcutiny.h:28,
                    from include/linux/rcupdate.h:210,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/blkdev.h:5,
                    from drivers/ata/libata-eh.c:36:
   drivers/ata/libata-eh.c: In function 'ata_qc_schedule_eh':
   drivers/ata/libata-eh.c:937:21: error: dereferencing pointer to incomplete type 'struct request_queue'
     937 |  spin_lock_irqsave(q->queue_lock, flags);
         |                     ^~
   include/linux/spinlock.h:222:34: note: in definition of macro 'raw_spin_lock_irqsave'
     222 |   flags = _raw_spin_lock_irqsave(lock); \
         |                                  ^~~~
   drivers/ata/libata-eh.c:937:2: note: in expansion of macro 'spin_lock_irqsave'
     937 |  spin_lock_irqsave(q->queue_lock, flags);
         |  ^~~~~~~~~~~~~~~~~
   drivers/ata/libata-eh.c:938:2: error: implicit declaration of function 'blk_abort_request'; did you mean 'blk_mq_end_request'? [-Werror=implicit-function-declaration]
     938 |  blk_abort_request(qc->scsicmd->request);
         |  ^~~~~~~~~~~~~~~~~
         |  blk_mq_end_request
   drivers/ata/libata-eh.c: In function 'ata_eh_quiet':
   drivers/ata/libata-eh.c:2119:39: error: 'RQF_QUIET' undeclared (first use in this function)
    2119 |      qc->scsicmd->request->rq_flags & RQF_QUIET)
         |                                       ^~~~~~~~~
   cc1: some warnings being treated as errors
..

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0fc09f920983f61be625658c62cc40ac25a7b3a5
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout 0fc09f920983f61be625658c62cc40ac25a7b3a5
vim +/MQ_RQ_IN_FLIGHT +300 include/linux/blk-mq.h

4f084b41a0c04a Ming Lei    2017-06-06  289  
0fc09f920983f6 Keith Busch 2018-07-23  290  /**
0fc09f920983f6 Keith Busch 2018-07-23  291   * blk_mq_mark_complete() - Set request state to complete
0fc09f920983f6 Keith Busch 2018-07-23  292   * @rq: request to set to complete state
0fc09f920983f6 Keith Busch 2018-07-23  293   *
0fc09f920983f6 Keith Busch 2018-07-23  294   * Returns true if request state was successfully set to complete. If
0fc09f920983f6 Keith Busch 2018-07-23  295   * successful, the caller is responsibile for seeing this request is ended, as
0fc09f920983f6 Keith Busch 2018-07-23  296   * blk_mq_complete_request will not work again.
0fc09f920983f6 Keith Busch 2018-07-23  297   */
0fc09f920983f6 Keith Busch 2018-07-23  298  static inline bool blk_mq_mark_complete(struct request *rq)
0fc09f920983f6 Keith Busch 2018-07-23  299  {
0fc09f920983f6 Keith Busch 2018-07-23 @300  	return cmpxchg(&rq->state, MQ_RQ_IN_FLIGHT, MQ_RQ_COMPLETE) ==
0fc09f920983f6 Keith Busch 2018-07-23  301  			MQ_RQ_IN_FLIGHT;
0fc09f920983f6 Keith Busch 2018-07-23  302  }
0fc09f920983f6 Keith Busch 2018-07-23  303  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
sOVWhULgej8/cuaNkz8qd9QZ99IBAA==

--FCuugMFkClbJLl1L--
