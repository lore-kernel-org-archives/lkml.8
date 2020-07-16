Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105CDC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9F2320663
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 02:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgGPCml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 22:42:41 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:50720 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727891AbgGPCmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 22:42:38 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0U2rTvAn_1594867352;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0U2rTvAn_1594867352)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 16 Jul 2020 10:42:34 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     mst@redhat.com, david@redhat.com, jasowang@redhat.com,
        akpm@linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc:     Hui Zhu <teawater@gmail.com>
Subject: [RFC for qemu v4 0/2] virtio-balloon: Add option cont-pages to set VIRTIO_BALLOON_F_CONT_PAGES
Date:   Thu, 16 Jul 2020 10:41:53 +0800
Message-Id: <1594867315-8626-4-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594867315-8626-1-git-send-email-teawater@gmail.com>
References: <1594867315-8626-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code of current version for Linux and qemu is available in [1] and [2].
Update of this version:
1. Report continuous pages will increase the speed.  So added deflate
   continuous pages.
2. According to the comments from David in [3], added 2 new vqs icvq and
   dcvq to get continuous pages with format 32 bits pfn and 32 bits size.

Following is the introduction of the function.
Set option cont-pages to on will open flags VIRTIO_BALLOON_F_CONT_PAGES.
qemu will get continuous pages from icvq and dcvq and do madvise
MADV_WILLNEED and MADV_DONTNEED with the pages.
Opening this flag can bring two benefits:
1. Increase the speed of balloon inflate and deflate.
2. Decrease the splitted THPs number in the host.

[1] https://github.com/teawater/linux/tree/balloon_conts
[2] https://github.com/teawater/qemu/tree/balloon_conts
[3] https://lkml.org/lkml/2020/5/13/1211

Hui Zhu (2):
  virtio_balloon: Add cont-pages and icvq
  virtio_balloon: Add dcvq to deflate continuous pages

 hw/virtio/virtio-balloon.c                      |   92 +++++++++++++++---------
 include/hw/virtio/virtio-balloon.h              |    2
 include/standard-headers/linux/virtio_balloon.h |    1
 3 files changed, 63 insertions(+), 32 deletions(-)
