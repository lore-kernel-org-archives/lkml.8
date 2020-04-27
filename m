Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9140C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5D6D206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 03:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ceOMoli5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgD0DjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 23:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726341AbgD0DjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 23:39:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8F4C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 20:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=wniblRoeFeVzjHbwI/eShcX0rxEXqnrqWa9Srx3dHN0=; b=ceOMoli52nv3xiFyOK7+Q16uoU
        PnG4U/dOuAIMU4J7bfk2BCIFDe+LVAVR8VjP+HKkBSRYgniFT/lzYoaMQdTyjJJTXC6cqbfwOwLXZ
        vxetVRnIG5on/Fw6Y3DwFXMoUfekJ+D0kP3rRCS5pn3ua35/pXf1W+TPgCNb/t+Ak3TOOsR7wy80Q
        2IU01zVBVmX/1X20GHnCPIGMAq2tUwwUxNfif83n9fsUHToEqNgbDTFOWmL+9+uLxXTSI8Bt+xyTV
        iFLXc8eKzNYW6gcuWyakt4vTcLFVy3pRI0019FScD7X/Yinqenw8Ow8Pxd1jNFkufAhDe+Jjqe5WE
        AGAV/XgQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jSubv-0006wN-I8; Mon, 27 Apr 2020 03:39:11 +0000
Subject: Re: block: remove unused header includes.
To:     "Ma, Jianpeng" <jianpeng.ma@intel.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6AA21C22F0A5DA478922644AD2EC308C73C55940@SHSMSX101.ccr.corp.intel.com>
 <768e4398-1789-8dfa-5883-effb566b2f31@infradead.org>
 <6AA21C22F0A5DA478922644AD2EC308C73C55A66@SHSMSX101.ccr.corp.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <0341f3e4-b43c-7f66-4123-cedc9d5516db@infradead.org>
Date:   Sun, 26 Apr 2020 20:39:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C73C55A66@SHSMSX101.ccr.corp.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/20 8:35 PM, Ma, Jianpeng wrote:
>> -----Original Message-----
>> From: Randy Dunlap <rdunlap@infradead.org>
>> Sent: Monday, April 27, 2020 11:06 AM
>> To: Ma, Jianpeng <jianpeng.ma@intel.com>; Christoph Hellwig
>> <hch@infradead.org>
>> Cc: axboe@kernel.dk; Williams, Dan J <dan.j.williams@intel.com>; linux-
>> kernel@vger.kernel.org
>> Subject: Re: block: remove unused header includes.
>>
>> Hi,
>>
>> On 4/26/20 7:56 PM, Ma, Jianpeng wrote:
>>> This used deheader(git@gitlab.com:esr/deheader.git) to produce.
>>>
>>> Signed-off-by: Jianpeng Ma <jianpeng.ma@intel.com>
>>> ---
>>>  block/badblocks.c        |  6 ------
>>>  block/bfq-cgroup.c       | 10 ----------
>>>  block/bfq-iosched.c      | 13 -------------
>>>  block/bio-integrity.c    |  6 ------
>>>  block/bio.c              | 14 --------------
>>>  block/blk-cgroup.c       | 10 ----------
>>>  block/blk-core.c         | 24 ------------------------
>>>  block/blk-exec.c         |  5 -----
>>>  block/blk-flush.c        | 10 ----------
>>>  block/blk-integrity.c    |  6 ------
>>>  block/blk-ioc.c          |  7 -------
>>>  block/blk-lib.c          |  5 -----
>>>  block/blk-map.c          |  4 ----
>>>  block/blk-merge.c        |  5 -----
>>>  block/blk-mq-cpumap.c    |  8 --------
>>>  block/blk-mq-debugfs.c   |  6 ------
>>>  block/blk-mq-pci.c       |  4 ----
>>>  block/blk-mq-rdma.c      |  1 -
>>>  block/blk-mq-sched.c     |  7 -------
>>>  block/blk-mq-sysfs.c     | 15 +--------------
>>>  block/blk-mq-tag.c       |  5 -----
>>>  block/blk-mq-virtio.c    |  4 ----
>>>  block/blk-mq.c           | 22 ----------------------
>>>  block/blk-pm.c           |  4 ----
>>>  block/blk-settings.c     |  8 --------
>>>  block/blk-softirq.c      |  6 ------
>>>  block/blk-stat.c         |  5 -----
>>>  block/blk-sysfs.c        |  9 ---------
>>>  block/blk-throttle.c     |  5 -----
>>>  block/blk-timeout.c      |  5 -----
>>>  block/blk-wbt.c          |  6 ------
>>>  block/blk-zoned.c        |  7 -------
>>>  block/bounce.c           | 15 ---------------
>>>  block/bsg-lib.c          |  5 -----
>>>  block/bsg.c              | 11 -----------
>>>  block/cmdline-parser.c   |  1 -
>>>  block/elevator.c         | 15 ---------------
>>>  block/genhd.c            | 14 --------------
>>>  block/ioctl.c            |  8 --------
>>>  block/ioprio.c           | 11 -----------
>>>  block/kyber-iosched.c    |  9 ---------
>>>  block/mq-deadline.c      | 14 --------------
>>>  block/partitions/amiga.c |  1 -
>>>  block/partitions/core.c  |  4 ----
>>>  block/partitions/efi.c   |  3 ---
>>>  block/partitions/karma.c |  1 -
>>>  block/partitions/ldm.c   |  4 ----
>>>  block/partitions/mac.c   |  1 -
>>>  block/scsi_ioctl.c       | 14 --------------
>>>  block/sed-opal.c         |  9 ---------
>>>  block/t10-pi.c           |  1 -
>>>  fs/block_dev.c           | 16 ----------------
>>>  52 files changed, 1 insertion(+), 408 deletions(-)
>>>
>>> diff --git a/block/badblocks.c b/block/badblocks.c index
>>> 2e5f5697db35..4e4eb0fc9eb9 100644
>>> --- a/block/badblocks.c
>>> +++ b/block/badblocks.c
>>> @@ -8,12 +8,6 @@
>>>   */
>>>
>>>  #include <linux/badblocks.h>
>>> -#include <linux/seqlock.h>
>>
>> above is used by:
>> 	seq = read_seqbegin(&bb->lock);
>>
>>> -#include <linux/device.h>
>>
>> 	struct device is used in this source file.
>>
>>> -#include <linux/kernel.h>
>>> -#include <linux/module.h>
>>> -#include <linux/stddef.h>
>>
>> 	NULL is used in this source file.
>>
>>> -#include <linux/types.h>
>>
>> 	sector_t is used in this source file.
>>
>>>  #include <linux/slab.h>
>>>
>>>  /**
>>
>>
>>
>> Can you explain the criteria that 'deheader' use to decide that a header file can
>> be removed?
>>
> Deheader iterator remove the #include and do make. If no fail mean this #include can remove.

In some cases it just means that headerfile-a sucks in headerfile-b automagically,
but that's not what we want to see, according to rule #1.
We want all needed header files to be explicitly #included.

> 
>> And are you aware of rule #1 in Documentation/process/submit-checklist.rst:
>>
>> 1) If you use a facility then #include the file that defines/declares
>>    that facility.  Don't depend on other header files pulling in ones
>>    that you use.
>>
> Is this rule mean for #ifdef case?

It depends. We try not to do things like

#ifdef CONFIG_OPTIONA
#include <linux/optiona.h>
#endif

and instead just do
#include <linux/optiona.h>

but that's probably not a universal rule.

-- 
~Randy

