Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B491C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE9D208E0
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 18:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SPyDMkSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgCaSke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 14:40:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39814 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgCaSkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 14:40:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VIdgJd195343;
        Tue, 31 Mar 2020 18:40:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Jx62qSdiTH7cXFTayvG3Y2qZ2IfJGs/x+XwHBSHDsyI=;
 b=SPyDMkSBnWmhCjwlGEk2EHZRpKMTiObfq5i/OK7A+oGIo/JTXpedeOLCnDzK+9u30PUJ
 XoCqy5xO8neh3BP0cSXU00SYBQg9HUh3vopHlfIMuAaFGGFmU+exe0g1uhs3KToiXgLH
 hfMTX9WYf6eLOgOlZ7KzjoKzuwtZNqra7TydsyAVpCQwqxvjrGDzOIzly9DaJHvBmIs+
 p1c37l5X/GrWQRNgunlCfxwZpHDR05yqDxCYLZpuJf1VAF9GP0OFxtsx27whs7V8EfHi
 mF5QK7mZdD01Yt9i6gkzyiv0OXZAqV5+uU0APfCH72T87rw6+/GU0nxYftRLiuw5DAp9 wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 303yun3wdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 18:40:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02VIb89G107708;
        Tue, 31 Mar 2020 18:40:12 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 302gcdcabh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Mar 2020 18:40:12 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02VIe8NG027868;
        Tue, 31 Mar 2020 18:40:08 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Mar 2020 11:40:08 -0700
Subject: Re: [PATCH v2 1/2] hugetlbfs: use i_mmap_rwsem for more pmd sharing
 synchronization
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A.Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        lkft-triage@lists.linaro.org
References: <20200316205756.146666-1-mike.kravetz@oracle.com>
 <20200316205756.146666-2-mike.kravetz@oracle.com>
 <CA+G9fYvopJ7v2w3+8Qb+ov_Ji30=mW-DJceZfUOtHFKFMWod8Q@mail.gmail.com>
 <CA+G9fYsJgZhhWLMzUxu_ZQ+THdCcJmFbHQ2ETA_YPP8M6yxOYA@mail.gmail.com>
 <74d61fb3-6750-e9c4-0b42-8d811d418091@oracle.com>
Message-ID: <650eb515-0e5a-c20e-39f1-6c08da71e7d5@oracle.com>
Date:   Tue, 31 Mar 2020 11:40:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <74d61fb3-6750-e9c4-0b42-8d811d418091@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310155
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9577 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003310154
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/30/20 4:35 PM, Mike Kravetz wrote:
> On 3/30/20 7:01 AM, Naresh Kamboju wrote:
>> FYI,
>>
>> The device is x86_64 device running i386 kernel image.
>>
>> - Naresh
>>
>> On Mon, 30 Mar 2020 at 19:00, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>>
>>> On i386 running LTP hugetlb tests found kernel BUG at fs/hugetlbfs/inode.c:458
>>> Running Linux version 5.6.0-rc7-next-20200330
>>> And hugemmap test failed due to ENOMEM.
>>>
>>> steps to reproduce:
>>>         # cd /opt/ltp
>>>         # ./runltp -f hugetlb
> 
> It took me a while to set up an environment to reproduce.  I was finally
> able to reproduce on an x86_64 VM running a 32 bit OS/5.6.0-rc7-next-20200330
> kernel.
> 
> My first attempt with PAE enabled and 8GB of memory did not reproduce.  When
> I disabled PAE and dropped memory to 4GB, the problem reproduced.
> 
> After reverting this patch, and the followup in the series I was still able
> to recreate the issue.  So, the patches are not the root cause.
> 
> One 'interesting' thing are the messages,
> mm/pgtable-generic.c:50: bad pgd ...
> These show up before the hugetlbfs BUG.
> 
> I will continue to investigate.  However, if the 'bad pgd ..' message provides
> a hint to someone please let us know.

As mentioned in another thread, the root cause for this issue is patch:

mm/hugetlb: fix a addressing exception caused by huge_pte_offset

Andrew should be removing this from the mm tree.

While looking at this issue, I noticed something else.  With earlier linux-next
i386 non-PAE kernels, I could run the ltp tests './runltp -f hugetlb' without
issue.  However, if I then did something like compile the kernel I would get
MCE errors such as:

