Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9E0C33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29ED20718
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579820331;
	bh=Ma7mr84NfXsNfnp/ICmqGQRnXoWqBHa1vhN/R+arV44=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=m2ORsl38iTyVtRMui/HoaEd7ti0mBX+v4Pu6UopdfZ25jl3lcAPyirRkdR7vDo0VL
	 3ndMAyapoBnfhWadpZhlYDcCRA2IanWAxrBG21KtPii4ygAYX4j1IaipSnShsgNa10
	 NI03MCNS3uHSIROZ/c6rOCC2lMWXjkS/VU6l12iE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729639AbgAWW6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:58:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:40250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbgAWW6u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:58:50 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64FF422522;
        Thu, 23 Jan 2020 22:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579820329;
        bh=Ma7mr84NfXsNfnp/ICmqGQRnXoWqBHa1vhN/R+arV44=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iKtw1ctzjapyoZ9ydaYq5z4fUuJODkHiwCgh++gqBmXnc0ScjOy0FHH26IbuBf6dY
         tzWcyVNyTRVwyNSZ79S08oUfRMXzqx9V9ZyqOwscJUW0pHwsH8K9LiKjJZRNCAQwoy
         uezSQDbWZ7Vb2rFaur+8jd5yyLDsIk2ptmssdUUk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1575527759-26452-4-git-send-email-rajan.vaja@xilinx.com>
References: <1574415814-19797-1-git-send-email-rajan.vaja@xilinx.com> <1575527759-26452-1-git-send-email-rajan.vaja@xilinx.com> <1575527759-26452-4-git-send-email-rajan.vaja@xilinx.com>
Subject: Re: [PATCH v3 3/6] clk: zynqmp: Warn user if clock user are more than allowed
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Rajan Vaja <rajan.vaja@xilinx.com>
To:     Rajan Vaja <rajan.vaja@xilinx.com>, gustavo@embeddedor.com,
        jolly.shah@xilinx.com, m.tretter@pengutronix.de,
        mark.rutland@arm.com, mdf@kernel.org, michal.simek@xilinx.com,
        mturquette@baylibre.com, nava.manne@xilinx.com, robh+dt@kernel.org,
        tejas.patel@xilinx.com
User-Agent: alot/0.8.1
Date:   Thu, 23 Jan 2020 14:58:48 -0800
Message-Id: <20200123225849.64FF422522@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rajan Vaja (2019-12-04 22:35:56)
> Warn user if clock is used by more than allowed devices.
> This check is done by firmware and returns respective
> error code. Upon receiving error code for excessive user,
> warn user for the same.
>=20
> This change is done to restrict VPLL use count. It is
> assumed that VPLL is used by one user only.
>=20
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---

Applied to clk-next

