Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1F7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAC0120B80
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590725992;
	bh=33+MHwIedDJ1eCtpRa7VZElWCFVUcTFTamW43B1VK2U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=hDYoIIXNePDQDELJq++lOBqncVc2EWKnzk50qdMO6ul8aGHKQ50X09dxkOOQgnoI5
	 OjiBbRMwCm5lv8upvHYnqWviZgWGyJlifVpSEJXtkaeK4tCxlu8Ck6mpfYUTeMBpUQ
	 l2V+MRURrC0GsnY0kMJvVA7Z3N7sKzq7Sx0qwz4o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728857AbgE2ETu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:19:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:45684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728842AbgE2ETq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:19:46 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8981D20814;
        Fri, 29 May 2020 04:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590725985;
        bh=33+MHwIedDJ1eCtpRa7VZElWCFVUcTFTamW43B1VK2U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=y1IYg0PlIZFZTBahbBdFs8PRajY+bFIxDvd3m3A7jSgE9aPPpaoBrSyJll/14YzzS
         B2GDlFDstzXOLtacHn39d16w8THXHK4q1JFprQsFPKgXo3VVhIhZT2oQbx+JZE48fr
         UohXpuwo6xCMOHhtpV/eCIPBUGhLacyHQaaTrJVE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582278742-1626-3-git-send-email-macpaul.lin@mediatek.com>
References: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com> <1582278742-1626-3-git-send-email-macpaul.lin@mediatek.com>
Subject: Re: [PATCH 2/5] dt-bindings: clock: mediatek: document clk bindings mipi0a for Mediatek MT6765 SoC
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
Date:   Thu, 28 May 2020 21:19:44 -0700
Message-ID: <159072598489.69627.4505171077410009164@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Macpaul Lin (2020-02-21 01:52:19)
> This patch adds the binding documentation for mipi0a.
>=20
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---

Applied to clk-next