[  655.771878] MCE: Killing ld:14278 due to hardware memory corruption fault at 27d5284
[  657.781429] get_swap_device: Bad swap file entry 700374d0
[  657.782311] BUG: kernel NULL pointer dereference, address: 00000000
[  657.783384] #PF: supervisor read access in kernel mode
[  657.784088] #PF: error_code(0x0000) - not-present page
[  657.784985] *pde = 00000000 
[  657.785490] Oops: 0000 [#1] SMP
[  657.785995] CPU: 3 PID: 14278 Comm: ld Not tainted 5.6.0-rc7-next-20200330+ #3
[  657.787116] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
[  657.789234] EIP: do_swap_page+0x40a/0x8a0
[  657.789862] Code: ba 70 24 2d da e8 26 90 ff ff 0f 0b 8d 74 26 00 89 fe c7 45 e4 10 00 00 00 e9 be fc ff ff 66 90 8b 75 e0 89 f0 e8 b6 0e 02 00 <8b> 00 f6 c4 10 0f 84 c3 00 00 00 89 f0 e8 84 df 01 00 83 f8 01 0f
[  657.792813] EAX: 00000000 EBX: ed3adc08 ECX: f6ff12c0 EDX: 00000001
[  657.793895] ESI: 700374d0 EDI: 00000000 EBP: ed3adbec ESP: ed3adbb4
[  657.794935] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[  657.796084] CR0: 80050033 CR2: 00000000 CR3: 362c3000 CR4: 00140ed0
[  657.797099] Call Trace:
[  657.797496]  ? pipe_write+0x33f/0x530
[  657.798092]  handle_mm_fault+0x3c8/0xb70
[  657.798658]  ? remove_wait_queue+0x50/0x50
[  657.799218]  __get_user_pages+0x12d/0x460
[  657.799766]  get_dump_page+0x3c/0x60
[  657.800251]  ? kunmap_high+0x1c/0xb0
[  657.800776]  elf_core_dump+0x12e3/0x13c0
[  657.801349]  ? newidle_balance+0xaa/0x440
[  657.801896]  do_coredump+0x532/0xe60
[  657.802410]  ? wake_up_state+0xf/0x20
[  657.802952]  ? signal_wake_up_state+0x22/0x30
[  657.803591]  get_signal+0x130/0x800
[  657.804103]  do_signal+0x23/0x5b0
[  657.804582]  ? mm_fault_error+0x18b/0x190
[  657.805165]  exit_to_usermode_loop+0x7d/0xe0
[  657.805776]  ? kvm_async_pf_task_wake+0xe0/0xe0
[  657.806421]  prepare_exit_to_usermode+0x67/0xb0
[  657.807093]  ret_from_exception+0x18/0x1d
[  657.807778] EIP: 0xb7d028aa
[  657.808266] Code: 55 57 56 53 e8 6e 40 0c 00 81 c3 77 b7 15 00 83 ec 2c 8b 83 60 ff ff ff 8b 4c 24 40 8b 00 85 c0 0f 85 da 00 00 00 85 c9 74 29 <8b> 71 fc 8d 51 f8 f7 c6 02 00 00 00 75 28 83 e6 04 8d 83 60 07 00
[  657.810957] EAX: 00000000 EBX: b7e5e000 ECX: 027d5288 EDX: 027d5288
[  657.811859] ESI: 0f61c7b0 EDI: 00000000 EBP: b7e5e000 ESP: bfa70850
[  657.812752] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00010206
[  657.813646] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ip_set nfnetlink ebtable_broute ebtable_nat ip6table_security ip6table_raw ip6table_mangle ip6table_nat iptable_security iptable_raw iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 libcrc32c nf_defrag_ipv4 ebtable_filter ebtables ip6table_filter ip6_tables sunrpc snd_hda_codec_generic snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hwdep snd_hda_core kvm_intel kvm snd_seq joydev snd_seq_device snd_pcm irqbypass crc32_pclmul snd_timer snd i2c_piix4 virtio_balloon soundcore virtio_net net_failover qxl failover virtio_console drm_ttm_helper ttm drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm 8139too virtio_pci ata_generic crc32c_intel virtio_ring pata_acpi 8139cp serio_raw virtio mii qemu_fw_cfg
[  657.823564] CR2: 0000000000000000
[  657.824065] ---[ end trace 3bb3cde8ebb1e195 ]---
[  657.824722] EIP: do_swap_page+0x40a/0x8a0
[  657.825734] Code: ba 70 24 2d da e8 26 90 ff ff 0f 0b 8d 74 26 00 89 fe c7 45 e4 10 00 00 00 e9 be fc ff ff 66 90 8b 75 e0 89 f0 e8 b6 0e 02 00 <8b> 00 f6 c4 10 0f 84 c3 00 00 00 89 f0 e8 84 df 01 00 83 f8 01 0f
[  657.830314] EAX: 00000000 EBX: ed3adc08 ECX: f6ff12c0 EDX: 00000001
[  657.831477] ESI: 700374d0 EDI: 00000000 EBP: ed3adbec ESP: ed3adbb4
[  657.832689] DS: 007b ES: 007b FS: 00d8 GS: 00e0 SS: 0068 EFLAGS: 00010246
[  657.834071] CR0: 80050033 CR2: 00000000 CR3: 362c3000 CR4: 00140ed0
[  907.190369] MCE: Killing pool:14285 due to hardware memory corruption fault at b46031fc

This does not happen on v5.6.  So, I 'think' there is something specifically
in next causing the issue.  It happens on earlier versions of next before
these hugetlbfs patches.  I am trying to isolate this some more, but any help
would be appreciated.
-- 
Mike Kravetz
