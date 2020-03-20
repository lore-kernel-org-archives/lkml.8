Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27973C43333
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E757F20714
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584746966;
	bh=MPi2xt97KetHw68975ngpSXAXFsvWzrmINAVPvDL8yE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=FHk1Z0FbU9OGBN1cyR3sR3IRTxsI0WECaPLSdQZeRJMGg+DKZwPofIAGGSNhPbj/M
	 x4dlTGGOSNStap2TXdGRAvwAivee0qW6g7miJ5thlLTUFgzV+Mk4RGf2HncBrl8PEh
	 UNpS/TH0an2XNU91BP0EvnAGgZ6gLC739itqbjY0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbgCTX3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:29:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726738AbgCTX3Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:29:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 198CB20714;
        Fri, 20 Mar 2020 23:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584746964;
        bh=MPi2xt97KetHw68975ngpSXAXFsvWzrmINAVPvDL8yE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=AuPofGsvXDvSvZ411Jm38SedVvs2FUKV8LKr+VPwyYsKL4hgjXV4YJP5TLT3IyN2R
         IAMdSgt9OANGmeLa6l6n11jsXecteaSFvKAOUA5MtxCeyxLgqc53gklbkjiQqd8q2S
         rhfgT2eNqqp/WjDSeGEYI8O5eGPaf8+1ie/xpQzU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200318131657.345-1-ansuelsmth@gmail.com>
References: <20200318131657.345-1-ansuelsmth@gmail.com>
Subject: Re: [PATCH v2] ipq806x: gcc: Added the enable regs and mask for PRNG
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kumar Gala <galak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>, Ansuel Smith <ansuelsmth@gmail.com>
Date:   Fri, 20 Mar 2020 16:29:23 -0700
Message-ID: <158474696335.125146.11066378876804140900@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Ansuel Smith (2020-03-18 06:16:56)
> From: Abhishek Sahu <absahu@codeaurora.org>
>=20
> Kernel got hanged while reading from /dev/hwrng at the
> time of PRNG clock enable
>=20
> Fixes: 24d8fba44af3 "clk: qcom: Add support for IPQ8064's global
> clock controller (GCC)"

BTW, this should be on one line. Please fix it next time.

>=20
> Signed-off-by: Abhishek Sahu <absahu@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
