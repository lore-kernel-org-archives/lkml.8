Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57CDC2D0FA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9515620659
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589318152;
	bh=UZ5NeKMCz+5HbweHT8/WJDTWgSKlAK45WYlgMgV8o1M=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=BX2U9p140vrJ2Qa3xpHkcRF8RBaK17vwbzo6p/25/9OUgvqujRKnX410Hpq4uWlZx
	 gUvkem8Jq2fSh3RdwiXvHkXnOKRnZXzj3IFoUM/widYi65rexXHanFRzMwKzCn2ven
	 kUfjZlMzNJLcRaQEMHSlECid/7wNyY2Ee+RjPw/8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731439AbgELVPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:58610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730200AbgELVPv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:15:51 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E999205C9;
        Tue, 12 May 2020 21:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589318151;
        bh=UZ5NeKMCz+5HbweHT8/WJDTWgSKlAK45WYlgMgV8o1M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Z7AwIOewlYecxAguRX3pTIF5hQYXnd9LieVNM7L1vWKyKRIlgm7O8eCAgpihpdQ6m
         u9z1LVH+rBLCMw3Z0V8m4sWajZji7J1xTcc/KeKLXvvc47nvq4CvjDbsn0ukl+/USU
         EnXJimWXTh6+f6asA23uxewQIQIOMr/PYZV+UJ9M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200506123236.7463-2-geert+renesas@glider.be>
References: <20200506123236.7463-1-geert+renesas@glider.be> <20200506123236.7463-2-geert+renesas@glider.be>
Subject: Re: [PATCH 1/2] of: Make <linux/of_reserved_mem.h> self-contained
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To:     Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Joseph Lo <josephl@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>
Date:   Tue, 12 May 2020 14:15:50 -0700
Message-ID: <158931815065.215346.3560274157495009646@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Geert Uytterhoeven (2020-05-06 05:32:35)
> <linux/of_reserved_mem.h> is not self-contained, as it uses
> _OF_DECLARE() to define RESERVEDMEM_OF_DECLARE(), but does not include
> <linux/of.h>.
>=20
> Fix this by adding the missing include.
>=20
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
