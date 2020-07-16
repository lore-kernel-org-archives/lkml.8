Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C557CC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23F820714
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 00:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594860177;
	bh=kaOQQyTRMKWLEB0Raa7TpNpGLou0+YP41gS5/5cE770=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:List-ID:From;
	b=FvkfO5BZzZeZRdrihLJAO+L1XFxrYqbssPxUBn0cbCp0sal2XqyOs7fWSCw6/YZE4
	 KH80iT8UKHYbAPGYXk09W+3qi9m+w4QJTumkW+3mFmCGKdQkE7mhEwkaWh0cAA51lu
	 Z3MX7yvTAUqDjX3pQNbLdUMVPUKb5ern9nvptP4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727771AbgGPAm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 20:42:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgGPAm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:42:56 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8284A20714;
        Thu, 16 Jul 2020 00:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594860175;
        bh=kaOQQyTRMKWLEB0Raa7TpNpGLou0+YP41gS5/5cE770=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=telor6XqCFtKlzYpQpH3WdxwKFx7t62VEO06eFMPBpREwcNpdjYZvCkKh6utCxKWL
         +ccfjZ+gCx4ApId0mWez3lvOoINEnwcPrOokrHIwDSLbpKb9Su94VAdKev2LGeTGgV
         nfISeO8ilZXRYANKBYHF4jpZqXu6VAtKf0zjuFCo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200713010001.18976-2-akshu.agrawal@amd.com>
References: <20200713010001.18976-1-akshu.agrawal@amd.com> <20200713010001.18976-2-akshu.agrawal@amd.com>
Subject: Re: [PATCH 2/5] clk: x86: Change name from ST to FCH
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     akshu.agrawal@amd.com
Date:   Wed, 15 Jul 2020 17:42:54 -0700
Message-ID: <159486017478.1987609.16233541356940866738@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akshu Agrawal (2020-07-12 17:59:50)
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

Is this file moved somewhere?

>  #include <linux/platform_device.h>
> =20
>  /* Clock Driving Strength 2 register */
