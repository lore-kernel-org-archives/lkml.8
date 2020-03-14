Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ABAC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:17:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1386A2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 01:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584148654;
	bh=+OILuvouBCX8uMF/DlchLPyrx1JavU6/eR/UOXvuv8c=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=dZWpG051C+vdKKzoqEfR0TdblvygUynzfiiVdGuPB/2UBt1j4xz+LLjpGkmNFKjlb
	 GNu5b1pzPNAkznzuy/gVFVKPF/auG+Qlmr0FrIEIKn0g9gn3/hkh8zpT+oTjoORTrp
	 z8I3PcusTKg7HQzUaQ4/tJTltIzCFiymoED0zKSs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgCNBRc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 21:17:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:59302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgCNBRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 21:17:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A13DC2074A;
        Sat, 14 Mar 2020 01:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584148651;
        bh=+OILuvouBCX8uMF/DlchLPyrx1JavU6/eR/UOXvuv8c=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=R7xvdtknuSkmlj0jrBNdhaBIycSQ2z7QKYLKtuKhx4O87Qcm/sNM8vE+OeWqk5IlB
         Zz74RpD+G7TgqxXlffwyX6UUf506YN4U+yRzn0iS+3a8CELbDkU83dsKnanJHrok9c
         fZimPWbrxN9BfUoGqhYBr+IUC3iseze8NpNOD/YQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1d569e023b6cb7b8d0da8d1bcccd92e97fe436c8.1583896348.git.joe@perches.com>
References: <cover.1583896344.git.joe@perches.com> <1d569e023b6cb7b8d0da8d1bcccd92e97fe436c8.1583896348.git.joe@perches.com>
Subject: Re: [PATCH -next 010/491] ARM/SAMSUNG EXYNOS ARM ARCHITECTURES: Use fallthrough;
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
To:     Chanwoo Choi <cw00.choi@samsung.com>,
        Joe Perches <joe@perches.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>
Date:   Fri, 13 Mar 2020 18:17:30 -0700
Message-ID: <158414865091.164562.17682025008359421835@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Joe Perches (2020-03-10 21:51:24)
> Convert the various uses of fallthrough comments to fallthrough;
>=20
> Done via script
> Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390=
fa.1582230379.git.joe.com/
>=20

This link doesn't work for me. It leads to a redirect for=20

https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.15822=
30379.git.joe@perches.com/

>  drivers/clk/samsung/clk-s3c2443.c | 2 +-

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
