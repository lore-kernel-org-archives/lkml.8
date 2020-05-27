Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AB3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4196207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 02:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590546146;
	bh=1Y7J1NdYDG9N/vDOJYQc8LafLZ6M0SRIKC84TW68RBE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=pqKIPzkfaQ5i2Z2sOqQKN7Q0EPGYel1oFljrHaZ6iB5fgk3PNEEVx3c+LuE6DeEg7
	 6EXFjh8Y++Nb5FfMG87EgycMi2D5RK84SpF9Rmx3UwE3RMC1TNG2pEgSY6sDyHHLvZ
	 nnT3fhPvD2/3y9bRs8wjEuRYsLVwKIbk9XrDqWMU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgE0CW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 22:22:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgE0CWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 22:22:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7051D20873;
        Wed, 27 May 2020 02:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590546144;
        bh=1Y7J1NdYDG9N/vDOJYQc8LafLZ6M0SRIKC84TW68RBE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=MyC3201OWySGnjrWvCe/P+rBJZd1I5SC+ILGIuSlT0h2fuhWy192SfQ3pKmi8ZMd5
         Hel524FqTu8Y78oIZXYqEFx4P6UqExf284+JQrKsk+7d5h9NX1eFGv/kkUHwPv8kr7
         M2mI8Bwn6lU2CRuh9SVu7g7/tDxBLIWI77Zu/+CA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1589709861-27580-3-git-send-email-tdas@codeaurora.org>
References: <1589709861-27580-1-git-send-email-tdas@codeaurora.org> <1589709861-27580-3-git-send-email-tdas@codeaurora.org>
Subject: Re: [PATCH v2 2/3] dt-bindings: clock: Add gcc_sec_ctrl_clk_src clock ID
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
Date:   Tue, 26 May 2020 19:22:23 -0700
Message-ID: <159054614359.88029.2985546320122491978@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2020-05-17 03:04:20)
> The gcc_sec_ctrl_clk_src clock is required to be controlled by the
> secure controller driver.
>=20
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next
