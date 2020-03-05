Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A047BC3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7870F208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 21:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583445302;
	bh=Cdl9vahemLMywmJ1RilFfSa4r7cnv/R5nzgqZRjdSq8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=0KyEcAX/c2GNFAZJVZQ/uQX+nB9dp+TySt3v6WZ1VCC5PGaFbAjnkKklGljn7z4U3
	 6KW2v3rWDTJBmGEcVNqzcboKa6jTtdPHC19vzg+O43ZW9JRU7cJ7lSgBGTrcugQVBv
	 G51zyjRaiXIi0tKbhNGlRcSQjRTdogG+FlLsz1bM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCEVzB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 16:55:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbgCEVzA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 16:55:00 -0500
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55C6D20848;
        Thu,  5 Mar 2020 21:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583445300;
        bh=Cdl9vahemLMywmJ1RilFfSa4r7cnv/R5nzgqZRjdSq8=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=rJXlUKeQDf6QcK8xwpc+6ZuNy6qH3lr4C7XXfLnqsj2pwZdn46h3EupRnNqmOYA37
         9juMT46iBfmzso3pbHeARsQAPSfQNVKN+ONB4QLrHlHBDF+ZwPMng/vuG/JeXZQIe/
         LSblxOdkx5sKY2G75akKNpCSzkCKxb+tdAYiVCO8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200303192956.64410-1-jbrunet@baylibre.com>
References: <20200303192956.64410-1-jbrunet@baylibre.com>
Subject: Re: [PATCH] clk: rockchip: fix mmc get phase
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-rockchip@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Markus Reichl <m.reichl@fivetechno.de>
To:     Heiko Stuebner <heiko@sntech.de>,
        Jerome Brunet <jbrunet@baylibre.com>
Date:   Thu, 05 Mar 2020 13:54:59 -0800
Message-ID: <158344529963.25912.17580013895714045674@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2020-03-03 11:29:56)
> If the mmc clock has no rate, it can be assumed to be constant.
> In such case, there is no measurable phase shift. Just return 0
> in this case instead of returning an error.
>=20
> Fixes: 2760878662a2 ("clk: Bail out when calculating phase fails during c=
lk
> registration")
> Tested-by: Markus Reichl <m.reichl@fivetechno.de>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Applied to clk-next right on top of the phase branch.
