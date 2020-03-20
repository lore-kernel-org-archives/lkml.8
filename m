Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5EDC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFA420714
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584747200;
	bh=UZUODod2zdZN+ajGZsRuYeTFkVM+vzLpWqGAFoy3BCA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=GWZo/F9ML+AXjTSSVwbOSQl7omwz/81p8pEF7qJbOVwfm3CcHUuSVsnZUPJXWgMaW
	 04XkNrNWxR6ruke7U3TgBQ/wkHezK9GYFJ/XAXc3peXtxjIrbL566JG+tKsQwCOGXW
	 zTURIZkmEAmKFBf7I9B0/i2Ml4N5dCzoztdiVaes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbgCTXdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:33:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTXdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:33:18 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13D0220714;
        Fri, 20 Mar 2020 23:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584747198;
        bh=UZUODod2zdZN+ajGZsRuYeTFkVM+vzLpWqGAFoy3BCA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=pGEivEqC0IyfRoeenPvzZIb44PCOsYBxUzaUHMe2h2QDUsX/eWnI2N6UrHy/nlNPT
         ddnFa7RgedxYdsylxvn7n6rjRYj0poWv7hGEFxJvMtFr4R9Zj81M+6pspWyLXw+cT2
         Yo4vV33peQUE2XrP1Na1GOKc0rQYT6+7yBi1BwnM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200319053902.3415984-4-bjorn.andersson@linaro.org>
References: <20200319053902.3415984-1-bjorn.andersson@linaro.org> <20200319053902.3415984-4-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: db820c: Add s2 regulator in pmi8994
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Date:   Fri, 20 Mar 2020 16:33:17 -0700
Message-ID: <158474719731.125146.2453513105696205383@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-03-18 22:39:01)
> From: Rajendra Nayak <rnayak@codeaurora.org>
>=20
> Add the SPMI regulator node in the PMI8994, use it to give us VDD_GX
> at a fixed max nominal voltage for the db820c and specify this as supply
> for the MMSS GPU_GX GDSC.
>=20
> With the introduction of CPR support the range for VDD_GX should be
> expanded.
>=20
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> [bjorn: Split between pmi8994 and db820c, changed voltage, rewrote commit=
 message]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

These two dts patches don't need to go through clk tree right? And the
first patch can be applied and regulator core will just return us a
dummy supply so it's safe to apply now?
