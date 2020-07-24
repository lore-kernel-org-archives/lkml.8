Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16B0C4345B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C503F2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595580770;
	bh=dJkOvr6QaxJRTt+XvBg8M2sJSMnFf3fm1NtMNiYtwZ0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=qMrgyJULwugTvllWvhbv2rqkfKo7gfyoULdiwUYeZMAHMt0wW6ro1BMtR0sd9KFln
	 DbVfYZMIvIjt/DYC4bRRQzadNc8W28+AG+tftrl849+eSVGxaT8gWtF4tDqANI1Hqk
	 9+s6tEdAg0aT4DHCg2AAHJvoOJeDKTj/4G8gEOr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgGXIwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:52:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:37678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXIws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:52:48 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B824206EB;
        Fri, 24 Jul 2020 08:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595580767;
        bh=dJkOvr6QaxJRTt+XvBg8M2sJSMnFf3fm1NtMNiYtwZ0=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FDvgjzHGy6hSzHLlnpYEkw1d5gXrWKLDVh8GsezINgodBP6ijb8hxnTUP2YPcWaUH
         wpfr5DJqsMWYLvF87U0cpeBKmyFsfZ13qStbxfB8h7JaQLPNv0KGivsSDPDzfZrNL1
         4uVnP+m/UBkm9xPTFM3pVakwHFjHMcm4tn1cWan0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200709135251.643-11-jonathan@marek.ca>
References: <20200709135251.643-1-jonathan@marek.ca> <20200709135251.643-11-jonathan@marek.ca>
Subject: Re: [PATCH v3 10/14] clk: qcom: Add graphics clock controller driver for SM8150
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Date:   Fri, 24 Jul 2020 01:52:46 -0700
Message-ID: <159558076686.3847286.7838610818613543237@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Marek (2020-07-09 06:52:41)
> Add support for the graphics clock controller found on SM8150
> based devices.
>=20
> This is initially copied from the downstream kernel, but has
> been modified to more closely match the upstream sc7180 driver.
>=20
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---

Applied to clk-next
