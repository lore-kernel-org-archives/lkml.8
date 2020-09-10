Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92EAAC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C84122211
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731016AbgIJOA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:00:59 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11778 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730880AbgIJNys (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 09:54:48 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E8985BA4B5B5E162909A;
        Thu, 10 Sep 2020 21:52:30 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Sep 2020
 21:52:22 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <pkshih@realtek.com>, <kvalo@codeaurora.org>,
        <davem@davemloft.net>, <kuba@kernel.org>,
        <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH -next 0/3] rtlwifi: rtl8188ee: fix comparison pointer to bool warning
Date:   Thu, 10 Sep 2020 21:59:14 +0800
Message-ID: <20200910135917.143723-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zheng Bin (3):
  rtlwifi: rtl8188ee: fix comparison pointer to bool warning in phy.c
  rtlwifi: rtl8188ee: fix comparison pointer to bool warning in trx.c
  rtlwifi: rtl8188ee: fix comparison pointer to bool warning in hw.c

 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/hw.c  | 12 ++++++------
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/phy.c |  2 +-
 drivers/net/wireless/realtek/rtlwifi/rtl8188ee/trx.c |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

--
2.26.0.106.g9fadedd

