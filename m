Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01323C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB42F2250E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 07:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgG3H3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 03:29:19 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36000 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgG3H3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 03:29:18 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B9A322011EB;
        Thu, 30 Jul 2020 09:29:16 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AD250200243;
        Thu, 30 Jul 2020 09:29:16 +0200 (CEST)
Received: from localhost (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8BF822033F;
        Thu, 30 Jul 2020 09:29:16 +0200 (CEST)
Date:   Thu, 30 Jul 2020 10:29:16 +0300
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 01/17] dt-bindings: clocks: imx8mp: Rename audiomix ids
 clocks to audio_blk_ctrl
Message-ID: <20200730072916.uxy7fvwbo54dyoxp@fsr-ub1664-175>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com>
 <1596024483-21482-2-git-send-email-abel.vesa@nxp.com>
 <159605204677.1360974.9090468980266949950@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159605204677.1360974.9090468980266949950@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180622
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-29 12:47:26, Stephen Boyd wrote:
> Quoting Abel Vesa (2020-07-29 05:07:47)
> > In the reference manual the actual name is Audio BLK_CTRL.
> > Lets make it more obvious here by renaming from audiomix to audio_blk_ctrl.
> 
> And this is safe because there aren't any users of the defines?

Yes, these defines are not used at all yet. This patchset introduces the first user.
