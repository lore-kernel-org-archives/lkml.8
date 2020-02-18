Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62ABC34048
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:03:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7D7208C4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582045402;
	bh=4HPxvqnC6UqFtjlcs923XdmHSklZVIjwOZJGhLHI9E0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=tMUDOhhFfwxBa4GrMessjlEJnsnltv7fzdroHZNPX0ei+X2S5jGJt06kYZuGSjDWy
	 liueORMg2QSu4+1v7xirVT1owjp8FFWD+15bFGn1SeoNGj2kSVxhdSLxiZtoUFbm7w
	 5VxMezyvqrxXg/w3eNjqzY5FRr8YrkuphP/nA3x4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgBRRDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:03:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:35816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgBRRDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:03:21 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 752762176D;
        Tue, 18 Feb 2020 17:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582045400;
        bh=4HPxvqnC6UqFtjlcs923XdmHSklZVIjwOZJGhLHI9E0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SIoO0LaSqKVcr6DysnyVNulKqi+wnRRx/DTyXMXVnbFml/Lt3Z2DVAORt/kAn3jpx
         LxnFENKsj1Chh13YvUoUStL8WovXF/f1ZMO7bPay0AHy00m2/SvWixBYzMygKg2BNX
         wFwbzlTQhi+/9Nv2wfCDXcjIN99kQGG++yp0BCvw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582023806-6261-2-git-send-email-Anson.Huang@nxp.com>
References: <1582023806-6261-1-git-send-email-Anson.Huang@nxp.com> <1582023806-6261-2-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH 2/3] clk: imx8mm: Remove unused includes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        festevam@gmail.com, kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, ping.bai@nxp.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Date:   Tue, 18 Feb 2020 09:03:19 -0800
Message-ID: <158204539974.184098.18375010474603889245@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-02-18 03:03:25)
> There is nothing in use from init.h/of.h, remove them.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
