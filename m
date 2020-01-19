Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B6A9C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 12:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65DAB20679
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 12:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbgASMSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 07:18:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbgASMS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 07:18:29 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AB1364C57EF4A5898D05;
        Sun, 19 Jan 2020 20:18:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Sun, 19 Jan 2020
 20:18:16 +0800
From:   yu kuai <yukuai3@huawei.com>
To:     <benh@kernel.crashing.org>, <b.zolnierkie@samsung.com>
CC:     <linux-fbdev@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <zhengbin13@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 0/4] cleanup patches for unused variables
Date:   Sun, 19 Jan 2020 20:17:26 +0800
Message-ID: <20200119121730.10701-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.17.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

yu kuai (4):
  video: fbdev: remove set but not used variable 'hSyncPol'
  video: fbdev: remove set but not used variable 'vSyncPol'
  video: fbdev: remove set but not used variable 'vSyncPol'
  video: fbdev: remove set but not used variable 'bytpp'

 drivers/video/fbdev/aty/radeon_base.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

-- 
2.17.2

