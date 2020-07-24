Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120AFC433F2
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5089206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595580741;
	bh=4FG+WYN+cXfEwFdQy84hxchhggqEifaoW67WtaOT0g8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=QzSQvxoR7a2Xanjq/xgMMUdyMCQZuZBmrRf3cnxjMrGfo64mfP9tcRvc9N3m5rkkP
	 p04wg1zIFDt7XlBFC4sXiwYpoj4rr+Qp4WQO4LzQvC8BDWmSHPnFwb0r131XlpRsJa
	 LJ9cfn0RGUaACPmtNdsmOqNZVELu02HmalPldggA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGXIwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:52:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:37090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXIwT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:52:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4AB42070B;
        Fri, 24 Jul 2020 08:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595580738;
        bh=4FG+WYN+cXfEwFdQy84hxchhggqEifaoW67WtaOT0g8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=fo3gkoZBMFz0WJqHgEqxP9h5Yt7eNb5luypTt13N5AfSu7V/JCUOsn6JzxNoxlMxM
         dIwBn69fF8ri+YPfy1bIDU7AI5OPHZqE26YUPIj557W6nnvJXWuW2nnk2BxgMb9prC
         +AMIMy7pvbtYqKY6eTc8KTOgOEYdT/ab1VR0MFIs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200709135251.643-5-jonathan@marek.ca>
References: <20200709135251.643-1-jonathan@marek.ca> <20200709135251.643-5-jonathan@marek.ca>
Subject: Re: [PATCH v3 04/14] clk: qcom: clk-alpha-pll: use the right PCAL_DONE value for lucid pll
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Date:   Fri, 24 Jul 2020 01:52:17 -0700
Message-ID: <159558073780.3847286.14352805752734393609@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Marek (2020-07-09 06:52:35)
> Lucid PCAL_DONE is different from trion.
>=20
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---

Applied to clk-next
