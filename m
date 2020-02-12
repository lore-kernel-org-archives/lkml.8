Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E10BC3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 456A32467B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581541013;
	bh=aic0+l6hRQmzI2xoa+qinsgy1JgQHwpdDkkRk5LV0cw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=OugsGH+JMCeOtggxUfMpv/MMJwtKxho1Tv0Esi3Hqtyce17b6QkLhpuk5y2RJiA0P
	 Ddwho3KXA7NmSSx5RMJkG78aWonUIsRqKAJ0ORTg+jPooTWqIFfG6Hfs+LhuI7v1WP
	 PoMUi9v2Q6s44xLRO1nF92MFRWCfOGFLW1B4sVJ4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgBLU4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:38888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgBLU4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:56:51 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1212024677;
        Wed, 12 Feb 2020 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581541011;
        bh=aic0+l6hRQmzI2xoa+qinsgy1JgQHwpdDkkRk5LV0cw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LtB8IiOC6WFUgvtyyWZiAAxUUEYP8l38Hvf/dzQeq96eOY57t07jpVevkYRuTupfV
         mAzVIstQkFeX96qrELoyJv1hlh/tTjvWPalTTVG5nDMUGLtvJKkMgwlWlULD7U2cIp
         yEyvN1e8ipWwMHtgLODwgHsSToL+yVIaCZmi+gTw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1581508657-12107-2-git-send-email-Anson.Huang@nxp.com>
References: <1581508657-12107-1-git-send-email-Anson.Huang@nxp.com> <1581508657-12107-2-git-send-email-Anson.Huang@nxp.com>
Subject: Re: [PATCH 2/5] clk: imx8mq: Add missing of_node_put()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Linux-imx@nxp.com
To:     Anson Huang <Anson.Huang@nxp.com>, abel.vesa@nxp.com,
        allison@lohutok.net, festevam@gmail.com,
        gregkh@linuxfoundation.org, kernel@pengutronix.de,
        leonard.crestez@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, peng.fan@nxp.com, ping.bai@nxp.com,
        s.hauer@pengutronix.de, shawnguo@kernel.org, tglx@linutronix.de
Date:   Wed, 12 Feb 2020 12:56:50 -0800
Message-ID: <158154101034.184098.2861713312401577161@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2020-02-12 03:57:34)
> After finishing using device node got from of_find_compatible_node(),
> of_node_put() needs to be called.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
