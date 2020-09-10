Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC4BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07A0A214F1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgIJTNY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:13:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:43088 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731445AbgIJQA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:00:56 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2773398BEAE6FDF66E8E;
        Thu, 10 Sep 2020 23:12:18 +0800 (CST)
Received: from huawei.com (10.175.113.133) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 23:12:17 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <jeffrey.t.kirsher@intel.com>, <davem@davemloft.net>,
        <kuba@kernel.org>, <intel-wired-lan@lists.osuosl.org>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 0/3] Fix some kernel-doc warnings for i40e
Date:   Thu, 10 Sep 2020 23:09:31 +0800
Message-ID: <20200910150934.34605-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.133]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wang Hai (3):
  i40e: Fix some kernel-doc warnings in i40e_client.c
  i40e: Fix some kernel-doc warnings in i40e_common.c
  i40e: Fix a kernel-doc warning in i40e_ptp.c

 drivers/net/ethernet/intel/i40e/i40e_client.c | 2 --
 drivers/net/ethernet/intel/i40e/i40e_common.c | 2 --
 drivers/net/ethernet/intel/i40e/i40e_ptp.c    | 1 -
 3 files changed, 5 deletions(-)

-- 
2.17.1

