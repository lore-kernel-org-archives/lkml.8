Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C7AAC3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DE520848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581550096;
	bh=1vklNqzDbpjpoE4p1KIjeerQyL1rbcfvPS6OLvqc2ZM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=HZDCutLvDvoUWZWHYxKkAJyEUpWGD00XeuJH1JV0l26jzPhptbveYWFXX3KIosMZ/
	 LGv/T+Mcfr5/n1luaJXa9xNOvepCsScxWnlBS69JOUmyUMN3BG2AfAZB2fKfuWt1Q0
	 AJj07zGZ2hx+rUKT5pKDXsQ5Gk72O5Etw/xykRmw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbgBLX2P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:28:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:42170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727117AbgBLX2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:28:15 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8411B20848;
        Wed, 12 Feb 2020 23:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581550094;
        bh=1vklNqzDbpjpoE4p1KIjeerQyL1rbcfvPS6OLvqc2ZM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hFCCIyCsUcKTQEyOETvjL3BOcBQUiTBapE53ZK5faftBw5CsWHRvBFpX5vtOKzFpV
         atRl3ZYWaCrDQ4//mnMotgbR8fx4ia3fLRBQ8T4FyRyNY0b+vJqjWp+H633r9kKXZ9
         cx4826HYeBBLPSOXEBw3aVxk2pL2qCF4KXVqFrrI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200205232802.29184-3-sboyd@kernel.org>
References: <20200205232802.29184-1-sboyd@kernel.org> <20200205232802.29184-3-sboyd@kernel.org>
Subject: Re: [PATCH v2 2/4] clk: Use 'parent' to shorten lines in __clk_core_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 12 Feb 2020 15:28:13 -0800
Message-ID: <158155009365.184098.9415232658756504945@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-02-05 15:28:00)
> Some lines are getting long in this function. Let's move 'parent' up to
> the top of the function and use it in many places whenever there is a
> parent for a clk. This shortens some lines by avoiding core->parent->
> indirections.
>=20
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
