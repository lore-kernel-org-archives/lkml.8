Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E18DC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771C72464E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582045408;
	bh=z2e7Xc6lbz//zrWoEYkGn2Dr4Bqdef+y65nYdB4LW4w=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=rncXVjd/1Gq4dvRxrBxW38xM7QagWJVIZfDrup4G+8Rzv4O2SECPcN83wwpxqa4dP
	 0rLqtcoMgDHnUVR+rL5LGhJNiCPKuIq2+gmIW369GHSf1Y2I9VuS/w+u06/eEd72QG
	 4l3g4sLwcRv306NGqFyRnHB3+NQWIgwvcDQfGGkg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBRRD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:03:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:35906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgBRRD0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:03:26 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 433282176D;
        Tue, 18 Feb 2020 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582045406;
        bh=z2e7Xc6lbz//zrWoEYkGn2Dr4Bqdef+y65nYdB4LW4w=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=yZw3tXvkgf00UtuPN0FGeiZYyA58t6dc3pToUfCxzWJYzfquCaO9KyeHDCZAHrOI7
         kZe7NU2wbosqQDcJ+nnMMfx8Fa3mWhdkrDFXPhPvs6vmV03hNhn2XddDXxDUiijs2r
         pU9Potw06nrODoiGEGtn60TJXc3ryNk372U49quw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582023806-6261-3-git-send-email-Anson.Huang@nxp.com>
References: <1582023806-6261-1-git-send-email-Anson.Huang@nxp.com> <1582023806-6261-3-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH 3/3] clk: imx8mn: Remove unused includes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        festevam@gmail.com, kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, ping.bai@nxp.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Date:   Tue, 18 Feb 2020 09:03:25 -0800
Message-ID: <158204540554.184098.3218074345552740072@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-02-18 03:03:26)
> There is nothing in use from init.h/of.h, remove them.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
