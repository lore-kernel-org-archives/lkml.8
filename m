Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A4BC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87E342070A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 03:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgCGD0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 22:26:55 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:37343 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726237AbgCGD0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 22:26:55 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04420;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0TrsR0i9_1583551608;
Received: from IT-FVFX43SYHV2H.local(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0TrsR0i9_1583551608)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 07 Mar 2020 11:26:49 +0800
Subject: Re: [failures] mm-vmscan-remove-unnecessary-lruvec-adding.patch
 removed from -mm tree
To:     Qian Cai <cai@lca.pw>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, aarcange@redhat.com,
        daniel.m.jordan@oracle.com, hannes@cmpxchg.org, hughd@google.com,
        khlebnikov@yandex-team.ru, kirill@shutemov.name,
        kravetz@us.ibm.com, mhocko@kernel.org, mm-commits@vger.kernel.org,
        tj@kernel.org, vdavydov.dev@gmail.com, willy@infradead.org,
        yang.shi@linux.alibaba.com
References: <20200306025041.rERhvnYmB%akpm@linux-foundation.org>
 <211632B1-2D6F-4BFA-A5A0-3030339D3D2A@lca.pw>
 <b123f1d8-eab0-4689-9400-ba1f853728b7@linux.alibaba.com>
 <f37b9b6b-730b-09b0-dd6b-5acba53e71e6@linux.alibaba.com>
 <792CE873-A64B-4FA6-A258-A8B6B951E698@lca.pw>
From:   Alex Shi <alex.shi@linux.alibaba.com>
Message-ID: <7149d2fb-2ff2-d251-2ed1-b4e6d81748ee@linux.alibaba.com>
Date:   Sat, 7 Mar 2020 11:26:47 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <792CE873-A64B-4FA6-A258-A8B6B951E698@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2020/3/7 上午10:27, Qian Cai 写道:
>> Compare to this patch's change, the 'c8cba0cc2a80 mm/thp: narrow lru locking' is more
>> likely bad. Maybe it's due to lru unlock was moved before ClearPageCompound() from
>> before remap_page(head); guess this unlock should be move after ClearPageCompound or
>> move back to origin place.
> I can only confirmed that after reverted those 6 patches, I am no long be able to reproduce it.
> 

Hi Qian, 

Thanks for response!
Could you like just try to revert the patch: 'mm/thp: narrow lru locking'? or would you like to
share me info of your tests and let me reproduce it? like kernel config, system ENV, machine type.
I had run hundreds cycle of oom01, but akpm kernel(f2cbd107a99b) still survived.

I got my ltp mm testing results, it run total 75 cases, failed 2, skip 9 and others are success
and kernel works well after test on yesterday's akmp head: f2cbd107a99b.

Many Thanks for help!
Alex

=====

Test Start Time: Fri Mar  6 20:49:59 2020
-----------------------------------------
Testcase                                           Result     Exit Value
--------                                           ------     ----------
mm01                                               PASS       0
mm02                                               PASS       0
mtest01                                            PASS       0
mtest01w                                           PASS       0
mtest05                                            PASS       0
mtest06                                            PASS       0
mtest06_2                                          PASS       0
mtest06_3                                          PASS       0
mem01                                              PASS       0
mem02                                              PASS       0
mem03                                              PASS       0
page01                                             PASS       0
page02                                             PASS       0
data_space                                         PASS       0
stack_space                                        PASS       0
shmt02                                             PASS       0
shmt03                                             PASS       0
shmt04                                             PASS       0
shmt05                                             PASS       0
shmt06                                             PASS       0
shmt07                                             PASS       0
shmt08                                             PASS       0
shmt09                                             PASS       0
shmt10                                             PASS       0
shm_test01                                         PASS       0
mallocstress01                                     PASS       0
mmapstress01                                       PASS       0
mmapstress02                                       PASS       0
mmapstress03                                       PASS       0
mmapstress04                                       PASS       0
mmapstress05                                       PASS       0
mmapstress06                                       PASS       0
mmapstress07                                       PASS       0
mmapstress08                                       PASS       0
mmapstress09                                       PASS       0
mmapstress10                                       PASS       0
mmap10                                             PASS       0
mmap10_1                                           PASS       0
mmap10_2                                           PASS       0
mmap10_3                                           PASS       0
mmap10_4                                           PASS       0
ksm01                                              FAIL       2
ksm01_1                                            FAIL       1
ksm02                                              CONF       32
ksm02_1                                            CONF       32
ksm03                                              PASS       0
ksm03_1                                            PASS       0
ksm04                                              CONF       32
ksm04_1                                            CONF       32
ksm05                                              PASS       0
ksm06                                              CONF       32
ksm06_1                                            CONF       32
ksm06_2                                            CONF       32
oom01                                              PASS       0
oom02                                              CONF       32
oom03                                              PASS       0
oom04                                              PASS       0
oom05                                              PASS       0
swapping01                                         PASS       0
thp01                                              PASS       0
thp02                                              PASS       0
thp03                                              PASS       0
vma01                                              PASS       0
vma02                                              PASS       0
vma03                                              CONF       32
vma04                                              PASS       0
vma05                                              PASS       0
overcommit_memory01                                PASS       0
overcommit_memory02                                PASS       0
overcommit_memory03                                PASS       0
overcommit_memory04                                PASS       0
overcommit_memory05                                PASS       0
overcommit_memory06                                PASS       0
max_map_count                                      PASS       0
min_free_kbytes                                    PASS       0

-----------------------------------------------
Total Tests: 75
Total Skipped Tests: 9
Total Failures: 2
Kernel Version: 5.6.0-rc4-06724-gf2cbd107a99b
Machine Architecture: x86_64
Hostname: alexshi-test

