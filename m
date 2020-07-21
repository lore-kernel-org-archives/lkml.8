Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E32C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A061B21702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595318784;
	bh=pnBwyEcL6JYMEtGfYCElFjLTcx4NkvOic1YqImpDBoU=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=YWBxZ6qFwz/5OHTl8wSTN2ypdPDTOwUR/+Kn7oNM47d5JTIOyWhkn7vxKN8mkQgr4
	 ClVWFDqcAtNf80qGG48Hnzg05lE9ZXyadfw19DL02CeleJbz4mczmUBQV4cX2XypUW
	 2ai5jNafAHJYVwSNPAIPzW9bz8MhoHBPco6TtZgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgGUIGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:06:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727086AbgGUIGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:06:22 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A5420B1F;
        Tue, 21 Jul 2020 08:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595318782;
        bh=pnBwyEcL6JYMEtGfYCElFjLTcx4NkvOic1YqImpDBoU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=JngdKE4+v454jwG5ez/4ZB5UC/cjVd9LolyVqd/d7dODe52M1kjxt3Sj/K/APepoX
         XcAvsVb0rvaj72PnQ0PKT5bLjs0dVtLxlgU0Pj2+WC1cNY8QUEwuPNRQRcWLvX2xBs
         7p23cAXqSMKVgVwO2sXg6iIo9Rr8NQPbe1Omv7Zg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200720050500.23357-3-akshu.agrawal@amd.com>
References: <20200720050500.23357-1-akshu.agrawal@amd.com> <20200720050500.23357-3-akshu.agrawal@amd.com>
Subject: Re: [PATCH 2/4] clk: x86: Change name from ST to FCH
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     akshu.agrawal@amd.com
Date:   Tue, 21 Jul 2020 01:06:21 -0700
Message-ID: <159531878155.3847286.4182941234530539520@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akshu Agrawal (2020-07-19 22:04:57)
> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-fch.c
> similarity index 73%
> rename from drivers/clk/x86/clk-st.c
> rename to drivers/clk/x86/clk-fch.c
> index 25d4b97aff9b..b252f0cf0628 100644
> --- a/drivers/clk/x86/clk-st.c
> +++ b/drivers/clk/x86/clk-fch.c
> @@ -8,7 +8,7 @@
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
>  #include <linux/clk-provider.h>
> -#include <linux/platform_data/clk-st.h>
> +#include <linux/platform_data/clk-fch.h>

As stated before, this should go with the patch that moves the file.
