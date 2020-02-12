Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EA9C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFAF24677
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581541074;
	bh=NJ7aaNUqEPVaOqRQtSadrD1LNqyvV0+PjEpnK+RiSgA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=csynN0tGD4F0pkgw3CJpakUIMSaYl8omWVdOKYBuskO/oHZ8EmjUZS+HfJJy51v6h
	 Ar3od6CyUQldYfDqGSRL8hUB6rZHyhRAMLt+irfM6VvXZmr0jhG4PXASxKZjDFEhl4
	 /cDnySTzcIlRjUmyDjsM14jp5OzzQqOD40XATmO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgBLU5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:57:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:39784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727420AbgBLU5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:57:53 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9CB0206D7;
        Wed, 12 Feb 2020 20:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581541073;
        bh=NJ7aaNUqEPVaOqRQtSadrD1LNqyvV0+PjEpnK+RiSgA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Hqp5Rj2bgJBgetIw/kbLJbfXvOyWWl2e/oGyZ3PJ+jGXFV/E+OlJBmGeBNekMqrjZ
         8cSW3L38W8G2LjFdoc/PC/G6BKoQAos/BNZrGxS+N/hT9p00FDs9cnAnlIqg2CC1Hc
         bSh3I5xhy+HG5gJNZ4h2nVuIuJywyQwLWd98/Acg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200212094317.1150-1-geert+renesas@glider.be>
References: <20200212094317.1150-1-geert+renesas@glider.be>
Subject: Re: [PATCH] of: clk: Make of_clk_get_parent_{count,name}() parameter const
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Wed, 12 Feb 2020 12:57:52 -0800
Message-ID: <158154107225.184098.12794012881408506837@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-02-12 01:43:17)
> of_clk_get_parent_count() and of_clk_get_parent_name() never modify the
> device nodes passed, so they can be const.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Seems fine. I'll push it into clk-fixes in case that help fastrack any
patches for next release.
