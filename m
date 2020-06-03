Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E23C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB1DC20738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 03:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgFCDGU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 23:06:20 -0400
Received: from mga07.intel.com ([134.134.136.100]:34993 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725780AbgFCDGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 23:06:19 -0400
IronPort-SDR: AjGQqh1WdhFzHeEY1Gi3a77mNLLDPxiw7qXlQAmja8s7P7JEJTL7RZpF+CqiNwPjHndtam5YHf
 qFomRA0fxgoQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 20:06:19 -0700
IronPort-SDR: kQGo9vkFlnDBIQYvOoljkfa5J3ViwwscSUL3naiprSsgOqwFTQnkcrWC7mft4x4MHHjTWelYTs
 M3qlIXkapL8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,466,1583222400"; 
   d="scan'208";a="470969634"
Received: from yuguoshi-mobl.ccr.corp.intel.com (HELO [10.255.28.20]) ([10.255.28.20])
  by fmsmga005.fm.intel.com with ESMTP; 02 Jun 2020 20:06:16 -0700
Subject: Re: [LKP] Re: 28307d938f ("percpu: make pcpu_alloc() aware of current
 gfp .."): BUG: kernel reboot-without-warning in boot stage
To:     Filipe Manana <fdmanana@suse.com>,
        kernel test robot <lkp@intel.com>
Cc:     LKP <lkp@lists.01.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Linus, Torvalds," <torvalds@linux-foundation.org>
References: <5ed0b6ea.QaEVKYBGHpcVDpW8%lkp@intel.com>
 <21fb7dbf-1fd2-cfcb-860e-c342ae0c310e@suse.com>
 <a1e41149-a3b3-4a19-7001-9b47d8b66555@intel.com>
 <0405917f-dc4f-f32c-0aeb-043742fc4d6e@suse.com>
From:   Li Zhijian <zhijianx.li@intel.com>
Message-ID: <1527ee5c-4e2f-7b4a-9ba4-b37d5f7c0258@intel.com>
Date:   Wed, 3 Jun 2020 11:05:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <0405917f-dc4f-f32c-0aeb-043742fc4d6e@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/20 8:18 PM, Filipe Manana wrote:
> On 02/06/20 05:37, Li Zhijian wrote:
>> Hi Filipe,
>>
>> LKP checked blow dmesg as the indicator in this problem
>>
>>>> [    0.144174] RAMDISK: [mem 0x7fa2e000-0x7fffffff]
>>>> [    0.144559] ACPI: Early table checksum verification disabled
>>>> [    0.144985] ACPI: RSDP 0x00000000000F5850 000014 (v00 BOCHS )
>>>> [    0.145424] ACPI: RSDT 0x00000000BFFE15C9 000030 (v01 BOCHS
>>>> BXPCRSDT 00000001 BXPC 00000001)
>>>> [    0.146051] ACPI: FACP 0x00000000BFFE149D 000074 (v01 BOCHS
>>>> BXPCFACP 00000001 BXPC 00000001)
>>>> BUG: kernel reboot-without-warning in boot stage
>>>>
>> And i have reproduced it with script in attachment. this issue is gone
>> when i reverted this commit 28307d938f
>>
>> Please note that
>> - i reproduced it with kernel compiled by gcc-5
>> - i failed to reproduce it in kernel compiled by gcc-7 so far
> Odd.

Indeed !

i tested gcc-5 gcc-6 gcc-7, only gcc-5 triggered this issue, kernel 
built with gcc6 and gcc-7 works well

lizhijian@shao2-debian:~$ gcc-6 --version
gcc-6 (Debian 6.5.0-2) 6.5.0 20181026
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

lizhijian@shao2-debian:~$ gcc-5 --version
gcc-5 (Debian 5.5.0-12) 5.5.0 20171010
Copyright (C) 2015 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

lizhijian@shao2-debian:~$ gcc-7 --version
gcc-7 (Debian 7.5.0-3) 7.5.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

Thanks
Zhijian

> Here I tested with:
>
> $ gcc --version
> gcc (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
> Copyright (C) 2016 Free Software Foundation, Inc.
>

