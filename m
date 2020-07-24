Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3375C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C67B2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582457;
	bh=/L5f10vbURPSOnHqw4I2YI6W0sA2MlARi69rL5E2y0k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Ch2irrJKqViPHS59WkhTlidpqIDyFOZZkQ9VFL4UAwVKmbyiQPzynvBtqvr/sbRwm
	 /B6hCEc5i2OqSpMManOjMUMvNHVLQ65LbAs0D/ZhvQqUX8JGqzskuZIosCUL3nvZwZ
	 GoaECeSISEXYH1ky8KJWRL+An+rDOn4EDv2X/TaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbgGXJU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:20:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGXJUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:20:53 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1398420791;
        Fri, 24 Jul 2020 09:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595582453;
        bh=/L5f10vbURPSOnHqw4I2YI6W0sA2MlARi69rL5E2y0k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=yE5RonWNYYMBvbhS2gVUR4v4sAsA6QlE+dnKXNiivdxGfAlECmn09iudwqdaU+0AO
         r8se3ZFxoznn2hXMBfdV88i+u9V19Qfh/KO/lte+HjjUSRPt4QMGQaRUvyuMICxbmn
         CVrIqfSUBIyKI6YHKYYPx+GUSNZJn55rtySgBYNY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595403506-8209-5-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com> <1595403506-8209-5-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 04/18] clk: at91: sam9x60-pll: use logical or for range check
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 24 Jul 2020 02:20:52 -0700
Message-ID: <159558245245.3847286.13137850272759358529@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-07-22 00:38:12)
> Use logical or for range check. In case bestrate is not in
> characteristics->output[0].min..characteristics->output[0].max
> range we should return -ERANGE.
>=20
> Fixes: a436c2a447e59 ("clk: at91: add sam9x60 PLL driver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-next
