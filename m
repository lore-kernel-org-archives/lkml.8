Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D769C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06A0620829
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595899329;
	bh=VjPgbBotx2j2mpmZm5DhzzZAaPi7egObI23Ux2zgilU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=jYAAUZr2DevgdoLnVDHGisOGAeWnVIZ/Hgrx30LvqEnyFku87P9QhnYq2dWogVfxR
	 CDcIJnPWK9Sp5qFmur3CvBbsLloxntP0JBPq1WvkzT+Z5VAX5tmUm2/xq13ynopJ5L
	 geblNsZTQdvCAOFTK4Lt1UlIQtN1wJgNYZkmGltY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgG1BWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:22:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG1BWH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:22:07 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8514720829;
        Tue, 28 Jul 2020 01:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595899326;
        bh=VjPgbBotx2j2mpmZm5DhzzZAaPi7egObI23Ux2zgilU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=NEvUTzyiBNiWr+fWR/YT23YZciibr7s6ygXP081pqi4Jl9H4BN9P/xjJzE9dzy+gD
         iA7kVxRkvXA63QQP4iwDSCOIYLAkotZP5mza+P4ijXczOV7qTdX2/JYTHv+vqEt1De
         FyhA9/kNgm62R5JFBBEafghvAExO2UzuYRdYyos0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200713032143.21362-1-vulab@iscas.ac.cn>
References: <20200713032143.21362-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] clk: clk-atlas6: fix return value check in atlas6_clk_init()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Xu Wang <vulab@iscas.ac.cn>
To:     Xu Wang <vulab@iscas.ac.cn>, baohua@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        mturquette@baylibre.com
Date:   Mon, 27 Jul 2020 18:22:05 -0700
Message-ID: <159589932546.1360974.12932267268128581186@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Xu Wang (2020-07-12 20:21:43)
> In case of error, the function clk_register() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check
> should be replaced with IS_ERR().
>=20
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> ---

Applied to clk-next
