Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F34C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE522078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 23:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594425042;
	bh=pjM63AJEMTvRBufcp7VTgOvAiZiKHrCpskfT6qkNxhI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=CSmJc9M1RwP5cOayHVdwFEdGw9xynIe/YNzQwd3kN1d3PpuYuZOifdY8l4OYSrjP2
	 qzZT83XIRGBVcorgwKldsXesnMvOn34wWOtGFx50e0sTfuMJOdZsn+yuHuqLAOzlKe
	 JwDFAsiQAdLuagoQcFuvQ9g2aNb9pUJhkYu1oaMc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgGJXul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 19:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726581AbgGJXul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 19:50:41 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA46020772;
        Fri, 10 Jul 2020 23:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594425040;
        bh=pjM63AJEMTvRBufcp7VTgOvAiZiKHrCpskfT6qkNxhI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=T7UAW/3AihcPn1mqkSy9Hm3Mgav/sWIXq4FogQrbgTU0trNqJqeqdNb+Iz0M5vNpi
         XLS+TtaQ9g+9tPSrS/8A0PWmkcfMzA6hWnXxFD0BmWyoHCC6f/Ym+qz9CssPUvK0lP
         TRlhwa6hm+uYWlcgnCgJI5sq1aV2C8zIHl2k12hc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200709081705.46084-2-sudeep.holla@arm.com>
References: <20200709081705.46084-1-sudeep.holla@arm.com> <20200709081705.46084-2-sudeep.holla@arm.com>
Subject: Re: [PATCH v2 2/2] clk: scmi: Fix min and max rate when registering clocks with discrete rates
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Dien Pham <dien.pham.ry@renesas.com>,
        linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Date:   Fri, 10 Jul 2020 16:50:40 -0700
Message-ID: <159442504011.1987609.3990897866011325023@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sudeep Holla (2020-07-09 01:17:05)
> Currently we are not initializing the scmi clock with discrete rates
> correctly. We fetch the min_rate and max_rate value only for clocks with
> ranges and ignore the ones with discrete rates. This will lead to wrong
> initialization of rate range when clock supports discrete rate.
>=20
> Fix this by using the first and the last rate in the sorted list of the
> discrete clock rates while registering the clock.
>=20
> Link: https://lore.kernel.org/r/20200708110725.18017-2-sudeep.holla@arm.c=
om
> Fixes: 6d6a1d82eaef7 ("clk: add support for clocks provided by SCMI")
> Reported-by: Dien Pham <dien.pham.ry@renesas.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/clk/clk-scmi.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
>=20
> Hi Stephen,
>=20
> If you are fine, I can take this via ARM SoC along with the change in
> firmware driver. However it is also fine if you want to merge this
> independently as there is no strict dependency. Let me know either way.

I don't mind either way. If you want to send it in along with the
firmware change then that's fine.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
