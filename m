Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63854C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B992208B8
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590627687;
	bh=LZnkNzSsbzB6azY77M84sY6QK7u8r73HOlYaSsFmZ5k=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=Fnbiqx5Wjc3zUfGRWJeduqtFYM/fwpKgIp1PY4JJKJCgUqX0BZIY2V76GMDqz67k1
	 ojbatJcpbj+YTIrktK8+1SnDh9LxUtGf36xRAX50WW4MKeJn+YyHrfAG2y4R0GTkfY
	 GP5avbNLdYDbgOfmr+fNw5UqTOWeyA7Siea+23mQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgE1BB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:01:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:36378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726398AbgE1BBW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:01:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0B98208B8;
        Thu, 28 May 2020 01:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590627681;
        bh=LZnkNzSsbzB6azY77M84sY6QK7u8r73HOlYaSsFmZ5k=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=FVTgqwrkk1bhMaOzI6deD7zTa5KuaGBO6b44dXjo+oApQksCNbmXWPnQzu5x6mSpL
         XosIxR/WeVGVQLkfCFdwLql2Y5MOlliwHM+6G009n3jtB840ezAkK/om855n7D2sun
         CTBAUVTgr9Za0saVmEIIklqg8lIJVt0bBAOwqtA8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200519224151.2074597-8-lkundrak@v3.sk>
References: <20200519224151.2074597-1-lkundrak@v3.sk> <20200519224151.2074597-8-lkundrak@v3.sk>
Subject: Re: [PATCH v3 07/13] clk: mmp2: Add the I2S clocks
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Lubomir Rintel <lkundrak@v3.sk>
To:     Lubomir Rintel <lkundrak@v3.sk>
Date:   Wed, 27 May 2020 18:01:21 -0700
Message-ID: <159062768102.69627.15186037560072615375@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lubomir Rintel (2020-05-19 15:41:45)
> A pair of fractional clock sources for PLLs and gates.
>=20
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
>=20
> ---

Applied to clk-next
