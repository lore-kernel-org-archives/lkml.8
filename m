Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1FCC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:21:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337D520791
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596237661;
	bh=n5x7Sfjfv0nDyBJcaRAYdP/bxR49Er90sgjkvQtMBwo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=jJEckqTqkZGOjW+ic1lTA7jdvc9T3jwAoMtM43vwlSuzG0uOQn/pF2P1LHgooM4e0
	 23Ha1yKfn9AdIOcaJctD+IUhQCwQcA0SkBqIe3KeM5i99Z72mHTKUaZreeEG2weeyd
	 qDoHRuNNfBxkdHsRi2UOv7/wtsN0sPgV6/19ZLhw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgGaXVA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:21:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726471AbgGaXU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:20:58 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DD2220791;
        Fri, 31 Jul 2020 23:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596237658;
        bh=n5x7Sfjfv0nDyBJcaRAYdP/bxR49Er90sgjkvQtMBwo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EflDU+VHZSN5DCYmQBleTYsvkKKfARTPs3jZ/uF5Dd1ySJ3xUx8YqYJRZqy8Bc0eU
         aQLjLraamVp/Uv+8wQrGClie+sdHvXNDITCEvTuYCsZbjr8Kx9E/FTqzc8chCfbTjL
         +8OgAOvxlMA5I+wcYs7rQHlrRSkzR31vxvyVvRU4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200731133006.1.Iee81b115f5be50d6d69500fe1bda11bba6e16143@changeid>
References: <20200731133006.1.Iee81b115f5be50d6d69500fe1bda11bba6e16143@changeid>
Subject: Re: [PATCH] dt-bindings: clock: Fix YAML schemas for LPASS clocks on SC7180
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>
Date:   Fri, 31 Jul 2020 16:20:57 -0700
Message-ID: <159623765728.1360974.15372294562830293191@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2020-07-31 13:30:10)
> The YAML schemas that landed forgot one clock: "bi_tcxo".  Presumably
> the bindings were developed against the v4 version of the driver and
> when the ".name" was removed in v5 of the driver things broke.
>=20
> While touching this, add the needed includes in each example.  I
> believe both examples are supposed to be independent of each other.
>=20
> Let's fix the bindings.
>=20
> Fixes: 381cc6f97cda ("dt-bindings: clock: Add YAML schemas for LPASS cloc=
ks on SC7180")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Applied to clk-next
