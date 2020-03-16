Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54063C2BB1D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAC920679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 17:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584378084;
	bh=g5ltHYg5EhTj2wtWCAMlXfpAqekS3BHtI2oNh/PrpZY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=WjAip3NrDKsOAjjO6Xsqk/bXXnTeNelhX6NrbFkvWS0XVZg7hlr+qPOcovbdJgdhE
	 oijcSXsssP3DOd5GfHeVu09jxutI5YlrUPbVZrcIpKDNDZsqZ7iarXTu/6n3hyzYca
	 zuHP5ZyqFLHGOPAj7kQ6sgffYKZLv+YBcFgKAhLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732195AbgCPRBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 13:01:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731809AbgCPRBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 13:01:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF852051A;
        Mon, 16 Mar 2020 17:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584378082;
        bh=g5ltHYg5EhTj2wtWCAMlXfpAqekS3BHtI2oNh/PrpZY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=PxAeOGBGGiJQ7k6yR8/Zbf65F61ub6JdO3hkQGdictEwYc2sQW+Raj9fjb9H37YRK
         bcvxdEi1pyTDHcwxO6/7VUm3rDkaUvs0J7jXHr1o1Oux8zxGCXlO0Rv7TaOv5FJBEn
         wlT5rqN40o1qxXGTTpNYqm5XvuKzNBbczc2e6vzU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1584070036-26447-3-git-send-email-peng.fan@nxp.com>
References: <1584070036-26447-1-git-send-email-peng.fan@nxp.com> <1584070036-26447-3-git-send-email-peng.fan@nxp.com>
Subject: Re: [PATCH 2/3] clk: imx: drop the dependency on ARM64 for i.MX8M
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, stefan@agner.ch, Anson.Huang@nxp.com,
        abel.vesa@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
To:     arnd@arndb.de, linus.walleij@linaro.org, peng.fan@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Mon, 16 Mar 2020 10:01:21 -0700
Message-ID: <158437808141.88485.7392377210560087656@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting peng.fan@nxp.com (2020-03-12 20:27:15)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Moving to support aarch32 mode on aarch64 hardware, need to drop
> the dependency on ARM64 to make the driver could be selected for
> ARM32.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
