Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B6C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 386D82078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgEKTzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:55:40 -0400
Received: from v6.sk ([167.172.42.174]:52448 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729049AbgEKTzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:55:40 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id F13CA610A9;
        Mon, 11 May 2020 19:55:37 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH 0/2] MMP2 Audio clock controller driver 
Date:   Mon, 11 May 2020 21:55:32 +0200
Message-Id: <20200511195534.1207927-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying this patch set. It contains a driver for the
audio clock generator on Marvell MMP2 along with the DT bindings.

Currently the I2S driver (mmp2-sspa) doesn't have support for DT and is
not able to get clocks from this driver. The patch set to address that
will be sent separately.

Note that the DT binding validation is going to complain about the
example in it until the "clk: mmp2: Enable Audio and GPU on MMP2 and
MMP3" [1] patch set is merged. Not a big deal I suppose.

[1] https://lore.kernel.org/lkml/20200511192517.1206442-1-lkundrak@v3.sk/

This patch set has been tested on an OLPC XO-1.75 laptop, along with a
patched mmp-sspa driver and rt5631 codec.

Thank you
Lubo


