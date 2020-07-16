Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42116C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 230A42077D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594861116;
	bh=QPAU9cSsPiOln4ZyYl9Bz+nZM9azo2HlMovfqhj7nxw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=NW8tuPL0LP+j5rnRiaEIoeFr6QqJLwGgEzVsnlrjRn3jrirUbfu0aU/KgnOdCCKbn
	 I1gdxaWbxvfYfklz+nNYxbrLOdLDoUYfh2TTQXZi8aHnaW8Vgaj5R5e7TnjDHwwAXm
	 vaDQd2lNiv0F7N6gpPx+ptje/yVBmx8AYt2ttrDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGPA6e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:58:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:36248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727081AbgGPA6e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:58:34 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FE0A2075B;
        Thu, 16 Jul 2020 00:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594861114;
        bh=QPAU9cSsPiOln4ZyYl9Bz+nZM9azo2HlMovfqhj7nxw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=BjDPe5R3MvmJuNlL55gsy5Dv4324vwcMU42lCGLaGSiPv8XM65YO60zR2v0iX25Yy
         2DQhFk9DaOfxxi1ZDmcNjfiJNxGZmNhvuO65WId0s3H0MzCb9nhc8jNkIKIa0tLqnD
         TWL8prGzq0xBp+6k4/q3MTpEHOdqrgvoxZomZVpU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1594098579-25050-6-git-send-email-Anson.Huang@nxp.com>
References: <1594098579-25050-1-git-send-email-Anson.Huang@nxp.com> <1594098579-25050-6-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V6 5/6] clk: imx8qxp: Support building i.MX8QXP clock driver as module
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
Date:   Wed, 15 Jul 2020 17:58:33 -0700
Message-ID: <159486111346.1987609.15603970881342169219@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-07-06 22:09:38)
> Change configuration to "tristate", add module author, description and
> license to support building i.MX8QXP clock drivers as module.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
