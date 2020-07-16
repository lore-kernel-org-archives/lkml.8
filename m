Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2F1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B96920714
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594861073;
	bh=3Q9P7UQS49i5KShXWhmDgVyNUCeDNAwi1WcfoQD4ewI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=QdeLverHywVvS13UQR2MY0ONQy4zRmVW46wHWhdLoNQkTqnCK9pMOEt0CK43kFtqy
	 NNOvvTY6APGyBPmR8LXTLq3zvALBlr5qbhFVo1/9enl2KcWy4NQq3/eR6DGwk1bR42
	 LfRtjKIb2mK3yUj9ooya4svJ8ffvb0mI7pgaGhis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbgGPA5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:35902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPA5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:57:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38FF20658;
        Thu, 16 Jul 2020 00:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594861070;
        bh=3Q9P7UQS49i5KShXWhmDgVyNUCeDNAwi1WcfoQD4ewI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=bZtm36rK+mUku7jiYwl47k7VQr/5YTzZe+8mH/k99Oit3LAVs0yzFAL4S4dZ/pl1Z
         05KWgLHxn61KG7EEGtz4HA748nGp2fhQ0SRhbW0JfHJm13H3pbfFvrD+bRujVn1jRj
         DGe5WsTxhS8ifU/rN+xQey3RVGCngWkcMPuVlxpE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1594098579-25050-3-git-send-email-Anson.Huang@nxp.com>
References: <1594098579-25050-1-git-send-email-Anson.Huang@nxp.com> <1594098579-25050-3-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V6 2/6] clk: imx: Support building i.MX common clock driver as module
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>,
        Georg.Waibel@wiedemann-group.com, abel.vesa@nxp.com,
        aisheng.dong@nxp.com, andrew.smirnov@gmail.com, chen.fang@nxp.com,
        daniel.baluta@nxp.com, festevam@gmail.com, fugang.duan@nxp.com,
        georg.waibel@wiedemann-group.de, horia.geanta@nxp.com,
        j.remmet@phytec.de, kernel@pengutronix.de,
        laurent.pinchart@ideasonboard.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, s.hauer@pengutronix.de, sfr@canb.auug.org.au,
        shawnguo@kernel.org, yuehaibing@huawei.com
Date:   Wed, 15 Jul 2020 17:57:50 -0700
Message-ID: <159486107011.1987609.3725728274148570354@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-07-06 22:09:35)
> There are more and more requirements of building SoC specific drivers
> as modules, add support for building i.MX common clock driver as module
> to meet the requirement.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
