Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6A6C3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:10:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 321F32070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 09:10:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgBCJKm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 04:10:42 -0500
Received: from mail.loongson.cn ([114.242.206.163]:49960 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726992AbgBCJKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 04:10:41 -0500
Received: from linux.HaierAP (unknown [111.18.44.203])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dxv9+M4zden_gLAA--.1394S2;
        Mon, 03 Feb 2020 17:10:37 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: add entry for Tiezhu Yang
Date:   Mon,  3 Feb 2020 17:10:45 +0800
Message-Id: <1580721045-4988-1-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: AQAAf9Dxv9+M4zden_gLAA--.1394S2
X-Coremail-Antispam: 1UD129KBjvdXoWrCFy7Jw1UCF4DtFyDCFyfJFb_yoWxArc_Gw
        1rKF4kWr4rJw4fCwn29wn3uwn0vw1xua10gw4DAry5Za43t34rKr4vvF4fWF15CrWkWrW5
        Jrs3JFZ2kr1I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AYjsxI4VWxJwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkIecxEwVAFwVW8uwCF04k2
        0xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI
        8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41l
        IxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIx
        AIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jYWlkUUUUU=
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an entry to connect all my email addresses.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index de36dce..29a74cd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -261,6 +261,7 @@ Sumit Semwal <sumit.semwal@ti.com>
 Tejun Heo <htejun@gmail.com>
 Thomas Graf <tgraf@suug.ch>
 Thomas Pedersen <twp@codeaurora.org>
+Tiezhu Yang <yangtiezhu@loongson.cn> <kernelpatch@126.com>
 Todor Tomov <todor.too@gmail.com> <todor.tomov@linaro.org>
 Tony Luck <tony.luck@intel.com>
 TripleX Chung <xxx.phy@gmail.com> <zhongyu@18mail.cn>
-- 
1.8.3.1

