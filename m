Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3EAC54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AE0720752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731432AbgEKTZ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:25:29 -0400
Received: from v6.sk ([167.172.42.174]:52316 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729453AbgEKTZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:25:29 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 9E3DC610A9;
        Mon, 11 May 2020 19:25:27 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v2 00/10] clk: mmp2: Enable Audio and GPU on MMP2 and MMP3
Date:   Mon, 11 May 2020 21:25:07 +0200
Message-Id: <20200511192517.1206442-1-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

please consider applying this patch set for 5.8.

The goal is to add support for various clocks used by the GPUs and Audio
subsystem MMP2 and MMP3-based machines.

Probably the most significant part is that this adds support for runtime
PM domains which is managed by the same PMU hardware as the clocks.

Tested the GPUs on MMP2 and MMP3 as well as audio on MMP2. (I don't have
an audio codec hooked up on MMP3, nor a camera on a MMP3 machine, so
those remain untested for now).

Compared to v1 this just adds a couple of ack tags for the DT bindings.

Thank you
Lubo


