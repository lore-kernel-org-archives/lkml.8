Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03448C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49F020663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgGMSHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:07:14 -0400
Received: from out28-196.mail.aliyun.com ([115.124.28.196]:49036 "EHLO
        out28-196.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729689AbgGMSHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:07:13 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1451672|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00533608-0.000892395-0.993772;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03306;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.I1D8Ndo_1594663624;
Received: from localhost.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I1D8Ndo_1594663624)
          by smtp.aliyun-inc.com(10.147.40.7);
          Tue, 14 Jul 2020 02:07:09 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     tsbogend@alpha.franken.de, robh+dt@kernel.org
Cc:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, paulburton@kernel.org,
        paul@crapouillou.net, ak@linux.intel.com, ebiederm@xmission.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Subject: [PATCH v3 0/3] Add support for Ingenic X1830 SoC and Y&A CU1830-Neo board.
Date:   Tue, 14 Jul 2020 02:06:37 +0800
Message-Id: <20200713180640.3990-1-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2->v3:
Adjust the order of nodes according to the
corresponding address value.

周琰杰 (Zhou Yanjie) (3):
  MIPS: Ingenic: Add Ingenic X1830 support.
  dt-bindings: MIPS: Add Ingenic X1830 based boards.
  MIPS: Ingenic: Add YSH & ATIL CU Neo board support.

 .../devicetree/bindings/mips/ingenic/devices.yaml  |  12 +-
 arch/mips/boot/dts/ingenic/Makefile                |   1 +
 arch/mips/boot/dts/ingenic/cu1830-neo.dts          | 168 ++++++++++++
 arch/mips/boot/dts/ingenic/x1830.dtsi              | 300 +++++++++++++++++++++
 arch/mips/configs/cu1830-neo_defconfig             | 123 +++++++++
 arch/mips/jz4740/Kconfig                           |  10 +
 6 files changed, 611 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/boot/dts/ingenic/cu1830-neo.dts
 create mode 100644 arch/mips/boot/dts/ingenic/x1830.dtsi
 create mode 100644 arch/mips/configs/cu1830-neo_defconfig

-- 
2.11.0

