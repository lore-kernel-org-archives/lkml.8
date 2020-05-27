Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E29EEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:21:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7E22084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590549695;
	bh=0HJqmsukxEbasVpB0fF6u+rD8B57992xBAQgVKu4vos=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=F2h5oY80znLr3JbshpSgb7WVInxNO71S5vqB4S5QDDm2IcVIUp4cwb6fjtjYWS4Zx
	 2t3WwCO3+2ArW0Yw50iBKHmI0GgZ3TPeIPS/cGtixuR0fn2sL+rgizHnfsd/5NZnno
	 GLl3PvRzrH4BUhyONxFOMRte+kFdAy/E/oPMNBbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgE0DVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:21:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbgE0DVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:21:34 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 449D5207D8;
        Wed, 27 May 2020 03:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590549694;
        bh=0HJqmsukxEbasVpB0fF6u+rD8B57992xBAQgVKu4vos=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Mi2ISsnNU9VRd0oVowT29uMrvDgoQXlh6ejF5wBU8G0zam7mydG3ewqR1VOzSQzje
         CCTsde1bR3zcyIiv1CxVKQINxSi76uvVOOWps6OFskQGFjDsTzP7jatk3KVMu+tU2Z
         E5QEZxQnhI1T1+ni/FYMwVrT9td1xl3m7trLemxY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200515142720.290206-1-codrin.ciubotariu@microchip.com>
References: <20200515142720.290206-1-codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH] clk: at91: Add peripheral clock for PTC
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     mturquette@baylibre.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        eugen.hristev@microchip.com,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 26 May 2020 20:21:33 -0700
Message-ID: <159054969349.88029.10932617999893578868@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Codrin Ciubotariu (2020-05-15 07:27:20)
> PMC generates the peripheral clock for the PTC.
>=20
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---

Applied to clk-next
