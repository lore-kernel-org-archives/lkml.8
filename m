Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E03C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 458DD22CAD
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596488020;
	bh=63vausDKl51fDul3cYf/wPKP2WMfhfwyaq3HXHq6eDM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=qzuJRFSZKCSu/cbTKBWG6fepUxZk3YD4hQqC1UpFS4zEoohCUpQxGw7AZ3vE7L+OA
	 IpvnbulR1jcEZF06vpO4Lx/8HbQNz3ZOGMRwDo17x5/CYlOTmyLvg05gMX12tCWOa+
	 95A53o9FZisMTVbKeC9dxQZjZjQdusqQaECKn/F0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728764AbgHCUxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgHCUxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:53:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32BDE22BF3;
        Mon,  3 Aug 2020 20:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596488018;
        bh=63vausDKl51fDul3cYf/wPKP2WMfhfwyaq3HXHq6eDM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=CL9EukmtgevqRm17QTiuKMh+tUSO32Wcv45FcTnONooSMa1oMhDlN+jaAKRAN6Suv
         UZYlzJMS+14rthWqFV0B7nwrtkGTykxS2SjIINdR4qwsHemi95QBL8OXEPhCmWeI5n
         IT8S00vlubSd4B/jEh6zQqJv2LQHq02R7OnHytus=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1596272022-14173-1-git-send-email-Julia.Lawall@inria.fr>
References: <1596272022-14173-1-git-send-email-Julia.Lawall@inria.fr>
Subject: Re: [PATCH] clk: drop unused function __clk_get_flags
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Julia Lawall <Julia.Lawall@inria.fr>,
        Michael Turquette <mturquette@baylibre.com>
Date:   Mon, 03 Aug 2020 13:53:36 -0700
Message-ID: <159648801691.1360974.3807233534486926682@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Julia Lawall (2020-08-01 01:53:42)
> The function __clk_get_flags has not been used since the April 2019
> commit a348f05361c9 ("ARM: omap2+: hwmod: drop CLK_IS_BASIC
> flag usage").  Other uses were removed in June 2015, eg by
> commit 98d8a60eccee ("clk: Convert __clk_get_flags() to
> clk_hw_get_flags()"), which shows how clk_hw_get_flags can easily
> be used instead.
>=20
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>=20
> ---

Applied to clk-next
