Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC92C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6752077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="cd1rfX6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728379AbgAJPNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:13:41 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:55684 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728137AbgAJPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:13:40 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1797940609;
        Fri, 10 Jan 2020 15:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1578669220; bh=YgRf2R2fEVbn4euNlEYstjVo6ED5nUtykY8bZiZZdok=;
        h=From:To:Cc:Subject:Date:From;
        b=cd1rfX6lviWpcYP4veI4RZBrG9EcMTAu7P5MwiZyolf322H4t/gHdEd58WSLkhS00
         M1gFVi/KQjKTNaT44jWkl+fYqYrYaGkJczYqiGhpZ7Gvbp9qKar2dmBD9XuwMphmJU
         aQFMReMV2YJgoP848ZMF8rosGTwKqlwNzDtCPIrLA8O3DvHwMJqF8v7WGjEh6gyhRD
         6NOKVJnW1txFWhjvUnpC6QY+1lQBtYhZLgHqWmB8JRi2jpwjjJDyLQFjFU7gciJIBH
         3qtE5cu+fc4op6QAI+ysf8Qm/ecc6lFamZazn2xTymG5qdh7e3DeRewUlfkGy01wL4
         K9ZsRZWaqcFwg==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 20B43A0061;
        Fri, 10 Jan 2020 15:13:36 +0000 (UTC)
From:   Jose Abreu <Jose.Abreu@synopsys.com>
To:     netdev@vger.kernel.org
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: stmmac: Frame Preemption fixes
Date:   Fri, 10 Jan 2020 16:13:33 +0100
Message-Id: <cover.1578669088.git.Jose.Abreu@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two single fixes for the -next tree for recently introduced Frame Preemption
feature.

1) and 2) fixes the disabling of Frame Preemption that was not being correctly
handled because of a missing return.

---
Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
---

Jose Abreu (2):
  net: stmmac: xgmac: Fix missing return
  net: stmmac: gmac5+: Fix missing return

 drivers/net/ethernet/stmicro/stmmac/dwmac5.c        | 1 +
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.7.4

