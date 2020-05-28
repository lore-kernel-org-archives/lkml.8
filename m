Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E39C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8067B208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgE1HtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:49:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:61997 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgE1HtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:49:24 -0400
IronPort-SDR: peWvCMGIRkIpgjr5QkyvSeYnAdQ7u58o7P+v+kE+NKU8+6ySnc3xIzaF9vz7WedZ69GQfH5dnG
 ZU9K9RNtsMkg==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 00:48:46 -0700
IronPort-SDR: vN/yy4B1pcFjmmSMGXUnwdwQDBtW9Au+Y+OGVHQ8APk9EZSgVFD+AxiAomZiInfhmhtWnq749K
 TG6Eq61XwhTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,444,1583222400"; 
   d="gz'50?scan'50,208,50";a="302739969"
Received: from lkp-server02.sh.intel.com (HELO 5e8f22f9921b) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 28 May 2020 00:48:43 -0700
Received: from kbuild by 5e8f22f9921b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jeDHP-00000S-5a; Thu, 28 May 2020 07:48:43 +0000
Date:   Thu, 28 May 2020 15:48:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jan Kara <jack@suse.cz>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: kernel/trace/blktrace.c:347:12: sparse: sparse: incorrect type in
 assignment (different address spaces)
Message-ID: <202005281500.16HgHvDn%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b0c3ba31be3e45a130e13b278cf3b90f69bda6f6
commit: c780e86dd48ef6467a1146cf7d0fe1e05a635039 blktrace: Protect q->blk_trace with RCU
date:   3 months ago
config: x86_64-randconfig-s021-20200528 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-13) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-240-gf0fe1cd9-dirty
        git checkout c780e86dd48ef6467a1146cf7d0fe1e05a635039
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=x86_64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> kernel/trace/blktrace.c:347:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct blk_trace *bt @@     got struct blk_trace [noderef] <asn:4> *[assigned] __ret @@
   kernel/trace/blktrace.c:347:12: sparse:     expected struct blk_trace *bt
   kernel/trace/blktrace.c:347:12: sparse:     got struct blk_trace [noderef] <asn:4> *[assigned] __ret
>> kernel/trace/blktrace.c:547:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct blk_trace [noderef] <asn:4> *__new @@     got struct blk_trace *[assigned] bt @@
   kernel/trace/blktrace.c:547:13: sparse:     expected struct blk_trace [noderef] <asn:4> *__new
   kernel/trace/blktrace.c:547:13: sparse:     got struct blk_trace *[assigned] bt
   kernel/trace/blktrace.c:998:50: sparse: sparse: incorrect type in argument 7 (different base types) @@     expected int error @@     got restricted blk_status_t [usertype] bi_status @@
   kernel/trace/blktrace.c:998:50: sparse:     expected int error
   kernel/trace/blktrace.c:998:50: sparse:     got restricted blk_status_t [usertype] bi_status
   kernel/trace/blktrace.c:1036:68: sparse: sparse: incorrect type in argument 7 (different base types) @@     expected int error @@     got restricted blk_status_t [usertype] bi_status @@
   kernel/trace/blktrace.c:1036:68: sparse:     expected int error
   kernel/trace/blktrace.c:1036:68: sparse:     got restricted blk_status_t [usertype] bi_status
   kernel/trace/blktrace.c:1257:16: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1257:16: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1257:16: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1257:16: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1257:16: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1257:16: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1257:16: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1257:16: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1257:16: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1257:16: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1264:32: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned long long [usertype] sector_from @@     got restricted __be64 const [usertype] sector_from @@
   kernel/trace/blktrace.c:1264:32: sparse:     expected unsigned long long [usertype] sector_from
   kernel/trace/blktrace.c:1264:32: sparse:     got restricted __be64 const [usertype] sector_from
   kernel/trace/blktrace.c:1266:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] device_from @@     got unsigned int @@
   kernel/trace/blktrace.c:1266:24: sparse:     expected restricted __be32 [usertype] device_from
   kernel/trace/blktrace.c:1266:24: sparse:     got unsigned int
   kernel/trace/blktrace.c:1267:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be32 [usertype] device_to @@     got unsigned int @@
   kernel/trace/blktrace.c:1267:24: sparse:     expected restricted __be32 [usertype] device_to
   kernel/trace/blktrace.c:1267:24: sparse:     got unsigned int
   kernel/trace/blktrace.c:1268:26: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1268:26: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1268:26: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1268:26: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1268:26: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1268:26: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1268:26: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1268:26: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1268:26: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1268:26: sparse: sparse: cast to restricted __be64
   kernel/trace/blktrace.c:1268:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __be64 [usertype] sector_from @@     got unsigned long long @@
   kernel/trace/blktrace.c:1268:24: sparse:     expected restricted __be64 [usertype] sector_from
   kernel/trace/blktrace.c:1268:24: sparse:     got unsigned long long
   kernel/trace/blktrace.c:1415:26: sparse: sparse: restricted __be32 degrades to integer
   kernel/trace/blktrace.c:1415:48: sparse: sparse: restricted __be32 degrades to integer
   kernel/trace/blktrace.c:1416:27: sparse: sparse: cast from restricted __be64
   kernel/trace/blktrace.c:1640:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct blk_trace *bt @@     got struct blk_trace [noderef] <asn:4> *[assigned] __ret @@
   kernel/trace/blktrace.c:1640:12: sparse:     expected struct blk_trace *bt
   kernel/trace/blktrace.c:1640:12: sparse:     got struct blk_trace [noderef] <asn:4> *[assigned] __ret
   kernel/trace/blktrace.c:1673:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct blk_trace [noderef] <asn:4> *__new @@     got struct blk_trace *[assigned] bt @@
   kernel/trace/blktrace.c:1673:13: sparse:     expected struct blk_trace [noderef] <asn:4> *__new
   kernel/trace/blktrace.c:1673:13: sparse:     got struct blk_trace *[assigned] bt

vim +347 kernel/trace/blktrace.c

2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23  342  
1f2cac107c591c kernel/trace/blktrace.c Jens Axboe 2017-11-05  343  static int __blk_trace_remove(struct request_queue *q)
2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23  344  {
2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23  345  	struct blk_trace *bt;
2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23  346  
2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23 @347  	bt = xchg(&q->blk_trace, NULL);
2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23  348  	if (!bt)
2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23  349  		return -EINVAL;
2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23  350  
5554720482a631 kernel/trace/blktrace.c Li Zefan   2009-03-25  351  	if (bt->trace_state != Blktrace_running)
2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23  352  		blk_trace_cleanup(bt);
2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23  353  
2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23  354  	return 0;
2056a782f8e7e6 block/blktrace.c        Jens Axboe 2006-03-23  355  }
1f2cac107c591c kernel/trace/blktrace.c Jens Axboe 2017-11-05  356  

:::::: The code at line 347 was first introduced by commit
:::::: 2056a782f8e7e65fd4bfd027506b4ce1c5e9ccd4 [PATCH] Block queue IO tracing support (blktrace) as of 2006-03-23

:::::: TO: Jens Axboe <axboe@suse.de>
:::::: CC: Jens Axboe <axboe@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--2fHTh5uZTiUOsy+g
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
G5cXmlWYejG4uPVF0DjsGfUfiW0Sqd0iAgA=

--2fHTh5uZTiUOsy+g--
