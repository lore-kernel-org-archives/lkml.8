Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE636C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF0A208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590627680;
	bh=jBVXYZkmmWDlv9o4kqsnN/HfJGhCXkyYlOK0BYqwJg8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=i6VpK0KFyCmGmgqETTHLyhiMKAjgJASUNdYwFCxTyd87O86BC5g2yK4LyIIQpfSgz
	 V2R16PqzCq6/kvyBcXVGeH91HJnoTSWNhEOLnjNRlMKiSyw6C/Z8Ogzq9qsI2RnZAn
	 eVyoL2GEBVhdlGQg1Mwmo1rLEkILSsTaZemwmb+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgE1BBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:01:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgE1BBR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:01:17 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 260C720888;
        Thu, 28 May 2020 01:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590627677;
        bh=jBVXYZkmmWDlv9o4kqsnN/HfJGhCXkyYlOK0BYqwJg8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dvB1PfwnC/pD0upEAcY9qqx5epSxMeNZj3ziOAmBlyHhJd4nrHQK0DBRTfV8LzXBu
         KPL6Xcy0Lpd+GbFgEbXVYSw4TCuaz1ZhBptIWMKqKWkdHjCFkxWbSWUvX+y5EKNrBk
         cxH1s60bwbhz82qGG6PNxVahQ9AwcyX2QTm+LFD0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200519224151.2074597-7-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk> <20200519224151.2074597-7-lkundrak@v3.sk>
Subject: Re: [PATCH v3 06/13] clk: mmp2: Rename mmp2_pll_init() to mmp2_main_clk_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Wed, 27 May 2020 18:01:16 -0700
Message-ID: <159062767630.69627.10455271223525770055@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-05-19 15:41:44)
> This is a trivial rename for a routine that registers more clock sources
> than the PLLs -- there's also a XO.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---

Applied to clk-next
