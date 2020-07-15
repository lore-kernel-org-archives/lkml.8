Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22436C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB080206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 23:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R5K7TOwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGOXae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 19:30:34 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49845 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgGOXad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 19:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594855833; x=1626391833;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0mCXGabb7HomZL/UNylxftn0LVKsqZIhAFSG2ya7jko=;
  b=R5K7TOwepvgZn+Th6hjM8giEqoaaFQxa/cQTQcku7walv6/yfz+1ym0c
   BojxjWbvgbqhaVSBTyDZDYmMX7XOcRih3hUKGLcOqnBvxksjyUAAP4xOA
   tL7oQmI9LztjNnPBOIThZenAahWXZaAk0VQz99uo45zBqVUZmqTnzJbQg
   a+ynyyZHWMY5Jkic+eSEgLIFdA1lJVmUNOm6worwfGZzhKkU0gU4DFVx4
   pufed0NV61vu0Fq64LkfOK8O3GGM5RR9juDK0K8Hcm6HFzUOlJNCJhTNQ
   6a9nBj4WDummOd+kU9v+f4JBKUIceetwlvoh9VHOnlvYiK2045/Z8wfTd
   g==;
IronPort-SDR: p6//3oUl9lv+RnEQHMwuj2wI0WMv8gomI758jZiQ/2TETY7QVC5bo3hJ+6lqPHoZNd8RXFOU3p
 B/MdNLPKlRaigZBIQNt9jxlyH2oB8/uJyvkOed3JwLZSpwi31nCIgmT1TmwzxPzuiWL4iBbd8+
 +Hw/pqvYtSodoEQStd+wLVN+LFYHzv7LegFG7SBkF4rsBJ4cHWrIswFeHaYFKE8XJivPUDM1rW
 ZvHw3aJCTNBZg33ZW3BWNFs7857QMTsiaYgjlm44/2iEPTK6v7eGBfonhPWtlottEylZu0/ynr
 1Tw=
X-IronPort-AV: E=Sophos;i="5.75,357,1589212800"; 
   d="scan'208";a="146868537"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2020 07:30:16 +0800
IronPort-SDR: AknsL6CK00Y0mAa7o6Ur18cYAty4rob5J6KLHUCQPuaIVepXTgqp76hh3yDkWsOGSnuEq6PKY9
 mrRkrhWEURtcC8i4eg9R3Qgw2Kahb6k6k=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2020 16:18:40 -0700
IronPort-SDR: +CsTUYtNKlPYkJ+S7TcweDE7AVV8Gd7nWEuOO4mFmqvpmmZgOOuPWQccY1e+r16n814OzHcIiJ
 SqnxvWA9ei3A==
WDCIronportException: Internal
Received: from cnf009656.ad.shared (HELO jedi-01.hgst.com) ([10.86.58.5])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 Jul 2020 16:30:13 -0700
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup.patel@wdc.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>
Subject: [PATCH 0/4] Few mm & exception handling fixes
Date:   Wed, 15 Jul 2020 16:30:05 -0700
Message-Id: <20200715233009.27183-1-atish.patra@wdc.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses some generic fixes that I found while working
on UEFI series. These patches are completely independent from UEFI
implementation and can be merged sooner that UEFI.

Some of the patches were already part of the UEFI series [1]. I will
remove them from next UEFI series (v3).

Patch1 moves set up the exception vector earlier while all other patches
are mm related fixes.

[1] http://lists.infradead.org/pipermail/linux-riscv/2020-July/000942.html

Atish Patra (4):
RISC-V: Setup exception vector early
RISC-V: Set maximum number of mapped pages correctly
RISC-V: Do not rely on initrd_start/end computed during early dt
parsing
riscv: Parse all memory blocks to remove unusable memory

arch/riscv/kernel/head.S    | 10 ++++--
arch/riscv/kernel/smpboot.c |  1 -
arch/riscv/kernel/traps.c   |  8 +----
arch/riscv/mm/init.c        | 66 +++++++++++++++++++++++++------------
4 files changed, 54 insertions(+), 31 deletions(-)

--
2.24.0

