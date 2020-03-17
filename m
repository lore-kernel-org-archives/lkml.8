Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D719CC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2A8B205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 07:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgCQHl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 03:41:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:18628 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgCQHl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 03:41:29 -0400
IronPort-SDR: +1CpZ8PnnlJp4jP+vAoTDvBm+sqG0Q3O5v2ShitXbd+auAW+t+k6JGNbmeMf/m5Sld8OS7m+0c
 /NR869i9Kjlg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 00:41:28 -0700
IronPort-SDR: Rh6v35oSwDAUkIqQr37u6MnCetiEjlu42va9wWGOFaf8EAPq3jOIxe+oZGmpgHacJe1hYVqZqN
 Z4Z0L6YzTBAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,563,1574150400"; 
   d="scan'208";a="247734664"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.30.124]) ([10.255.30.124])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2020 00:41:26 -0700
Subject: Re: [scsi] 618b4d07a4: xfstests.generic.484.fail
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
References: <20200316134148.GG11705@shao2-debian>
 <1584368247.14250.17.camel@mtksdccf07>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <531bbf4b-221c-5d42-e04f-6b15b6d27e35@intel.com>
Date:   Tue, 17 Mar 2020 15:41:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1584368247.14250.17.camel@mtksdccf07>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2020 10:17 PM, Stanley Chu wrote:
> Hi,
>
> On Mon, 2020-03-16 at 21:41 +0800, kernel test robot wrote:
>> FYI, we noticed the following commit (built with gcc-7):
>>
>> commit: 618b4d07a4420ca9f01837f183ce7b1ac0b31307 ("scsi: ufs: ufs-mediatek: fix TX LCC disabling timing")
>> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>>
> The modified file in above commit is /drivers/scsi/ufs/ufs-mediatek.c
> which shall not be built according to the kernel configuration used by
> the robot.
>
> Could this possibly be a false alarm?
>
> Thanks,
> Stanley Chu

Hi Stanley,

Sorry for the inconvenience, it's a false positive, the 
xfstests.generic.484 test
didn't run successfully in the parent commit.

Best Regards,
Rong Chen


>
>
>> in testcase: xfstests
>> with following parameters:
>>
>> 	disk: 4HDD
>> 	fs: xfs
>> 	test: generic-group11
>>
>> test-description: xfstests is a regression test suite for xfs and other files ystems.
>> test-url: git://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
>>
>>
>> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
>>
>> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
>>
>>
>>
>>
>> If you fix the issue, kindly add following tag
>> Reported-by: kernel test robot <rong.a.chen@intel.com>
>>
>> 2020-03-16 18:33:34 export TEST_DIR=/fs/vda
>> 2020-03-16 18:33:34 export TEST_DEV=/dev/vda
>> 2020-03-16 18:33:34 export FSTYP=xfs
>> 2020-03-16 18:33:34 export SCRATCH_MNT=/fs/scratch
>> 2020-03-16 18:33:34 mkdir /fs/scratch -p
>> 2020-03-16 18:33:34 export SCRATCH_DEV=/dev/vdd
>> 2020-03-16 18:33:34 export SCRATCH_LOGDEV=/dev/vdb
>> meta-data=/dev/vda               isize=512    agcount=4, agsize=16777216 blks
>>           =                       sectsz=512   attr=2, projid32bit=1
>>           =                       crc=1        finobt=1, sparse=0, rmapbt=0, reflink=1
>> data     =                       bsize=4096   blocks=67108864, imaxpct=25
>>           =                       sunit=0      swidth=0 blks
>> naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
>> log      =internal log           bsize=4096   blocks=32768, version=2
>>           =                       sectsz=512   sunit=0 blks, lazy-count=1
>> realtime =none                   extsz=4096   blocks=0, rtextents=0
>> 2020-03-16 18:33:35 export MKFS_OPTIONS=-mreflink=1
>> 2020-03-16 18:33:35 sed "s:^:generic/:" //lkp/benchmarks/xfstests/tests/generic-group11
>> 2020-03-16 18:33:35 ./check generic/015 generic/056 generic/092 generic/124 generic/160 generic/192 generic/222 generic/254 generic/287 generic/319 generic/350 generic/381 generic/416 generic/446 generic/484 generic/519 generic/550 generic/580
>> FSTYP         -- xfs (debug)
>> PLATFORM      -- Linux/x86_64 vm-snb-15 5.6.0-rc1-00021-g618b4d07a4420 #1 SMP Mon Mar 16 17:42:08 CST 2020
>> MKFS_OPTIONS  -- -f -mreflink=1 /dev/vdd
>> MOUNT_OPTIONS -- /dev/vdd /fs/scratch
>>
>> generic/015	 2s
>> generic/056	 3s
>> generic/092	 2s
>> generic/124	 5s
>> generic/160	 2s
>> generic/192	 7s
>> generic/222	 5s
>> generic/254	 4s
>> generic/287	 4s
>> generic/319	 2s
>> generic/350	 2s
>> generic/381	 2s
>> generic/416	 157s
>> generic/446	 9s
>> generic/484	- output mismatch (see /lkp/benchmarks/xfstests/results//generic/484.out.bad)
>>      --- tests/generic/484.out	2020-03-05 16:38:54.000000000 +0800
>>      +++ /lkp/benchmarks/xfstests/results//generic/484.out.bad	2020-03-16 18:37:07.484545261 +0800
>>      @@ -1,2 +1,3 @@
>>       QA output created by 484
>>      +record lock is not preserved across execve(2)
>>       Silence is golden
>>      ...
>>      (Run 'diff -u /lkp/benchmarks/xfstests/tests/generic/484.out /lkp/benchmarks/xfstests/results//generic/484.out.bad'  to see the entire diff)
>> generic/519	 2s
>> generic/550	[not run] xfs_io set_encpolicy  support is missing
>> generic/580	[not run] xfs_io set_encpolicy  support is missing
>> Ran: generic/015 generic/056 generic/092 generic/124 generic/160 generic/192 generic/222 generic/254 generic/287 generic/319 generic/350 generic/381 generic/416 generic/446 generic/484 generic/519 generic/550 generic/580
>> Not run: generic/550 generic/580
>> Failures: generic/484
>> Failed 1 of 18 tests
>>
>>
>>
>>
>> To reproduce:
>>
>>          # build kernel
>> 	cd linux
>> 	cp config-5.6.0-rc1-00021-g618b4d07a4420 .config
>> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage modules
>> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 INSTALL_MOD_PATH=<mod-install-dir> modules_install
>> 	cd <mod-install-dir>
>> 	find lib/ | cpio -o -H newc --quiet | gzip > modules.cgz
>>
>>
>>          git clone https://github.com/intel/lkp-tests.git
>>          cd lkp-tests
>>          bin/lkp qemu -k <bzImage> -m modules.cgz job-script # job-script is attached in this email
>>
>>
>>
>> Thanks,
>> Rong Chen
>>

