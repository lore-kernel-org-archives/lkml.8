Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC8EC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F13942082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 19:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596052050;
	bh=/shdwx/9lgN18/zovI7T6WrW2TM4iev+RPl6FvNe4z4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=1UzMDTayTL1f085NxHXvoNdv5oUFa/F1qKQLGeUnbL2chOWItwEVv1vGUP+p9jQ7w
	 mj2nGpIDBPP0+W4a2QKXqlZpUXWu1zi/GcWMUZPROM4JEbW4wJcRYmb7omoSICaK+w
	 xeCB8bctfAHTRa+p0x5mJmnEgYpNRyq5kLy0cgLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgG2Tr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 15:47:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2Tr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 15:47:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20A920809;
        Wed, 29 Jul 2020 19:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596052048;
        bh=/shdwx/9lgN18/zovI7T6WrW2TM4iev+RPl6FvNe4z4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=juCXyfcA6CRr2zc33lfDcBkJGMXCtBUDey0peljdsXCTHLDUABbwsfotvw0frOAJT
         lMKXbWSpJVRvc12f3gDoWxvoys5R1n4EKT8kxiMwfjqkN+hTgMAQi3H6kiKaxnCt/H
         My7hhJvp0mxXvZazJzVmpq+Wj/y+VUxpQ6KL2Azc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1596024483-21482-2-git-send-email-abel.vesa@nxp.com>
References: <1596024483-21482-1-git-send-email-abel.vesa@nxp.com> <1596024483-21482-2-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH 01/17] dt-bindings: clocks: imx8mp: Rename audiomix ids clocks to audio_blk_ctrl
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Anson Huang <anson.huang@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 29 Jul 2020 12:47:26 -0700
Message-ID: <159605204677.1360974.9090468980266949950@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2020-07-29 05:07:47)
> In the reference manual the actual name is Audio BLK_CTRL.
> Lets make it more obvious here by renaming from audiomix to audio_blk_ctr=
l.

And this is safe because there aren't any users of the defines?
