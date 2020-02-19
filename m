Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79481C34022
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F59F2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 07:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgBSHeE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 02:34:04 -0500
Received: from [167.172.186.51] ([167.172.186.51]:35050 "EHLO shell.v3.sk"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726772AbgBSHeC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 02:34:02 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 8FF63E0071;
        Wed, 19 Feb 2020 07:34:14 +0000 (UTC)
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HN17adJcV5R0; Wed, 19 Feb 2020 07:34:13 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by zimbra.v3.sk (Postfix) with ESMTP id 1EE14E0046;
        Wed, 19 Feb 2020 07:34:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at zimbra.v3.sk
Received: from shell.v3.sk ([127.0.0.1])
        by localhost (zimbra.v3.sk [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 2QCWGCc6_F_A; Wed, 19 Feb 2020 07:34:12 +0000 (UTC)
Received: from furthur.lan (unknown [109.183.109.54])
        by zimbra.v3.sk (Postfix) with ESMTPSA id 7C773DFCA2;
        Wed, 19 Feb 2020 07:34:12 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 00/10] MMP2 CLK Update
Date:   Wed, 19 Feb 2020 08:33:43 +0100
Message-Id: <20200219073353.184336-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying this patch series. Its goal is to ultimately
provide accurate clock sources from PLLs configured by firmware on MMP2 a=
nd
MMP3. Currently they are hardcoded to more or less wrong values, which
causes bad timings when they are use (e.g. to generate display clock).

It starts off with a handful of cleanups:

  [PATCH 01/10] clk: mmp2: Remove a unused prototype
  [PATCH 02/10] clk: mmp2: Constify some strings
  [PATCH 03/10] dt-bindings: clock: Convert marvell,mmp2-clock to

The next patch adds the logic for calculating the rate of clock signals
coming from the PLLs dynamically, while not actually switching the
driver over to using it.

  [PATCH 04/10] clk: mmp2: Add support for PLL clock sources

Then MMP2 is switched over:

  [PATCH 05/10] clk: mmp2: Stop pretending PLL outputs are constant

Switching MMP3 requires some more work, because until now, the driver
has been the same for both versions of the SoC:

  [PATCH 06/10] dt-bindings: clock: Add MMP3 compatible string
  [PATCH 07/10] clk: mmp2: Check for MMP3
  [PATCH 08/10] dt-bindings: marvell,mmp2: Add clock ids for MMP3 PLLs
  [PATCH 09/10] clk: mmp2: Add PLLs that are available on MMP3
  [PATCH 10/10] ARM: dts: mmp3: Use the MMP3 compatible string for

The hardware vendor doesn't supply documentation, so this is best-effort
work based on the code dump from Marvell.

Tested on MMP2 and MMP3 based hardware I have; details in relevant
commit messages.

Thank you,
Lubo

