Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E36C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CBB820754
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584461429;
	bh=TE0OALslBnAglDc0PbW0+eztUT4bhEdyvuy67q7ODsA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=G6RPEOFKbkE9Vb2SYICgP+I+TEYHkB2r2ttuMou+OCSJRaen328Lmse/eHb5ckWCV
	 0oFnyhY2YVCIHowV3jy0v4e1Gayii0YqpXLcgXUd37nkxQuzpwyH+HOb0XKr8nNsCn
	 Fn0O2/tHgUKDQHGhXMmTZ40r2WxCLX0aqnTBwVbw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbgCQQK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgCQQK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:10:28 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 880D420724;
        Tue, 17 Mar 2020 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584461427;
        bh=TE0OALslBnAglDc0PbW0+eztUT4bhEdyvuy67q7ODsA=;
        h=From:To:Cc:Subject:Date:From;
        b=t8O7crINsA3AtuGuMMK+pePvF5aF7Fb0BIZ1zxo4crz2S9zepUdiZ303EtOl0nAfm
         4DZKRihRj8Xp/JbUwFFLy7LidMQ5YRnCmhfg6NdhMC2SAILL8Db8Y/bncOQIHfzaV6
         XNTFBaPv+ie6KQcXKLng6/sY+pKK3hCkVDBZ4/10=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCHv3 0/5] clk: agilex: add clock driver
Date:   Tue, 17 Mar 2020 11:10:17 -0500
Message-Id: <20200317161022.11181-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 3 of the patchset to add a clock driver to the Agilex
platform.

This version adds 2 new patches that was a result from comments received
in v2.

Patch 2/5: clk: socfpga: remove clk_ops enable/disable methods
Patch 3/5: clk: socfpga: add const to _ops data structures

Thanks,
Dinh


Dinh Nguyen (5):
  clk: socfpga: stratix10: use new parent data scheme
  clk: socfpga: remove clk_ops enable/disable methods
  clk: socfpga: add const to _ops data structures
  dt-bindings: documentation: add clock bindings information for Agilex
  clk: socfpga: agilex: add clock driver for the Agilex platform

 .../bindings/clock/intel,agilex.yaml          |  36 ++
 drivers/clk/Makefile                          |   3 +-
 drivers/clk/socfpga/Makefile                  |   2 +
 drivers/clk/socfpga/clk-agilex.c              | 454 ++++++++++++++++++
 drivers/clk/socfpga/clk-gate-s10.c            |   5 +-
 drivers/clk/socfpga/clk-periph-s10.c          |  10 +-
 drivers/clk/socfpga/clk-pll-a10.c             |   4 +-
 drivers/clk/socfpga/clk-pll-s10.c             |  78 ++-
 drivers/clk/socfpga/clk-pll.c                 |   4 +-
 drivers/clk/socfpga/clk-s10.c                 | 160 ++++--
 drivers/clk/socfpga/stratix10-clk.h           |  10 +-
 include/dt-bindings/clock/agilex-clock.h      |  70 +++
 12 files changed, 784 insertions(+), 52 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
 create mode 100644 drivers/clk/socfpga/clk-agilex.c
 create mode 100644 include/dt-bindings/clock/agilex-clock.h

-- 
2.25.1

