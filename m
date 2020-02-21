Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B37E4C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B45F206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 23:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582329474;
	bh=n0vjHVM2DuhbpPYoxUKATWLMuk00e4mnD7YQoWp4vUk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=PbKKjgx6lBlMbITa/O5PaM86LNpBQfiMB/lsoft7r6A46pn+X/9WV/t6rAam6gDwO
	 cZuP6NrPJYKkB5UtSjbfE7VRct5eKlhQvjLACrRT5+GLYFxY4xuwqrlw/nRFvIIJVc
	 Ab5x/Z0hpUht8Fto9RsTrMAd0gzRRXd3cmZVxX8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbgBUX5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 18:57:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgBUX5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 18:57:53 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B862068F;
        Fri, 21 Feb 2020 23:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582329472;
        bh=n0vjHVM2DuhbpPYoxUKATWLMuk00e4mnD7YQoWp4vUk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OIc0H/6FEBoyV45z3mlrdQOZGlTjYb5cKOX8tyqwAiMmkIlY4O9/GD+thIk3aXxsG
         jIjtFlVnom2DIHf7DacvmaOFcDdyLjsT6f8EY9Pmpo3a9lwbkeFP/VA7/hGESogbek
         ZcPYRqs8Jucy3hrPeOGTK7yh2xCobn+qyOSRBAc4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582266716-19821-1-git-send-email-Anson.Huang@nxp.com>
References: <1582266716-19821-1-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH] clk: imx: pll14xx: Return error if pll type is invalid
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, festevam@gmail.com,
        kernel@pengutronix.de, leonard.crestez@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        peng.fan@nxp.com, ping.bai@nxp.com, s.hauer@pengutronix.de,
        shawnguo@kernel.org, yuehaibing@huawei.com
Date:   Fri, 21 Feb 2020 15:57:51 -0800
Message-ID: <158232947182.258574.584668677246692139@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-02-20 22:31:56)
> When pll type is invalid, ONLY output error message is NOT enough,
> should return error immediately.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
