Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBC9C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C669218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581548997;
	bh=1iUCooTSVvuSZIPW3R3UIqC1urOlQcutMWC6laLHEHY=;
	h=In-Reply-To:References:Subject:From:To:Date:List-ID:From;
	b=VK8JlZGP2kXTAVZOEhUI84HK1nSTLqKUDVQrY1pselzKTRW7MyDorgVebz7GGMxvE
	 5Nf2iFXT1O5bfu73mGNTC/54KYCtx0BNF6ZhjP+cE7tSogVswkW8tjYmh6nTzjFtEK
	 h8ddpT5iPdWaLsR+oWIfSe3smmChC+qHXxQZi2zs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbgBLXJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:09:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:50528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729119AbgBLXJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:09:56 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCE1F2168B;
        Wed, 12 Feb 2020 23:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581548995;
        bh=1iUCooTSVvuSZIPW3R3UIqC1urOlQcutMWC6laLHEHY=;
        h=In-Reply-To:References:Subject:From:To:Date:From;
        b=vmYeuGVhwp8SuZHsnbrsdOd353kfjeHcJ0LtW/I/plYN/B2M5QzcZ1OGdPWwTpdGf
         QPGpVOiRzvNLUVb87cyLcpkNPlGp595RhlYhtCIwO06wsPEZawP62eYVKI1tMWHgT1
         O/E4MYJh2bonuiPq2d2hbdcNEiINDEnYfrT8noyk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1579905147-12142-4-git-send-email-vnkgutta@codeaurora.org>
References: <1579905147-12142-1-git-send-email-vnkgutta@codeaurora.org> <1579905147-12142-4-git-send-email-vnkgutta@codeaurora.org>
Subject: Re: [PATCH v2 3/7] clk: qcom: clk-alpha-pll: Refactor and cleanup trion PLL
From:   Stephen Boyd <sboyd@kernel.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        devicetree@vger.kernel.org, jshriram@codeaurora.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        mturquette@baylibre.com, psodagud@codeaurora.org,
        robh+dt@kernel.org, tdas@codeaurora.org, tsoni@codeaurora.org,
        vinod.koul@linaro.org, vnkgutta@codeaurora.org
Date:   Wed, 12 Feb 2020 15:09:54 -0800
Message-ID: <158154899499.184098.8708399326565910374@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Venkata Narendra Kumar Gutta (2020-01-24 14:32:23)
> From: Taniya Das <tdas@codeaurora.org>
>=20
> The PLL run and standby modes are similar across the PLLs, thus rename
> and refactor the code accordingly.
>=20
> Remove duplicate function for calculating the round rate of PLL and also
> update the trion pll ops to use the common function.
>=20
> Reviewed-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> Signed-off-by: Venkata Narendra Kumar Gutta <vnkgutta@codeaurora.org>
> ---
>  drivers/clk/qcom/clk-alpha-pll.c | 71 +++++++++++++---------------------=
------
>  1 file changed, 22 insertions(+), 49 deletions(-)

Looks mostly ok but it's wrecked now by me. Can you resend, splitting
this patch into at least two things? One patch to replace defines with
standard names and another to do the rest that this patch does?
