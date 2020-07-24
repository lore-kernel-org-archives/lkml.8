Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBE3C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CB6920767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595580762;
	bh=nlTpH+zNloGUDHu4bBIXHjZAIjrbQ2ltkqMnDkDN5ZE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=EITWfcDW1IBDfbFA5NR7U2ptR+7gFdzi23Hm982ekSQuW4UTI6U9spRAyIhZr6xTw
	 f/mAx9E/Nh66q9FlOPOll8xG8QEYrn11ItzC8qWajrNW2dLupbyB0R4iPo0Ajh+jwP
	 fLKiRrSYgS9+BAxGbaA7eg7qZZ5c76KZWbKBAvoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGXIwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXIwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:52:37 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33FDF206EB;
        Fri, 24 Jul 2020 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595580757;
        bh=nlTpH+zNloGUDHu4bBIXHjZAIjrbQ2ltkqMnDkDN5ZE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=I6qUAljfK3PD7HpcoImnWOSiw4wTwRNpR7QRY9s52NvPEvl3YMsfOM5Ytw19SfNzD
         v+DzXIQuFKU37sy3R0jhB/igXapA0lVc9uuR+t1533Dy4KXrFW5vaNxUITCJvvjrBv
         Q7ZtQCi/1N2mwRKezyvNxOhTi4DQ+Cd5qzID+CWM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200709135251.643-9-jonathan@marek.ca>
References: <20200709135251.643-1-jonathan@marek.ca> <20200709135251.643-9-jonathan@marek.ca>
Subject: Re: [PATCH v3 08/14] dt-bindings: clock: add SM8250 QCOM Graphics clock bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Date:   Fri, 24 Jul 2020 01:52:36 -0700
Message-ID: <159558075648.3847286.11651453704096964720@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Marek (2020-07-09 06:52:39)
> Add device tree bindings for graphics clock controller for
> Qualcomm Technology Inc's SM8250 SoCs.
>=20
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---

Applied to clk-next
