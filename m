Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB620C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A770320719
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 06:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCXGtv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:49:51 -0400
Received: from mo-csw1516.securemx.jp ([210.130.202.155]:37210 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbgCXGtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 02:49:51 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 02O6nVTs010867; Tue, 24 Mar 2020 15:49:32 +0900
X-Iguazu-Qid: 34trWq5avtnaVNYr0i
X-Iguazu-QSIG: v=2; s=0; t=1585032571; q=34trWq5avtnaVNYr0i; m=wsPGRAhtXjyFu7PbYsoh/2Lf9/c1dyQ1oLRf9Vcu8UA=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1513) id 02O6nUIk008719;
        Tue, 24 Mar 2020 15:49:31 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 02O75mV7025945;
        Tue, 24 Mar 2020 16:05:48 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 02O6nTiC009914;
        Tue, 24 Mar 2020 15:49:30 +0900
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
To:     miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: [PATCH v5 0/2] mtd: spinand: toshiba: Support for new Kioxia Serial NAND
Date:   Tue, 24 Mar 2020 15:49:27 +0900
X-TSB-HOP: ON
Message-Id: <cover.1584949601.git.ytc-mb-yfuruyama7@kioxia.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First patch is to rename function name becase of add new device.
Second patch is to supprot for new device.

Yoshio Furuyama (2):
  mtd: spinand: toshiba: Rename function name to change suffix and
    prefix (8Gbit)
  mtd: spinand: toshiba: Support for new Kioxia Serial NAND

 drivers/mtd/nand/spi/toshiba.c | 182 +++++++++++++++++++++++++++++++----------
 1 file changed, 138 insertions(+), 44 deletions(-)

-- 
1.9.1

