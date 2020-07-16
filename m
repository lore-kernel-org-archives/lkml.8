Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D5A6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D9E820663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:42:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgGPCmP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:42:15 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:47743 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727105AbgGPCmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:42:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01419;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U2rEMt5_1594867319;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0U2rEMt5_1594867319)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jul 2020 10:42:09 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     mst@redhat.com, david@redhat.com, jasowang@redhat.com,
        akpm@linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc:     Hui Zhu <teawater@gmail.com>
Subject: [RFC for Linux v4 0/2] virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES to report continuous pages
Date:   Thu, 16 Jul 2020 10:41:50 +0800
Message-Id: <1594867315-8626-1-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first, second and third version are in [1], [2] and [3].
Code of current version for Linux and qemu is available in [4] and [5].
Update of this version:
1. Report continuous pages will increase the speed.  So added deflate
   continuous pages.
2. According to the comments from David in [6], added 2 new vqs inflate_cont_vq
   and deflate_cont_vq to report continuous pages with format 32 bits pfn and 32
   bits size.
Following is the introduction of the function.
These patches add VIRTIO_BALLOON_F_CONT_PAGES to virtio_balloon. With this
flag, balloon tries to use continuous pages to inflate and deflate.
Opening this flag can bring two benefits:
1. Report continuous pages will increase memory report size of each time
   call tell_host.  Then it will increase the speed of balloon inflate and
   deflate.
2. Host THPs will be splitted when qemu release the page of balloon inflate.
   Inflate balloon with continuous pages will let QEMU release the pages
   of same THPs.  That will help decrease the splitted THPs number in
   the host.
   Following is an example in a VM with 1G memory 1CPU.  This test setups an
   environment that has a lot of fragmentation pages.  Then inflate balloon will
   split the THPs.
// This is the THP number before VM execution in the host.
// None use THP.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:         0 kB
// After VM start, use usemem
// (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
// punch-holes function generates 400m fragmentation pages in the guest
// kernel.
usemem --punch-holes -s -1 800m &
// This is the THP number after this command in the host.
// Some THP is used by VM because usemem will access 800M memory
// in the guest.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    911360 kB
// Connect to the QEMU monitor, setup balloon, and set it size to 600M.
(qemu) device_add virtio-balloon-pci,id=balloon1
(qemu) info balloon
balloon: actual=1024
(qemu) balloon 600
(qemu) info balloon
balloon: actual=600
// This is the THP number after inflate the balloon in the host.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:     88064 kB
// Set the size back to 1024M in the QEMU monitor.
(qemu) balloon 1024
(qemu) info balloon
balloon: actual=1024
// Use usemem to increase the memory usage of QEMU.
killall usemem
usemem 800m
// This is the THP number after this operation.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:     65536 kB

Following example change to use continuous pages balloon.  The number of
splitted THPs is decreased.
// This is the THP number before VM execution in the host.
// None use THP.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:         0 kB
// After VM start, use usemem punch-holes function generates 400M
// fragmentation pages in the guest kernel.
usemem --punch-holes -s -1 800m &
// This is the THP number after this command in the host.
// Some THP is used by VM because usemem will access 800M memory
// in the guest.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    911360 kB
// Connect to the QEMU monitor, setup balloon, and set it size to 600M.
(qemu) device_add virtio-balloon-pci,id=balloon1,cont-pages=on
(qemu) info balloon
balloon: actual=1024
(qemu) balloon 600
(qemu) info balloon
balloon: actual=600
// This is the THP number after inflate the balloon in the host.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    616448 kB
// Set the size back to 1024M in the QEMU monitor.
(qemu) balloon 1024
(qemu) info balloon
balloon: actual=1024
// Use usemem to increase the memory usage of QEMU.
killall usemem
usemem 800m
// This is the THP number after this operation.
cat /proc/meminfo | grep AnonHugePages:
AnonHugePages:    907264 kB

[1] https://lkml.org/lkml/2020/3/12/144
[2] https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email-teawater@gmail.com/
[3] https://lkml.org/lkml/2020/5/12/324
[4] https://github.com/teawater/linux/tree/balloon_conts
[5] https://github.com/teawater/qemu/tree/balloon_conts
[6] https://lkml.org/lkml/2020/5/13/1211

Hui Zhu (2):
  virtio_balloon: Add VIRTIO_BALLOON_F_CONT_PAGES and inflate_cont_vq
  virtio_balloon: Add deflate_cont_vq to deflate continuous pages

 drivers/virtio/virtio_balloon.c     |  180 +++++++++++++++++++++++++++++++-----
 include/linux/balloon_compaction.h  |   12 ++
 include/uapi/linux/virtio_balloon.h |    1
 mm/balloon_compaction.c             |  117 +++++++++++++++++++++--
 4 files changed, 280 insertions(+), 30 deletions(-)
