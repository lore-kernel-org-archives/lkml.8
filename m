Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAC42C2BA1E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8870221E8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586189070;
	bh=qpa1esmnSCdujDJEAzPw7H6IbbTIQDzuZG08g5oE34Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=bceR6izzr0E0ph4/xz7TBUWkZEBHKo8rnfiMAPZ9i0ZoubOI8LRbqd2bq76t5iOQF
	 gkomqERilF87O8FdsymSX9oUFPTiPJf5GEVQoULBop4lgl21JM3oFmsfAQ8zvjVW5d
	 eCk0TieJf9taLU+OtJxCLU8ZSpE6XUfN6rvoR0Es=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgDFQE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:04:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728982AbgDFQE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:04:29 -0400
Received: from localhost.localdomain (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36D1920B1F;
        Mon,  6 Apr 2020 16:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586189069;
        bh=qpa1esmnSCdujDJEAzPw7H6IbbTIQDzuZG08g5oE34Q=;
        h=From:To:Cc:Subject:Date:From;
        b=oiW5Kl69+HvhFuBsAjp4Pw6Q2azlgJG+oys3nyonDO2wlH/6spDtixEKADrUHPpOk
         JjEo5PnQhBFekjN3jqvbq666jklv8Ci5Tr3d05PekALg3Mtr4YWo+7cBzS4wsQE5jJ
         MXWqZjmCsSZ5m00qxF/LumrsqkeLfyHku3eHPfnI=
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     linux-clk@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com
Subject: [PATCHv6 0/5] clk: agilex: add clock driver
Date:   Mon,  6 Apr 2020 11:04:13 -0500
Message-Id: <20200406160418.27476-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is version 6 of the patchset to add a clock driver to the Agilex
platform.

The change from v5 is fix build error from 'make dt_binding_check'.

Thanks,

Dinh Nguyen (5):
  clk: socfpga: remove clk_ops enable/disable methods
  clk: socfpga: add const to _ops data structures
  dt-bindings: documentation: add clock bindings information for Agilex
  clk: socfpga: agilex: add clock driver for the Agilex platform
  arm64: dts: agilex: populate clock dts entries

 .../bindings/clock/intel,agilex.yaml          |  46 ++
 arch/arm64/boot/dts/intel/socfpga_agilex.dtsi |  72 +++
 .../boot/dts/intel/socfpga_agilex_socdk.dts   |   8 +
 drivers/clk/Makefile                          |   3 +-
 drivers/clk/socfpga/Makefile                  |   2 +
 drivers/clk/socfpga/clk-agilex.c              | 454 ++++++++++++++++++
 drivers/clk/socfpga/clk-pll-a10.c             |   4 +-
 drivers/clk/socfpga/clk-pll-s10.c             |  74 ++-
 drivers/clk/socfpga/clk-pll.c                 |   4 +-
 drivers/clk/socfpga/stratix10-clk.h           |   2 +
 include/dt-bindings/clock/agilex-clock.h      |  70 +++
 11 files changed, 728 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/intel,agilex.yaml
 create mode 100644 drivers/clk/socfpga/clk-agilex.c
 create mode 100644 include/dt-bindings/clock/agilex-clock.h

-- 
2.25.1

