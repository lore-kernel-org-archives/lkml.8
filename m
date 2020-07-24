Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DC6C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009A72063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582482;
	bh=LzPTb4x+FLSUPH+NHmD1bJ4ERu+GlQhIbBmboWegqvk=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=UE8T1VZrfbeeDz7XumXWvq4uzTQLRVNIIYstpCIbReFsaCQAefZzGu7HY9lb7QPVn
	 BDVU6wHl0b7BAUuk26F4wmtTHeA8PlFpPjXVQknurZ28cVCe8hSeK/B1nogxq9ONU0
	 eaHdXRhBpGlfli7Zj/PhNTURwoBI7l0skvi1XK3A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbgGXJVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:21:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGXJVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:21:20 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3B052063A;
        Fri, 24 Jul 2020 09:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595582479;
        bh=LzPTb4x+FLSUPH+NHmD1bJ4ERu+GlQhIbBmboWegqvk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=paDbyVWpT5WbiXRG9xDz0koaZtLK5CODW0/I/hFh1Xg89JmBF85teM2hAaCegeyqY
         V6hdcgo82RrLCAeMmgWUOLiA8XZANeMryMWvJDRqJQXA3ryDXrJ3f9s3Bd07NCRFeJ
         phay31DuYPvQTg6gUh5NngGI68gtI1rykgZDK0MQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595403506-8209-8-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com> <1595403506-8209-8-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 07/18] clk: at91: sam9x60: fix main rc oscillator frequency
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 24 Jul 2020 02:21:19 -0700
Message-ID: <159558247921.3847286.12219188368386875463@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-07-22 00:38:15)
> Main RC oscillator frequency is 12MHz according to datasheet
> (chapter 27.2).
>=20
> Fixes: 01e2113de9a52 ("clk: at91: add sam9x60 pmc driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com
> ---

Applied to clk-next
