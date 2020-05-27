Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1564C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BC4420787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590547304;
	bh=8pmFYGawYKquGFtp3cwkbNq/yJ/Z20y2pO5HiRcXK+k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=y9w4C0VFt6mPgvH/IuXuF7l2MiCH9agHNZLkKZNPYm9XR9HWBXzZnERGwOm3M0/yn
	 SWfFln8Elr5rxZBL48c+0OCkLiyV3C2TbDbWNRpXYBvKG8VQmZ0HoRDE2ZuTfJTSY9
	 yiQKFsWN0Q/jP6lR613PbV53HyaatdrYy6NTgR74=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgE0Clo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:45118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE0Cln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:41:43 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4222720787;
        Wed, 27 May 2020 02:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590547303;
        bh=8pmFYGawYKquGFtp3cwkbNq/yJ/Z20y2pO5HiRcXK+k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=faSsfdcgDJiwhjCEqcWQDN0XrBY0c8h/+QO/0Z2mfLszFu+GZ/w0gY8gIw5QWOor2
         wfaXzvVoqRurUsTq90UOn1CpdSzoiYJEvIua8hGKcUNO7T5Dt6KDx7sRizcndeloyp
         GLH8qP4RTyVhPMuf3W8AvWHGpyeB5Ld+xI8RAA5Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1588573803-3823-1-git-send-email-sivaprak@codeaurora.org>
References: <1588573803-3823-1-git-send-email-sivaprak@codeaurora.org>
Subject: Re: [PATCH] dt-bindings: clock: Add YAML schemas for QCOM A53 PLL
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     Sivaprakash Murugesan <sivaprak@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, mturquette@baylibre.com,
        robh+dt@kernel.org
Date:   Tue, 26 May 2020 19:41:42 -0700
Message-ID: <159054730255.88029.5143799149038084787@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sivaprakash Murugesan (2020-05-03 23:30:03)
> This patch adds schema for primary CPU PLL found on few Qualcomm
> platforms.
>=20
> Signed-off-by: Sivaprakash Murugesan <sivaprak@codeaurora.org>
> ---

Applied to clk-next
