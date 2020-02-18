Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73064C34048
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE822176D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582045392;
	bh=Pkh3+MVKZTQRwe6qGsimXYvavRkZ2+UBGlARjHQhXuM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=hJ1fGiD4dtaE9btq/cIKxW9MXx5/tfoukWXzm/9vr2ewWRIa6CRZA1MaKUaUlWgAH
	 SqYIKjA0FmEIJqKkjrGmbkMoOtjKF9j9wLASSoqhGLanrn9VRMPKjLDUusQPAk2P3W
	 bYrkNwRQSM/66U6U7ovoL9OxNygXfw7h6JivHcFU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgBRRDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:03:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726486AbgBRRDK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:03:10 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 036B0208C4;
        Tue, 18 Feb 2020 17:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582045390;
        bh=Pkh3+MVKZTQRwe6qGsimXYvavRkZ2+UBGlARjHQhXuM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AH2Z7+rtO15bJVYGmNOVYNmBYuU6IWkyQakA8ANCSqQ+rVBQcmWUf3mKI0FlXUKDt
         Bv3Mq8SHomPyCUlk+h40wL2M9r2Va+3h9oe/BciiZN69eLlGO1OkBwdzEFMTZpoR8J
         Zl1iF3x7/ckMBjBK8CpfZbWa4hmw0eVrsTHRBlm8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582023806-6261-1-git-send-email-Anson.Huang@nxp.com>
References: <1582023806-6261-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH 1/3] clk: imx8mp: Include slab.h instead of clkdev.h
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        festevam@gmail.com, kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, ping.bai@nxp.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org
Date:   Tue, 18 Feb 2020 09:03:09 -0800
Message-ID: <158204538915.184098.16137807611905794422@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-02-18 03:03:24)
> slab.h is necessary and included indirectly by clkdev.h,
> actually, there is nothing in use from clkdev.h, so just
> include slab.h instead of clkdev.h.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
