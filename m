Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93EAC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A968F206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YmFVqxi8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgD0DGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 23:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726316AbgD0DGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:06:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C346C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 20:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Nr6RLmrP1KV83MkQyNa0o1w0G6FaUfrhecqVRlXs+uk=; b=YmFVqxi8AezJBoWneQSudmP02h
        B3u3ojoCirNsugReI1IXeNZ7nAMs+LxUYPNCfQ2fnxa0r6zLYRArxF4U1RsgkwORUMKpkYEUUo0md
        2zY3TtNxQGIWZiYcNzuHqUsrClacTfCKEz5GkWdqBnC1Kq/DxV8yqaN5TS9ARY5j8bgrZngiajvbF
        kr1mXP0J5D2/2vjYN05AX4uday9ze8P4Yk/kCwABWnqEqrwfpXYQP3ExIQU00n1LVnOK/K7m5K/8x
        0rUIIU3r67Y3QMz1MmoLhxLP/F6PdWSJjI6FALUfuXXYvTP48ZMS/XLyGVCnmOdmQXli2yCMeuYZC
        KALyCBiQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSu67-0004Mx-KI; Mon, 27 Apr 2020 03:06:19 +0000
Subject: Re: block: remove unused header includes.
To:     "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6AA21C22F0A5DA478922644AD2EC308C73C55940@SHSMSX101.ccr.corp.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <768e4398-1789-8dfa-5883-effb566b2f31@infradead.org>
Date:   Sun, 26 Apr 2020 20:06:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C73C55940@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/26/20 7:56 PM, Ma, Jianpeng wrote:
> This used deheader(git@gitlab.com:esr/deheader.git) to produce.
> 
> Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
> ---
>  block/badblocks.c        |  6 ------
>  block/bfq-cgroup.c       | 10 ----------
>  block/bfq-iosched.c      | 13 -------------
>  block/bio-integrity.c    |  6 ------
>  block/bio.c              | 14 --------------
>  block/blk-cgroup.c       | 10 ----------
>  block/blk-core.c         | 24 ------------------------
>  block/blk-exec.c         |  5 -----
>  block/blk-flush.c        | 10 ----------
>  block/blk-integrity.c    |  6 ------
>  block/blk-ioc.c          |  7 -------
>  block/blk-lib.c          |  5 -----
>  block/blk-map.c          |  4 ----
>  block/blk-merge.c        |  5 -----
>  block/blk-mq-cpumap.c    |  8 --------
>  block/blk-mq-debugfs.c   |  6 ------
>  block/blk-mq-pci.c       |  4 ----
>  block/blk-mq-rdma.c      |  1 -
>  block/blk-mq-sched.c     |  7 -------
>  block/blk-mq-sysfs.c     | 15 +--------------
>  block/blk-mq-tag.c       |  5 -----
>  block/blk-mq-virtio.c    |  4 ----
>  block/blk-mq.c           | 22 ----------------------
>  block/blk-pm.c           |  4 ----
>  block/blk-settings.c     |  8 --------
>  block/blk-softirq.c      |  6 ------
>  block/blk-stat.c         |  5 -----
>  block/blk-sysfs.c        |  9 ---------
>  block/blk-throttle.c     |  5 -----
>  block/blk-timeout.c      |  5 -----
>  block/blk-wbt.c          |  6 ------
>  block/blk-zoned.c        |  7 -------
>  block/bounce.c           | 15 ---------------
>  block/bsg-lib.c          |  5 -----
>  block/bsg.c              | 11 -----------
>  block/cmdline-parser.c   |  1 -
>  block/elevator.c         | 15 ---------------
>  block/genhd.c            | 14 --------------
>  block/ioctl.c            |  8 --------
>  block/ioprio.c           | 11 -----------
>  block/kyber-iosched.c    |  9 ---------
>  block/mq-deadline.c      | 14 --------------
>  block/partitions/amiga.c |  1 -
>  block/partitions/core.c  |  4 ----
>  block/partitions/efi.c   |  3 ---
>  block/partitions/karma.c |  1 -
>  block/partitions/ldm.c   |  4 ----
>  block/partitions/mac.c   |  1 -
>  block/scsi_ioctl.c       | 14 --------------
>  block/sed-opal.c         |  9 ---------
>  block/t10-pi.c           |  1 -
>  fs/block_dev.c           | 16 ----------------
>  52 files changed, 1 insertion(+), 408 deletions(-)
> 
> diff --git a/block/badblocks.c b/block/badblocks.c
> index 2e5f5697db35..4e4eb0fc9eb9 100644
> --- a/block/badblocks.c
> +++ b/block/badblocks.c
> @@ -8,12 +8,6 @@
>   */
>  
>  #include <linux/badblocks.h>
> -#include <linux/seqlock.h>

above is used by:
	seq = read_seqbegin(&bb->lock);

> -#include <linux/device.h>

	struct device is used in this source file.

> -#include <linux/kernel.h>
> -#include <linux/module.h>
> -#include <linux/stddef.h>

	NULL is used in this source file.

> -#include <linux/types.h>

	sector_t is used in this source file.

>  #include <linux/slab.h>
>  
>  /**



Can you explain the criteria that 'deheader' use to decide that
a header file can be removed?

And are you aware of rule #1 in Documentation/process/submit-checklist.rst:

1) If you use a facility then #include the file that defines/declares
   that facility.  Don't depend on other header files pulling in ones
   that you use.



-- 
~Randy

