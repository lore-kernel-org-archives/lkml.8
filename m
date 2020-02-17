Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D0AC35242
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7DE520718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 07:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581925944;
	bh=WkTrSJpzAK3eiaSApQ9z6T6eUIIFo891pxQZAK31cBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bVX8ziAHInwOj1DgpVO9EDxBcgmMeiB4g/n568SHtOe5h8KNDMvM8tMxAmI0cE+3Z
	 B7YYCNXqOOl9os/rZi7dR3FBeCmhXlSfOvF9NcAe9i4Dd7Y1HfQVUAz+v90pfJyau+
	 8FtgAjBqo0CxnisKKzFI1cmQwxjdIi4Yj/GYJmI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgBQHwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 02:52:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:42960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgBQHwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 02:52:23 -0500
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E00BE2064C;
        Mon, 17 Feb 2020 07:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581925942;
        bh=WkTrSJpzAK3eiaSApQ9z6T6eUIIFo891pxQZAK31cBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VcpjNiN2GgZYOCVS48zBx/z1afRs4VsiAcjYT/+MFfF1vstYBh6FJzghxoWOs0vBN
         GuohSp2aqk6a/FTZuXyGIi6lan16aZv86HePDpEDVdUzESEj+IH5+4NP/3z1RzL/A4
         tLaez1DV3cWF43bgLYpSKfrwHClwlEAKcQ4jVbIM=
Date:   Mon, 17 Feb 2020 15:52:16 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rouven Czerwinski <r.czerwinski@pengutronix.de>
Cc:     s.hauer@pengutronix.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        Lucas Stach <l.stach@pengutronix.de>
Subject: Re: [PATCH] ARM: imx: build v7_cpu_resume() unconditionally
Message-ID: <20200217075216.GL7973@dragon>
References: <20200116141849.73955-1-r.czerwinski@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116141849.73955-1-r.czerwinski@pengutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 03:18:49PM +0100, Rouven Czerwinski wrote:
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> This function is not only needed by the platform suspend code, but is also
> reused as the CPU resume function when the ARM cores can be powered down
> completely in deep idle, which is the case on i.MX6SX and i.MX6UL(L).
> 
> Providing the static inline stub whenever CONFIG_SUSPEND is disabled means
> that those platforms will hang on resume from cpuidle if suspend is disabled.
> 
> So there are two problems:
> 
>   - The static inline stub masks the linker error
>   - The function is not available where needed
> 
> Fix both by just building the function unconditionally, when
> CONFIG_SOC_IMX6 is enabled. The actual code is three instructions long,
> so it's arguably ok to just leave it in for all i.MX6 kernel configurations.
> 
> Fixes: 05136f0897b5 ("ARM: imx: support arm power off in cpuidle for i.mx6sx")
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
> Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Applied, thanks.
