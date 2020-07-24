Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8622FC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 616BF20768
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 08:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595580757;
	bh=HaZAGhQ/CczQRJ//7RQcyLNQiIIaVrGd8jVm0qSOOPY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=AvwpQbPoxjzFGd2HZBJEBomXmfTelri8FsvlwjeUXwEfFChBYcfYrSiGt6w6QOZhB
	 o0X//r9clUPWfb8TgOFQ6WN5tB8mqlUEyNLs1aM0nkLyiAwHfSDfS35y8wJmh/jDvK
	 axpG+hkrm4sIHIM/hwDU6p9q5SwqmXvlGCAtpWxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727886AbgGXIwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 04:52:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbgGXIwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 04:52:31 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 469B5206EB;
        Fri, 24 Jul 2020 08:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595580751;
        bh=HaZAGhQ/CczQRJ//7RQcyLNQiIIaVrGd8jVm0qSOOPY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=2Bb4/yWdCXSTzTDcFbvecjO8Ugf5ltw5HcFOIx20S3vB+NXm8tMOu2QsNE/P1gGdh
         Eag2vr/Vt89WsAAq5w9Dpe+1L+hfoelL6/9QvkIawsoaslTrJG4+f7UAZv6KHXbXI+
         nz3+NX+3pyOvf93KaApwb0Si9dgalzfmBTgly5hg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200709135251.643-8-jonathan@marek.ca>
References: <20200709135251.643-1-jonathan@marek.ca> <20200709135251.643-8-jonathan@marek.ca>
Subject: Re: [PATCH v3 07/14] dt-bindings: clock: add SM8150 QCOM Graphics clock bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Taniya Das <tdas@codeaurora.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Jonathan Marek <jonathan@marek.ca>, linux-arm-msm@vger.kernel.org
Date:   Fri, 24 Jul 2020 01:52:30 -0700
Message-ID: <159558075062.3847286.8668727283732083398@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Marek (2020-07-09 06:52:38)
> Add device tree bindings for graphics clock controller for
> Qualcomm Technology Inc's SM8150 SoCs.
>=20
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> ---

Applied to clk-next
