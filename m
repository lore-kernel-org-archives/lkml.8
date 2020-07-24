Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FE6C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2DB20714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595583731;
	bh=UTbUq984n65wlovPvPVfXGRpofUx4w/DmHnikEOryGE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=aIj0xn58mhsHTyxvcDXmTfzUCZKEwySEVf7ZTDy99QRVuuhY4763jCUxaAYT+7dr3
	 Z2DccZSguIyC3YBAp/FilWOJ6x5GdV8SvysihIXK0M5CybE6S0Qxu2vSeSeAfzuVEA
	 dIXgMYOWkuCnCbEkfNiucAWZhsz3lfA8T/4hw6jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgGXJmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:42:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbgGXJmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:42:08 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 701C7206EB;
        Fri, 24 Jul 2020 09:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595583728;
        bh=UTbUq984n65wlovPvPVfXGRpofUx4w/DmHnikEOryGE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ECYqlR/GScqnb+tq0jHokTteIwsz4ohh3GaN0EqiuPHbTTtywrv7Ug8SWGoemvjNp
         SqX8ZppyOPtA+ZhgxwbfIbCYgDLW0ZUTXfnb8czdb80DfhPOrgNmGpiGEb480fgT0J
         vGrYJ/HTPTRkvENvC4mr06RzVjJYneS9egaNHRfc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200622090935.213833-1-sboyd@kernel.org>
References: <20200622090935.213833-1-sboyd@kernel.org>
Subject: Re: [PATCH] clk: Clean up kernel-doc errors
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 24 Jul 2020 02:42:07 -0700
Message-ID: <159558372766.3847286.7662762683733987681@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-06-22 02:09:35)
> Two things aren't documented causing kernel-doc to fail when checking
> the core clk.c file. Fix them so that this file is clean.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
