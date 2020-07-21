Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86A4C433E6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB9321702
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595318660;
	bh=RDk4iY6iYqvSg+xGeXp7q0Oy+7kOsYkUs66LVpJVSoI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=D9Dhu3PJlMXEPZUM+xblmamqxNwErJDIZR8C5jPQ4qmIkMGwe5WBEVNsCQfyhqP2h
	 t8u0pxw7fqTIoCoL51MkUh5JfTgLx2Wk/OPZbOzOiwup+ZRnOEwoCMrfLuGTqhlpyc
	 4Hb8NDpCdDXLfp446HeaXlVuhUHfclOM1hI7rzeo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgGUIET (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:04:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbgGUIET (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:04:19 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF98B20709;
        Tue, 21 Jul 2020 08:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595318658;
        bh=RDk4iY6iYqvSg+xGeXp7q0Oy+7kOsYkUs66LVpJVSoI=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=d7pogMm7aLFzIlKa2BN0JQ5gO5DIYpaDnOvuV88wPKVhGhXMTS5zSbMFK8xoGKQI3
         80XqZheQu1grctfZoRybXH+7GwcL8L3n0MuI4A/rxztdBJDP6W3RVOBL7VgGtDz/QO
         tRuF3SqxowfWfdm6+9Cn0VfWd8fKVzKB+H20OZrU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cccfd007-1801-f289-2730-b831d9494a08@amd.com>
References: <20200713010001.18976-1-akshu.agrawal@amd.com> <20200713010001.18976-2-akshu.agrawal@amd.com> <159486017478.1987609.16233541356940866738@swboyd.mtv.corp.google.com> <cccfd007-1801-f289-2730-b831d9494a08@amd.com>
Subject: Re: [PATCH 2/5] clk: x86: Change name from ST to FCH
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     "Agrawal, Akshu" <aagrawal2@amd.com>, akshu.agrawal@amd.com
Date:   Tue, 21 Jul 2020 01:04:18 -0700
Message-ID: <159531865807.3847286.3414535445817803885@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Agrawal, Akshu (2020-07-19 21:59:02)
>=20
> On 7/16/2020 6:12 AM, Stephen Boyd wrote:
> > Quoting Akshu Agrawal (2020-07-12 17:59:50)
> >> diff --git a/drivers/clk/x86/clk-st.c b/drivers/clk/x86/clk-fch.c
> >> similarity index 73%
> >> rename from drivers/clk/x86/clk-st.c
> >> rename to drivers/clk/x86/clk-fch.c
> >> index 25d4b97aff9b..b252f0cf0628 100644
> >> --- a/drivers/clk/x86/clk-st.c
> >> +++ b/drivers/clk/x86/clk-fch.c
> >> @@ -8,7 +8,7 @@
> >>   #include <linux/clk.h>
> >>   #include <linux/clkdev.h>
> >>   #include <linux/clk-provider.h>
> >> -#include <linux/platform_data/clk-st.h>
> >> +#include <linux/platform_data/clk-fch.h>
> > Is this file moved somewhere?
>=20
> Renaming it from ST to FCH in previous patch of the series.
>=20

So it won't compile if the first patch is applied and then this patch
isn't? Please compile test each patch in succession.
