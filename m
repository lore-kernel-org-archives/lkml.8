Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B761EC433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E2102074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595580739;
	bh=RSV3yoZJlmcQqvC4Tht2+qXNbyIPtHut7jh9OUg1XrA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=AZgpp8s9kNUCGD6wDHe0wrVvZtCgm8p6ZZfW8AAB10Y8OvCPb0ZeklpiKW3pYqvYu
	 6IkYmHJ101beCPzX6OBEil8B8D0bMw2P8uUgCBeI1KUgFlL4+cU7YQKoEEk2YIBAre
	 67LVCnOcP5inyljIDZcbPhr+KlUYsgQPZbXuMcic=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgGXIwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXIwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:52:15 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12AA4206EB;
        Fri, 24 Jul 2020 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595580735;
        bh=RSV3yoZJlmcQqvC4Tht2+qXNbyIPtHut7jh9OUg1XrA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DGSspufJjyd13keqRyl1cOde3JFskmc/GWp1xQoxs2Ug4+tDqsKyp5jq3P6fc7CmV
         Ajj1T5myuTFj5yw4clSBQW1TnkAJCkY5SZwsR/mrwR0bTFslKW2lZdgpkHOuNh1s1d
         ycrkdojSv7P8fQuZ7mUg3XHWCWqp7PWYDR+16SeU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200709135251.643-4-jonathan@marek.ca>
References: <20200709135251.643-1-jonathan@marek.ca> <20200709135251.643-4-jonathan@marek.ca>
Subject: Re: [PATCH v3 03/14] clk: qcom: clk-alpha-pll: same regs and ops for trion and lucid
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Date:   Fri, 24 Jul 2020 01:52:14 -0700
Message-ID: <159558073424.3847286.1020763027961656768@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Marek (2020-07-09 06:52:34)
> Fixed ops were already identical, this adds support for non-fixed ops by
> sharing between trion and lucid.
>=20
> This also changes the names for trion ops to be consistent with the rest.
>=20
> Note LUCID_PCAL_DONE is renamed to TRION_PCAL_DONE because it is wrong for
> lucid, LUCID_PCAL_DONE should be BIT(27). Next patch will address this.
>=20
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---

Applied to clk-next
