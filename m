Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC13EC3524D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C515C2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580757595;
	bh=uBBbiImlEg2xwm35XnV5KjFv99jVwQZgJjra2q22NCs=;
	h=In-Reply-To:References:From:To:Subject:Cc:Date:List-ID:From;
	b=OQKUx1TDEutNOGY6pMMG3FeRYmlM/tXwHN8Dgq1WzoN9xUNY35p2FDctaI6Vz3Cow
	 jAM90/xFVW8SOpMA/8YokSqGtLO4bqtrmeSoDQh+38oEPKFNFJ+92IMDD9Lt29IhIa
	 AibjdkXUYqkQL2ExX8GPKUz8+wDBV5oy3Es0zdzE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgBCTTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:19:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:46938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbgBCTTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:19:54 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C0482082E;
        Mon,  3 Feb 2020 19:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580757594;
        bh=uBBbiImlEg2xwm35XnV5KjFv99jVwQZgJjra2q22NCs=;
        h=In-Reply-To:References:From:To:Subject:Cc:Date:From;
        b=mhvJhYWGN3R0B8DlAXNO8YC1Uc1OGloSfXP0rpiW+YQumPN64gQhp10iWPUK9CCmr
         6QMRdZcZ8Re9pccjwbytRz2OcBZeepLjqyI8/aV8BHNnEL0A4GN3VsKtP0VSmfu0pS
         NEe/RuynkP+XJgHFC+MXzIcmIaVWgiIVpT6bgMVI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200128193329.45635-1-sboyd@kernel.org>
References: <20200128193329.45635-1-sboyd@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk: qcom: Don't overwrite 'cfg' in clk_rcg2_dfs_populate_freq()
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rajendra Nayak <rnayak@codeaurora.org>
User-Agent: alot/0.8.1
Date:   Mon, 03 Feb 2020 11:19:53 -0800
Message-Id: <20200203191954.1C0482082E@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-01-28 11:33:29)
> The DFS frequency table logic overwrites 'cfg' while detecting the
> parent clk and then later on in clk_rcg2_dfs_populate_freq() we use that
> same variable to figure out the mode of the clk, either MND or not. Add
> a new variable to hold the parent clk bit so that 'cfg' is left
> untouched for use later.
>=20
> This fixes problems in detecting the supported frequencies for any clks
> in DFS mode.
>=20
> Fixes: cc4f6944d0e3 ("clk: qcom: Add support for RCG to register for DFS")
> Reported-by: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next

