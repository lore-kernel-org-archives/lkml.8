Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6638C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B6B2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589491610;
	bh=Qk8k761CHhiFeR8rPYabO/Vk9oPDdb4wovUd+6GDfe0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=MX9r3oKz+swMflo4x+C1cglbo8O6hT02n+vsLDMXZlzF4LFeb6pqh9LoefZoFae+C
	 QRgQTFqPMXZYKh+qNhStg/zJyPJ5YGVjzVNmttyGRyiEOc0p0UWH3ig2GGnPrfNXT/
	 eaQ6ACvFo3HepduVtS5kEKCqao52Y1SgBxGUDsjM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbgENV0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:26:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726216AbgENV0s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:26:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 634B22065D;
        Thu, 14 May 2020 21:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589491608;
        bh=Qk8k761CHhiFeR8rPYabO/Vk9oPDdb4wovUd+6GDfe0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hVCy2lVdWufweYcLPH7fYSoxraIy5mmtVSKg4kg4cXas0zenyazGGngGGE2WhVas4
         2oUH2HYI2+7GDIFMBBUvlgL00T/C5hi2u3nuAAJiS6ShTKyYBW7xH90ztSL0ANtDfU
         aBZcMfdvskGZPUDE78GVi+WKxdwgxGekGXF55zL8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200513065420.32735-2-vkoul@kernel.org>
References: <20200513065420.32735-1-vkoul@kernel.org> <20200513065420.32735-2-vkoul@kernel.org>
Subject: Re: [PATCH v2 2/2] clk: qcom: gcc: Add missing UFS clocks for SM8150
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>
Date:   Thu, 14 May 2020 14:26:47 -0700
Message-ID: <158949160766.215346.1445169785058704472@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2020-05-12 23:54:20)
> Add the missing ufs card and ufs phy clocks for SM8150. They were missed
> in earlier addition of clock driver.
>=20
> Fixes: 2a1d7eb854bb ("clk: qcom: gcc: Add global clock controller driver =
for SM8150")
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---

Applied to clk-next
