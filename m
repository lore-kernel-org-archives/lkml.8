Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9062CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6530820C56
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590726259;
	bh=lFi0u1OCN7DS3Nx+qCcOJ3WY0Mze38rDYI7+wUCYVi8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=ISHl/LTdXb73Qc3Tj/Oj02BeYokTOOG7OeX/PJCbN6YuecJcAFGZ4hDmrwye1wGQ/
	 F8/fnakqPsH+6ThfY3LMy0gRQw0woLZOyD+vLKDO32hnXLfrrOREkXO1pyY3CtH1pr
	 ACVtLacLV3+99hpgS9WPCBunI3IXBrOXX1tFe/x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728016AbgE2EYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:24:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727062AbgE2EYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:24:10 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDCC520814;
        Fri, 29 May 2020 04:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590726249;
        bh=lFi0u1OCN7DS3Nx+qCcOJ3WY0Mze38rDYI7+wUCYVi8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=vvunTao0bslrO3i537orWdUayXbC7ajkMnt3XUx7Put4e5vth1qh+C2iqmv0ZL+W/
         mJHIUeXzjfMKpSj0C6G0ty2Hk+mKIKkNq65ebi6QVnGvZDMCFkknutDTvst/KV51gR
         dWndcNnQ2iAH8KYc0VCUfTxPu9Epcv4Yb/NT2WMA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582278742-1626-6-git-send-email-macpaul.lin@mediatek.com>
References: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com> <1582278742-1626-6-git-send-email-macpaul.lin@mediatek.com>
Subject: Re: [PATCH 5/5] clk: mediatek: Add MT6765 clock support
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Fabien Parent <fparent@baylibre.com>,
        Joerg Roedel <jroedel@suse.de>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ryder Lee <Ryder.Lee@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Will Deacon <will@kernel.org>, Yong Wu <yong.wu@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        mtk01761 <wendell.lin@mediatek.com>
Date:   Thu, 28 May 2020 21:24:09 -0700
Message-ID: <159072624910.69627.8948903264567221142@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Macpaul Lin (2020-02-21 01:52:22)
> From: Owen Chen <owen.chen@mediatek.com>
>=20
> Add MT6765 clock support, include topckgen, apmixedsys,
> infracfg, mcucfg and subsystem clocks.
>=20
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---

Applied to clk-next
