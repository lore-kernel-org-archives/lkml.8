Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C665EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7C620842
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 03:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgHEDuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 23:50:51 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9331 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726150AbgHEDuu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 23:50:50 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A14A45A96A7C7BAC2659;
        Wed,  5 Aug 2020 11:50:48 +0800 (CST)
Received: from localhost.localdomain (10.175.112.70) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 5 Aug 2020 11:50:47 +0800
From:   Zhang Changzhong <zhangchangzhong@huawei.com>
To:     <robin@protonic.nl>, <linux@rempel-privat.de>,
        <kernel@pengutronix.de>, <socketcan@hartkopp.net>,
        <mkl@pengutronix.de>, <davem@davemloft.net>, <kuba@kernel.org>
CC:     <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net 0/4] support multipacket broadcast message
Date:   Wed, 5 Aug 2020 11:50:21 +0800
Message-ID: <1596599425-5534-1-git-send-email-zhangchangzhong@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.70]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang Changzhong (4):
  can: j1939: fix support for multipacket broadcast message
  can: j1939: cancel rxtimer on multipacket broadcast session complete
  can: j1939: abort multipacket broadcast session when timeout occurs
  can: j1939: add rxtimer for multipacket broadcast session

 net/can/j1939/transport.c | 48 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 12 deletions(-)

-- 
2.9.5

