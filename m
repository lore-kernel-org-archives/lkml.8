Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35177C2D0E7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB3420714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585300130;
	bh=XrAvoCe6JDXHuFSYHVF4BgS7lNcFIt165cn726JTkwA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=2uUWND8p3b69EuSiKkRdPBQ1tgeAUPfSxiX9Ya7NX9obEyvZ8Qf7kH3uiLMubOu76
	 qVXTIn0T2INKLXQlT8FYdWjLM84qjcLzXKG8S0+TbNbd3lCSFWk8F9SZJx24wyktV0
	 Hu2Y0DZJixgAAY956LeKl/eJ4dTASCCiFVkHLc4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgC0JIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:08:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:52000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgC0JIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:08:48 -0400
Received: from mail.kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C90BA206E6;
        Fri, 27 Mar 2020 09:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585300127;
        bh=XrAvoCe6JDXHuFSYHVF4BgS7lNcFIt165cn726JTkwA=;
        h=From:To:Cc:Subject:Date:From;
        b=e7Z/xRnXtNMiv8OjzISZiG7pCqd5bXGh6w12I5GVcXfsiGfabV5t2xuqc03+SCO3F
         tYd8qzpcukmC1OLIPOcMm9meFnzIBL8KvN6kabKra5bNu7I9clKmprN5BCuFAou5/Y
         qEPMMzPvzvkrM7pj4fKGx5zyDiiUBCa/Yise5RM4=
From:   Stephen Boyd <sboyd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] clk fixes for v5.6-rc7
Date:   Fri, 27 Mar 2020 02:08:47 -0700
Message-Id: <20200327090847.152877-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 20055448dc1b439c87d0cb602e6d0469b0a3aaad:

  Merge tag 'imx-clk-fixes-5.6' of git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux into clk-fixes (2020-02-25 08:57:00 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git tags/clk-fixes-for-linus

for you to fetch changes up to 8400ab8896324641243b57fc49b448023c07409a:

  clk: imx: Align imx sc clock parent msg structs to 4 (2020-03-25 18:46:05 -0700)

----------------------------------------------------------------
A handful of clk driver fixes. Mostly they're around the i.MX drivers
fixing the parents of a few clks and making KASAN happy with how the
message passing code works. Besides that we have a TI driver fix for the
RTC parent and a fix for the basic gate type registration functions
introduced this release where they didn't actually pass the arguments in
the right places to the multiplexer function down below.

----------------------------------------------------------------
Anson Huang (1):
      clk: imx8mp: Correct IMX8MP_CLK_HDMI_AXI clock parent

Fugang Duan (1):
      clk: imx8mp: Correct the enet_qos parent clock

Leonard Crestez (2):
      clk: imx: Align imx sc clock msg structs to 4
      clk: imx: Align imx sc clock parent msg structs to 4

Stephen Boyd (2):
      Merge tag 'imx-clk-fixes-5.6-2' of git://git.kernel.org/.../shawnguo/linux into clk-fixes
      clk: Pass correct arguments to __clk_hw_register_gate()

Tony Lindgren (1):
      clk: ti: am43xx: Fix clock parent for RTC clock

 drivers/clk/imx/clk-imx8mp.c |  4 ++--
 drivers/clk/imx/clk-scu.c    |  8 ++++----
 drivers/clk/ti/clk-43xx.c    |  2 +-
 include/linux/clk-provider.h | 10 +++++-----
 4 files changed, 12 insertions(+), 12 deletions(-)

-- 
Sent by a computer, using git, on the internet
