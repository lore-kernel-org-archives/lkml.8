Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5725BC18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2601320873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 13:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="WOUvTtDf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729553AbgCKNlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 09:41:21 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:50454 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729232AbgCKNlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 09:41:20 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 16D254080F;
        Wed, 11 Mar 2020 13:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1583934080; bh=lw1x64akbq/Rtsh3xZ/yvfvvJN+tyISDQ0cHYFcOvKI=;
        h=From:To:Cc:Subject:Date:From;
        b=WOUvTtDfIQ6p2Ojn18nwqGHf9dfTVW3shEfaKo+QCNdOdO0cI8ADlOSTRKDX3TEu1
         hSIeV0u6fxnz4G20O5NGK8LE1AxnoOI2dsisYcSMI0YAu+mr5+SO8nIjSKSzbGNa+A
         7vPKLpwJ0f6poG8NHYfGoQ1TGJOHIyAWx+w4ot1NTZZ2YO7QwP19i+Mu/228ndHi3i
         Lr4OimaqA9iiaECho4LZb0vid5iSWWpPEYU2M8xgHtdO39ZUPiz7FVn4JZsS7mLtuZ
         7Ynr6ETASmJzgn72iLXTlvOyDOsk7E2AnWGjoT+3jLOzhnJCkSw6lwG9T6fkAjQzHg
         d3GMBsx7XoYcA==
Received: from paltsev-e7480.internal.synopsys.com (unknown [10.121.8.79])
        by mailhost.synopsys.com (Postfix) with ESMTP id 5D154A005D;
        Wed, 11 Mar 2020 13:41:17 +0000 (UTC)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH 0/3] CLK: HSDK: CGU: updates for HSDK clock management
Date:   Wed, 11 Mar 2020 16:41:12 +0300
Message-Id: <20200311134115.13257-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bunch of updates for HSDK clock generation unit (CGU) driver.

Eugeniy Paltsev (3):
  CLK: HSDK: CGU: check if PLL is bypassed first
  CLK: HSDK: CGU: support PLL bypassing
  CLK: HSDK: CGU: add support for 148.5MHz clock

 drivers/clk/clk-hsdk-pll.c | 70 +++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 31 deletions(-)

-- 
2.21.1

