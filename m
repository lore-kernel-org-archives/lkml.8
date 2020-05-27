Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D51C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF2E921531
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590567261;
	bh=sNNmG0cTdLLy7b3yFmzQ1Wka7gK77HZTE8IJ1WgDr5g=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=U1FAvOPfU2B144728uq+Fc1oLVG/MOyCg3Z/fswu0f8vm0agxcajZ7NNloqfmIccZ
	 p73KoF7DTUWRp0u6xywqT6g0FvHpgJDljnM8qyrzvsrIAHr+DKEC6aITGjFbHyepn2
	 udMn1FyFUnqNNqrQZtnQ3Ybse8P36WS6ynD+uBaA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388040AbgE0IOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:14:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387566AbgE0IOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:14:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D5C2215A4;
        Wed, 27 May 2020 08:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590567259;
        bh=sNNmG0cTdLLy7b3yFmzQ1Wka7gK77HZTE8IJ1WgDr5g=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=B5Vd4iwJGZ/B+rETNRCUGw9OdegjBIFMpPIZZ+zcav6kbxIlaW0uIoAuej7D4Vesd
         x/IbJ5Z8EUYiE7jcboRBrls30PAlp67QqD084Zv5SJMbA6Mj/37q/2jWp8OtB6aYUO
         UhL23ilKa1Sb08bZ2j3RehdIWXNTHt58pup2400Q=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200322140740.3970-1-avolmat@me.com>
References: <20200322140740.3970-1-avolmat@me.com>
Subject: Re: [PATCH] clk: clk-flexgen: fix clock-critical handling
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     patrice.chotard@st.com, avolmat@me.com
To:     Alain Volmat <avolmat@me.com>, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com
Date:   Wed, 27 May 2020 01:14:18 -0700
Message-ID: <159056725840.88029.11402589340387170761@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alain Volmat (2020-03-22 07:07:40)
> Fixes an issue leading to having all clocks following a critical
> clocks marked as well as criticals.
>=20
> Fixes: fa6415affe20 ("clk: st: clk-flexgen: Detect critical clocks")
>=20
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---

Applied to clk-next
