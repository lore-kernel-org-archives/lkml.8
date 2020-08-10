Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C09DC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 157B72068F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgHJCZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 22:25:00 -0400
Received: from mga06.intel.com ([134.134.136.31]:26410 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgHJCZA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 22:25:00 -0400
IronPort-SDR: BTp5bGl21Uqd9JRbwUNAO6nCh/96a/ZRHJZCMwmBu8zxfK5a/kW4WUH/M+Gf7NKTAJ+OizVZIT
 x0xhlH9k1KwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="214986722"
X-IronPort-AV: E=Sophos;i="5.75,455,1589266800"; 
   d="scan'208";a="214986722"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2020 19:24:59 -0700
IronPort-SDR: Qg/TPXbIWSpHoGDHVCKslpVTT+q6Hvb52xnDfB6jOUrtGp/zJaX2m6h80+FCVp6ZoeIJbjrvaP
 MAyF1tWhYL5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,455,1589266800"; 
   d="scan'208";a="494641943"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2020 19:24:57 -0700
Subject: Re: [kbuild-all] Re: drivers/virtio/virtio_mem.c:1031
 virtio_mem_mb_plug_any_sb() error: uninitialized symbol 'rc'.
To:     David Hildenbrand <dhildenb@redhat.com>,
        kernel test robot <lkp@intel.com>
Cc:     David Hildenbrand <david@redhat.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
References: <202008081921.lHEnQxg2%lkp@intel.com>
 <77F03240-61B0-437C-BBC0-84E081FA92EF@redhat.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <28c5b6f1-a7fb-a432-dd93-b54b0c2e47e4@intel.com>
Date:   Mon, 10 Aug 2020 10:24:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <77F03240-61B0-437C-BBC0-84E081FA92EF@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/20 8:44 PM, David Hildenbrand wrote:
>
>> Am 08.08.2020 um 13:39 schrieb kernel test robot <lkp@intel.com>:
>>
>> ﻿tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   449dc8c97089a6e09fb2dac4d92b1b7ac0eb7c1e
>> commit: 5f1f79bbc9e26fa9412fa9522f957bb8f030c442 virtio-mem: Paravirtualized memory hotplug
>> date:   9 weeks ago
>> config: x86_64-randconfig-m001-20200808 (attached as .config)
>> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
> Was there a delay in sending these out? The fix by Dan is long upstream: 1c3d69ab5348
Hi David,

Sorry for the inconvenience, the bot will check head commit before 
reporting usually, we'll take a look.

Best Regards,
Rong Chen

>
>> New smatch warnings:
>> drivers/virtio/virtio_mem.c:1031 virtio_mem_mb_plug_any_sb() error: uninitialized symbol 'rc'.
>> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:1607 calculate_bandwidth() warn: Function too hairy.  No more merges.
>>
>> Old smatch warnings:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dce_calcs.c:3387 bw_calcs() warn: inconsistent indenting
>>
>> vim +/rc +1031 drivers/virtio/virtio_mem.c
>>
>>    978
>>    979    /*
>>    980     * Try to plug the desired number of subblocks of a memory block that
>>    981     * is already added to Linux.
>>    982     *
>>    983     * Will modify the state of the memory block.
>>    984     *
>>    985     * Note: Can fail after some subblocks were successfully plugged.
>>    986     */
>>    987    static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
>>    988                         uint64_t *nb_sb, bool online)
>>    989    {
>>    990        unsigned long pfn, nr_pages;
>>    991        int sb_id, count;
>>    992        int rc;
>>    993
>>    994        if (WARN_ON_ONCE(!*nb_sb))
>>    995            return -EINVAL;
>>    996
>>    997        while (*nb_sb) {
>>    998            sb_id = virtio_mem_mb_first_unplugged_sb(vm, mb_id);
>>    999            if (sb_id >= vm->nb_sb_per_mb)
>>   1000                break;
>>   1001            count = 1;
>>   1002            while (count < *nb_sb &&
>>   1003                   sb_id + count < vm->nb_sb_per_mb &&
>>   1004                   !virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id + count,
>>   1005                                  1))
>>   1006                count++;
>>   1007
>>   1008            rc = virtio_mem_mb_plug_sb(vm, mb_id, sb_id, count);
>>   1009            if (rc)
>>   1010                return rc;
>>   1011            *nb_sb -= count;
>>   1012            if (!online)
>>   1013                continue;
>>   1014
>>   1015            /* fake-online the pages if the memory block is online */
>>   1016            pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
>>   1017                       sb_id * vm->subblock_size);
>>   1018            nr_pages = PFN_DOWN(count * vm->subblock_size);
>>   1019            virtio_mem_fake_online(pfn, nr_pages);
>>   1020        }
>>   1021
>>   1022        if (virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
>>   1023            if (online)
>>   1024                virtio_mem_mb_set_state(vm, mb_id,
>>   1025                            VIRTIO_MEM_MB_STATE_ONLINE);
>>   1026            else
>>   1027                virtio_mem_mb_set_state(vm, mb_id,
>>   1028                            VIRTIO_MEM_MB_STATE_OFFLINE);
>>   1029        }
>>   1030
>>> 1031        return rc;
>>   1032    }
>>   1033
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>> <.config.gz>
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

