Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E38C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E1CA2075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594861109;
	bh=9EKTngfjCN/n4Q/onWR1tJ2xkpNC1gxrqjfsNozy7Bo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=v1F1++nd+3ecNfrT35SUrJUBT5EbR5/9C4zVvCU7LkRAuhWiIeHPDGrYVvnMcD9jO
	 9lBn4/8weJJdVoer7b/HpfYoZp6jWb7zPU9dbDByl2YrituCvt2L24MDMyaufYRSD2
	 D73FkE1GppNgXr/H+t+V669hDpEa1lYE4oPPUm7o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgGPA62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:58:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:36144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPA61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:58:27 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 161702072E;
        Thu, 16 Jul 2020 00:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594861107;
        bh=9EKTngfjCN/n4Q/onWR1tJ2xkpNC1gxrqjfsNozy7Bo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=o85njE2t4auJAie6K8tCWOyxhGYVfEkdCL8ks/LdtRok1NQa7Tc/RBDlATo9t4/+e
         VdpCkx/t7wRey4x9NJa/3IrCz2sxUwg8Wn/Pn5GIh4hEfrvyarfYrb7FTf6Qb4uM2k
         ONw6HFIUgJvZxlJdhHTt70asvWcZlye5w50Rf+RA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1594098579-25050-5-git-send-email-Anson.Huang@nxp.com>
References: <1594098579-25050-1-git-send-email-Anson.Huang@nxp.com> <1594098579-25050-5-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH V6 4/6] clk: imx8m: Support module build
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
Date:   Wed, 15 Jul 2020 17:58:26 -0700
Message-ID: <159486110648.1987609.2639033833528077460@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-07-06 22:09:37)
> Change configuration to "tristate", add module author, description
> and license to support building i.MX8M SoCs clock driver as module.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
