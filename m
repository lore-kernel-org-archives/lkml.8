Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EADC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A555E20748
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595580774;
	bh=3XAOLRXH+A5spT3PUCVqth7VHfe4CGFX/QSU9CZHx44=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=OuAXoUqEhiJbJWbGLoB1zLAiB0QrRhiTwcmyONBmEWwd/f06o2QT0ALPAHSS1W5vP
	 3jYbf+TajpCgQIuKig3dYpov6Mjx3UcGNEATXanQNJ+D8dyqqOBzL0/QY8zBzNFlrm
	 4VnmdY0cT585kBUMe0umWUjUMJIx35wxDyl0FK0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgGXIwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:52:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXIww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:52:52 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADBC5206EB;
        Fri, 24 Jul 2020 08:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595580771;
        bh=3XAOLRXH+A5spT3PUCVqth7VHfe4CGFX/QSU9CZHx44=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Rw7XkhQcY5FW6xbsyMZBXEUG/Ik1Wu+zCSg9CYpbtSNmDwm0krzyLmvfm5i2yl5jo
         5YOFfvV5otirQ5ak3P6eveW2XcV8W/r9sTXHVcfdi2sLi9rVxLCVZZ5wSVb63iwkmr
         1hJH1LLi0gKKVS/OR7VkFCnr/YzvNkMsQapjd1Q8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200709135251.643-12-jonathan@marek.ca>
References: <20200709135251.643-1-jonathan@marek.ca> <20200709135251.643-12-jonathan@marek.ca>
Subject: Re: [PATCH v3 11/14] clk: qcom: Add graphics clock controller driver for SM8250
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Date:   Fri, 24 Jul 2020 01:52:51 -0700
Message-ID: <159558077103.3847286.2846749165672548492@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Marek (2020-07-09 06:52:42)
> Add support for the graphics clock controller found on SM8250
> based devices.
>=20
> This is initially copied from the downstream kernel, but has
> been modified to more closely match the upstream sc7180 driver.
>=20
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---

Applied to clk-next
