Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFCA0C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD41220674
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595582519;
	bh=YXtimZhigq25Me5UeLpSiKtykz9k/KaNaHsIp4L9exY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=WU7ogJcf+ko7I/BSrdZS1D5SkzhG64lrVyrLra7aTZrCx6UGo7lRWtPPEDDbqAz+t
	 8cR7avw8s4AtntVp7rOinlY49HQugYbJxAobA3izju6ibQOubqglYs3hZ8SrNbFyRN
	 ACsPOvfre5wLPbgb1tvinzUxyIE35d21gojQs0VM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbgGXJV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:21:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGXJV5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:21:57 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DF962063A;
        Fri, 24 Jul 2020 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595582517;
        bh=YXtimZhigq25Me5UeLpSiKtykz9k/KaNaHsIp4L9exY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=W5qHIxI2CNmIkWAgGjAklUlu0WD4PTm/omwY1EeoTY/aenGV1MHPthC59NXTCvwnV
         BycctsNkcPb+0sutWpAK+4gFsz4SfW40xOsQoEkz5PGTS5PX5lnRzZ19digHg4v3s8
         7KHZwtpHKYrZDqTlEevQNyr7FXdAaJowSZ9rMdjg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1595403506-8209-16-git-send-email-claudiu.beznea@microchip.com>
References: <1595403506-8209-1-git-send-email-claudiu.beznea@microchip.com> <1595403506-8209-16-git-send-email-claudiu.beznea@microchip.com>
Subject: Re: [PATCH v2 15/18] clk: at91: add macro for pll ids mask
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     bbrezillon@kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        mturquette@baylibre.com, nicolas.ferre@microchip.com
Date:   Fri, 24 Jul 2020 02:21:56 -0700
Message-ID: <159558251663.3847286.14578790114931614684@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Claudiu Beznea (2020-07-22 00:38:23)
> Add macro for PLL IDs mask.
>=20
> Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> ---

Applied to clk-next
